//
//  NameListTableViewController.swift
//  Unit6Test
//
//  Created by Hayden Hastings on 3/17/17.
//  Copyright © 2017 Hayden Hastings. All rights reserved.
//

import UIKit

class NameListTableViewController: UITableViewController {
    
    var names: [Name] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        names = NameController.shared.name
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "images-1"))
       
    }
    
    @IBAction func addNameButtonTapped(_ sender: Any) {
        addNewName()
    }
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        names.randomize()
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \([section + 1][0])"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return NameController.shared.sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if names.count % 2 != 0 && section == NameController.shared.sections - 1 {
            return 1
        }
        return NameController.shared.namesPerSection
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        
        let row = indexPath.row + (NameController.shared.namesPerSection * indexPath.section)
        let name = names[row]
        
        cell.textLabel?.text = name.name
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let name = names[indexPath.row]
            NameController.shared.deleteNames(name: name)
            self.names = NameController.shared.name
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func addNewName() {
        var inputTextField: UITextField?
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            inputTextField = textfield
            textfield.placeholder = "Name"
        }
        
        let add = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let typeText = inputTextField?.text else { return }
            let newName = NameController.shared.addNames(name: typeText)
            self.names.append(newName)
            
            self.tableView.reloadData()
            print("\(typeText)")
        }
        
        let cancle = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in }
        
        alertController.addAction(add)
        alertController.addAction(cancle)
        present(alertController, animated: true, completion: nil)
    }
}



// Tooke me 3 hours and 10 minutes
