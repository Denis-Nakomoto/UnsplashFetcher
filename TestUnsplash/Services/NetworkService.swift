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
    
    static func getListPictures<T: Decodable>(with url: String,
                                        query: String = "",
                                        completition: @escaping(_ result: T?, _ error: String?) -> Void ) {
        let randomPage = Int.random(in: 0...10)
        
        var completeUrl = "\(endPoint)\(url)?client_id=\(accessKey)&per_page=30"

        if url == ApiRequests.searchRequest.rawValue {
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
    
    static func getPicture(with picId: String,
                                        completition: @escaping(_ result: Photo?, _ error: String?) -> Void ) {
        
        let completeUrl = "\(endPoint)photos/\(picId)?client_id=\(accessKey)"

        AF.request(completeUrl, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                    switch response.result {
                    case .success(let data):
                        do {
                            let pictures = try JSONDecoder().decode(Photo.self, from: data)
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
    
    static func downloadPicture(with photo: Photo,
                                        completition: @escaping(_ result: UIImage?, _ error: String?) -> Void ) {
        guard let urlString = photo.urls?.regular else { return }
        
        let url = URL(string: urlString)!

        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                    switch response.result {
                    case .success(let data):
                            let pictures = UIImage(data: data)
                            completition(pictures, nil)
                    case .failure (let error):
                        print("AF REQUEST FAILURE \(error)")
                        completition(nil, error.localizedDescription)
                    }
            }
    }
    
    
}
