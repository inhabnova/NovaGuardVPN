import Foundation

struct HTTPMethod {
    static let get = HTTPMethod(rawValue: "GET")
    static let post = HTTPMethod(rawValue: "POST")
    static let put = HTTPMethod(rawValue: "PUT")
    static let delete = HTTPMethod(rawValue: "DELETE")
    
    let rawValue: String
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    //MARK: - Properties
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 250
        return URLSession(configuration: configuration)
    }
    
    //MARK: - makeRequest
    
    func makeRequest<T: Decodable> (
        urlString: String,
        httpMethod: HTTPMethod,
        body: Data? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL(urlString)))
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let body {
            do {
                request.httpBody = body
//                request.httpBody = try encoder.encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                DispatchQueue.main.async {
                    return completion(.failure(.badEncode("\(T.self)")))
                }
            }
        }
        
        if let headers {
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: headers, options: [])
                request.httpBody = jsonData
            } catch {
                var description: String = ""
                for (key, value) in headers {
                    description += key + ": " + value
                }
                
                DispatchQueue.main.async {
                    completion(.failure(.badEncode(description)))
                }
                return
            }
        }
        
        self.session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.responseError(error!.localizedDescription)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData("\(T.self)")))
                }
                return
            }
            
            print("\n🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢🟢")
            
            if let response = response as? HTTPURLResponse {
                let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print("statusCode: " + "\(response.statusCode)")
            }
            print("- \(request.httpMethod!) \(request.url!)")
            if headers != nil {
                print("- Headers:")
                print(headers as Any)
            }
            print("- response:")
            print("🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴\n")
            
            guard let response = response as? HTTPURLResponse else {
                let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                completion(.failure(.responseError("Code: -701, " + ((responseString ?? "/003")  as String))))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try self.decoder.decode (T.self,
                                                               from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    DispatchQueue.main.async {
                        completion(.failure(.badDecode((responseString ?? "nil in responseString") as String)))
                    }
                    return
                }
            case 401:
                DispatchQueue.main.async {
                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    completion(.failure(.noData((responseString ?? "401") as String)))
                }
            default:
                DispatchQueue.main.async {
                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    completion(.failure(.badDecode((responseString ?? "nil in responseString") as String)))
                }
            }
            
        }.resume()
    }
    
    func makeJSONData(from dictionary: [AnyHashable: Any]) -> Data? {
        let jsonCompatibleDictionary = dictionary.reduce(into: [String: Any]()) { result, item in
            if let key = item.key as? String {
                result[key] = convertToJSONCompatibleValue(item.value)
            }
        }
        
        // Преобразуем словарь в JSON Data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonCompatibleDictionary, options: [])
            return jsonData
        } catch {
            print("Ошибка при сериализации в JSON:", error)
            return nil
        }
    }

    // Функция для преобразования значения в JSON-совместимый формат
    func convertToJSONCompatibleValue(_ value: Any) -> Any {
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
            return "\(value)" // Конвертируем любые другие типы в строку
        }
    }
}

//MARK: - isAddDefaultSettings to URLRequest

extension URLRequest {
    
    ///init, который задает httpMethod = get и добавляет header accept: application/json
    init(url: URL, isAddDefaultSettings: Bool = false, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0) {
        self.init(url: url)
        self.httpMethod = HTTPMethod.get.rawValue
        self.setValue("application/json", forHTTPHeaderField: "accept")
    }
}
