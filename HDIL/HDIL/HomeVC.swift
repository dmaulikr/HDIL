//
//  HomeVC.swift
//  HDIL
//
//  Created by Richard Velazquez on 5/26/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
  @IBOutlet var HDILButton: UIButton!
  @IBOutlet var refreshButton: UIBarButtonItem!
  @IBOutlet var imageView: UIImageView!
  
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var chooseImageButton: UIButton!
  var imagePicker : UIImagePickerController!
  
  override func viewDidLoad() {
    self.refreshButton.enabled = false
    self.refreshButton.tintColor = UIColor.clearColor()
    self.activityIndicator.hidesWhenStopped = true
    self.activityIndicator.hidden = true
  }
  
 
  @IBAction func ChoosePicture(sender: UIButton) {
    
    self.imagePicker = UIImagePickerController()
    self.imagePicker.delegate = self
    self.imagePicker.sourceType = .SavedPhotosAlbum
    self.presentViewController(self.imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func onHDILPressed(sender: UIButton) {
  self.imagePicker = UIImagePickerController()
  self.imagePicker.delegate = self
  self.imagePicker.sourceType = .Camera
  self.presentViewController(self.imagePicker, animated: true, completion: nil)
    
  }
  
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    self.activityIndicator.hidden = false
    self.activityIndicator.startAnimating()
    picker.dismissViewControllerAnimated(true, completion: nil)
    imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    let data = UIImageJPEGRepresentation((info[UIImagePickerControllerOriginalImage] as? UIImage)!, 0.8)
    DataService.returnImageAnalysisDataUsingData(data)
    self.HDILButton.setTitle("Try Again", forState: .Normal)
    self.chooseImageButton.setTitle("Choose a new picture", forState: .Normal)
  }
  
  
//bridge works
//  let ref = DataService.checkingBridge(string as String)
//  if ref == true {
//  print("true")
//  } else {
//  print("false")
//  }
  
  
  
}