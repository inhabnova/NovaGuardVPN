import AdSupport

enum Events: String {
    case install = "install"
    case subscribe = "subscribe"
}

struct SendEventRequest {
    let apiKey = "b1947044-1d5f-4381-ac53-f1271a2dedb8"
    let event: String
    let product: String
    let af_data: [AnyHashable: Any]
    
    func toJSONData() -> Data? {
        // Собираем словарь с API ключом, событием и продуктом
        var jsonCompatibleDictionary: [String: Any] = [
            "apiKey": apiKey,
            "event": event,
            "product": product
        ]
        
        // Конвертируем af_data в JSON-совместимый формат и добавляем его в словарь
        jsonCompatibleDictionary["af_data"] = af_data.reduce(into: [String: Any]()) { result, item in
            if let key = item.key as? String {
                result[key] = convertToJSONCompatibleValue(item.value)
            }
        }
        
        // Преобразуем словарь в JSON Data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonCompatibleDictionary, options: [])
            return jsonData
        } catch {
            print("Ошибка сериализации JSON:", error)
            return nil
        }
    }
    
    // Преобразование значений в JSON-совместимый формат
    private func convertToJSONCompatibleValue(_ value: Any) -> Any {
        switch value {
        case let intValue as Int:
            return intValue
        case let doubleValue as Double:
            return doubleValue
        case let boolValue as Bool:
            return boolValue
        case let stringValue as String:
            return stringValue
        case let dateValue as Date:
            let dateFormatter = ISO8601DateFormatter()
            return dateFormatter.string(from: dateValue)
        case let arrayValue as [Any]:
            return arrayValue.map { convertToJSONCompatibleValue($0) }
        case let dictValue as [AnyHashable: Any]:
            return dictValue.reduce(into: [String: Any]()) { result, item in
                if let key = item.key as? String {
                    result[key] = convertToJSONCompatibleValue(item.value)
                }
            }
        default:
            return "\(value)" // Преобразование любых других типов в строку
        }
    }
}

//struct AnyEncodable: Encodable {
//    private let value: Any
//
//    init(_ value: Any) {
//        self.value = value
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        
//        switch value {
//        case let intValue as Int:
//            try container.encode(intValue)
//        case let doubleValue as Double:
//            try container.encode(doubleValue)
//        case let stringValue as String:
//            try container.encode(stringValue)
//        case let boolValue as Bool:
//            try container.encode(boolValue)
//        case let dateValue as Date:
//            let dateFormatter = ISO8601DateFormatter()
//            let dateString = dateFormatter.string(from: dateValue)
//            try container.encode(dateString)
//        case let dictValue as [String: Any]:
//            try container.encode(dictValue.mapValues { AnyEncodable($0) })
//        case let arrayValue as [Any]:
//            try container.encode(arrayValue.map { AnyEncodable($0) })
//        default:
//            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Unsupported type"))
//        }
//    }
//}

extension NetworkManager {
    func sendEvent(event: Events, productId: String?, afData: [AnyHashable: Any]?, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        let body: SendEventRequest = .init(event: event.rawValue, product: productId ?? "", af_data: afData ?? [:])
        let data = body.toJSONData()
        makeRequest(
            urlString: "https://inhabitrlimited.digital/api/vpn/events.php",
            httpMethod: .post,
            body: data
        ) { (result: Result<String, NetworkError>) in
            completion(result)
        }
    }
}
//{
//    "api_key": "строка которую мы вам предоставим",
//    "event": "название события (**install**, **trial** или **subscribe**)",
//    "product": "идентификатор подписки (только для **subscribe** и **trial**, для **install** можно оставить пустым или не отправлять вовсе)",
//  "idfa": "IDFA (если он доступен. Только для iOS, для Android этот параметр можно не добавлять)"
//    "af_data": {
//            "название первого параметра конверсии из Appsflyer SDK": "значение первого параметра конверсии",
//            "название второго параметра конверсии из Appsflyer SDK": "значение второго параметра конверсии",
//            ... и т.д. все полученные параметры
//    }
//}
