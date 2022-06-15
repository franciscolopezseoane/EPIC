//
//  APIManager.swift
//  EPIC
//
//  Created by Francisco Lopez on 14/06/2022.
//

import Foundation

class APIManager {
    func getDates(completion: @escaping(([DateResult]) -> Void)){
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=5xhhlsbeqeREM7d7FLwh8YZHJrnlQyzG3fxWlnd1&start_date=2020-05-01&end_date=2020-06-14")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let date = try? JSONDecoder().decode(dateResult.self, from: data) {
                    var resultArray: [DateResult] = []
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
    
    
    func getPhotosFromDate(_ query: String, completion: @escaping (([PhotoResult]) -> Void)){
        let url = URL(string: "https://epic.gsfc.nasa.gov/api/enhanced/date/"+query+"?api_key=5xhhlsbeqeREM7d7FLwh8YZHJrnlQyzG3fxWlnd1")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let photos = try? JSONDecoder().decode(photoResult.self, from: data) {
                    var photosArray: [PhotoResult] = []
                    for dict in photos {
                        let newPhotos = dict
                        photosArray.append(newPhotos)
                    }
                    completion(photosArray)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
    func getThumbnails(_ date: String ,_ query: String) -> URL {
        if let url = URL(string: "https://epic.gsfc.nasa.gov/archive/natural/"+date+"/thumbs/epic_1b_"+query+".jpg") {
            return url
        } else {
            return URL(string: "https://epic.gsfc.nasa.gov/contents/assets/logo.png")!
        }
    }
}
  
