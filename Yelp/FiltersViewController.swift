//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Na Li on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: FiltersViewControllerDelegate?
    
    var categories: [[String:String]]!
    var switchStates = [Int:Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = yelpCategories()
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        var filters = [String : AnyObject]()
        
        var selectedCategories = [String]()
        for(row,isSelected) in switchStates{
            if(isSelected){
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        if(selectedCategories.count > 0){
            filters["categories"] = selectedCategories as AnyObject?
        }
        
        delegate?.filtersViewController!(filtersViewController: self, didUpdateFilters: filters)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        
        cell.switchLabel.text = categories[indexPath.row]["name"]
        cell.delegate = self
        
        //if(switchStates[indexPath.row] != nil){
            //cell.onSwitch.isOn = switchStates[indexPath.row]!
        //}else{
            //cell.onSwitch.isOn = false
        //}
        cell.onSwitch.isOn = switchStates[indexPath.row] ?? false
        
        return cell
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        
        
        switchStates[indexPath.row] = value
        
    }
    
    func yelpCategories() -> [[String:String]] {
        return [["name" : "Afghan", "code": "afghani"],
                ["name" : "African", "code": "african"],
                ["name": "American", "code": "newamerican"],
                ["name": "Arabian", "code": "arabian"],
                ["name": "Argentine", "code": "argentine"],
                ["name": "Armenian", "code": "armenian"],
                ["name": "Austrian", "code": "austrian"],
                ["name": "Baguettes", "code": "baguettes"],
                ["name": "Bangladeshi", "code": "bangladeshi"],
                ["name": "Barbeque", "code": "bbq"],
                ["name": "Basque", "code": "basque"],
                ["name": "Bavarian", "code": "bavarian"]]
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
