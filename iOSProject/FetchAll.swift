//
//  FetchAll.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation

func parseJson(json: Data) -> Array<User>? {
    do {
        let jsonDecoder = JSONDecoder()
        let httpResult : Result = try jsonDecoder.decode(Result.self, from: json)
        return httpResult.users
    } catch {
        return nil
    }
}

func fetchData(callback : @escaping (_ users: Array<User>?) -> Void) {
    DispatchQueue.main.async() {
        let myURL = URL(string: "https://dummyjson.com/users")!
        let httpTask = URLSession.shared.dataTask(with: myURL) {
            (optionalData, response, error) in
                if let data = optionalData {
                    let users = parseJson(json: data)
                    callback(users)
                } else {
                    callback(nil)
                }
        }
        httpTask.resume()
    }
}
