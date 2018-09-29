//
//  ServerRequestManager.swift
//  ExampleRESTApi
//
//  Created by Rajesh Karmaker on 29/9/18.
//  Copyright © 2018 Rajesh Karmaker. All rights reserved.
//

import UIKit
protocol UserListDelegate {
    func getAlluser(users:[User]?)
}
struct User {
    var id:Int
    var firstName:String
    var lastName:String
    var avatar:String
}
class ServerRequestManager {
    static let shared = ServerRequestManager()
    var delegate:UserListDelegate?
    let urlString = "https://reqres.in/api/users?page=2"
    private init(){
        
    }
    func getUserList(completionHandler:@escaping ([User]?)->Void){
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let responseData = data, error == nil else{
                    print(error?.localizedDescription ?? "Response Error")
                    completionHandler(nil)
                    self.delegate?.getAlluser(users: nil)
                    return
                }
                do{
                    if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any],let userList = json["data"] as? [Any]{
                        var list = [User]()
                        for user in userList{
                            if let user = user as? [String:Any],let id = user["id"] as? Int,let firstName = user["first_name"] as? String,let lastName =  user["last_name"] as? String , let avatar = user["avatar"] as? String{
                                list.append(User(id: id, firstName: firstName, lastName:lastName, avatar: avatar))
                            }
                        }
                        completionHandler(list)
                        self.delegate?.getAlluser(users: list)
                    }
                    
                }catch let parsingError{
                    completionHandler(nil)
                    self.delegate?.getAlluser(users: nil)
                    print("Error", parsingError)
                }
            }.resume()
        }
    }
    
}
