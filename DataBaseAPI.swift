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
            
            print(dataJson)
            
            
            guard let root = dataJson as? [ String : AnyObject] else
            {
                return
            }
            
            guard  let feed = root["feed"] as? [ String : AnyObject]  else
            {
                return
            }
            
            guard  let list = feed["entry"] as? [[ String : AnyObject]]  else
            {
                return
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
