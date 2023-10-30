import Foundation

struct ProfileNetworkRequestModel: NetworkRequest {
    var endpoint: URL?
    var httpMethod: HttpMethod
    var dto: Encodable?
}
