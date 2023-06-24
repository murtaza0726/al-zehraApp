//
//  bookHomeViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-16.
//

import UIKit

typealias OfferDataSource = UICollectionViewDiffableDataSource<BookManager.Section, OffersModel>

class bookHomeViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var dataSource: OfferDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){

        setUpNavigationBarImage()
        collectionView.collectionViewLayout = confirgureCollectionViewLayout()

        configureDataSource()
        //createSnapshot(user: BookManager.offersAd2)
        
        configureSnapshot()
        collectionView.delegate = self
        
        collectionView.register(TitleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeader.reuseIdentifier)

        collectionView.register(FooterButton.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterButton.reuseIdentifier)
        
        //self.navigationController?.hidesBarsOnSwipe = true
        
        let instanceOfUser = getData()
        instanceOfUser.getFourDataFromDB{
            print("getting data from firebase")
            print("offersAd2 value from DB check : \(BookManager.offersAd2)")
        }
        
    }
    
    private func setUpNavigationBarImage(){
        let logo = UIImage(named: "logo")
        
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = imageView
    }
}

extension bookHomeViewController{
    func confirgureCollectionViewLayout() -> UICollectionViewCompositionalLayout{
        let sectionProvide = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var section : NSCollectionLayoutSection?
            
            switch sectionIndex{
            case 0:
                section = self.getHighlightSection()
            case 1:
                section = self.getPreviewSection()
            default:
                section = self.getBestsellerSection()
                //section = self.getHighlightSection()
            }
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvide)
    }
    
    private func getHighlightSection() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    private func getPreviewSection() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
        
        section.boundarySupplementaryItems = getHeader2()
        
        return section
    }
    private func getBestsellerSection() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.22))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2)
        
        section.boundarySupplementaryItems = getHeader()
        
        return section
    }
    
    private func getHeader() -> [NSCollectionLayoutBoundarySupplementaryItem]{
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)

        let FooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(10))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: FooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading)

        return [sectionHeader, sectionFooter]
    }

    private func getHeader2() -> [NSCollectionLayoutBoundarySupplementaryItem]{
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)

        return [sectionHeader]
    }
}
extension bookHomeViewController {
    
    func configureDataSource(){
        print("DataSource started running.....")
        dataSource = OfferDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, OffersModel) -> UICollectionViewCell? in
            print("reuseIdentifier")
            let reuseIdentifier: String
            
            switch indexPath.section{
                case 0: reuseIdentifier = HighlightCell.reuseIdentifier
                case 1: reuseIdentifier = PreviewCell.reuseIdentifier
                case 2: reuseIdentifier = BestsellerCell.reuseIdentifier
                default: reuseIdentifier = BestsellerCell.reuseIdentifier
               // default: reuseIdentifier = HighlightCell.reuseIdentifier
            }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? OfferCell else {
                print("error")
                return nil
            }
            let section = BookManager.Section.allCases[indexPath.section]
            cell.showOffer(offer: BookManager.offers[section]?[indexPath.item])
            //cell.showOffer(offer: BookManager.offersAd2[indexPath.row])
            print("Demo : \(BookManager.offersAd2)")
            //cell.showOffer(offer: BookManager.offersAd2[indexPath.item])
            return cell
        })
//        cell.showOffer(offer: self.offersAd[indexPath.item])
//
//            cell.showOffer(offer: BookManager.offersAd[indexPath.item])
//            print("cell value : \(cell.showOffer(offer: BookManager.offersAd[indexPath.item]))")
//            if let url = URL(string: BookManager.offersAd[indexPath.item].headerImage){
//                cell.showOffer(offer: BookManager.offersAd[section))
//
//            }
        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            if kind == UICollectionView.elementKindSectionHeader{
                if let self = self, let headerSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeader.reuseIdentifier, for: indexPath) as? TitleHeader{
                    
                    let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                    headerSupplementaryView.textLabel.text = section.rawValue
                    
                    return headerSupplementaryView
            }
            }else{
                if let self = self, let FooterSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterButton.reuseIdentifier, for: indexPath) as? FooterButton{
                    
                    let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                    FooterSupplementaryView.btn.setTitle("See All", for: .normal)
                    
                    FooterSupplementaryView.btnAction.addTarget(self, action: #selector(FooterSupplementaryView.headerButtonAction), for: .touchUpInside)
                    return FooterSupplementaryView
                }
            }
            return nil
        }
        print("DataSource stop running.....")
}
    
//    func createSnapshot(user: [OffersModel]){
//        print("snap started running.....")
//        var snapshot = NSDiffableDataSourceSnapshot<BookManager.Section, OffersModel> ()
//        snapshot.appendSections([.HIGHLIGHTS])
//        snapshot.appendItems(user)
//        dataSource.apply(snapshot, animatingDifferences: false)
//    }
    
    func configureSnapshot(){
        var currentSnapshot = NSDiffableDataSourceSnapshot<BookManager.Section, OffersModel> ()

        BookManager.Section.allCases.forEach{collection in
            currentSnapshot.appendSections([collection])
            if let book = BookManager.offers[collection]{
                currentSnapshot.appendItems(book)
            }
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
}

extension bookHomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "NewReleaseViewController") as? NewReleaseViewController
        let book = dataSource.itemIdentifier(for: indexPath)
        vc1?.oneBookDetail2 = book?.title ?? ""
        navigationController?.pushViewController(vc1!, animated: true)
        print(book?.title ?? "nil")
    }
}

extension UIImageView{
    func loadImage10(from url: URL){
        
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
