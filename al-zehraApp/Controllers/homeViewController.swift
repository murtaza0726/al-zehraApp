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
    var newCategoryList = [homeList]()
    var bestSellerList = [homeList]()
    var searching = false
    var searchedItem = [homeList]()
    var offerAd = ["ad1", "ad2", "ad3"]
    var prodCat = ["Cat-1", "Cat-2", "Cat-3", "Cat-1", "Cat-2", "Cat-3", "Cat-1", "Cat-2", "Cat-3"]
    
    var currentCellIndex = 0
    var timer: Timer?

    @IBOutlet var myCollectionView: UICollectionView!
    @IBOutlet var adCollectionView: UICollectionView!
    @IBOutlet var newCollectionView: UICollectionView!
    @IBOutlet var bestSellerCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        navigationItem.searchController = searchController
        getDataFromDB()
        getFourDataFromDB()
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 30)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 3
        myCollectionView!.collectionViewLayout = layout
        bestSellerCollectionView.collectionViewLayout = layout
        confirgureSearch()
    }
    
    @objc func slideToNext(){
        if adCollectionView.tag == 0{
            if currentCellIndex < offerAd.count-1
            {
                currentCellIndex = currentCellIndex+1
            }else{
                currentCellIndex = 0
            }
        }
        adCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0),at: .right, animated: true)
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
            self.newCategoryList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let bookCategory = mainDict?["bookCategory"]
                let bookCoverImage = mainDict?["bookCoverImage"]
                let Category = homeList(bookCategory: bookCategory as! String? ?? "", bookCoverImage: bookCoverImage as! String? ?? "")
                self.categoryList.append(Category)
                self.newCategoryList.append(Category)
             }
            self.myCollectionView.reloadData()
            self.newCollectionView.reloadData()
        })
    }
    func getFourDataFromDB(){
        self.ref.child("Categories").queryLimited(toLast: 4).observe(.value, with: {(snapshot) in
            self.bestSellerList.removeAll()
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let mainDict = snap.value as? [String: AnyObject]
                let bookCategory = mainDict?["bookCategory"]
                let bookCoverImage = mainDict?["bookCoverImage"]
                let Category = homeList(bookCategory: bookCategory as! String? ?? "", bookCoverImage: bookCoverImage as! String? ?? "")
                self.bestSellerList.append(Category)
             }
            self.bestSellerCollectionView.reloadData()
        })
    }

}
extension homeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1000 {
            return offerAd.count
        }
        else if collectionView.tag == 1001 {
            if searching{
                return searchedItem.count
            }
            else{
                return categoryList.count
            }
        }
        if collectionView.tag == 1003{
            return bestSellerList.count
        }
        else
        {
            return newCategoryList.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1000 {
            let cellC = adCollectionView.dequeueReusableCell(withReuseIdentifier: "cellC", for: indexPath) as! adCollectionViewCell
            cellC.adImageView.image = UIImage(named: offerAd[indexPath.row])
            return cellC
        }
        if collectionView.tag == 1001 {
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "homeList", for: indexPath) as! homeCollectionViewCell
            if searching{
                let myCategory2: homeList
                myCategory2 = searchedItem[indexPath.row]
                cell.bookLabel.text = "\(searchedItem[indexPath.row].bookCategory)"
                cell.bookImage.layer.cornerRadius = 5
                if let url = URL(string: myCategory2.bookCoverImage ?? ""){
                    cell.bookImage.loadImage(from: url)
                }
            }
            else{
                let myCategory: homeList
                myCategory = categoryList[indexPath.row]
                cell.bookLabel?.text = myCategory.bookCategory
                if let url = URL(string: myCategory.bookCoverImage ?? ""){
                    cell.bookImage.loadImage(from: url)
                }
            }
            return cell
        }
        if collectionView.tag == 1002
        {
            let cellCat = newCollectionView.dequeueReusableCell(withReuseIdentifier: "cellCat", for: indexPath) as! CategoryOneCollectionViewCell
            cellCat.productCatImageView.layer.cornerRadius = cellCat.frame.height/15
            
            let myCategory3: homeList
            myCategory3 = newCategoryList[indexPath.row]
            cellCat.catImage.text = myCategory3.bookCategory
            
            if let url = URL(string: myCategory3.bookCoverImage ?? ""){
                cellCat.productCatImageView.loadImage(from: url)
            }
            return cellCat
        }
        if collectionView.tag == 1003
        {
            let cellBest = bestSellerCollectionView.dequeueReusableCell(withReuseIdentifier: "bestSellerCollectionViewCell", for: indexPath) as! bestSellerCollectionViewCell
            let myCategory4: homeList
            myCategory4 = bestSellerList[indexPath.row]
            if let url = URL(string: myCategory4.bookCoverImage ?? ""){
                cellBest.bestSellerImage.loadImage(from: url)
            }
            return cellBest
        }
        else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let size = (collectionView.frame.size.width-10)/2
        if collectionView.tag == 1000 {
            return CGSize(width: adCollectionView.frame.width, height: adCollectionView.frame.height)
        }
        else if collectionView.tag == 1001
        {
            return CGSize(width: 190, height: 300)
        }
        else if collectionView.tag == 1003{
            return CGSize(width: 190, height: 200)
        }
        else{
            return CGSize(width: 130, height: 150)
        }
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
