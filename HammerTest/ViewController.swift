//
//  ViewController.swift
//  HammerTest
//
//  Created by Andrei Kovryzhenko on 23.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCollectionViewLayout()
    )
    
    let locationIcon : UIImageView = {
        var imageView = UIImageView(frame: .zero)
        let image = UIImage(named: "City")?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        return imageView
    }()
    
    struct Banner {
        var image: UIImage
    }
    
    struct Category {
        var name: String
    }
    
    struct Menu {
        var image: UIImage
    }
    enum Section {
        case banners([Banner])
        case categoryes([Category])
        case menu([Menu])
        
        var count: Int {
            switch self {
            case .banners(let banners):
                return banners.count
            case .categoryes(let tracks):
                return tracks.count
            case .menu(let dishes):
                return dishes.count
            }
        }
    }
    
    private var sections: [Section] = [
        .banners([
            Banner(image: UIImage(named: "Banner1")!),
            Banner(image: UIImage(named: "Banner2")!)
        ]),
        .categoryes([
            Category(name: "Пицца"),
            Category(name: "Комбо"),
            Category(name: "Десерты"),
            Category(name: "Напитки")
        ]),
        .menu([
            Menu(image: UIImage(named: "Товар 1")!),
            Menu(image: UIImage(named: "Товар 2")!),
            Menu(image: UIImage(named: "Товар 3")!),
            Menu(image: UIImage(named: "Товар 4")!),
            Menu(image: UIImage(named: "Товар 5")!),
            Menu(image: UIImage(named: "Товар 6")!),
            Menu(image: UIImage(named: "Товар 7")!),
            Menu(image: UIImage(named: "Товар 8")!)
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.addSubview(locationIcon)
        
        collectionView.backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 249/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: locationIcon.topAnchor, constant: 24),
            locationIcon.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 16),
            locationIcon.widthAnchor.constraint(equalToConstant: 83)
        ])
        
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "\(BannerCell.self)")
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "\(CategoryCell.self)")
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "\(MenuCell.self)")
        collectionView.dataSource = self
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize: NSCollectionLayoutSize
            let orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
            
            if section == 0 {
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .fractionalHeight(0.14)
                )
                orthogonalScrollingBehavior = .continuous
                
            } else if section == 1 {
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(98),
                    heightDimension: .absolute(32)
                )
                orthogonalScrollingBehavior = .continuous
                
            } else {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(160)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(160)
                    ),
                    subitems: [item]
                )
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                let sectionInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.contentInsets = sectionInsets
                section.boundarySupplementaryItems = [header]
                return section
            }
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            let sectionInsets = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = orthogonalScrollingBehavior
            section.contentInsets = sectionInsets
            section.interGroupSpacing = 8
            return section
        }
        return layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .banners(let banners):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BannerCell.self)", for: indexPath) as! BannerCell
            let banner = banners[indexPath.row]
            cell.image = banner.image
            cell.layer.shadowOpacity = 0.1
            cell.layer.shadowRadius = 1
            return cell
        case .categoryes(let categoryes):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as! CategoryCell
            let category = categoryes[indexPath.row]
            cell.name = category.name
            return cell
        case .menu(let dishes):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MenuCell.self)", for: indexPath) as! MenuCell
            let dish = dishes[indexPath.row]
            cell.image = dish.image
            return cell
        }
    }
}

final class BannerCell: UICollectionViewCell {
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CategoryCell: UICollectionViewCell {
    var name: String? {
        get { categoryButton.title(for: .normal) }
        set { categoryButton.setTitle(newValue, for: .normal) }
    }
    
    private let categoryButton = UIButton()
    private let buttonColor = UIColor(red: 253/255, green: 58/255, blue: 105/255, alpha: 0.4)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryButton)
        categoryButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        categoryButton.layer.borderWidth = 1
        categoryButton.layer.borderColor = buttonColor.cgColor
        categoryButton.layer.cornerRadius = 16
        categoryButton.setTitleColor(buttonColor, for: .normal)
        categoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryButton.frame = bounds
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            categoryButton.backgroundColor = buttonColor
            categoryButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
            categoryButton.setTitleColor(buttonColor.withAlphaComponent(1), for: .normal)
            categoryButton.layer.borderWidth = 0
        } else {
            sender.backgroundColor = nil
            categoryButton.setTitleColor(buttonColor, for: .normal)
            categoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            categoryButton.layer.borderWidth = 1
            
        }
    }
}

final class MenuCell: UICollectionViewCell {
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    private let imageView = UIImageView()
    private let whiteSquareView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(whiteSquareView)
        addSubview(imageView)
        
        whiteSquareView.backgroundColor = .white
        whiteSquareView.frame = CGRect(x: 0, y: 0, width: 390, height: 156)
        whiteSquareView.center = contentView.center
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: whiteSquareView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: whiteSquareView.centerYAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalTo: whiteSquareView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: whiteSquareView.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


