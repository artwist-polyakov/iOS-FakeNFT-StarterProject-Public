import UIKit

enum Resources {
    
    enum Images {
        static let editProfile = UIImage(named: "editIcon")
        static let forwardButtonImage = UIImage(systemName: "chevron.forward")
        
        enum NotificationBanner {
            static let notificationBannerImage = UIImage(systemName: "antenna.radiowaves.left.and.right.slash")
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
            }
        }
    }
}
