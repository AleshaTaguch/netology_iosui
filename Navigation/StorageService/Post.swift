import UIKit
import iOSIntPackage

public struct Post {
    public var title: String
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    var colorFilter: ColorFilter?
    
    public var imageWithFilter: UIImage? {
         get {
            var sourceImage: UIImage?
            if let valueColorFilter = colorFilter,
               let originalImage = UIImage(named: self.image) {
                ImageProcessor().processImage(sourceImage: originalImage, filter: valueColorFilter) { image in  sourceImage = image}
            }
            return sourceImage
        }
    }
    
    public init(title: String, author: String, description: String, image: String, likes: Int, views: Int) {
        self.title = title
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
        
        self.colorFilter = ColorFilter.allCases.randomElement()
        if let valueColorFilter = self.colorFilter {
            self.description = "\(self.description) \n\nИспользован фильтр: \(valueColorFilter.description())"
        }
    }
    
}


extension ColorFilter {
    public func description() -> String {
        return String(describing: self)
    }
    
}

