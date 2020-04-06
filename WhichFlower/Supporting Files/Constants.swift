//
//  Constants.swift
//  WhichFlower
//
//  Created by aisenur on 6.04.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation
import UIKit

struct K {
    
    struct NavigationBar {
        static let navBarColor = "E9E9FF"
        static let titleTextColor = UIColor.darkGray
        static let backTitle = "Back"
    }
    
    struct TableView {
        static let bgColor = UIColor.systemBackground
        static let rowHeight = 80.0
    }
    
    struct FlowerManager {
        static let callModelFailed = "Failed to load model"
        static let coreMLRequestFailed = "Unexpected results"
    }
    
    struct SearchedManager {
        static let saveModelFailed = "Error saving flower"
        static let deleteModelFailed = "Unexpected results"
    }
    
    struct DetailViewController {
        static let descriptionTextInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    struct TableViewController {
        static let detailSceneSegue = "goToDetail"
        static let sortedKey = "dateCreated"
        static let cellTitleColor = "#485460"
        static let cellSubTitleColor = "#bdc3c7"
        static let ciimageConvertError = "Could not convert image to CIImage"
    }
    
    struct SwipeCell {
        static let cellIdentifier = "Cell"
        static let delete = "Delete"
        static let deleteIconName = "delete-icon"
    }
    
    struct Alert {
        static let error = "Error"
        static let ok = "OK"
    }
}
