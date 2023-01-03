import Foundation
import Components

public struct BaseResponse: Codable {
    public let page: Int?
    public let results: [Result]?
    public let dates: Dates?
    public let totalPages: Int?
    public let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates = "dates"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeWrapper(key: .page, defaultValue: 0)
        self.results = try container.decodeWrapper(key: .results, defaultValue: nil)
        self.dates = try container.decodeWrapper(key: .dates, defaultValue: nil)
        self.totalPages = try container.decodeWrapper(key: .totalPages, defaultValue: 0)
        self.totalResults = try container.decodeWrapper(key: .totalResults, defaultValue: 0)
    }
    
    public struct Dates: Codable {
        public let maximum: String?
        public let minimum: String?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.maximum = try container.decodeWrapper(key: .maximum, defaultValue: "")
            self.minimum = try container.decodeWrapper(key: .minimum, defaultValue: "")
        }
    }
    
    public struct Result: Codable {
        public let posterPath: String?
        public let adult: Bool?
        public let overview: String?
        public let releaseDate: String?
        public let genreIDS: [Int]?
        public let id: Int?
        public let originalTitle: String?
        public let originalLanguage: String?
        public let title: String?
        public let backdropPath: String?
        public let popularity: Double?
        public let voteCount: Int?
        public let video: Bool?
        public let voteAverage: Double?
        
        enum CodingKeys: String, CodingKey {
            case adult = "adult"
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id = "id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview = "overview"
            case popularity = "popularity"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title = "title"
            case video = "video"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.posterPath = try container.decodeWrapper(key: .posterPath, defaultValue: "")
            self.adult = try container.decodeWrapper(key: .adult, defaultValue: false)
            self.overview = try container.decodeWrapper(key: .overview, defaultValue: "")
            self.releaseDate = try container.decodeWrapper(key: .releaseDate, defaultValue: "")
            self.genreIDS = try container.decodeWrapper(key: .genreIDS, defaultValue: [0])
            self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
            self.originalTitle = try container.decodeWrapper(key: .originalTitle, defaultValue: "")
            self.originalLanguage = try container.decodeWrapper(key: .originalLanguage, defaultValue: "")
            self.title = try container.decodeWrapper(key: .title, defaultValue: "")
            self.backdropPath = try container.decodeWrapper(key: .backdropPath, defaultValue: "")
            self.popularity = try container.decodeWrapper(key: .popularity, defaultValue: 0)
            self.voteCount = try container.decodeWrapper(key: .voteCount, defaultValue: 0)
            self.video = try container.decodeWrapper(key: .video, defaultValue: false)
            self.voteAverage = try container.decodeWrapper(key: .voteAverage, defaultValue: 0)
        }
    }
}
