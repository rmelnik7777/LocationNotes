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
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        textName.text = note?.name
        textDiscription.text = note?.textDescription
        imageView.image = note?.imageActual

  
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if textName.text == "" && textDiscription.text == "" && imageView.image == nil {
            CoreDataManager.sharedInstance.managedObjecContext.delete(note!)
            CoreDataManager.sharedInstance.saveContext()
            return
        }
        
        if note?.name != textName.text || note?.textDescription != textDiscription.text {
            note?.dateUpdate = Date()
            CoreDataManager.sharedInstance.saveContext()

        }
        
        note?.name = textName.text
        note?.textDescription = textDiscription.text
        note?.imageActual = imageView.image
        

        
        CoreDataManager.sharedInstance.saveContext()
    
    }

    // MARK: - Table view data source
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 0 {
            let alertController = UIAlertController(title: "Select action", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            let a1Camera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default, handler: { (alert) in
                print("Photo")
                self.imagePicker.sourceType = .savedPhotosAlbum //.camera
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            let a2Photo = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default, handler: { (alert) in
                print("go To biblioteka")
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            })
            
            if self.imageView.image != nil {
                let a3Delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { (alert) in
                self.imageView.image = nil
                })
                alertController.addAction(a3Delete)
            }
            let a4Cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alert) in
                
            })
            alertController.addAction(a1Camera)
            alertController.addAction(a2Photo)
            
            alertController.addAction(a4Cancel)
            present(alertController, animated: true, completion: nil)
        }
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

