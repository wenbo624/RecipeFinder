//
//  RecipeDetailsViewController.swift
//  Recipe Finder
//
//  Created by Wen Bo on 5/7/20.
//  Copyright © 2020 Wen Bo. All rights reserved.
//

import UIKit
import Foundation


class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    var recipes = [[String:Any]]()
    var recipe: [String:Any]!
    
    var myString: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        if(recipe["instructions"] == nil) {
            print("There is no data")
            myString = "Sorry! This recipe has no instructions yet. Please choose another one."
           /* recipes = recipe["instructions"] as! [[String : Any]]
            for index in recipes {
                myString += index["display_text"] as! String
                myString += "\n"
                
            }*/
        } else {
           recipes = recipe["instructions"] as! [[String : Any]]
            for index in recipes {
                myString += index["display_text"] as! String
                myString += "\n"
            }
                
        }
        
        print(myString)
        
        titleLabel.text = (recipe["name"]) as? String
        titleLabel.sizeToFit()
        
        
        detailTextView.text = myString
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
