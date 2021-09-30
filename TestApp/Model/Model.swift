//
//  Model.swift
//  TestApp
//
//  Created by Артем Ропавка on 23.09.2021.
//

import Foundation

struct SearchPosts: Codable {
    var posts: [Post]
}

struct Post: Codable {
    let id: Int
    let name: String
    let photo: String?
    let description: String
    let createdAt: String
    let updatedAt: String
    
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case photo
            case description
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
}
