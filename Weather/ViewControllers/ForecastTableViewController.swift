//
//  ForecastTableViewController.swift
//  Weather
//
//  Created by  Adele Shavalieva on 13/11/2019.
//  Copyright © 2019  Adele Shavalieva. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    var viewModels: [ForecastViewModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }
 
    
   // var viewModels = [ForecastViewModel] ()
    
    func getViewModels() -> [ForecastViewModel]{
        return viewModels
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ForecastTableViewCell
        
        let vm = viewModels[indexPath.row]
        let temp = Double(vm.temperature - 273.15)
        let wind = vm.wind
        cell.forecastImageView.image = vm.image
        cell.temperatureLabel.text = "\(Int(temp))°C"
        cell.cityLabel.text = vm.city
        cell.directionLabel.text = vm.direction
        cell.windLabel.text = "\(wind) м/s"
        
        return cell
    }
    
    
    // Delete rows
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //let viewModel = viewModels[indexPath.section]
            self.viewModels.remove(at: indexPath.row)
            tableView.reloadData()
           // tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Add row
    func AddRow(city: String,country: String){
        let location = city + "," + country
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.getCity(city:location) { (viewModel : ForecastViewModel) in
            self.viewModels.append(viewModel)
        }
        tableView.reloadData()
        //tableView.beginUpdates()
        //tableView.insertRows(at: [IndexPath(row: viewModels.count-1, section: 0)], with: .automatic)
        //tableView.endUpdates()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToSearchPage") {
            let navigation = segue.destination as? UINavigationController
            
            let cltvc = navigation!.topViewController as! SearchTableViewController
            
            cltvc.vc = self
            
        }
    }
    
    
   /*
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            self.viewModels.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .red
        
        return action
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.viewModels.remove(at: indexPath.row)
            
            let smth = self.tableView
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .red
        
        return action
    }
 */
}
