//
//  ViewController.swift
//  Recipe Finder
//
//  Created by Wen Bo on 4/25/20.
//  Copyright © 2020 Wen Bo. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class RecipeViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate {
    
   
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chooseRecipeButton: UIButton!
    
    var recipes = [[String:Any]]()
    var audioPlayer: AVAudioPlayer!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print("Hello")
        
        
        //UIView animation for WelcomeButton and TagLabel
        chooseRecipeButton.frame = CGRect(x: 100, y: 118, width: 218, height: 37)
        tagLabel.frame = CGRect(x: 20, y: 201, width: 374, height: 24)
        
        UIView.animate(withDuration: 2) {
            self.chooseRecipeButton.frame = CGRect(x: 100, y: 118, width: 518, height: 37)
            self.tagLabel.frame = CGRect(x: 20, y: 301, width: 374, height: 24)
            
        }
        
        //Get the Tag List by Tasty API request with NSURLSession
        let headers = [
            "x-rapidapi-host": "tasty.p.rapidapi.com",
            "x-rapidapi-key": x-rapidapi-key
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://tasty.p.rapidapi.com/tags/list")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
            }
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.recipes = dataDictionary["results"] as! [[String:Any]]
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                    
                }
                //print(dataDictionary)
                
            }
        })

        dataTask.resume()
        

        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let recipe = recipes[indexPath.row]
        let title = recipe["name"] as! String
        
        
        cell.textLabel!.text = title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    //Play a sound when button is pressed
    @IBAction func playButtonPressed(_ sender: UIButton) {
         if let soundURL = Bundle.main.url(forResource: "sounds", withExtension: "mp3") {
               
                   do {
                       audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                   }
                   catch {
                       print(error)
                   }
                   
                   audioPlayer.play()
               }else{
                   print("Unable to locate audio file")
               }
    }
    
   
   
    

    
    
    
}

