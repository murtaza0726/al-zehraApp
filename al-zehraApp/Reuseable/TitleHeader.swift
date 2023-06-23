//
//  TitleHeader.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-18.
//

import UIKit

class TitleHeader: UICollectionReusableView {
    static let reuseIdentifier = String(describing: TitleHeader.self)
        
    let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    private func configure(){
        addSubview(textLabel)
        textLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        textLabel.textColor = .label
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let inset : CGFloat = 5
        let leadingInset : CGFloat = 2
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingInset),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: inset),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset),
        ])
    }
}
