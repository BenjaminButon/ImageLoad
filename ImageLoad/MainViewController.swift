//
//  ViewController.swift
//  ImageLoad
//
//  Created by Benko Ostap on 12/5/18.
//  Copyright © 2018 Ostap Benko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let listUrl = URL(string: "https://picsum.photos/list")
    var currentImageIndex = 0
    var imagesArray = [[String : Any]]()
    let defaultHeight : CGFloat = 250
    let cellSpacingHeight : CGFloat = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        QueryService.shared.loadArrayFromUrl(listUrl!, into: self)
    }

    func calculateImageSize(currentWidth: CGFloat, currentHeight: CGFloat) -> CGSize{
        let correlation = currentWidth / currentHeight
        let width = self.view.frame.width
        let height = width / correlation
        return CGSize(width: width, height: height)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayImage", let displayImageController = segue.destination as? ImageDisplayViewController{
            displayImageController.mainView = self
        }
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.imagesArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell{
            guard !self.imagesArray.isEmpty else {
                return UITableViewCell()
            }
            cell.cellImageView?.contentMode = .scaleAspectFit
            cell.cellImageView.image =
            let currentImage = imagesArray[indexPath.section]
            guard let currentId = currentImage["id"] as? Int else { return cell}
            guard let currentWidth = currentImage["width"] as? CGFloat else { return cell}
            guard let currentHeight = currentImage["height"] as? CGFloat else { return cell}
            let size = self.calculateImageSize(currentWidth: currentWidth, currentHeight: currentHeight)
            QueryService.shared.loadImageWithId(currentId, into: cell.cellImageView, width: Int(size.width), height: Int(size.height))
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = imagesArray[indexPath.section]
        guard let currentWidth = currentImage["width"] as? CGFloat else { return self.defaultHeight}
        guard let currentHeight = currentImage["height"] as? CGFloat else { return self.defaultHeight}
        let size = self.calculateImageSize(currentWidth: currentWidth, currentHeight: currentHeight)
        return size.height
    }
}
