//
//  FolderVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 23.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class FolderVC: UITableViewController {

    
    var folder: Folder?
    var notesActual: [Note] {
        if let folder = folder {
            return folder.notesSorted
        } else{
            return notes
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let folder = folder {
            navigationItem.title = folder.name
        } else{
            navigationItem.title = "All notes"
        }
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return folder!.notes!.count
        return notesActual.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNote", for: indexPath)
//        let noteInCell = folder!.notesSorted[indexPath.row]
        let noteInCell = notesActual[indexPath.row]
        cell.textLabel?.text = noteInCell.name
        cell.detailTextLabel?.text = noteInCell.dateUpdateString
        if noteInCell.imageSmall != nil {
            cell.imageView?.image = UIImage(data: noteInCell.imageSmall!)
        } else {
            cell.imageView?.image = nil
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteInCell = notesActual[indexPath.row]
        selectedNote = noteInCell
        goToNote()
//        performSegue(withIdentifier: "goToNote", sender: self)
    }
    
    var buyingForm = BuyingForm()
    
    var selectedNote: Note?
    @IBAction func pushAddAction(_ sender: Any) {
        if buyingForm.isNeedToShow {
            buyingForm.showForm(inController: self)
            return
        }
        selectedNote = Note.newNote(name: "nn", inFolder: folder)
        selectedNote?.addCurrentLocation()
        goToNote()
//        performSegue(withIdentifier: "goToNote", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToNote"{
//            (segue.destination as? NoteVC)?.note = selectedNote
//        }
//    }
    
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
            CoreDataManager.sharedInstance.managedObjecContext.delete(notesActual[indexPath.row])
            CoreDataManager.sharedInstance.saveContext()
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


    // MARK: - Navigation

    func goToNote() {
        guard let vc = Router.shared.noteVC() else { return }
        vc.note = self.selectedNote
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
