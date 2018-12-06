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
    
    func loadImageWithId(_ id: Int, into imageView: UIImageView){
        print("loading image")
        let urlString = "https://picsum.photos/200/300/?image=" + String(id)
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
                    let image = UIImage(data: data)!
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
    func getImageWithId(_ id: Int) -> Data {
        var resultData = Data()
        let url = URL(string: "https://picsum.photos/200/300/?random")!
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
                    resultData = data
                }
            }
        }
        dataTask.resume()
        
        return resultData
    }
    
    private init(){}
}
