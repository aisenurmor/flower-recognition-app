//
//  TableViewController.swift
//  WhichFlower
//
//  Created by aisenur on 30.03.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit
import CoreML
import Vision
import RealmSwift

class TableViewController: SwipeCellController, UINavigationControllerDelegate {
    
    @IBOutlet var notFoundView: UIView!
    
    let flowerManager = FlowerManager()
    var searched: Searched = Searched()
    var searcedManager: SearchedManager?
    
    private let realm = try! Realm()
    private var historyArray: Results<Searched>?
    
    private let imagePicker = UIImagePickerController()
    private var pickedImage: UIImage?
    private var flowerName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navBarCustomization(nav: self.navigationController!)
        
        loadHistory()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: - Load History Method
    func loadHistory() {
        historyArray = realm.objects(Searched.self).sorted(byKeyPath: K.TableViewController.sortedKey, ascending: false)
        tableView.reloadData()
    }
    
    
    // MARK: - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.TableViewController.detailSceneSegue {
            let destinationVC = segue.destination as! DetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                destinationVC.navTitle = historyArray?[indexPath.row].flowerName
                destinationVC.flowerImgUrl = historyArray?[indexPath.row].flowerImgUrl
                destinationVC.flowerDesc = historyArray?[indexPath.row].flowerDescription
            
            } else {
                if let flowerName = flowerManager.getFlowerName(),
                    let desc = flowerManager.getFlowerDesc(),
                    let imgUrl = flowerManager.getFlowerImgUrl() {
                    
                    destinationVC.navTitle = flowerName
                    destinationVC.flowerImgUrl = imgUrl
                    destinationVC.flowerDesc = desc
                }
            }
        } 
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfSections: Int = 0
        
        if historyArray!.count > 0 {
            numOfSections            = historyArray!.count
            tableView.nullTableView(tableView: tableView, view: nil)
        } else {
            tableView.nullTableView(tableView: tableView, view: notFoundView)
        }
        
        return numOfSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = historyArray?[indexPath.row].flowerName?.capitalized ?? "-"
        cell.detailTextLabel?.text = historyArray?[indexPath.row].flowerDescription
        
        cell.textLabel?.textColor = UIColor(named: "#485460")
        cell.detailTextLabel?.textColor = UIColor(named: "#bdc3c7")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: K.TableViewController.detailSceneSegue, sender: nil)
    }
    
    override func updateModel(at indexPath: IndexPath) {
        searched = historyArray![indexPath.row]
        searcedManager = SearchedManager(_searched: searched)
        searcedManager?.delete()
    }
}


//MARK: - Image Picker Controller
extension TableViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            guard let ciImage = CIImage(image: userPickedImage) else {
                
                let alert = UIAlertController(title: K.Alert.error, message: K.TableViewController.ciimageConvertError, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: K.Alert.ok, style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            pickedImage = userPickedImage
            
            flowerManager.detect(pickedImage: self.pickedImage!, ciimage: ciImage) { (completed : Bool) in
                if completed {
                    self.imagePicker.dismiss(animated: true, completion: nil)
                    self.performSegue(withIdentifier: K.TableViewController.detailSceneSegue, sender: nil)
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
}
