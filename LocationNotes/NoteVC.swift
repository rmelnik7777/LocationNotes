//
//  NoteVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 23.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class NoteVC: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDiscription: UITextView!
    @IBOutlet weak var folderLabel: UILabel!
    @IBOutlet weak var folderNameLabel: UILabel!
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        textName.text = note?.name
        textDiscription.text = note?.textDescription
        imageView.image = note?.imageActual

        navigationItem.title = note?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let folder = note?.folder {
            folderNameLabel.text = folder.name
        } else {
            folderNameLabel.text = ""
        }
    }
    
    func saveNote() {
        if textName.text == "" && textDiscription.text == "" && imageView.image == nil {
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
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 && indexPath.section == 0 {
            let alertController = UIAlertController(title: "Select action", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            
            let a1Camera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default, handler: { (alert) in
                self.imagePicker.sourceType = .camera
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(a1Camera)
            
            
            let a2Photo = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default, handler: { (alert) in
                self.imagePicker.sourceType = .savedPhotosAlbum  //.photoLibrary
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(a2Photo)
            
            if self.imageView.image != nil {
                let a3Delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (alert) in
                self.imageView.image = nil
                })
                alertController.addAction(a3Delete)
            }
            let a4Cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alert) in
            })
            alertController.addAction(a4Cancel)

            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func pushDoneAction(_ sender: Any) {
        saveNote()
       _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareNote(_ sender: Any) {
        
        var activities: [Any] = []
//        if note?.imageActual != nil {
//            activities.append(note?.imageActual ?? "")
//        }
        activities.append(note?.name ?? "")
        activities.append(note?.textDescription ?? "")
        
        let activityController = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSelectFolder" {
            (segue.destination as! SelectFolderVC).note = note
        }
        if segue.identifier == "goToMap" {
            (segue.destination as! NoteMapVC).note = note
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}

extension NoteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

