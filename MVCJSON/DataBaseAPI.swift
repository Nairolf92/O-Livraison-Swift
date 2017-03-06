//
//  DataBaseAPI.swift
//  MVCJSONBlank
//
//  Created by Florian Kelnerowski on 02/03/2017.
//  Copyright © 2017 FlyLab. All rights reserved.
//

import UIKit

protocol DataBaseDelegateAPI
{
    func didLoadData()
    func didLoadDataAtIndex( index : Int)
}

class DataObjectAPI: NSObject {
    var login = String()
    var password =  String()
    var first_name = String()
    var last_name = String()
    var id = String()
}

class DataBaseAPI: NSObject
{
    
    static let shared = DataBaseAPI()
    
    public var delegate : DataBaseDelegateAPI? = nil
    
    public var objects = [DataObjectAPI]()
    
    public func loadData()
    {
        if let url = URL(string: "http://www.antoine-lucas.fr/api_android/web/index.php/api/users")
        {
            
            let task = URLSession.shared.dataTask(with: url, completionHandler:
                { (data, response, error) -> Void in
                    guard let data = data, error == nil else
                    {
                        return
                    }
                    // ok
                    self.parseJSON( data: data)
            })
            
            task.resume()
        }
    }
    
    func parseJSON(data : Data)
    {
        do
        {
            let dataJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments )
            
            //print(dataJson)
            
            guard let root = dataJson as? [[ String : AnyObject]] else
            {
                print("pas ok")
                return
            }
            
            for item in root
            {
                let dataItem = DataObjectAPI()
                
                if let loginEntry = item["login"] as? String
                {
                    dataItem.login = loginEntry
                    //print(dataItem.login)
                }
                if let passwordEntry = item["password"] as? String
                {
                    dataItem.password = passwordEntry
                    //print(dataItem.password)
                }
                if let first_nameEntry = item["first_name"] as? String
                {
                    dataItem.first_name = first_nameEntry
                    //print(dataItem.first_name)
                }
                if let last_nameEntry = item["last_name"] as? String
                {
                    dataItem.last_name = last_nameEntry
                    //print(dataItem.last_name)
                }
                if let idEntry = item["id"] as? String
                {
                    dataItem.id = idEntry
                    //print(dataItem.id)
                }
                
                objects.append(dataItem)
            }
            
            DispatchQueue.main.async
            {
                    self.delegate?.didLoadData()
            }
            
        }
        catch
        {
            assert( false )
            return
        }
    }
    
}
