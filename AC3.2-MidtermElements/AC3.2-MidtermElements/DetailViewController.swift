//
//  DetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Amber Spadafora on 12/8/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var element: Element?

    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var meltingPt: UILabel!
    @IBOutlet weak var boilingPT: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var atomicWeight: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = element?.name!
        
        if let symbol = element?.symbol {
            let imageUrl: String = "https://s3.amazonaws.com/ac3.2-elements/\(symbol).png"
            APIRequestManager.manager.getData(endPoint: imageUrl){ (data) in
                
                if let unwrappedData = data {
                    DispatchQueue.main.async {
                        self.largeImage.image = UIImage(data: unwrappedData)
                    }
                }
            }
        }
        
        self.number.text = "\(element?.number!)"
        self.atomicWeight.text = "\(element?.weight!)"

    }
    

    @IBAction func makeFavElement(_ sender: UIButton) {
        let elementSymbol = self.element?.symbol
        let post = ["my_name": "Amber", "favorite_element":"\(elementSymbol)"]
        
        APIRequestManager.manager.postRequest(endPoint: "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites", data: post)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
