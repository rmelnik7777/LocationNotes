//
//  FolderVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 23.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class FolderVC: UITableViewController {

    // MARK: - Properties
    
    var folder: Folder?
    var buyingForm = BuyingForm()
    var selectedNote: Note?
    
    var notesActual: [Note] {
        if let folder = folder {
            return folder.notesSorted
        } else {
            return notes
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let folder = folder {
            navigationItem.title = folder.name
        } else {
            navigationItem.title = "All notes"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesActual.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNote", for: indexPath)
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
    }
    
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
    
    // MARK: - Actions
    
    @IBAction func pushAddAction(_ sender: Any) {
        if buyingForm.isNeedToShow {
            buyingForm.showForm(inController: self)
            showBanner()
            return
        }
        selectedNote = Note.newNote(name: "nn", inFolder: folder)
        selectedNote?.addCurrentLocation()
        goToNote()
    }
        
    // MARK: - Navigation

    func goToNote() {
        guard let vc = Router.shared.noteVC() else { return }
        vc.note = self.selectedNote
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showBanner() {
        guard let vc = Router.shared.bannerVC() else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

}
