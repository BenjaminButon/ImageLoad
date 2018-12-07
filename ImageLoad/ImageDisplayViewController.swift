//
//  ImageDisplayViewController.swift
//  ImageLoad
//
//  Created by Benko Ostap on 12/6/18.
//  Copyright © 2018 Ostap Benko. All rights reserved.
//

import UIKit

class ImageDisplayViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var mainView: MainViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFit
        setImage()
    }
    

    func setImage(){
        guard mainView != nil else { return }
        if let selectedRow = mainView?.tableView.indexPathForSelectedRow{
            if let selectedCell = mainView?.tableView.cellForRow(at: selectedRow) as? CustomCell{
                if let image = selectedCell.cellImageView.image{
                    self.imageView.frame.size = image.size
                    self.imageView.image = image
                    if let imageId = mainView?.imagesArray[selectedRow.section]["id"] as? Int{
                        self.idLabel.text = "#" + String(imageId)
                    } else {
                        self.idLabel.text = "image id"
                    }
                    mainView?.tableView.deselectRow(at: selectedRow, animated: true)
                    
                }
            }
        }
    }
}
