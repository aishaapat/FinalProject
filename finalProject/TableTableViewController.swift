//
//  TableTableViewController.swift
//  finalProject
//
//  Created by Alex Bringuel on 4/29/25.
//

import UIKit
import CoreData

class TableTableViewController: UITableViewController {
    var places: [Address] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    func loadData() {
        // Fetch Address objects from Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Address> = Address.fetchRequest()
        do {
            places = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Failed to fetch Address: \(error), \(error.userInfo)")
        }

    }
    

    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        super.viewDidLoad()
        loadData()
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesCell", for: indexPath)
        
        cell.textLabel?.text = places[indexPath.row].name
        cell.accessoryType = .detailDisclosureButton

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditPlaces" {
            let editController = segue.destination as! EditViewViewController
            let selectedRow = self.tableView.indexPath(for: sender as! UITableViewCell)?.row
            let selectedPlace = places[selectedRow!] as Address
            editController.currentAddress = selectedPlace
        }
    }
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let address = places[indexPath.row] as? Address
            let context = appDelegate.persistentContainer.viewContext
            context.delete(address!)
            do {
                try context.save()
            } catch {
                fatalError("Error saving context: \(error)")
                
            }
            loadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


}
