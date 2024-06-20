//
//  NetworkManager.swift
//  MyPokemonList
//
//  Created by Irsyad Ashari on 22/05/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
    
    private struct Constants {
        static let memoryCacheByteLimit: Int = 4 * 1024 * 1024 // 20 MB
        static let diskCacheByteLimit: Int = 20 * 1024 * 1024 // 4 MB
        static let cacheName: String = "GithubBrowser.cache"
    }
    
    func setupURLCache() {
        guard let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(Constants.cacheName) else {
            assertionFailure("Failed to setup URL Cache: Can not get cache file path.")
            return
        }
        
        if #available(iOS 13.0, *) {
            let urlCache = URLCache(
                memoryCapacity: Constants.memoryCacheByteLimit,
                diskCapacity: Constants.diskCacheByteLimit,
                directory: cacheURL)
            URLCache.shared = urlCache
        } else {
            let urlCache = URLCache(
                memoryCapacity: Constants.memoryCacheByteLimit,
                diskCapacity: Constants.diskCacheByteLimit,
                diskPath: Constants.cacheName
            )
            URLCache.shared = urlCache
        }
    }
    
    private func buildURL(endpoint: API) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme.rawValue
        urlComponents.host = endpoint.baseURL
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.parameters
        
        return urlComponents
    }
    
    private func buildRequest(url: URL?, endpoint: API) -> URLRequest? {
        guard let urlWrapped = url else {
            return nil
        }
        
        var request = URLRequest(url: urlWrapped, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = endpoint.method.rawValue
        
        for item in endpoint.headers {
            request.setValue(item.key, forHTTPHeaderField: item.value)
        }
        return request
    }
    
    func request<T: Decodable>(endpoint: API, completion: @escaping ((Result<T, Error>) -> Void)) {
        let components = buildURL(endpoint: endpoint)
        
        guard let url = components.url, let request = buildRequest(url: url, endpoint: endpoint) else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(NSError(domain: error.localizedDescription, code: 404)))
            }
            guard let dataWrapped = data else {
                completion(.failure(NSError(domain: "response is nil", code: 404)))
                return
            }
            
            if let responseObject = try? JSONDecoder().decode(T.self, from: dataWrapped) {
                completion(.success(responseObject))
            } else {
                completion(.failure(NSError(domain: "Failed to parsed JSON", code: 204)))
            }
        }
        
        task.resume()
    }
    
    private func getCachedData(for url: URL) -> Data? {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return cachedResponse.data
        }
        return nil
    }
}
