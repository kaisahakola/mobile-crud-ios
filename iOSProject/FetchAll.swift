//
//  FetchAll.swift
//  iOSProject
//
//  Created by Kaisa Hakola on 9.5.2023.
//

import Foundation
import Alamofire

func fetchData(callback : @escaping (_ users: Array<User>?) -> Void) {
    AF.request("https://dummyjson.com/users").responseDecodable(of: Result.self) { response in
        switch response.result {
        case .success(let value):
            callback(value.users)
        case .failure(let error):
            print(error)
            callback(nil)
        }
    }
    
}
