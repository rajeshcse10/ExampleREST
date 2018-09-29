//
//  ViewController.swift
//  ExampleRESTApi
//
//  Created by Rajesh Karmaker on 29/9/18.
//  Copyright © 2018 Rajesh Karmaker. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UserListDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ServerRequestManager.shared.delegate = self
        ServerRequestManager.shared.getUserList { (userList) in
            //print(userList!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAlluser(users: [User]?) {
        if let users = users{
            print(users)
        }
    }
}

