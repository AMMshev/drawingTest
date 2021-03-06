//
//  IntroductionViewController.swift
//  testTask
//
//  Created by Artem Manyshev on 19.05.2020.
//  Copyright © 2020 Artem Manyshev. All rights reserved.
//

import UIKit

protocol TrainingViewCellDelegate: class {
    func hideTraining(onLeftSide: Bool)
}

class TrainingViewController: UIViewController {
    
    weak open var delegate: TrainingViewCellDelegate?
    
    fileprivate var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0.0
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame:
            CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height),
                                              collectionViewLayout: collectionViewLayout)
        collectionView.register(TrainingCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.CollectionViewCellsID.trainingCell.rawValue)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    fileprivate let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    fileprivate let nextButton: UIButton = {
        let button = UIButton()
        let title = NSAttributedString(string: "Next", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: Constants.Fonts.arialRoundedMTProCyr.rawValue, size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
        ])
        button.setAttributedTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    fileprivate let introductionScreenData = DataForTraining().pagesArray
    fileprivate var currentPage = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func setViews() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        pageControl.numberOfPages = introductionScreenData.count
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                constant: -50.0),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -30.0),
            nextButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor)
        ])
    }
    @objc fileprivate func nextButtonTapped() {
        let xPositionOfNextPage = collectionView.bounds.width * CGFloat(currentPage + 1)
        if let path = collectionView.indexPathForItem(at: CGPoint(x: xPositionOfNextPage, y: 1.0)) {
            currentPage += 1
            pageControl.currentPage = currentPage
            collectionView.scrollToItem(at: path, at: .right,
                                        animated: true)
        }
    }
}

extension TrainingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        introductionScreenData.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCellsID.trainingCell.rawValue,
                                                            for: indexPath) as? TrainingCollectionViewCell else { return UICollectionViewCell() }
        let pageData = introductionScreenData[indexPath.row]
        cell.addToPage(image: pageData.pageImageName,
                       title: pageData.pageTitle,
                       description: pageData.pageDescription,
                       priceImage: pageData.priceImageName)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x < -100.0 {
            self.delegate?.hideTraining(onLeftSide: true)
        }
        if scrollView.contentOffset.x > 850.0 {
            self.delegate?.hideTraining(onLeftSide: false)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        pageControl.currentPage = currentPage
    }
    func changePage() {
        pageControl.currentPage = currentPage
    }
}
