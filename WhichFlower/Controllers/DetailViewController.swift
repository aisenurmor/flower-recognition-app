//
//  ViewController.swift
//  WhichFlower
//
//  Created by aisenur on 29.03.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit
import CoreML
import Vision
import SDWebImage

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    
    let flowerManager = FlowerManager()
    
    public var flowerImgUrl: String?
    public var navTitle: String?
    public var flowerDesc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navBarCustomization(nav: self.navigationController!)
        
        descriptionText.isScrollEnabled = true
        descriptionText.showsVerticalScrollIndicator = false
        descriptionText.textContainerInset = K.DetailViewController.descriptionTextInsets
        
        if let title = navTitle {
            self.title = title.capitalized
        }
        
        if let imageUrl = flowerImgUrl {
            imageView.sd_setImage(with: URL(string: imageUrl))
        }
        
        if let desc = flowerDesc {
            descriptionText.text = desc
        }
        
    }
}
