import Foundation

public class FavoriteModel {
    public let id: Int32?
    public let popularity: Double?
    public let poster_path: String?
    public let release_date: String?
    public let title: String?
    
    public init(
        id: Int32?,
        popularity: Double?,
        poster_path: String?,
        release_date: String?,
        title: String?
    )  {
        self.id = id
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
    }
}
