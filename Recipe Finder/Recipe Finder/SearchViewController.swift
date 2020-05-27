//
//  SearchViewController.swift
//  Recipe Finder
//
//  Created by Wen Bo on 4/28/20.
//  Copyright © 2020 Wen Bo. All rights reserved.
//

import UIKit
import Foundation

class SearchViewController: UIViewController {
    
    var hasSearched = false
    var recipes = [[String:Any]]()
    var selectRecipe = [[String:Any]]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
            // Do any additional setup after loading the view.
        
    }
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Helper Methods
    func tastyURL(searchText: String) -> URL {
        let url = URL(string: "https://tasty.p.rapidapi.com/recipes/list?tags="+searchText.lowercased()+"&from=0&sizes=20")
        print(url as Any)
        return url!
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print("Loading up the details screen")
        
        //Find the selected recipe
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let recipe = recipes[indexPath.row]
        
        
        //Pass the select recipe to details view controller
        let detailsViewController = segue.destination as! RecipeDetailsViewController
        detailsViewController.recipe = recipe
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    

}

extension SearchViewController: UISearchBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
           return .topAttached
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty{
            searchBar.resignFirstResponder()
            hasSearched = true
            
            //Get Recipe by Tasty API request with NSURLSession
            let headers = [
                    "x-rapidapi-host": "tasty.p.rapidapi.com",
                    "x-rapidapi-key": "b0484e2dbemsh43bbbbebc17a218p1c72e4jsnec1793b33d2d"
            ]

            
            let searchText = searchBar.text!
            
            let request = NSMutableURLRequest(url: NSURL(string: ("https://tasty.p.rapidapi.com/recipes/list?tags=" + searchText.lowercased()+"&from=0&sizes=20"))! as URL,
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
                     print(dataDictionary)
                 
                 }
            })

                 dataTask.resume()
                 
            
            tableView.reloadData()
        }
        
    }
   
}

extension SearchViewController: UITableViewDelegate,
                                UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        if !hasSearched {
            return 0
        }
        else if recipes.count == 0 {
            return 1
        }
        else {
            return recipes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
       
        if recipes.count == 0 {
            //cell.textLabel!.text = "(Nothing found)"
           
        } else {
            
            let recipe = recipes[indexPath.row]
            let title = recipe["name"] as! String
            
            cell.titleLabel!.text = title
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                  didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if recipes.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}


