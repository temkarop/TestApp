//
//  NewPostTableViewController.swift
//  TestApp
//
//  Created by Артем Ропавка on 24.09.2021.
//

import UIKit

class NewPostTableViewController: UITableViewController {
    
//    var post: Post?
    let alertService = AlertService()
//    let networkService = NetworkService()
    let baseURL = "https://scripts.qexsystems.ru/test_ios/public/api"
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var newImagePost: UIImageView!
    @IBOutlet weak var newNamePost: UITextField!
    @IBOutlet weak var newDescriptionPost: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        saveButton.isEnabled = false
        newNamePost.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        newDescriptionPost.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
//        func saveNewPost() {
//            let newNamePost = newNamePost.text
//            let newDescriptionPost = newDescriptionPost.text
//            
//            let post = ["name": newNamePost,
//                        "description": newDescriptionPost]
//    //                       "photo": newImagePost
//            
//                networkService.postToSave(endPoint: "/post/create", parameters: post as [String : Any]) { [weak self] (result) in
//                switch result{
//                    
//                case .success(let post):
//                    self?.performSegue(withIdentifier: "savePost", sender: post)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
    }
//    @IBAction func savaButton(_ sender: Any) {
//
//        let newNamePost = newNamePost.text
//        let newDescriptionPost = newDescriptionPost.text
//
//        let post = ["name": newNamePost,
//                    "description": newDescriptionPost]
////                       "photo": newImagePost
//
//            networkService.postToSave(endPoint: "/post/create", parameters: post as [String : Any]) { [weak self] (result) in
//            switch result{
//
//            case .success(let post):
//                self?.performSegue(withIdentifier: "savePost", sender: post)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
// MARK: Text field delegate

extension NewPostTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        
        if newNamePost.text!.isEmpty == false && newDescriptionPost.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
}
// MARK: Work with image

extension NewPostTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        newImagePost.image = info[.editedImage] as? UIImage
        newImagePost.contentMode = .scaleAspectFit
        newImagePost.clipsToBounds = true
        dismiss(animated: true)
        
    }
    
}
