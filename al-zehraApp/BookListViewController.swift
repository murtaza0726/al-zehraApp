//
//  BookListViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-23.
//

import UIKit

class BookListViewController: UIViewController {

    var bookLists = [String]()
    
    @IBOutlet var bookListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = bookListTableView.dequeueReusableCell(withIdentifier: "bookList", for: indexPath)
        cell1.textLabel?.text = "\(bookLists[indexPath.row])"
        return cell1
    }
    
    
}
