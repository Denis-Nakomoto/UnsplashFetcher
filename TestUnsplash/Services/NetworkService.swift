//
//  NetworkService.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 06.06.2022.
//

import Foundation
import Alamofire

enum ApiRequests: String {
    case photos = "photos/"
    case searchRequest = "search/photos/"
}

class NetworkService {

    static let endPoint = "https://api.unsplash.com/"
    static let accessKey = "i6xkfXe33b7kyclfSPA76pfeasTLWbY5OyQpNbpl7DA"
    
    static func getListPictures<T: Decodable>(with url: ApiRequests,
                                        query: String = "",
                                        completition: @escaping(_ result: T?, _ error: String?) -> Void ) {
        let randomPage = Int.random(in: 0...10)
        
        var completeUrl = "\(endPoint)\(url)?client_id=\(accessKey)&per_page=30"

        if url == ApiRequests.searchRequest {
            completeUrl += "&query=\(query)"
        } else {
            completeUrl += "&page=\(randomPage)"
        }
        AF.request(completeUrl, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                    switch response.result {
                    case .success(let data):
                        do {
                            let pictures = try JSONDecoder().decode(T.self, from: data)
                            completition(pictures, nil)
                        }
                        catch let err {
                            print ("ENCOIDNG ERROR \(err)")
                            completition(nil, err.localizedDescription)
                        }
                    case .failure (let error):
                        print("AF REQUEST FAILURE \(error)")
                        completition(nil, error.localizedDescription)
                    }
            }
    }
    
}
