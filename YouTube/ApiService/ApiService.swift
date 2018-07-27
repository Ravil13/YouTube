//
//  ApiService.swift
//  YouTube
//
//  Created by Равиль Вильданов on 27.07.2018.
//  Copyright © 2018 Равиль Вильданов. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let shared = ApiService()
    
    func fetchVideo(completion: @escaping ([Video]) -> ()) {
        let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    var videos = [Video]()
                    videos = try decoder.decode([Video].self, from: data)
                    completion(videos)
                } catch let jsonError {
                    print("Failed to decode: ", jsonError)
                }
            }
            }.resume()
    }
}
