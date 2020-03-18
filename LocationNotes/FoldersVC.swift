//
//  FoldersVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 22.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class FoldersVC: UITableViewController {

    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new folder", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (text) in
            text.placeholder = "Folder name"
        }
        
        let alertActionAdd = UIAlertAction(title: "Create", style: UIAlertAction.Style.default) { (alert) in
            var folderName = alertController.textFields?[0].text
            if folderName == ""{
                folderName =  "NEW FOLDER"
            }
            _ = Folder.newFolder(name: folderName!.uppercased())
            CoreDataManager.sharedInstance.saveContext()
            self.tableView.reloadData()
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default){ (alert) in
            
        }
        alertController.addAction(alertActionAdd)
        alertController.addAction(alertActionCancel)
        
        present(alertController, animated: true, completion: nil)
        
        
        
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shareInstance.requestAutorization()
//        LocationManager.shareInstance.getCurrentLocation { (location) in
//            print(location)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFolder", for: indexPath)
        let folderInCell = folders[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = folderInCell.name
        cell.detailTextLabel?.text = "\(folderInCell.notes!.count) item(-s)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderInCell = folders[indexPath.row]
        performSegue(withIdentifier: "goToFolder", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFolder" {
            let selectedFolder = folders[tableView.indexPathForSelectedRow!.row]
            (segue.destination as! FolderVC).folder = selectedFolder
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let folderInCell = folders[indexPath.row]
            CoreDataManager.sharedInstance.managedObjecContext.delete(folderInCell)
            CoreDataManager.sharedInstance.saveContext()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func subscribeButtonTapped(_ sender: Any) {
//        navigationController?.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
}
