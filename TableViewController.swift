//
//  TableViewController.swift
//  MVCJSON
//
//  Created by Manuel Deneu on 24/02/2017.
//  Copyright © 2017 FlyLab. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController , DataBaseDelegate {
    
    public var user : DataObjectAPI?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let dataBase = DataBase.shared
        dataBase.delegate = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        dataBase.loadData(id : User.id )
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func didLoadData()
    {
        tableView.reloadData()
        
        /*
        if(DataBase.shared.saveDatas())
        {
            print("Save OK")
        }
        else
        {
            print("Save ERROR")
        }
        */
        
    }
    
    func didLoadDataAtIndex( index : Int)
    {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataBase.shared.objects.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCellule", for: indexPath) as! CustomTableViewCell
        
        
        let item = DataBase.shared.objects[indexPath.row]
        
        //print((user?.first_name)! as String)
        
       /* if let img = item.image
        {
            cell.imageView?.image = img
        }*/
        //cell.textLabel?. = item.reference
        
        cell.referenceLabel?.text = item.reference
        cell.nomLabel?.text = item.nom
        cell.adresseLabel?.text = item.adresse
        cell.contactLabel?.text = item.phone
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "Details")
        {
            if let controller = segue.destination as? DetailsViewController
            {
                if let ligne = tableView.indexPathForSelectedRow?.row
                {
                    controller.object = DataBase.shared.objects[ ligne]
                }
            }
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
