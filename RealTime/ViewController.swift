//
//  ViewController.swift
//  RealTime
//
//  Created by MacBookMBP1 on 22/11/22.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref : DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        ObserveData()//Comentario
    }
    
    
    @IBOutlet weak var textFieldNames: UITextField!
    
    @IBOutlet weak var textviewNameList: UITextView!
    
    @IBAction func stopObserver(_ sender: UIButton) {
        self.ref.child("realtime").child("users").removeAllObservers()
    }
    
    @IBAction func addClick(_ sender: Any) {
        if (textFieldNames.text != ""){
            self.ref.child("realtime").child("users").child(textFieldNames.text!).setValue(textFieldNames.text)
            textFieldNames.text = ""
        }
    }
    func ObserveData(){
        self.ref.child("realtime").child("users").observe(.value, with: {(snapshot) in
            self.textviewNameList.text = ""
            
            if let oSnapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in oSnapShot {
                    if let sName = oSnap.value as? String{
                        print("Name \(sName)")
                        self.textviewNameList.text = self.textviewNameList.text + sName + "\n"
                    }
                }
                
                
            }
        })
        
    }
    
}

