//
//  HousesTableViewController.swift
//  CoreDataPractice
//
//  Created by Sau Chung Loh on 10/20/16.
//  Copyright © 2016 Matthew Loh. All rights reserved.
//

import UIKit
import CoreData

class HousesTableViewController: UITableViewController {

// If you want to use the dot syntax to access properties, cast as the Class i.e. 'House' rather than NSManagedObject
//    var houses = [NSManagedObject]()
    
    var houses = [House]()
    let coreDataStack = CoreDataStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView .dataSource = self
        coreDataStack.seedCoreDataIfNeeded()
        fetchHouses()
        //testingMethodPurgeData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchHouses() {
        let housesFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "House")
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        do {
            let results = try managedContext.fetch(housesFetchRequest)
            //houses = results as! [NSManagedObject]
            houses = results as! [House]
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Unable to fetch \(error), \(error.userInfo)")
        }
    }
    
    func testingMethodPurgeData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        do {
            try coreDataStack.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: managedContext)
            tableView.reloadData()
        } catch let error as NSError {
            // TODO: handle the error
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return houses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath) as! HouseTableViewCell
        let house = houses[indexPath.row]
//        cell.houseNameLabel.text = house.value(forKey: "name") as? String
//        cell.houseMottoLabel.text = house.value(forKey: "motto") as? String
//        cell.houseLocationLabel.text = house.value(forKey: "location") as? String
        
        cell.houseNameLabel.text = house.name
        cell.houseMottoLabel.text = house.motto
        cell.houseLocationLabel.text = house.location
        
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
