//
//  userInfoListViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-04-23.
//

import UIKit
import Firebase
import FirebaseAuth

class userInfoListViewController: UIViewController {

    
    @IBOutlet var supportTable: UITableView!
    
    var supportList = ["User Profile", "Notifications", "Location Services", "Country/Region", "Contact Us", "Help and Information", "Privacy Policy", "Setting", "Terms & Conditions"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Support"
        
    }
}

extension userInfoListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = supportTable.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath)
        cell.textLabel?.text = supportList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            checkCurrentUser()
        }else{
            let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: "notReady") as! notReadyViewController
            self.navigationController?.pushViewController(homePageVC, animated: true)
        }
    }
    func checkCurrentUser(){
        if Auth.auth().currentUser?.uid != nil{
            Auth.auth().currentUser?.reload(completion: { (error) in
                if let error = error{
                    print("checkIfUserSignedIn \(error.localizedDescription)")
                }
                let userPageVC = self.storyboard?.instantiateViewController(withIdentifier: "userPage") as! userInfoPageViewController
                self.navigationController?.pushViewController(userPageVC, animated: true)
                let userID = (Auth.auth().currentUser?.uid) ?? ""
                print("Current user ID is : " + userID)
            })
        }else{
            let createNewUser = self.storyboard?.instantiateViewController(withIdentifier: "userCheck") as! welcomePageViewController
            self.navigationController?.pushViewController(createNewUser, animated: true)
        }
    }
}
