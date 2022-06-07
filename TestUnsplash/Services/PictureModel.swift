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
    let urls: Urls?
    let description: String?
    let user: User?
    
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
    let id: String
    let name: String
}
