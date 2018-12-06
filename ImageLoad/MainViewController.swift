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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        QueryService.shared.loadArrayFromUrl(listUrl!, into: self)
    }


    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(self.imagesArray.count) + " array")
        return self.imagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell{
            guard !self.imagesArray.isEmpty else {
                return UITableViewCell()
            }
            let currentImage = imagesArray[indexPath.row]
            if let currentId = currentImage["id"] as? Int{
                QueryService.shared.loadImageWithId(currentId, into: cell.cellImageView)
            }
            print(indexPath.row)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}
