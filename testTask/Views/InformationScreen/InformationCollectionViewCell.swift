//
//  InformationCollectionViewCell.swift
//  testTask
//
//  Created by Artem Manyshev on 21.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//
//  MARK: - collection view from INFO screen
import UIKit

class InformationCollectionViewCell: UICollectionViewCell {
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    fileprivate let labelView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.arialRoundedMTProCyr.rawValue, size: 12.0)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.cornerRadius = 8.0
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.2
        addSubview(imageView)
        addSubview(labelView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 25.0),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25.0),
            labelView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func addToCell(imageName: String, labelText: String) {
        imageView.image = UIImage(named: imageName)
        labelView.text = labelText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
