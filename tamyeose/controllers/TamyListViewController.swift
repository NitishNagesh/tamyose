//
//  ViewController.swift
//  tamyeose
//
//  Created by nitish nayak n on 03/10/18.
//  Copyright © 2018 nitish nayak n. All rights reserved.
//

import UIKit

class TamyListViewController: UITableViewController {
      var ItemArray = [Item]()
      let dataFilePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("itemsPlist")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        print(dataFilePath!)
        let newItem = Item()
        newItem.title = "first item"
        ItemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "second item"
        ItemArray.append(newItem1)
        
        let newItem3 = Item()
        newItem3.title = "third item3"
        ItemArray.append(newItem3)
        
        
        let newItem4 = Item()
        newItem4.title = "fourth item"
        ItemArray.append(newItem4)
     
        }
    

    //MARK -TableView DataSource
    override  func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = ItemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        if item.done == true {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        ItemArray[indexPath.row].done = !ItemArray[indexPath.row].done
      
        tableView.reloadData()
        
      
        
        //MARK addbutton ideas
        
        

    

}
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "ADD NEW ITEM", message:"", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD ITEM", style: .default) { (action) in
        let newItem = Item()
            newItem.title = textField.text!
            
            self.ItemArray.append(newItem)
             let encoder = PropertyListEncoder()
            do
            {
                print(self.ItemArray)
                let data = try encoder.encode(self.ItemArray)
           try data.write(to: self.dataFilePath!)
                
            } catch{
                print("error encoding item array  , \(error)")
            }
            
            
            self.tableView.reloadData()
            
            
           
        }
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "create new text field"
                textField = alertTextField
            }
        
            
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

