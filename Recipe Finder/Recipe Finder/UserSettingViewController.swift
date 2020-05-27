//
//  UserSettingViewController.swift
//  Recipe Finder
//
//  Created by Wen Bo on 5/9/20.
//  Copyright © 2020 Wen Bo. All rights reserved.
//

import UIKit

class UserSettingViewController: UIViewController {

    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var tagtextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let x = UserDefaults.standard.object(forKey: "name") as? String {
                nameLabel.text = x
            }
        if let y = UserDefaults.standard.object(forKey: "tag") as? String {
            tagLabel.text = y
        }
    }
    
    //Change user name and favorite Recipe Tag
    @IBAction func saveAction(_ sender: UIButton) {
        
        nameLabel.text = nametextField.text
        tagLabel.text = tagtextField.text
        UserDefaults.standard.set(nametextField.text, forKey: "name")
        UserDefaults.standard.set(tagtextField.text, forKey: "tag")
        nametextField.text = ""
        tagtextField.text = ""
        
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
