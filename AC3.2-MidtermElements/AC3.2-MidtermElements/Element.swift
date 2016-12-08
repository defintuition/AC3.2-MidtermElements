//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Amber Spadafora on 12/8/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation


//
//"id": 90,
//"record_url": "https://fieldbook.com/records/5848deac37802c0400b17cc4",
//"number": 90,
//"weight": 232.0381,
//"name": "Thorium",
//"symbol": "Th",
//"melting_c": 1750,
//"boiling_c": 4790,
//"density": 11.72,
//"crust_percent": null,
//"discovery_year": "1829",
//"group": 102,
//"electrons": "[Rn] 6d2 7s2",
//"ion_energy": 6.3067

//func nullToNil(value : AnyObject?) -> AnyObject? {
//    if value is NSNull {
//        return nil
//    } else {
//        return value
//    }
//}


class Element: NSObject {
    let id: Int?
    let recordUrl: String?
    let number: Int?
    let weight: Float?
    let name: String?
    let symbol: String?
    var density: Int?
    let discoveryYear: String?
    let group: Int?
    let electrons: String?
    var ionEnergy: Double?
    var crustPercent: Double?
    
    init(id: Int?, recordUrl: String?, number: Int?, weight: Float?, name: String?, symbol: String?, density: Int?, discoveryYear: String?, group: Int?, electrons: String?, ionEnergy: Double?, crustPercent: Double?){
        
        self.id = id
        self.recordUrl = recordUrl
        self.number = number
        self.weight = weight
        self.name = name
        self.symbol = symbol
        
        self.density = density
        self.discoveryYear = discoveryYear
        self.group = group
        self.electrons = electrons
        self.ionEnergy = ionEnergy
        self.crustPercent = crustPercent
    }
    
    convenience init?(from dict: [String: Any]) {
        var dense: Int?
        var ionEnergy: Double?
        var crustPercent: Double?
        var electrons: String?
        
        guard let id = dict["id"] as! Int? else {
            print("issue with id")
            return nil
        }
        guard let recordUrl = dict["record_url"] as! String? else {
            print("issue with recordUrl")
            return nil
        }
        guard let number = dict["number"] as! Int? else {
            print("issue with number")
            return nil
        }
        guard let weight = dict["weight"] as! Float? else {
            print("issue with weight")
            return nil
        }
        guard let name = dict["name"] as! String? else {
            print("issue with name")
            return nil
        }
        guard let symbol = dict["symbol"] as! String? else {
            print("issue with symbol")
            return nil
        }
        guard let discoveryYear = dict["discovery_year"] as! String? else {
            print("issue with discoveryYear")
            return nil
        }
        guard let group = dict["group"] as! Int? else {
            print("issue with group")
            return nil
        }
//        guard let electrons = dict["electrons"] as! String? else {
//            print("issue with electrons")
//            return nil
//        }
        
        if let elect = dict["electrons"] as? String {
            electrons = elect
        } else {
            electrons = nil
        }
        
        
        if let density = dict["density"] as? Int {
            dense = density
        } else {
            dense = nil
        }
        
        if let ionEn = dict["ion_energy"] as? Double {
            ionEnergy = ionEn
        } else {
            ionEnergy = nil
        }
        
        
        if let crustPerc = dict["crust_percent"] as? Double {
            crustPercent = crustPerc
        } else {
            crustPercent = nil
        }
        
        
        
        self.init(id: id, recordUrl: recordUrl, number: number, weight: weight, name: name, symbol: symbol, density: dense, discoveryYear: discoveryYear, group: group, electrons: electrons, ionEnergy: ionEnergy, crustPercent: crustPercent)
    }
    

    
    static func getElements(data: Data?) -> [Element]? {
        var elements: [Element] = []
        
        do{
            let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
            guard let response: [[String: Any?]] = jsonData as? [[String: Any]] else {
                print("error with converting data into jsonObject")
                return nil
            }
            
            for dict in response {
                
                if let elementData: Element = Element(from: dict) {
                    elements.append(elementData)
                } else {
                    print("There was an empty dict")
                }
            }
        }
        
        catch{
            print("error was thrown: \(error)")
        }
        return elements
    }
    
    
}




















