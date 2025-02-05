//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 13.10.2023.
//

import Foundation

final class DataProviderInteractor: DataProviderInteractorProtocol {
    
    private let sortTypeKey = "selectedSortType"
    private var collections: [CollectionModel]
    private var author: AuthorModel?
    private var NFTs: [NFTModel] = []
    private let nftAccessSemaphore = DispatchSemaphore(value: 1)
    private var currentSortType: SortType?
    private let dataProvider: CatalogDataProviderProtocol
    
    // MARK: - INIT
    init(
        dataProvider: CatalogDataProviderProtocol,
        completion: @escaping (Result<[CollectionModel], Error>) -> Void = {_ in }
    ) {
        self.dataProvider = dataProvider
        self.collections = []
        
        currentSortType = savedSortType()
        self.dataProvider.fetchMeAllCollections() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let collections):
                self.collections = collections
                switch self.currentSortType {
                case .byName:
                    sortCollectionsByName()
                default:
                    sortCollectionsByNFTQuantity()
                }
                completion(result)
                
            case .failure:
                completion(result)
            }
        }
    }
    
    // MARK: - Answers
    func giveMeAllCollections(isSorted: Bool = false) -> [CollectionModel] {
        return self.collections
    }
    
    func howManyCollections() -> Int {
        return self.collections.count
    }
    
    func giveMeCollectionAt(index: Int, withSort: Bool = false) -> CollectionModel? {
        if index < self.collections.count {
            return self.collections[index]
        } else {
            return nil
        }
    }
    
    // MARK: - Reload
    func reloadCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void = {_ in }) {
        self.dataProvider.fetchMeAllCollections() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let collections):
                self.collections = collections
                if let sortType = self.currentSortType {
                    switch sortType {
                    case .byName(let order):
                        self.sortCollectionsByName(inOrder: order)
                    case .byNFTQuantity(let order):
                        self.sortCollectionsByNFTQuantity(inOrder: order)
                    }
                }
            case .failure:
                break
            }
            completion(result)
        }
    }
    
    // MARK: - Authors
    func fetchMyAuthor(with id: String, completion: @escaping (Result<AuthorModel, Error>) -> Void = {_ in })  {
        self.dataProvider.fetchMyAuthor(with: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let author):
                self.author = author
            case .failure:
                break
            }
            completion(result)
        }
    }
    
    func clearAuthor() {
        self.author = nil
    }
    
    func giveMeCurrentAuthor() -> AuthorModel? {
        return self.author
    }
    
    // MARK: - NFTs
    func fetchMyNFT(with id: String, completion: @escaping (Result<NFTModel, Error>) -> Void = {_ in }) {
        self.dataProvider.fetchMeNft(withID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let nft):
                self.NFTs.append(nft)
            case .failure:
                break
            }
            completion(result)
        }
    }
    
    func clearNFTs() {
        self.NFTs = []
    }
    
    func giveMeNFTsQuantity() -> Int {
        return self.NFTs.count
    }
    
    func giveMeNFTAt(index: Int) -> NFTModel? {
        if index < self.NFTs.count {
            return self.NFTs[index]
        } else {
            return nil
        }
    }
    
    // MARK: - Sort
    func sortCollectionsByName(inOrder: SortCases = .ascending ) {
        applySortType(.byName(order: inOrder))
        switch inOrder {
        case .ascending:
             self.collections = collections.sorted { $0.name < $1.name }
        case .descending:
            self.collections = collections.sorted { $0.name > $1.name }
        }
    }
    
    func sortCollectionsByNFTQuantity(inOrder: SortCases = .descending) {
        applySortType(.byNFTQuantity(order: inOrder))
        switch inOrder {
        case .ascending:
            self.collections =  collections.sorted { $0.nfts.count < $1.nfts.count }
        case .descending:
            self.collections =  collections.sorted { $0.nfts.count > $1.nfts.count }
        }
    }
    
    // MARK: - Save/Load
    private func saveSortType(_ type: SortType) {
        let value: String
        switch type {
        case .byName:
            value = "byName"
        case .byNFTQuantity:
            value = "byNFTQuantity"
        }
        UserDefaults.standard.setValue(value, forKey: sortTypeKey)
    }
    
    private func loadSortType() -> SortType? {
        guard let value = UserDefaults.standard.string(forKey: sortTypeKey) else {
            return nil
        }
        switch value {
        case "byName":
            currentSortType = .byName(order: .ascending)
            return .byName(order: .ascending)
        case "byNFTQuantity":
            currentSortType = .byNFTQuantity(order: .descending)
            return .byNFTQuantity(order: .descending)
        default:
            return nil
        }
    }
    
    private func applySortType(_ type: SortType) {
        currentSortType = type
        saveSortType(type)
    }
    
    private func savedSortType() -> SortType {
        let value = UserDefaults.standard.string(forKey: sortTypeKey)
        switch value {
        case "byName":
            return .byName(order: .ascending)
        default:
            return .byNFTQuantity(order: .descending)
        }
    }
}
