//
//  CreateRecipeVC.swift
//  Recipez
//
//  Created by Shivam Sharma on 6/19/17.
//  Copyright © 2017 ShivamSharma. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        recipeImage.layer.cornerRadius = 4.0
        recipeImage.clipsToBounds = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            recipeImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImage(sender: UIButton!) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func createRecipe(sender: UIButton!) {
        if let title = recipeTitle.text, title != "" {
            let app = UIApplication.shared.delegate as! AppDelegate
            let context = app.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: context)!
            
            let recipe = Recipe(entity: entity, insertInto: context)
            
            recipe.title = title
            recipe.ingredients = recipeIngredients.text
            recipe.steps = recipeSteps.text
            recipe.setRecipeImage(image: recipeImage.image!)
            
            context.insert(recipe)
            
            do {
                try context.save()
                //recipe.append(recipe)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
