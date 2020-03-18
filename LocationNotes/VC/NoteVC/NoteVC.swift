//
//  NoteVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 23.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class NoteVC: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDiscription: UITextView!
    @IBOutlet weak var folderLabel: UILabel!
    @IBOutlet weak var folderNameLabel: UILabel!
    
    // MARK: - Properties
    
    let imagePicker = UIImagePickerController()
    var note: Note?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNote()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let folder = note?.folder {
            folderNameLabel.text = folder.name
        } else {
            folderNameLabel.text = ""
        }
    }
    
    // MARK: - Helper
    
    func setNote() {
        textName.text = note?.name
        textDiscription.text = note?.textDescription
        imageView.image = note?.imageActual
        navigationItem.title = note?.name
    }
    
    func saveNote() {
        if textName.text!.isEmpty && textDiscription.text.isEmpty && imageView.image == nil {
               CoreDataManager.sharedInstance.managedObjecContext.delete(note!)
               CoreDataManager.sharedInstance.saveContext()
               return
           }
           
           if note?.name != textName.text || note?.textDescription != textDiscription.text {
               note?.dateUpdate = Date()
           }
           
           note?.name = textName.text
           note?.textDescription = textDiscription.text
           note?.imageActual = imageView.image
           CoreDataManager.sharedInstance.saveContext()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 && indexPath.section == 0 {
            let alertController = UIAlertController(title: "Select action", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            
            let a1Camera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default, handler: { _ in
                self.imagePicker.sourceType = .camera
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(a1Camera)
            
            let a2Photo = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default, handler: { _ in
                self.imagePicker.sourceType = .savedPhotosAlbum  //.photoLibrary
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(a2Photo)
            
            if self.imageView.image != nil {
                let a3Delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { _ in
                self.imageView.image = nil
                })
                alertController.addAction(a3Delete)
            }
            let a4Cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
            })
            alertController.addAction(a4Cancel)

            present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func pushDoneAction(_ sender: Any) {
        saveNote()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareNote(_ sender: Any) {
        
        var activities: [Any] = []
        activities.append(note?.name ?? "")
        activities.append(note?.textDescription ?? "")
        
        let activityController = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSelectFolder" {
            (segue.destination as? SelectFolderVC)?.note = note
        }
        if segue.identifier == "goToMap" {
            (segue.destination as? NoteMapVC)?.note = note
        }
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension NoteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imageView.image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
