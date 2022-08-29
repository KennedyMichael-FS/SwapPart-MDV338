//
//  CpuLabe;ViewController.swift
//  Swap-Part
//
//  Created by Michael Kennedy on 8/14/22.
//

import UIKit
import SafariServices

class CpuVendorSelectViewController: UIViewController {
    
    var cpuList : [cpu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DownloadData(toDownload: "https://top-computer-parts.p.rapidapi.com/top/26/cpu")
    }
    
    func DownloadData(toDownload: String) {
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        if let validURL = URL(string: toDownload) {
            
            var request = URLRequest(url: validURL)
            request.setValue("9fd6ff1ec4msh26002748290f4d7p18e423jsnfef714a328ce", forHTTPHeaderField: "x-RapidAPI-Key")
            request.setValue("top-computer-parts.p.rapidapi.com", forHTTPHeaderField: "x-RapidAPI-Host")
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if let error = error {
                    print("Task failed with error: " + error.localizedDescription)
                    return
                }
                
                print("Success")
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200,
                      let validData = data
                        else { print("JSON Creation Failed"); return}
                
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [String]
                    
                    self.ParseData(jsonObject: jsonObj!)
                }
                catch{
                    print(error.localizedDescription)
                }
                
            })
            
            task.resume()
        }
    }
    
    func ParseData(jsonObject: [String]?) {

        guard let json = jsonObject
        else { print("Failed to unwrap json data!"); return}
        
        let object = json as [String]
        
        for string in object {
            let stringSeparated = string.components(separatedBy: ",")
            let newDevice = cpu(name: "\(stringSeparated[3])", brand: "\(stringSeparated[2])", link: stringSeparated[7])
            cpuList.append(newDevice)
        }

    }
    
    @IBAction func intelSelected(_ sender: Any) {
        
        var passedCpus : [cpu] = []
        
        for cpu in cpuList {
            if cpu.brand == "Intel" {
                passedCpus.append(cpu)
            }
        }
        
        cpuList = passedCpus
        
        performSegue(withIdentifier: "vendorSelected", sender: self)
    }
    
    @IBAction func amdSelected(_ sender: Any) {
        
        var passedCpus : [cpu] = []
        
        for cpu in cpuList {
            if cpu.brand == "AMD" {
                passedCpus.append(cpu)
            }
        }
        
        cpuList = passedCpus
        
        performSegue(withIdentifier: "vendorSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CpuTableViewController {
            destination.passedCpuList = cpuList
        }
    }
    
}

class CpuTableViewController: UITableViewController {
    
    var passedCpuList: [cpu] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return passedCpuList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cpuCell", for: indexPath)

        cell.textLabel?.text = passedCpuList[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc = SFSafariViewController(url: URL(string: passedCpuList[indexPath.row].link)!)
        present(svc, animated: true, completion: nil)
    }
    
    

}
