//
//  BookListViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-23.
//

import UIKit

class BookListViewController: UIViewController {

    var bookDetail = [bookDetailsData]()
    var bookLists = [String]()
    var bookName:String?
    var price = [String]()
    var author = [String]()
    var bookPhoto = [String]()

    
    @IBOutlet var bookListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = bookName
        bookListTableView.reloadData()

    }
    
    //grid view design
    func showBookCategory(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bookListTableView.frame.width, height: 50))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bookListTableView.frame.width, height: 50))
        label.textAlignment = .center
        label.text = bookName
        headerView.addSubview(label)
        self.bookListTableView.tableHeaderView = headerView
    }
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(bookLists)
        return bookLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: myTableViewCell = bookListTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! myTableViewCell

        //display data in table
        
        cell.bookNameDisplay.text = (bookLists[indexPath.row])
        cell.author.text = "by " + (author[indexPath.row]) + " (author)"
        cell.price.text = "$ \(price[indexPath.row])"
        cell.imageBookImage.image = UIImage(named: bookPhoto[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "bookDetailsPage") as? BookDetailsViewController
        vc1?.oneBookDetail = bookDetail[indexPath.row]
        //vc1?.authorNameLabel?.text = author[indexPath.row]
        print(author[indexPath.row])
        navigationController?.pushViewController(vc1!, animated: true)
    }
}
