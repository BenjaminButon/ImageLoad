//
//  QueryService.swift
//  ImageLoad
//
//  Created by Benko Ostap on 12/5/18.
//  Copyright © 2018 Ostap Benko. All rights reserved.
//

import Foundation
import UIKit
class QueryService{
    
    static let shared = QueryService()
    private let queue = DispatchQueue.global(qos: .utility)
    
    func loadImageWithId(_ id: Int, into imageView: UIImageView, width: Int, height: Int){
        let urlString = "https://picsum.photos/" + String(width) + "/" + String(height) + "/?image=" + String(id)
        let url = URL(string: urlString)!
        let dataTask = URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{
                print(error.localizedDescription)
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("bad response")
                return
            }
            if let data = data{
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    imageView.image = image
                }
            }
        }
        dataTask.resume()
    }

    func loadArrayFromUrl(_ url: URL, into controller: MainViewController){
        let dataTask = URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("bad response")
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                if let jsonArray = json as? [[String : Any]]{
                    DispatchQueue.main.async {
                        controller.imagesArray = jsonArray
                        controller.tableView.reloadData()
                    }
                }
            }
        }
        dataTask.resume()
    }
    

    
    private init(){}
}
