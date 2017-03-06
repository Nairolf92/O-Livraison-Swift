//
//  DataBase.swift
//  MVCJSON
//
//  Created by Manuel Deneu on 24/02/2017.
//  Copyright © 2017 FlyLab. All rights reserved.
//

import UIKit



protocol DataBaseDelegate
{
    func didLoadData()
    func didLoadDataAtIndex( index : Int)
}

class DataObject : NSObject , NSCoding
{
    var id = String()
    var reference = String()
    var livreur = String()
    var nom = String()
    var prenom = String()
    var phone = String()
    var adresse = String()
    var prix_total = String()
    

    
    static let KeyId = "KeyId"
    static let KeyReference = "KeyReference"
    static let KeyLivreur = "KeyLivreur"
    static let KeyNom = "KeyNom"
    static let KeyPrenom = "KeyPrenom"
    static let KeyPhone = "KeyPhone"
    static let KeyAdresse = "KeyAdresse"
    static let KeyPrix_total = "KeyPrix_total"
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: DataObject.KeyId)
        aCoder.encode(reference, forKey: DataObject.KeyReference)
        aCoder.encode(livreur, forKey: DataObject.KeyLivreur)
        aCoder.encode(nom, forKey: DataObject.KeyNom)
        aCoder.encode(prenom, forKey: DataObject.KeyPrenom)
        aCoder.encode(phone, forKey: DataObject.KeyPhone)
        aCoder.encode(adresse, forKey: DataObject.KeyAdresse)
        aCoder.encode(prix_total, forKey: DataObject.KeyPrix_total)
    }
    override init()
    {
        super.init()
    }
    public required init?(coder aDecoder: NSCoder) {
        if let value = aDecoder.decodeObject(forKey: "KeyId") as? String
        {
            self.id = value
        }
        if let value = aDecoder.decodeObject(forKey: "KeyReference") as? String
        {
            self.reference = value
        }
        if let value = aDecoder.decodeObject(forKey: "KeyLivreur") as? String
        {
            self.livreur = value
        }
        if let value = aDecoder.decodeObject(forKey: "KeyNom") as? String
        {
            self.nom = value
        }
        if let value = aDecoder.decodeObject(forKey: "KeyPrenom") as? String
        {
            self.prenom = value
        }
        if let value = aDecoder.decodeObject(forKey: "KeyPhone") as? String
        {
            self.phone = value
        }
        if let value = aDecoder.decodeObject(forKey: "KeyAdresse") as? String
        {
            self.adresse = value
        }
        if let value = aDecoder.decodeObject(forKey: "KeyPrix_total") as? String
        {
            self.prix_total = value
        }
    }
    
    
}

class DataBase: NSObject
{

    private static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private static let ArchiveURL = DocumentsDirectory.appendingPathComponent("fichier-swift")
    
    static let shared = DataBase()
    
    public var delegate : DataBaseDelegate? = nil
    
    public var objects = [DataObject]()
    
    
    public func loadData()
    {
        //url = "https://itunes.apple.com/us/rss/topgrossingipadapplications/limit=10/json"
        
        if let url = URL(string: "http://antoine-lucas.fr/api_android/web/index.php/api/commandes/todo")
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
            
            guard let root = dataJson as? [[ String : AnyObject]] else
            {
                return
            }
            
        
            
            guard  let list = root as? [[ String : AnyObject]]  else
            {
                return
            }
            
            for item in list
            {
                let dataItem = DataObject()
                
                if let id  = item["id"] as? String
                {
                    dataItem.id = id
                }
                if let reference  = item["reference"] as? String
                {
                    dataItem.reference = reference
                }
                if let nom  = item["nom"] as? String
                {
                    dataItem.nom = nom
                }
                if let prenom  = item["prenom"] as? String
                {
                    dataItem.prenom = prenom
                }
                if let phone  = item["phone"] as? String
                {
                    dataItem.phone = phone
                }
                if let adresse  = item["adresse"] as? String
                {
                    dataItem.adresse = adresse
                }
                if let prix_total  = item["prix_total"] as? String
                {
                    dataItem.prix_total = prix_total
                }
                
                /*
                if let priceEntry  = item["im:price"] as? [String : AnyObject]
                {
                    if let priceAttributes = priceEntry["attributes"] as? [String : String]
                    {
                        
                        if let price = priceAttributes["amount"] ,
                           let currency = priceAttributes["currency"]
                        {
                            if (Double(price) == 0)
                            {
                                dataItem.price = "Free"
                            }
                            else
                            {
                                dataItem.price = "\(price) \(currency)"
                            }
                            
                        }
                    }
                }
                if let imageList = item["im:image"] as? [AnyObject]
                {
                    let imageEntry = imageList.first
                    
                    if let imageUrl = imageEntry!["label"] as? String
                    {
                        downloadImage(object: dataItem, url: imageUrl)
                        
                    }
                    
                }*/
                
                objects.append(dataItem)
            }
           
            /*if (self.saveToDisk())
            {
                print("save ok")
            }else
            {
                print("save error")
            }*/
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
    
   /* func downloadImage( object :  DataObject ,  url : String)
    {
        if let url = URL(string:  url )
        {
            let task = URLSession.shared.dataTask(with: url, completionHandler:
                { (data, response, error) -> Void in
                    guard let data = data, error == nil else
                    {
                        return
                    }
                    
                    object.image = UIImage(data: data)
                    
                    DispatchQueue.main.async
                    {
                        self.delegate?.didLoadData()
                    }
                    

            })
            
            task.resume()
        }
    }*/
    
    func saveToDisk() -> Bool
    {
        return NSKeyedArchiver.archiveRootObject(objects, toFile: DataBase.ArchiveURL.path)
    }
    func loadFromDisk() -> Bool
    {
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: DataBase.ArchiveURL.path) as? [DataObject]
        {
            objects =  data
            return true
        }
        return false
    }
    
     
}
















