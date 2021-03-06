//
//  MenuBar.swift
//  testTask
//
//  Created by Artem Manyshev on 20.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

class MenuBarView: UIView {
    
    fileprivate let shelfView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        view.layer.shadowRadius = 25.0
        view.layer.cornerRadius = 25.0
        view.layer.shadowOpacity = 0.1
        return view
    }()
    fileprivate var mainMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.ImageNames.MenuBar.birdActive.rawValue), for: .normal)
        button.addTarget(self, action: #selector(menuButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    fileprivate var easelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.ImageNames.MenuBar.paint.rawValue), for: .normal)
        button.addTarget(self, action: #selector(menuButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    fileprivate var giftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.ImageNames.MenuBar.gift.rawValue), for: .normal)
        button.addTarget(self, action: #selector(menuButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    fileprivate var infoMenuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.ImageNames.MenuBar.info.rawValue), for: .normal)
        button.addTarget(self, action: #selector(menuButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    fileprivate var isInfoVCpresented = false
    fileprivate let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(shelfView)
        shelfView.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            shelfView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            shelfView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            shelfView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            shelfView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStackView.topAnchor.constraint(equalTo: shelfView.topAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: shelfView.leadingAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: shelfView.bottomAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: shelfView.trailingAnchor)
        ])
        buttonsStackView.addArrangedSubview(mainMenuButton)
        buttonsStackView.addArrangedSubview(easelButton)
        buttonsStackView.addArrangedSubview(giftButton)
        buttonsStackView.addArrangedSubview(infoMenuButton)
    }
    
    fileprivate func setButtonsInactiveImages() {
        mainMenuButton.setImage(UIImage(named: Constants.ImageNames.MenuBar.bird.rawValue),
                                for: .normal)
        easelButton.setImage(UIImage(named: Constants.ImageNames.MenuBar.gift.rawValue),
                             for: .normal)
        giftButton.setImage(UIImage(named: Constants.ImageNames.MenuBar.paint.rawValue),
                            for: .normal)
        infoMenuButton.setImage(UIImage(named: Constants.ImageNames.MenuBar.info.rawValue),
                            for: .normal)
    }
    
    @objc fileprivate func menuButtonTapped(sender: UIButton) {
        let navigationController = UIApplication.shared.windows[0].rootViewController as? NavigationController
        if sender == mainMenuButton {
            navigationController?.popToRootViewController(animated: false)
            setButtonsInactiveImages()
            mainMenuButton.setImage(UIImage(named: Constants.ImageNames.MenuBar.birdActive.rawValue), for: .normal)
            isInfoVCpresented = false
        }
        if sender == infoMenuButton && isInfoVCpresented == false {
            isInfoVCpresented = true
            let infoVC = InformationScreenViewController(nibName: nil, bundle: nil)
            setButtonsInactiveImages()
            infoMenuButton.setImage(UIImage(named: Constants.ImageNames.MenuBar.infoActive.rawValue), for: .normal)
            navigationController?.pushViewController(infoVC, animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
