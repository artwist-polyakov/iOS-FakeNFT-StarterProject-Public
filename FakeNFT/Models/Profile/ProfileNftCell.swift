import Foundation

struct ProfileNFTCell {
    let name: String
    let images: [String]
    let rating: Int
    let price: Double
    let author: String
    let id: String
    let isLiked: Bool
    let isAddedToCard: Bool
}

typealias NFTCells = [ProfileNFTCell]
