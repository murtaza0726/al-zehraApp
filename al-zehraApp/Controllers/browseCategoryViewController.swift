//
//  browseCategoryViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-04.
//

import UIKit
import Firebase
class browseCategoryViewController: UIViewController {

    
    @IBOutlet var browseCategoryCollectionView: UICollectionView!
    
    let searchController2 = UISearchController(searchResultsController: nil)

    
    var listCategory = [homeList]()
    var searching = false
    var searchedItem = [homeList]()
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromDB()
        confirgureSearch2()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 30)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 3
        browseCategoryCollectionView!.collectionViewLayout = layout
    }
    
    func confirgureSearch2(){
        searchController2.loadViewIfNeeded()
        searchController2.searchResultsUpdater = self
        searchController2.searchBar.delegate = self
        searchController2.obscuresBackgroundDuringPresentation = false
        searchController2.searchBar.enablesReturnKeyAutomatically = false
        searchController2.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController2
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController2.searchBar.placeholder = "Search Category"
    }
    
    func getDataFromDB(){
        self.ref.child("Categories").observe(.value, with: {(snapshot) in
            self.listCategory.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let bookCategory = mainDict?["bookCategory"]
                let bookCoverImage = mainDict?["bookCoverImage"]
                let Category = homeList(bookCategory: bookCategory as! String? ?? "", bookCoverImage: bookCoverImage as! String? ?? "")
                self.listCategory.append(Category)
             }
            self.browseCategoryCollectionView.reloadData()
        })
    }
}

extension browseCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return searchedItem.count
        }
        else{
            return listCategory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = browseCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "browseCategoryCollectionViewCell", for: indexPath) as! browseCategoryCollectionViewCell
        if searching{
            let myCategory2: homeList
            myCategory2 = searchedItem[indexPath.row]
            cell.bookCategoryLabel.text = "\(searchedItem[indexPath.row].bookCategory)"
            cell.bookCategoryImage.layer.cornerRadius = 5
            if let url = URL(string: myCategory2.bookCoverImage ?? ""){
                cell.bookCategoryImage.loadImage(from: url)
            }
        }
        else{
            let myCategory: homeList
            myCategory = listCategory[indexPath.row]
            cell.bookCategoryLabel?.text = myCategory.bookCategory
            if let url = URL(string: myCategory.bookCoverImage ?? ""){
                cell.bookCategoryImage.loadImage(from: url)
            }
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
            bookListVC?.bookCategory = listCategory[indexPath.row].bookCategory
        }
    }
}
extension browseCategoryViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            searchedItem.removeAll()
            
            for book in listCategory{
                if ((book.bookCategory.lowercased().contains(searchText.lowercased()))){
                    searchedItem.append(book)
                }
            }
        }else{
            searching = false
            searchedItem.removeAll()
            searchedItem = listCategory
        }
        browseCategoryCollectionView.reloadData()
    }
}

extension UIImageView{
    func loadImageCat(from url: URL){
        
        let newSpinner = UIActivityIndicatorView(style: .medium)
        newSpinner.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        newSpinner.hidesWhenStopped = true
        newSpinner.startAnimating()
        newSpinner.center = center
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
