//
//  homeViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-18.
//

import UIKit

class homeViewController: UIViewController {

    var bookList = [bookCategoryData]()
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookListData()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        myCollectionView!.collectionViewLayout = layout

        // Do any additional setup after loading the view.
    }

    func bookListData(){
        let book1 = bookCategoryData(bookName: "Finction", bookLogoName: "cover-1")
        bookList.append(book1)
        let book2 = bookCategoryData(bookName: "Non-Finction", bookLogoName: "cover-2")
        bookList.append(book2)
        let book3 = bookCategoryData(bookName: "Romance", bookLogoName: "cover-3")
        bookList.append(book3)
        let book4 = bookCategoryData(bookName: "Family", bookLogoName: "cover-4")
        bookList.append(book4)
        let book5 = bookCategoryData(bookName: "Crime", bookLogoName: "cover-5")
        bookList.append(book5)
        let book6 = bookCategoryData(bookName: "Horror", bookLogoName: "cover-6")
        bookList.append(book6)
        let book7 = bookCategoryData(bookName: "Humour and satire", bookLogoName: "cover-7")
        bookList.append(book7)
        let book8 = bookCategoryData(bookName: "Classics", bookLogoName: "cover-8")
        bookList.append(book8)
        let book9 = bookCategoryData(bookName: "Fantasy", bookLogoName: "cover-9")
        bookList.append(book9)
        let book10 = bookCategoryData(bookName: "Adventure", bookLogoName: "cover-10")
        bookList.append(book10)
    }
}
extension homeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "homeList", for: indexPath) as! homeCollectionViewCell
        cell.bookLabel.text = "\(bookList[indexPath.row].bookName)"
        cell.bookImage.image = UIImage(named: bookList[indexPath.row].bookLogoName)
//        cell.bookLabel.center = cell.center
//        cell.bookImage.center = cell.center
        cell.bookImage.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        }
    
}
