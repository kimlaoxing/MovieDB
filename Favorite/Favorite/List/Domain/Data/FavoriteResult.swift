import Foundation

public class FavoriteResult {
    public var id: Int32
    public var popularity: Double
    public var poster_path: String
    public var release_date: String
    public var title: String
    
    public init(
        id: Int32?,
        popularity: Double?,
        poster_path: String?,
        release_date: String?,
        title: String?
    )  {
        self.id = id ?? 0
        self.popularity = popularity ?? 0
        self.poster_path = poster_path ?? ""
        self.release_date = release_date ?? ""
        self.title = title ?? ""
    }
}
