//
//  CpuLabe;ViewController.swift
//  Swap-Part
//
//  Created by Michael Kennedy on 8/14/22.
//

import UIKit

class CpuTableViewController: UITableViewController {
    
    var passedCpuList: [cpu] = []
    var passedChosenSocket: String = ""
    var compatibleCpuList: [cpu] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let baseFunctions = ViewController()
        
        compatibleCpuList = baseFunctions.CpuListCompat(passedSocket: passedChosenSocket)

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return compatibleCpuList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cpuCell", for: indexPath)

        cell.textLabel?.text = compatibleCpuList[indexPath.row].name

        return cell
    }

}
