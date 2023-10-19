import UIKit

enum Resources {
    
    enum Images {
        static let editProfile = UIImage(named: "editIcon")
        static let forwardButtonImage = UIImage(systemName: "chevron.forward")
        
        enum NotificationBanner {
            static let notificationBannerImage = UIImage(systemName: "antenna.radiowaves.left.and.right.slash")
        }
        
        enum NavBar {
            static let sortIcon = UIImage(systemName: "text.justify.leading")
        }
        
        enum NFTCollectionCell {
            static let unlikedButton = UIImage(systemName: "heart.fill")?.withTintColor(.ypWhiteUniversal, renderingMode: .alwaysOriginal)
            static let likedButton = UIImage(systemName: "heart.fill")?.withTintColor(.ypRed, renderingMode: .alwaysOriginal)
        }
        
        enum RateImages {
            static let rateZero = UIImage(named: "rateZero")
            static let rateOne = UIImage(named: "rateOne")
            static let rateTwo = UIImage(named: "rateTwo")
            static let rateThree = UIImage(named: "rateThree")
            static let rateFour = UIImage(named: "rateFour")
            static let rateFive = UIImage(named: "rateFive")
        }
        
        enum NFTBrowsing {
            static let cancellButton = UIImage(systemName: "xmark")?.withTintColor(.ypBlackWithDarkMode, renderingMode: .alwaysOriginal)
        }
    }
    
    enum Network {
        
        enum MockAPI {
            static let defaultStringURL = "https://651ff0cc906e276284c3c1bc.mockapi.io"
            
            enum Paths {
                static let profile = "/api/v1/profile/1"
                static let nftCard = "/api/v1/nft"
                static let users = "/api/v1/users"
            }
        }
    }
}
