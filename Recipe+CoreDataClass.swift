//
//  Recipe+CoreDataClass.swift
//  Recipez
//
//  Created by Shivam Sharma on 6/19/17.
//  Copyright © 2017 ShivamSharma. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Recipe)
public class Recipe: NSManagedObject {
    func setRecipeImage(image: UIImage) {
        let data = UIImagePNGRepresentation(image)
        self.image = data as NSData?
    }
    
    func getRecipeImage() -> UIImage {
        let image = UIImage(data: self.image! as Data)
        return image!
    }
}
