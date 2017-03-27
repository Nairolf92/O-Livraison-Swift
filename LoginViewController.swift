//
//  LoginViewController.swift
//  MVCJSONBlank
//
//  Created by Antoine Lucas on 02/03/2017.
//  Copyright © 2017 FlyLab. All rights reserved.
//

import UIKit
import SystemConfiguration

class LoginViewController: UIViewController, DataBaseDelegateAPI {
    
    public var object : DataObjectAPI?
    
    @IBOutlet var user_login : UITextField?
    @IBOutlet var user_password : UITextField?
    @IBOutlet var login_button : UIButton?
    
    func isInternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    override func viewDidLoad()
    {
        
        if(isInternetAvailable())
        {
            print("internet ok")
            super.viewDidLoad()
            let dataBase = DataBaseAPI.shared
            dataBase.delegate = self
            
            dataBase.loadData()
        }else
        {
            while isInternetAvailable() == false {
                isInternetAvailable()
                print("internet pas ok")
            }
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func didLoadData()
    {
        
    }
    
    func didLoadDataAtIndex( index : Int)
    {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        /*
           // if(user_login != "" && user_password != "")
            {
                
                if (segue.identifier == "Connection")
                {
                        
                    print(user_login)
                    print(user_password)
                    
                    let list = DataBaseAPI.shared.objects
                 
                    for item in list
                    {
                        if(item.login == user_login && item.password == user_password)
                        {
                            print("ok")

                            controller.user = item
                            break
                            
                        }else{
                            print("pas ok")
                        }
                     
                    }
                }
    
            }
        }
 */
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func connectTouched(sender: AnyObject)
    {
        if let user_login = self.user_login?.text,
            let user_password = self.user_password?.text
        {
            if( !user_login.isEmpty && !user_password.isEmpty )
            {
                let list = DataBaseAPI.shared.objects
                
                for item in list
                {
                    if(item.login == user_login && item.password == user_password)
                    {
                        print("ok")
                        
                        User.id = item.id
                        print(User.id)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "RootNav")
                        self.present(controller, animated: true, completion: nil)
                        
                    }else{
                        print("pas ok")
                    }
                    
                }
                // verif user
                
                // si ok
                //navigationController?.pushViewController(TableViewController(), animated: true)
                
            }
            else
            {
                
            }
        }
    }
    
/*
    @IBAction func signInAction(for segue: UIStoryboardSegue, sender: AnyObject) {
        if let user_login = self.user_login?.text, let user_password = self.user_password?.text
        {
            print(user_login)
            print(user_password)
            
            let list = DataBaseAPI.shared.objects
            var i = 0
            for item in list
            {
                if(item.login == user_login && item.password == user_password)
                {
                    print("ok")
                    let list_user = DataBaseAPI.shared.objects[i]
                    if let controller = segue.destination as? TableViewController
                    {
                        controller.object = list_user
                    }
                    
                }else{
                    print("pas ok")
                }
                i += 1
            }
        }
    }
*/

}
