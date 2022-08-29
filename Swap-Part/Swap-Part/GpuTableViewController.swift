//
//  GpuTableViewController.swift
//  Swap-Part
//
//  Created by Michael Kennedy on 8/20/22.
//

import Foundation
import UIKit
import SafariServices

class GpuTableViewController: UITableViewController {
    
    var arrayOfComponents: [storageDevice] = []
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view
        
        group.enter()
        DownloadData(toDownload: "https://top-computer-parts.p.rapidapi.com/top/26/gpu")

        group.wait()

        arrayOfComponents.remove(at: 0)
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }

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
            let newDevice = storageDevice(name: "\(stringSeparated[2]) \(stringSeparated[3])", type: stringSeparated[0], link: stringSeparated[7])
            arrayOfComponents.append(newDevice)
        }

        group.leave()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfComponents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gpuCell", for: indexPath)

        cell.textLabel?.text = arrayOfComponents[indexPath.row].name
        cell.detailTextLabel?.text = arrayOfComponents[indexPath.row].type

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc = SFSafariViewController(url: URL(string: arrayOfComponents[indexPath.row].link)!)
        present(svc, animated: true, completion: nil)
    }
    
}
