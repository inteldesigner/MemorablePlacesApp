//
//  PlacesViewController.swift
//  Memorable places
//
//  Created by Eric Stein on 7/31/19.
//  Copyright © 2019 Eric Stein. All rights reserved.
//

import UIKit

var places = [Dictionary<String, String>()]
var activePlace = -1

class PlacesViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let tempPlaces = UserDefaults.standard.object(forKey: "places") as? [Dictionary<String, String>] { // UserDefaults.standard() is now UserDefaults.standard
            
            places = tempPlaces
            
        }
        
        if places.count == 1 && places[0].count == 0 {
            
            places.remove(at: 0)
            
            places.append(["name":"Taj Mahal","lat":"27.175277","lon":"78.042128"])
            
            UserDefaults.standard.set(places, forKey: "places") // UserDefaults.standard() is now UserDefaults.standard
            
        }
        
        activePlace = -1
        
        table.reloadData()
        
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            places.remove(at: indexPath.row)
            
            UserDefaults.standard.set(places, forKey: "places") // UserDefaults.standard() is now UserDefaults.standard
            
            table.reloadData()
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        
        if places[indexPath.row]["name"] != nil {
            
            cell.textLabel?.text = places[indexPath.row]["name"]
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activePlace = indexPath.row
        
        performSegue(withIdentifier: "toMap", sender: nil)
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
