//
//  DetectFlower.swift
//  WhichFlower
//
//  Created by aisenur on 2.04.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation
import UIKit
import CoreML
import Vision


class FlowerManager {
    private var flowerName: String?
    private var flowerDescription: String?
    private var flowerImgUrl: String?
    
    public func getFlowerName() -> String? {
        return flowerName
    }
    
    public func getFlowerDesc() -> String? {
        return flowerDescription
    }
    
    public func getFlowerImgUrl() -> String? {
        return flowerImgUrl
    }
    
    public func detect(pickedImage: UIImage, ciimage: CIImage, completion: @escaping (_ value:Bool)->()) {
        
        let request = coreMLRequest() { (comp: Bool) in
            completion(comp)
        }
        
        let handler = VNImageRequestHandler(ciImage: ciimage)
        DispatchQueue.global().sync {
            do {
                try handler.perform([request])
                
            } catch {
                print(error)
            }
        }
    }
    
    
    //MARK: -  //Try and load the model
    private func callModel() -> VNCoreMLModel {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError(K.FlowerManager.callModelFailed)
        }
        return model
    }
    
    
    //MARK: - Create a vision request
    private func coreMLRequest(completion: @escaping(Bool)->()) -> VNCoreMLRequest {
        let model = callModel()
        
        let request = VNCoreMLRequest(model: model) {request, error in
            guard let results = request.results as? [VNClassificationObservation]
                else {
                    fatalError(K.FlowerManager.coreMLRequestFailed)
            }
            let name = results.first!.identifier
            self.flowerName = name
            
            NetworkManager.request.getFlowerInformation(flowerName: name) { (desc : String, imgUrl: String) in
                
                self.flowerDescription = desc
                self.flowerImgUrl = imgUrl
                
                let searched = Searched()
                searched.flowerName = name
                searched.flowerDescription = desc
                searched.flowerImgUrl = imgUrl
                
                self.saveFlower(searched)
                
                completion(true)
            }
        }
        
        return request
    }
    
    private func saveFlower(_ searched: Searched) {
        var searcedManager: SearchedManager?
        searcedManager = SearchedManager(_searched: searched)
        searcedManager!.save()
    }
}
