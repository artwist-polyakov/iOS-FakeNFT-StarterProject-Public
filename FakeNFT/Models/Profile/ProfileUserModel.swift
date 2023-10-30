import Foundation

struct ProfileUserModel: Decodable {
    let name: String
    let avatar: String
    let rating: String
    let id: String
}

typealias Users = [ProfileUserModel]
