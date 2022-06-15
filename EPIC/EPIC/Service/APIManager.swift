//
//  APIManager.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import Foundation

class APIManager {
    func getPhotos(completion: @escaping(([MainResult]) -> Void)){
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=5xhhlsbeqeREM7d7FLwh8YZHJrnlQyzG3fxWlnd1&start_date=2020-01-01&end_date=2020-03-01")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let date = try? JSONDecoder().decode(theResult.self, from: data) {
                    var resultArray: [MainResult] = []
                    for dict in date {
                        let newDate = dict
                        resultArray.append(newDate)
                    }
                    completion(resultArray)
                } else {
                    print("invalid response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
}
