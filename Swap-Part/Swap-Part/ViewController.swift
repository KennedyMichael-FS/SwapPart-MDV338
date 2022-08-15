//
//  ViewController.swift
//  Swap-Part
//
//  Created by Michael Kennedy on 8/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    /// Storage of necessary variables.
    ///
    
    var socketTypes: [String] = []
    var cpuList: [cpu] = []
    
    // PLACEHOLDER - WILL NOT ACCEPT THIS AS CPU
    var selectedCpu: cpu = cpu(name: "", numOfCores: 0, socket: "", tdp: 0, baseFreq: 0)
    var determinedOem: Bool? = nil

    /// End of variable storage.
    ///
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetTempData()
        DetermineOEM()
        
    }

    func SetTempData() {
        
        socketTypes.append("AM4")
        socketTypes.append("AM3")
        socketTypes.append("FM2+")
        
        // Temp AM4
        cpuList.append(cpu(name: "Ryzen 7 5800", numOfCores: 8, socket: "AM4", tdp: 65, baseFreq: 3400))
        cpuList.append(cpu(name: "Ryzen 9 3900", numOfCores: 12, socket: "AM4", tdp: 65, baseFreq: 3100))
        cpuList.append(cpu(name: "Ryzen 5 3500", numOfCores: 6, socket: "AM4", tdp: 65, baseFreq: 3500))
        cpuList.append(cpu(name: "Ryzen 9 3900XT", numOfCores: 12, socket: "AM4", tdp: 105, baseFreq: 3800))
        
        // Temp AM3
        cpuList.append(cpu(name: "Sempron 150", numOfCores: 1, socket: "AM3", tdp: 45, baseFreq: 2900))
        cpuList.append(cpu(name: "Athlon II X3 435", numOfCores: 3, socket: "AM3", tdp: 95, baseFreq: 2000))
        cpuList.append(cpu(name: "Phenom II X4 925", numOfCores: 4, socket: "AM3", tdp: 95, baseFreq: 2800))
        cpuList.append(cpu(name: "Phenmon II X6 1055T", numOfCores: 6, socket: "AM3", tdp: 125, baseFreq: 2000))
        
        // Temp FM2+
        cpuList.append(cpu(name: "A8-7600", numOfCores: 4, socket: "FM2+", tdp: 65, baseFreq: 3100))
        cpuList.append(cpu(name: "A10-8750", numOfCores: 4, socket: "FM2+", tdp: 65, baseFreq: 3600))
        cpuList.append(cpu(name: "Athlon X4 870K", numOfCores: 4, socket: "FM2+", tdp: 95, baseFreq: 3900))
        cpuList.append(cpu(name: "A6-8550", numOfCores: 2, socket: "FM2+", tdp: 65, baseFreq: 3700))
        
    }
    
    func DetermineOEM() {
        
        if determinedOem == nil {
            
            let oemPrompt = UIAlertController(title: "Is your system OEM?", message: "This will determine if your system is able to be upgraded easily. An OEM system includes prebuilt systems from Dell, Lenovo, HP, etc.", preferredStyle: UIAlertController.Style.alert)
            
            oemPrompt.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                self.determinedOem = false
            }))
            
            oemPrompt.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.determinedOem = true
            }))

            present(oemPrompt, animated: true, completion: nil)
            
        }
        else {
            return
        }
        
    }
    
    // Function to be moved to a master function file once all categories are fully implemented.
    func CpuListCompat(passedSocket: String) -> [cpu] {
        
        var compatibleCpus: [cpu] = []
        
        for item in cpuList {
            if item.socket == passedSocket {
                compatibleCpus.append(item)
            }
        }
        
        return compatibleCpus
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? SocketTableViewController {
            
            destination.passedSockets = socketTypes
            destination.passedCpuList = cpuList
            
        }
        
    }


}



