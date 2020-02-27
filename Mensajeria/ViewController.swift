//
//  ViewController.swift
//  Mensajeria
//
//  Created by usuario on 12/02/2020.
//  Copyright © 2020 usuario. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAnalytics

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var texto: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var texto1: UITextField!
    var num = 0
    var txt = [String]()
    var ref: DatabaseReference!
    var refHandle:DatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        texto.text="escribe tu nota"
        Analytics.setAnalyticsCollectionEnabled(true)
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        ref.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0 {
                self.num = 0
                self.txt.removeAll()
                for nota in snapshot.children.allObjects as!
                    [DataSnapshot]{
                    self.txt.append((nota.value as? String)!)
                    self.tableView.reloadData()
                    self.num+=1
                }
            }
            
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return txt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell=tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.lblText.text = txt[indexPath.row]
        return cell*/
        let cell=tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = txt[indexPath.row]
        return cell!
    }
    
}


