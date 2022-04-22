import Foundation

public struct Post {
    public var title: String
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    
    public init(title: String, author: String, description: String, image: String, likes: Int, views: Int) {
        self.title = title
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
    
}
