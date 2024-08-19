import AdSupport

enum Events: String {
    case install = "install"
    case subscribe = "subscribe"
}

struct SendEventRequest: Encodable {
    let apiKey = "b1947044-1d5f-4381-ac53-f1271a2dedb8"
    let event: String
    let product: String
//    let afData: [String: String]
}

extension NetworkManager {
    func sendEvent(event: Events, productId: String?, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        let body: SendEventRequest = .init(event: event.rawValue, product: productId ?? "")
        makeRequest(
            urlString: "https://inhabitrlimited.digital/api/vpn/events.php",
            httpMethod: .post,
            body: body
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
