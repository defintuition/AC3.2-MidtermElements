//
//  ElementTableVC.swift
//  AC3.2-MidtermElements
//
//  Created by Amber Spadafora on 12/8/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ElementTableVC: UITableViewController {
    
    let reuseId: String = "element"
    var elementsArray: [Element] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadElements()
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ElementCellVC = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! ElementCellVC
        
        cell.symbolLabel.text = elementsArray[indexPath.row].symbol!
        cell.nameLabel.text = "\(elementsArray[indexPath.row].name!) (\(elementsArray[indexPath.row].number!))"
        
        let symbol = elementsArray[indexPath.row].symbol!
        
        let thumbnailUrl: String = "https://s3.amazonaws.com/ac3.2-elements/\(symbol)_200.png"
        APIRequestManager.manager.getData(endPoint: thumbnailUrl){ (data) in
            
            if let unwrappedData = data {
                DispatchQueue.main.async {
                    cell.thumbNailImage.image = UIImage(data: unwrappedData)
                }
            }
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tappedCell: ElementCellVC = sender as? ElementCellVC {
            if segue.identifier == "tappedElement" {
                let destinationVC = segue.destination as! DetailViewController
                let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedCell)!
                
                let selectedElement: Element = elementsArray[cellIndexPath.row]
                destinationVC.element = selectedElement
                
                
            }
        }
    }
 
    func loadElements(){
        APIRequestManager.manager.getData(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements") { (data) in
            
            if let unwrappedData = data {
                guard let elements = Element.getElements(data: unwrappedData)
                    else { return }
                DispatchQueue.main.async {
                    self.elementsArray = elements
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    

}





















