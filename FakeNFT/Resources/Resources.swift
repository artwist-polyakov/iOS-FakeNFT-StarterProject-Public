import UIKit

enum Resources {
    
    enum Images {
        static let editProfile = UIImage(named: "editIcon")
        static let forwardButtonImage = UIImage(systemName: "chevron.forward")
        
        enum NotificationBanner {
            static let notificationBannerImage = UIImage(systemName: "antenna.radiowaves.left.and.right.slash")
        }
    }
    
    enum Network {
        
        enum MockAPI {
            static let defaultStringURL = "https://651ff0cc906e276284c3c1bc.mockapi.io"
            
            enum Paths {
                static let currencies = "/api/v1/currencies"
                static let nftCollection = "/api/v1/collections"
                static let nftCard = "/api/v1/nft"
                static let orders = "/api/v1/orders/1"
                static let orderPayment = "/api/v1/orders/1/payment"
                static let profile = "/api/v1/profile/1"
                static let users = "/api/v1/users"
            }
        }
    }
}
