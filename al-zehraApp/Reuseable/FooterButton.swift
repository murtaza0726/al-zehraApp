//
//  FooterButton.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-06-20.
//

import UIKit


class FooterButton: UICollectionReusableView {
    static let reuseIdentifier = String(describing: FooterButton.self)
    
    let btn = UIButton(type: .system) as UIButton
    let btnAction = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    @objc func headerButtonAction() {
        // Handle the action here
        print("Header button tapped!")
    }

    
    private func configure(){
        addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        
        let inset : CGFloat = 5
        let leadingInset : CGFloat = 2
        
        NSLayoutConstraint.activate([
            btn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingInset),
            btn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: inset),
            btn.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            btn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset),
        ])
    }
}
