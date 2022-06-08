//
//  PictureModel.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import Foundation

struct SearchResult: Decodable {
    let results: [Photo]
}

struct Photo: Decodable, Hashable {

    let id: String?
    let createdAt: String?
    let urls: Urls?
    let user: User?
    let likes: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case urls
        case likes
        case user
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Urls: Decodable {
    let thumb, small, regular: String
}

struct User: Decodable {
    let id: String?
    let name: String?
    let location: String?
}
