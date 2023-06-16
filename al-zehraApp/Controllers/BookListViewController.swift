//
//  BookListViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-23.
//

import UIKit
import Firebase

class BookListViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var bookCategory: String?
    var ref = Database.database().reference()

    var secondBookList = [bookList]()
    var searchingBook = [bookList]()
    var searchingBookName = false
    
    var url_ratingZero = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-0.png?alt=media&token=684078e0-e930-4fc8-a53b-56f804cf07f2"
    var url_ratingOne = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-1.png?alt=media&token=b370a027-91c0-433d-a9b1-9269e000b8df"
    var url_ratingTwo = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-2.png?alt=media&token=d5c77cf2-3a03-4547-929f-28649f623755"
    var url_ratingThree = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-3.png?alt=media&token=a853915e-13e6-4c36-9e2c-e381cad6d44e"
    var url_ratingFour = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-4.png?alt=media&token=15af6f97-28c7-48b3-9cca-60f99cebf890"
    var url_ratingFive = "https://firebasestorage.googleapis.com/v0/b/al-zehraapp.appspot.com/o/productRating%2Frating-5.png?alt=media&token=121f8391-ee19-40bf-8db2-1c973deb3dcf"
    
    @IBOutlet var bookListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        bookListTableView.reloadData()

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
        confirgureSearch()
    }
    //Search book with Book Name
    func confirgureSearch(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Book"
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
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
                let productStock = mainDict?["productStock"]
                let productRating = mainDict?["productRating"]
                let Category = bookList(title: title as? String ?? "", author: author as? String ?? "", description: description as? String ?? "", price: price as? String ?? "", imageURL: imageURL as? String ?? "", productStock: productStock as? String ?? "", productRating: productRating as? String ?? "")
                self.secondBookList.append(Category)
             }
            self.bookListTableView.reloadData()
        })
    }
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchingBookName{
            return searchingBook.count
        }else{
            return secondBookList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: myTableViewCell = bookListTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! myTableViewCell
        cell.selectionStyle = .none
        self.bookListTableView.separatorStyle = .none
        if searchingBookName{
            let takeData2 : bookList
            takeData2 = searchingBook[indexPath.row]
            cell.bookNameDisplay.text = "\(takeData2.title)"
            cell.imageBookImage.layer.cornerRadius = 5
            if let url = URL(string: takeData2.imageURL){
                cell.imageBookImage.loadImage1(from: url)
            }

        }else{
            let takeData : bookList
            takeData = secondBookList[indexPath.row]
            cell.bookNameDisplay?.text = takeData.title
            cell.author?.text = "by " + takeData.author
            cell.price?.text = "$ " + takeData.price
            cell.descrip?.text = takeData.description
            if takeData.productRating == "0"{
                if let urlZero = URL(string: self.url_ratingZero){
                    cell.imageRating.loadImage1(from: urlZero)
                    cell.bookRatingNumber.text = "N/A"
                }
            }
            if takeData.productRating == "1"{
                if let urlOne = URL(string: self.url_ratingOne){
                    cell.imageRating.loadImage1(from: urlOne)
                    cell.bookRatingNumber.text = "1.0"
                }
            }
            if takeData.productRating == "2"{
                if let urlTwo = URL(string: self.url_ratingTwo){
                    cell.imageRating.loadImage1(from: urlTwo)
                    cell.bookRatingNumber.text = "2.0"
                }
            }
            if takeData.productRating == "3"{
                if let urlThree = URL(string: self.url_ratingThree){
                    cell.imageRating.loadImage1(from: urlThree)
                    cell.bookRatingNumber.text = "3.0"
                }
            }
            if takeData.productRating == "4"{
                if let urlFour = URL(string: self.url_ratingFour){
                    cell.imageRating.loadImage1(from: urlFour)
                    cell.bookRatingNumber.text = "4.0"
                }
            }
            if takeData.productRating == "5"{
                if let urlFive = URL(string: self.url_ratingFive){
                    cell.imageRating.loadImage1(from: urlFive)
                    cell.bookRatingNumber.text = "5.0"
                }
            }
            if takeData.productStock == "0" {
                cell.productStock?.text = "Out of Stock"
                cell.productStock.textColor = .red
            }else{
                cell.productStock?.text = "In Stock"
                cell.productStock.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 2.0)
            }
            if let url = URL(string: takeData.imageURL){
                cell.imageBookImage.loadImage1(from: url)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "bookDetailsPage") as? BookDetailsViewController
        if searchingBookName{
            vc1?.oneBookDetail = secondBookList[indexPath.row]
            navigationController?.pushViewController(vc1!, animated: true)
        }else{
            vc1?.oneBookDetail = secondBookList[indexPath.row]
            navigationController?.pushViewController(vc1!, animated: true)
        }
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

extension BookListViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        print(searchText)
        if !searchText.isEmpty{
            searchingBookName = true
            searchingBook.removeAll()
            
            for books in secondBookList{
                if ((books.title.lowercased().contains(searchText.lowercased()))){
                    print(books)
                    searchingBook.append(books)
                }
            }
        }else{
            searchingBookName = false
            searchingBook.removeAll()
            searchingBook = secondBookList
        }
        bookListTableView.reloadData()
    }
}
