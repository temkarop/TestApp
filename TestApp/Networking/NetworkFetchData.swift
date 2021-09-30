//
//  NetworkFetchData.swift
//  TestApp
//
//  Created by Артем Ропавка on 23.09.2021.
//

import Foundation

class NetworkFetchData {
    
    let networkService = NetworkService()
    
    func fetchPosts(endPoint: String, response: @escaping (SearchPosts?) -> Void) {
        networkService.request(endPoint: endPoint) { (result) in
            
            switch result {
            
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let posts = try decoder.decode(SearchPosts.self, from: data)
                    response(posts)
                    
                }catch let jsonError {
                    print("Failedto decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
        }
    }
    
   
}
