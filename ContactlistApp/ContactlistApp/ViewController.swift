//
//  ViewController.swift
//  ContactlistApp
//
//  Created by Koduru,Krishna Ruthwik Reddy on 4/19/22.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return contactNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell
        let cell = tableviewOutlet.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        //populate the data
        cell.textLabel?.text = contactNames[indexPath.row]
        
        //return cell
        return cell
    }
    
    

    @IBOutlet weak var tableviewOutlet: UITableView!
    
    var contactNames : [String] = []
    var contacts = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableviewOutlet.delegate = self
        tableviewOutlet.dataSource = self
        fetchData()
    }

    
    func fetchData(){
        
        let databaseRef = Database.database().reference()
        
        databaseRef.observeSingleEvent(of: .value) {
            snapshot in
            let contacts = snapshot.value as! NSDictionary
            
            self.contactNames = contacts.allKeys as! [String]
            
            self.tableviewOutlet.reloadData()
        }
    }

}

