//
//  ViewController.swift
//  MemeMe 1
//
//  Created by مي الدغيلبي on 27/01/1441 AH.
//  Copyright © 1441 مي الدغيلبي. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate ,UITextFieldDelegate{
    
    
    
    // Outlet
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var buttomToolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var AlbumButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var CancelButton: UIToolbar!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        setTextField( textfailed: topTextField, defaultText: "TOP")
        setTextField( textfailed: bottomTextField, defaultText: "BOTTOM")

        subscribeToHideKeyboardNotifications()
    }
    
    
override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    
    unsubscribeToKeyboardNotifications()
}

    
   //The user might select an image
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    //The user might cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)

    }
    
   //when user choose pick an image from Album
    @IBAction func pressdAlbum(_ sender: Any) {
        
        pickAnImage(from : .photoLibrary)
        
    }
    
    //when user choose pick an image from Camera
    @IBAction func pressedCamera(_ sender: Any) {
        
        pickAnImage(from : .camera)
            }
    
    
    //pick an image from camera or Album
    func pickAnImage(from source: UIImagePickerController.SourceType) {
        
        
        let imagePicker = UIImagePickerController()
         imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
        
    }
    
   //text fielad
    
    func setTextField(textfailed : UITextField, defaultText:String){
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor:UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -2.0
        ]

        textfailed.text=defaultText
        textfailed.delegate = self
        textfailed.defaultTextAttributes = memeTextAttributes
        textfailed.textAlignment = .center
    }
    
    
    //share Meme
    @IBAction func SharePhoto(_ sender: Any) {
        
       let controller = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (type, completed, items, error) in
            if (completed) {

                self.save()
            }
        
            self.dismiss(animated: true, completion: nil)
        }
        self.present(controller, animated: true, completion: nil)
        
    }
    
    //Cancel Button
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    //text delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.text == "TOP" || textField.text == "BOTTOM" {
        textField.text=" "
        }
            return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    //Keyboard
    func subscribeToHideKeyboardNotifications(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowNotification(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideNotification(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    @objc func keyboardWillShowNotification(_ notification:Notification){
        
        if bottomTextField.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    
    @objc func keyboardWillHideNotification(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    
    
    //generate Memed Image
    func generateMemedImage() -> UIImage {
        
        
        hideToolbar(hide: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideToolbar( hide: false)

        return memedImage
    }
    
   //Hide tool bar
    func hideToolbar(hide: Bool){
        buttomToolbar.isHidden = hide
        topToolbar.isHidden = hide
    }
    

    
    //Save Meme
    func save(){
    
    let meme = Meme( topText: topTextField.text!, bottomText: bottomTextField.text! , originalImage: imagePickerView! , memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
   (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    

}

}


    

    

    

    
    


