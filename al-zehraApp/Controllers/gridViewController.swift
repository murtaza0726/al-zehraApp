//
//  gridViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-24.
//

import UIKit
import Firebase
class gridViewController: UIViewController {

    
    @IBOutlet var authorCollectionView: UICollectionView!
    
    var authorBookListArr = [authorBookList]()
    var ref = Database.database().reference()
    
    var homelistCategory = [homeList]()
    
    var oneBookDetail3: String?
    var oneBookDetail4: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromDB()
        
        self.getSeeAllData()
        
        self.title = oneBookDetail3
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        authorCollectionView!.collectionViewLayout = layout
    }
    
    func getSeeAllData(){
        if oneBookDetail3 == "Author" {
            self.ref.child("Author").observe(.value, with: {(snapshot) in
                self.authorBookListArr.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let bookName = mainDict?["bookName"]
                    let imageURL = mainDict?["imageURL"]
                    let Category = authorBookList(authorName: "", imageURL: imageURL as! String, bookName: bookName as! String)
                    self.authorBookListArr.append(Category)
                 }
                self.authorCollectionView.reloadData()
            })
        }
        if oneBookDetail3 == "Category"{
            self.ref.child("Categories").observe(.value, with: {(snapshot) in
                self.authorBookListArr.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let bookName = mainDict?["bookName"]
                    let imageURL = mainDict?["imageURL"]
                    let Category = authorBookList(authorName: "", imageURL: imageURL as! String, bookName: bookName as! String)
                    self.authorBookListArr.append(Category)
                 }
                self.authorCollectionView.reloadData()
            })
        }
        if oneBookDetail3 == "Best Seller"{
            self.ref.child("Best Seller").observe(.value, with: {(snapshot) in
                self.authorBookListArr.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let bookName = mainDict?["bookName"]
                    let imageURL = mainDict?["imageURL"]
                    let Category = authorBookList(authorName: "", imageURL: imageURL as! String, bookName: bookName as! String)
                    self.authorBookListArr.append(Category)
                 }
                self.authorCollectionView.reloadData()
            })
        }
    }
    
    func getDataFromDB(){
        if oneBookDetail4 == "Author"{
            self.ref.child("AuthorBookList/Author_Name/\(oneBookDetail3!)").observe(.value, with: {(snapshot) in
                self.authorBookListArr.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let authorName = mainDict?["authorName"]
                    let imageURL = mainDict?["imageURL"]
                    let bookName = mainDict?["bookName"]
                    let Category = authorBookList(authorName: authorName as! String, imageURL: imageURL as! String, bookName: bookName as! String)
                    self.authorBookListArr.append(Category)
                 }
                self.authorCollectionView.reloadData()
            })
        }
        else if oneBookDetail4 == "Category"{
            self.ref.child("BookList/\(oneBookDetail3!)").observe(.value, with: {(snapshot) in
                self.authorBookListArr.removeAll()
                for snap in snapshot.children.allObjects as! [DataSnapshot]{
                    let mainDict = snap.value as? [String: AnyObject]
                    let authorName = mainDict?["authorName"]
                    let imageURL = mainDict?["imageURL"]
                    let bookName = mainDict?["bookName"]
                    let Category = authorBookList(authorName: authorName as! String, imageURL: imageURL as! String, bookName: bookName as! String)
                    self.authorBookListArr.append(Category)
                 }
                self.authorCollectionView.reloadData()
            })
        }
    }
}
extension gridViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        authorBookListArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = authorCollectionView.dequeueReusableCell(withReuseIdentifier: "authorCell", for: indexPath) as! authorCell
        cell.author_bookName.text = authorBookListArr[indexPath.row].bookName
        let myCategory: authorBookList
        
        cell.backgroundColor = .systemBackground
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        myCategory = authorBookListArr[indexPath.row]
        if let url = URL(string: myCategory.imageURL ?? "cover-1"){
            cell.authorBookImage.loadImage13(from: url)

        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc3 = storyboard?.instantiateViewController(withIdentifier: "NewReleaseViewController") as? NewReleaseViewController
        vc3?.oneBookDetail4 = oneBookDetail4
        vc3?.oneBookDetail2 = authorBookListArr[indexPath.row].bookName
        vc3?.oneBookDetail5 = oneBookDetail3
        debugPrint(">>>>>>>>>>oneBookDetail3 = \(oneBookDetail3!)>>>>>>>>>>")
        debugPrint(">>>>>>>>>>oneBookDetail4 = \(oneBookDetail4!)>>>>>>>>>>")
        navigationController?.pushViewController(vc3!, animated: true)
        
        
    }
}
extension UIImageView{
    func loadImage13(from url: URL){
        
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
