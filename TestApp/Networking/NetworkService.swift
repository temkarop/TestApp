//
//  NetworkService.swift
//  TestApp
//
//  Created by Артем Ропавка on 23.09.2021.
//

import Foundation

class NetworkService {
    
    let baseURL = "https://scripts.qexsystems.ru/test_ios/public/api"
    
    func request(endPoint: String, completion: @escaping  (Result<Data, Error>) -> Void) {
        
            guard let url = URL(string: baseURL + endPoint) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    guard let data = data else { return }
                    completion(.success(data))
                }
            }.resume()
    }
    func postToSave(endPoint: String,
                    parameters: [String: Any],
                    completion: @escaping (Result<Post, Error>) -> Void ) {
        
        guard let url = URL(string: baseURL + endPoint) else { return }
        
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        urlRequest.httpBody = httpBody
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let response = response, let data = data else { return }
                print(response)
            
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch let error{
                    print(error)
                }
        }.resume()
    }
}
