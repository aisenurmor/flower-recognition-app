//
//  NetworkManager.swift
//  WhichFlower
//
//  Created by aisenur on 4.04.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager {
    private var flowerDescription: String?
    
    static var request = NetworkManager()
    
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    func getFlowerInformation(flowerName: String, completion: @escaping(_ desc: String, _ imgUrl: String)->()) {
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize": "500"
        ]
        
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
                if response.result.isSuccess {
                    let flowerJSON: JSON = JSON(response.result.value!)
                    let pageId = flowerJSON["query"]["pageids"][0].stringValue
                    
                    let desc = flowerJSON["query"]["pages"][pageId]["extract"].stringValue
                    let imgUrl = flowerJSON["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
                    
                    completion(desc, imgUrl)
                }
            }
    }
}
