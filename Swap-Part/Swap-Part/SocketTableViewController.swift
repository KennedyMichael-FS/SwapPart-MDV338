//
//  SocketTableViewController.swift
//  Swap-Part
//
//  Created by Michael Kennedy on 8/14/22.
//

import UIKit

class SocketTableViewController: UITableViewController {
    
    var passedCpuList: [cpu] = []
    var selectedSocket: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedSockets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "socketCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = passedSockets[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSocket = passedSockets[indexPath.row].description
        self.performSegue(withIdentifier: "showCpus", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? CpuTableViewController {
            
            var compatibleCpus: [cpu] = []
            
            for item in passedCpuList {
                if item.socket == selectedSocket.description {
                    compatibleCpus.append(item)
                }
            }
            
            destination.compatibleCpuList = compatibleCpus
            
        }
        
    }
}
