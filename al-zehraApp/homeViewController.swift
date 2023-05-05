//
//  homeViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-18.
//

import UIKit

class homeViewController: UIViewController {

    var bookListArray = [bookCategoryData]()
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        bookListData()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        myCollectionView!.collectionViewLayout = layout
    }

    func bookListData(){
        let book1 = bookCategoryData(bName: "Fiction",
                                     LogoName: "cover-1",
                                     NameList: ["All the Light We Cannot See: A Novel",
                                                "The Paper Palace: A Novel",
                                                "The Nightingale: A Novel",
                                                "The Seven Husbands of Evelyn Hugo: A Novel"],
                                     bPhoto: ["fictionBook-1",
                                              "fictionBook-2",
                                              "fictionBook-3",
                                              "fictionBook-4"],
                                     bookPrice: ["500",
                                                 "600",
                                                 "700",
                                                 "800"],
                                     bookAuthor: ["Anthony Doerr",
                                                  "Miranda Cowley Heller",
                                                  "Kristin Hannah",
                                                  "Taylor Jenkins Reid"],
                                     bData: [bookDetailsData(bookDetailsImage: "fictionBook-1a",
                                                             bookDetailsName: "All the Light We Cannot See: A Novel",
                                                             bookDetailsAuthor: "Anthony Doerr",
                                                             bookDetailsPrice: "500"),
                                             bookDetailsData(bookDetailsImage: "fictionBook-2a",
                                                             bookDetailsName: "The Paper Palace: A Novel",
                                                             bookDetailsAuthor: "Miranda Cowley Heller",
                                                             bookDetailsPrice: "600"),
                                             bookDetailsData(bookDetailsImage: "fictionBook-3a",
                                                             bookDetailsName: "The Nightingale: A Novel",
                                                             bookDetailsAuthor: "Kristin Hannah",
                                                             bookDetailsPrice: "700"),
                                             bookDetailsData(bookDetailsImage: "fictionBook-4a",
                                                             bookDetailsName: "The Seven Husbands of Evelyn Hugo: A Novel",
                                                             bookDetailsAuthor: "Taylor Jenkins Reid",
                                                             bookDetailsPrice: "800")])
        bookListArray.append(book1)
        let book2 = bookCategoryData(bName: "Non-Fiction",
                                     LogoName: "cover-2",
                                     NameList: ["The Revolutionary",
                                                "The Invisible Kingdom",
                                                "How Far the Light Reaches",
                                                "His Name Is George Floyd",
                                                "Constructing a Nervous System",
                                                "An Immense World",
                                                "The Escape Artist",
                                                "Ducks",
                                                "South to America",
                                                "In Love"],
                                     bPhoto: ["Revolutionary",
                                              "Invisible",
                                              "Reaches",
                                              "GeorgeFloyd",
                                              "NervousSystem",
                                              "ImmenseWorld",
                                              "EscapeArtist",
                                              "Ducks",
                                              "South_to_America",
                                              "InLove"],
                                     bookPrice: ["500",
                                                 "35",
                                                 "40",
                                                 "60",
                                                 "45",
                                                 "77",
                                                 "90",
                                                 "120",
                                                 "20",
                                                 "25"],
                                     bookAuthor: ["Samuel Adams, Stacy Schiff",
                                                  "Meghan O’Rourke",
                                                  "Sabrina Imbler",
                                                  "Robert Samuels and Toluse Olorunnipa",
                                                  "Margo Jefferson",
                                                  "Ed Yong",
                                                  "Jonathan Freedland",
                                                  "Kate Beaton",
                                                  "Imani Perry",
                                                  "Amy Bloom"],
                                     bData: [bookDetailsData(bookDetailsImage: "cover-2",
                                                             bookDetailsName: "haider",
                                                             bookDetailsAuthor: "Ambani",
                                                             bookDetailsPrice: "500")])
        bookListArray.append(book2)
        let book3 = bookCategoryData(bName: "Romance",
                                     LogoName: "cover-3",
                                     NameList: ["naqvi"],
                                     bPhoto: ["cover-3"],
                                     bookPrice: ["500"],
                                     bookAuthor: ["Ambani"],
                                     bData: [bookDetailsData(bookDetailsImage: "cover-3",
                                                             bookDetailsName: "haider",
                                                             bookDetailsAuthor: "Ambani",
                                                             bookDetailsPrice: "500")])
        bookListArray.append(book3)
        let book4 = bookCategoryData(bName: "Family",
                                     LogoName: "cover-4",
                                     NameList: ["ali"],
                                     bPhoto: ["cover-5"],
                                     bookPrice: ["500"],
                                     bookAuthor: ["Ambani"],
                                     bData: [bookDetailsData(bookDetailsImage: "cover-4",
                                                             bookDetailsName: "ali",
                                                             bookDetailsAuthor: "Ambani",
                                                             bookDetailsPrice: "500")])
        bookListArray.append(book4)
        let book5 = bookCategoryData(bName: "Crime",
                                     LogoName: "cover-5",
                                     NameList: ["nishi"],
                                     bPhoto: ["cover-4"],
                                     bookPrice: ["500"],
                                     bookAuthor: ["Maula Abbas"],
                                     bData: [bookDetailsData(bookDetailsImage: "cover-5",
                                                             bookDetailsName: "nishi",
                                                             bookDetailsAuthor: "Maula Abbas",
                                                             bookDetailsPrice: "500")])
        bookListArray.append(book5)
        let book6 = bookCategoryData(bName: "Horror",
                                     LogoName: "cover-6",
                                     NameList: ["abbas"],
                                     bPhoto: ["cover-7"],
                                     bookPrice: ["500"],
                                     bookAuthor: ["Ambani"],
                                     bData: [bookDetailsData(bookDetailsImage: "cover-6",
                                                             bookDetailsName: "abbas",
                                                             bookDetailsAuthor: "Ambani",
                                                             bookDetailsPrice: "500")])
        bookListArray.append(book6)
        let book7 = bookCategoryData(bName: "Humour and satire",
                                     LogoName: "cover-7",
                                     NameList: ["murtaza"],
                                     bPhoto: ["cover-6"],
                                     bookPrice: ["500"],
                                     bookAuthor: ["Imam Husain"],
                                     bData: [bookDetailsData(bookDetailsImage: "cover-6",
                                                             bookDetailsName: "murtaza",
                                                             bookDetailsAuthor: "Imam Husain",
                                                             bookDetailsPrice: "500")])
        bookListArray.append(book7)
        let book8 = bookCategoryData(bName: "Classics",
                                     LogoName: "cover-8",
                                     NameList: ["faizan"],
                                     bPhoto: ["cover-9"],
                                     bookPrice: ["500"],
                                     bookAuthor: ["Imam"],
                                     bData: [bookDetailsData(bookDetailsImage: "cover-9",
                                                             bookDetailsName: "faizan",
                                                             bookDetailsAuthor: "Imam",
                                                             bookDetailsPrice: "500")])
        bookListArray.append(book8)
        let book9 = bookCategoryData(bName: "Fantasy",
                                     LogoName: "cover-9",
                                     NameList: ["nishat"],
                                     bPhoto: ["cover-8"],
                                     bookPrice: ["500"],
                                     bookAuthor: ["Maula Ali"],
                                     bData: [bookDetailsData(bookDetailsImage: "cover-9",
                                                             bookDetailsName: "nishat",
                                                             bookDetailsAuthor: "Maula Ali",
                                                             bookDetailsPrice: "500")])
        bookListArray.append(book9)
        let book10 = bookCategoryData(bName: "Adventure",
                                      LogoName: "cover-10",
                                      NameList: ["rizvi"],
                                      bPhoto: ["cover-10"],
                                      bookPrice: ["500"],
                                      bookAuthor: ["Bhoot"],
                                      bData: [bookDetailsData(bookDetailsImage: "cover-10",
                                                              bookDetailsName: "rizvi",
                                                              bookDetailsAuthor: "Bhoot",
                                                              bookDetailsPrice: "500")])
        bookListArray.append(book10)
    }
}
extension homeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "homeList", for: indexPath) as! homeCollectionViewCell
        cell.bookLabel.text = "\(bookListArray[indexPath.row].bookName)"
        cell.bookImage.image = UIImage(named: bookListArray[indexPath.row].bookLogoName)
        
        cell.bookImage.layer.cornerRadius = 5
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let booky = bookListArray[indexPath.row]
        let bookListVC = self.storyboard?.instantiateViewController(withIdentifier: "bookListHome") as? BookListViewController
        
        //to display category name on list home page
        bookListVC?.bookName = bookListArray[indexPath.row].bookName
        
        bookListVC?.bookLists = bookListArray[indexPath.row].bookNameList
        bookListVC?.bookPhoto = bookListArray[indexPath.row].bookPhoto
        bookListVC?.author = bookListArray[indexPath.row].author
        bookListVC?.price = bookListArray[indexPath.row].price
        self.navigationController?.pushViewController(bookListVC!, animated: true)
        bookListVC?.bookDetail = bookListArray[indexPath.row].bookDetailsObj
    }
}
