//
//  BookListViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-23.
//

import UIKit
import Firebase

class BookListViewController: UIViewController {
    
    //new code
    var bookCategory: String?
    var ref = Database.database().reference()
    
    //new code
    //var bookDetail = [bookDetailsData]()
    var secondBookList = [bookList]()

    
    @IBOutlet var bookListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = bookName
        bookListTableView.reloadData()

        //new code
        self.title = bookCategory
        if bookCategory == "Fiction"{
            getFictionData()
        }
        if bookCategory == "Non-Fiction"
        {
            getNonFictionData()
        }
        if bookCategory == "Adventure"
        {
            getAdventureData()
        }
        if bookCategory == "Family"
        {
            getFamilyData()
        }
        if bookCategory == "Crime"
        {
            getCrimeData()
        }
        if bookCategory == "Classics"
        {
            getClassicsData()
        }
        if bookCategory == "Fantasy"
        {
            getFantasyData()
        }
        if bookCategory == "Horror"
        {
            getHorrorData()
        }
        if bookCategory == "Romance"
        {
            getRomanceData()
        }
        if bookCategory == "Humour & Sattire"
        {
            getHumourData()
        }
    }
    
    //new code
    func showBookCategory(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bookListTableView.frame.width, height: 50))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bookListTableView.frame.width, height: 50))
        label.textAlignment = .center
        label.text = bookCategory
        headerView.addSubview(label)
        self.bookListTableView.tableHeaderView = headerView
    }
    
    
    func getFictionData(){
        self.ref.child("BookList/Fiction").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
    
    func getNonFictionData(){
        self.ref.child("BookList/Non-Fiction").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
    
    func getAdventureData(){
        self.ref.child("BookList/Adventure").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
    func getFamilyData(){
        self.ref.child("BookList/Family").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
    func getClassicsData(){
        self.ref.child("BookList/Classics").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
    func getCrimeData(){
        self.ref.child("BookList/Crime").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
    func getFantasyData(){
        self.ref.child("BookList/Fantasy").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
    func getHorrorData(){
        self.ref.child("BookList/Horror").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
    func getHumourData(){
        self.ref.child("BookList/Humour_Satire").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
    func getRomanceData(){
        self.ref.child("BookList/Romance").observe(.value, with: {(snapshot) in
            self.secondBookList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let title = mainDict?["title"]
                let price = mainDict?["price"]
                let author = mainDict?["author"]
                let description = mainDict?["description"]
                let imageURL = mainDict?["imageURL"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secondBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: myTableViewCell = bookListTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! myTableViewCell
        let takeData : bookList
        takeData = secondBookList[indexPath.row]
        cell.bookNameDisplay?.text = takeData.title
        cell.author?.text = "by " + takeData.author
        cell.price?.text = "$ " + takeData.price
        cell.descrip?.text = takeData.description
        if let url = URL(string: takeData.imageURL){
            cell.imageBookImage.loadImage1(from: url)
        }
         return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "bookDetailsPage") as? BookDetailsViewController
        vc1?.oneBookDetail = secondBookList[indexPath.row]
        navigationController?.pushViewController(vc1!, animated: true)
    }
}
extension UIImageView{
    func loadImage1(from url: URL){
        
        let newSpinner = UIActivityIndicatorView(style: .medium)
        newSpinner.hidesWhenStopped = true
        newSpinner.startAnimating()
        newSpinner.center = CGPoint(x: 80, y: 120)
        self.addSubview(newSpinner)
        
        var task: URLSessionDataTask!
        let imageCache = NSCache<AnyObject, AnyObject>()
        
        image = nil
        
        if let task = task {
            task.cancel()
        }
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        task = URLSession.shared.dataTask(with: url){(data, response, error) in
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else{
                print("error")
                return
            }
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
                newSpinner.stopAnimating()
            }
        }
        task.resume()
    }
}
