//
//  SavedPicturesVC.swift
//  HDIL
//
//  Created by Richard Velazquez on 5/30/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import UIKit

class SavedPicturesVC: UIViewController, UITableViewDelegate, UITableViewDataSource,SavedPictureCellDelegate {
  var pictures : NSMutableArray?
  var selectedImage : UIImage?
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (self.pictures?.count)!
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("PictureCell") as! SavedPictureCell
    let cellPicture = self.pictures?.objectAtIndex(indexPath.row) as! Picture
    let imageData = cellPicture.binary
    cell.pictureView.image = UIImage(data: imageData!)
    cell.analyzeButton.enabled = true
    cell.delegate = self
  
    return cell
  }
  
  func userDidRequestAnalysisOnImgae(image: UIImage) {
    print("delegte hit")
    self.selectedImage = image
    self.performSegueWithIdentifier("unwind", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "unwind" {
      let destVC = segue.destinationViewController as! HomeVC
      destVC.selectedImage = self.selectedImage
      destVC.didSelectImage = true
    }
  }
  
}
