//
//  BaseProvider.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import Foundation

class BaseProvider{
    func createRequest(withUrlString:String!,result completion:@escaping (([String : Any]?,Error?)->())){
        let url = URL(string: withUrlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if(error != nil){
                completion(nil,error)
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : Any]
                    completion(json,nil)
                }catch let error{
                    completion(nil,error)
                }
            }
        }).resume()
    }
}
