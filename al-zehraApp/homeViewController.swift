//
//  homeViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-18.
//

import UIKit
import Firebase

class homeViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var ref = Database.database().reference()
    var categoryList = [homeList]()
    var searching = false
    var searchedItem = [homeList]()
    
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        navigationItem.searchController = searchController
        getDataFromDB()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        myCollectionView!.collectionViewLayout = layout
        confirgureSearch()
    }
    
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
        searchController.searchBar.placeholder = "Search Category"
    }

    func getDataFromDB(){
        self.ref.child("Categories").observe(.value, with: {(snapshot) in
            self.categoryList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let bookCategory = mainDict?["bookCategory"]
                let bookCoverImage = mainDict?["bookCoverImage"]
                let Category = homeList(bookCategory: bookCategory as! String? ?? "", bookCoverImage: bookCoverImage as! String? ?? "")
                self.categoryList.append(Category)
             }
            self.myCollectionView.reloadData()
        })
    }
}
extension homeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return searchedItem.count
        }else{
            return categoryList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "homeList", for: indexPath) as! homeCollectionViewCell
        if searching{
            cell.bookLabel.text = "\(searchedItem[indexPath.row].bookCategory)"
            cell.bookImage.image = UIImage(named: searchedItem[indexPath.row].bookCoverImage ?? "")
            cell.bookImage.layer.cornerRadius = 5
        }else{
            let myCategory: homeList
            myCategory = categoryList[indexPath.row]
            cell.bookLabel?.text = myCategory.bookCategory
            if let url = URL(string: myCategory.bookCoverImage ?? ""){
                cell.bookImage.loadImage(from: url)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: 190, height: 300)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let bookListVC = self.storyboard?.instantiateViewController(withIdentifier: "bookListHome") as? BookListViewController
        if searching{
            self.navigationController?.pushViewController(bookListVC!, animated: true)
            bookListVC?.bookCategory = searchedItem[indexPath.row].bookCategory
        }else{
            self.navigationController?.pushViewController(bookListVC!, animated: true)
            bookListVC?.bookCategory = categoryList[indexPath.row].bookCategory
        }
    }
}

extension homeViewController: UISearchResultsUpdating, UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            searchedItem.removeAll()
            
            for book in categoryList{
                if ((book.bookCategory.lowercased().contains(searchText.lowercased()))){
                    searchedItem.append(book)
                }
            }
        }else{
            searching = false
            searchedItem.removeAll()
            searchedItem = categoryList
        }
        myCollectionView.reloadData()
    }
}

extension UIImageView{
    func loadImage(from url: URL){
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
            }
        }
        task.resume()
    }
}
