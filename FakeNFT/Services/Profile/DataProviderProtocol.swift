import Foundation

protocol DataProviderProtocol {
    func fetchProfile(completion: @escaping (Result<Profile, Error>) -> Void)
}
