//
//  ViewController.swift
//  Swap-Part
//
//  Created by Michael Kennedy on 8/10/22.
//

import UIKit
import SafariServices
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {
    
    
    // PLACEHOLDER for OEM system checker.
    var determinedOem: Bool? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetermineOEM()
        
    }

    @IBOutlet weak var currentOemOutlet: UIButton!
    @IBAction func currentOemAction(_ sender: UIButton) {
        let svc = SFSafariViewController(url: URL(string: "https://www.cgdirector.com/can-you-upgrade-pre-built-pc/")!)
        present(svc, animated: true, completion: nil)
    }
    
    @IBAction func savedBuilds(_ sender: Any) {
        let savedPrompt = UIAlertController(title: "There are no saved builds.", message: "Unfortunately, this feature is not complete.", preferredStyle: UIAlertController.Style.alert)
        
        savedPrompt.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(savedPrompt, animated: true, completion: nil)
    }
    
    @IBAction func signoutButton(_ sender: UIButton) {
        SignOut()
    }
    
    func DetermineOEM() {
        
        if determinedOem == nil {
            
            let oemPrompt = UIAlertController(title: "Is your system OEM?", message: "This will determine if your system is able to be upgraded easily.", preferredStyle: UIAlertController.Style.alert)
            
            oemPrompt.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                self.determinedOem = false
                self.OEMDetermined()
            }))
            
            oemPrompt.addAction(UIAlertAction(title: "Help", style: .default, handler: {(action: UIAlertAction!) in
                self.HelpOEMDetermination()
            }))
            
            oemPrompt.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.determinedOem = true
                self.OEMDetermined()
            }))

            present(oemPrompt, animated: true, completion: nil)
            
        }
        else {
            return
        }
        
    }
    
    func SignOut() {
        do { try Auth.auth().signOut() }
        catch {
            print(error.localizedDescription)
        }
        let signoutPrompt = UIAlertController(title: "Signed out.", message: "You have been signed out of SwapPart.", preferredStyle: UIAlertController.Style.alert)
        
        signoutPrompt.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(signoutPrompt, animated: true, completion: nil)
    }
    
    func HelpOEMDetermination() {
        
        let oemPrompt = UIAlertController(title: "Is your system OEM?", message:"Your system is OEM if you answer 'yes' to any of the following questions...\n \n - You purchased the system at a retail store. \n - You, or any previous owners, did not assemble this system from scratch. \n - The PC is branded with a well-known company's logo or name (Dell, HP, Lenovo, Acer, Asus, Apple, Alienware. Please note that gaming PCs are generally exempt from this question as they aren't 'pre-built'.) \n - The PC has non-removable essential parts such as its CPU, RAM, storage devices, or graphics cards.", preferredStyle: UIAlertController.Style.alert)
        
        oemPrompt.addAction(UIAlertAction(title: "Not OEM", style: .default, handler: { (action: UIAlertAction!) in
            self.determinedOem = false
            self.OEMDetermined()
        }))
        
        oemPrompt.addAction(UIAlertAction(title: "OEM", style: .default, handler: { (action: UIAlertAction!) in
            self.determinedOem = true
            self.OEMDetermined()
        }))
        
        present(oemPrompt, animated: true, completion: nil)
    }
    
    func OEMDetermined() {
        if determinedOem == false {
            currentOemOutlet.isHidden = true
            currentOemOutlet.isUserInteractionEnabled = false
        }
        if determinedOem == true {
            currentOemOutlet.titleLabel?.text = "Current build is OEM. Tap to learn more..."
            currentOemOutlet.isHidden = false
            currentOemOutlet.isUserInteractionEnabled = true
        }
        if determinedOem == nil {
            currentOemOutlet.titleLabel?.text = "Build may be OEM. Tap to learn more..."
            currentOemOutlet.isHidden = false
            currentOemOutlet.isUserInteractionEnabled = true
        }
    }
    
    // DEPRECATED: Would compare two thermal profiles of CPUs (one that was pre-selected and one that was just chosen) and return a value.
    // Cannot be used due to API limitations, but code remains here for reference.
    // Compares TDP (thermal design power) to determine if a thermal issue may arise
//    func CpuThermalPotentialCompar(passedCpu: cpu) -> Bool {
//
//        if selectedCpu.tdp < passedCpu.tdp { // If new is warmer than selected
//            return true
//        }
//        if selectedCpu.tdp > passedCpu.tdp { // If selected is warmer than new
//            return false
//        }
//        else { // Shouldn't reach this point, ever!!
//            print("Somehow, the TDP could not be compared. Returning false by default.")
//            return false
//        }
//
//    }

}



