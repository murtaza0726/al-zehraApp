//
//  userInfoPageViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-04-23.
//

import UIKit
import Firebase
import FirebaseAuth

class userInfoPageViewController: UIViewController {
    
    
    @IBOutlet var userInfoList: UITableView!
    
    var user = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        user.append(["User": "First Name", "Details":"Murtaza"])
        user.append(["User": "Last Name", "Details": "Haider"])
        user.append(["User": "Email", "Details": "murtaza@gmail.com"])
        user.append(["User": "Phone", "Details": "4372568766"])
        user.append(["User": "Password", "Details": "Aman@0726"])
        logout()
    }
    
    func logout(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(log))
    }
    @objc func log(){
        let auth = Auth.auth()
        do{
            try auth.signOut()
            let userPageVC = self.storyboard?.instantiateViewController(withIdentifier: "userCheck") as!
            welcomePageViewController
            self.navigationController?.popViewController(animated: true)
            print("user is logged out successfully")
            
        }catch
        {
            print("Error in signOut")
        }
    }
}
extension userInfoPageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userInfoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = user[indexPath.row]["User"] as? String
        cell.detailTextLabel?.text = user[indexPath.row]["Details"] as? String
        return cell
    }
}
