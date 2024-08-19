extension NetworkManager {
    func getServers(completion: @escaping (Result<[Server], NetworkError>) -> Void) {
        makeRequest(
            urlString: "https://inhabitrlimited.digital/api/vpn/servers.php?key=b1947044-1d5f-4381-ac53-f1271a2dedb8",
            httpMethod: .get
        ) { (result: Result<[Server], NetworkError>) in
            completion(result)
        }
    }
}
