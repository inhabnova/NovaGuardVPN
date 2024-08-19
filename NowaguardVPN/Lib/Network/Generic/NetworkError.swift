enum NetworkError: Error {
    case invalidURL(String)
    case noData(String)
    case badDecode(String)
    case badEncode(String)
    case responseError(String)
}
