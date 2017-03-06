//
//  DetailsViewController.swift
//  MVCJSONBlank
//
//  Created by Florian Kelnerowski on 27/02/2017.
//  Copyright © 2017 FlyLab. All rights reserved.
//

import UIKit

class DetailsViewController: UITableViewController {
    
    public var object : DataObject?
    
    @IBOutlet var NomClientLabel : UILabel?
    @IBOutlet var phoneClientLabel : UILabel?
    @IBOutlet var adresseLabel : UILabel?
    @IBOutlet var totalLabel : UILabel?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        NomClientLabel?.text = object?.nom
        phoneClientLabel?.text = object?.phone
        adresseLabel?.text = object?.adresse
        totalLabel?.text = object?.prix_total
        
        if let id_commande = object?.id
        {
            User.id_commande = id_commande
        }
        if let adresse = object?.adresse
        {
            User.adresse = adresse
        }

        // Do any additional setup after loading the view.
    }

}
