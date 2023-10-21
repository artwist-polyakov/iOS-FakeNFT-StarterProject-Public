//
//  NFTsTableViewCell.swift
//  FakeNFT
//
//  Created by Александр Поляков on 20.10.2023.
//

import UIKit

final class NFTsTableViewCell: UITableViewCell, ReuseIdentifying {
    // MARK: - Elements
    private var collection: UICollectionView
    private var dataSource: NFTDataSourceProtocol?
    static let numberOfColumns: CGFloat = 3
    var selectedIndexPath: IndexPath? = nil
    private var collectionHeightConstraint: NSLayoutConstraint?
    var estimatedHeight: CGFloat = 0 //{
//        didSet {
//                collectionHeightConstraint?.constant = estimatedHeight
//                layoutIfNeeded()
//            }
//    }
    var estimatedCellWidth: CGFloat = 0
    // MARK: - INIT
    init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?,
        estimatedHeight: CGFloat,
        estimatedCellWidth: CGFloat
    ) {
        self.estimatedHeight = estimatedHeight
        self.estimatedCellWidth = estimatedCellWidth
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collection.register(NFTCell.self)
        collection.allowsSelection = false
        collection.isScrollEnabled = false
        collection.dataSource = self
        collection.delegate = self
        setupUI()
        contentView.layoutIfNeeded()
        print(collection.frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataSource(with source: NFTDataSourceProtocol) {
        self.dataSource = source
        self.collection.reloadData()
    }
    
    private func setupUI() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collection)
        print(estimatedHeight)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collection.heightAnchor.constraint(equalToConstant: estimatedHeight)
        ])
    }
}

extension NFTsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Я таблица — узнаю количетсво ячеек во мне")
        print(dataSource?.numberOfNFTs() ?? 0)
        return dataSource?.numberOfNFTs() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NFTCell = collection.dequeueReusableCell(indexPath: indexPath)
        cell.imageWidth = estimatedCellWidth
        print("pre configurecell for indexpath \(indexPath)")
        guard let dataSource = dataSource,
              let NFT = dataSource.nft(at: indexPath) 
        else { 
            print("ухожу из цикла по гарду")
            return cell }
        cell.configureCell(isLiked: dataSource.isNFTLiked(at: indexPath), isOrdered: dataSource.isNFTOrdered(at: indexPath), NFT:NFT)
        print("post configurecell at indexpath \(indexPath)")
        return cell
    }
}

extension NFTsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.frame.width - 9 * (NFTsTableViewCell.numberOfColumns - 1)) / NFTsTableViewCell.numberOfColumns)
        return CGSize(width: width, height: width + 56 + 6)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
