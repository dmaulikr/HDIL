//
//  SavedPictureCell.swift
//  HDIL
//
//  Created by Richard Velazquez on 5/30/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import UIKit

protocol SavedPictureCellDelegate {
  
  func userDidRequestAnalysisOnImgae(image: UIImage)
  
}

class SavedPictureCell: UITableViewCell {
  
  @IBOutlet var pictureView: UIImageView!
  
  
  @IBOutlet var analyzeButton: UIButton!
  
  var delegate:SavedPictureCellDelegate?


  @IBAction func onAnalyzePressed(sender: UIButton) {
    let image = self.pictureView.image
    delegate!.userDidRequestAnalysisOnImgae(image!)
  }
}
