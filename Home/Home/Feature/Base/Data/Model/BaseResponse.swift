import Foundation
import Components

public struct BaseResponse: Codable {
    public let page: Int?
    public let results: [Result]?
    public let dates: Dates?
    public let total_pages: Int?
    public let total_results: Int?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeWrapper(key: .page, defaultValue: 0)
        self.results = try container.decodeWrapper(key: .results, defaultValue: nil)
        self.dates = try container.decodeWrapper(key: .dates, defaultValue: nil)
        self.total_pages = try container.decodeWrapper(key: .total_pages, defaultValue: 0)
        self.total_results = try container.decodeWrapper(key: .total_results, defaultValue: 0)
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
        public let poster_path: String?
        public let adult: Bool?
        public let overview: String?
        public let release_date: String?
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
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.poster_path = try container.decodeWrapper(key: .poster_path, defaultValue: "")
            self.adult = try container.decodeWrapper(key: .adult, defaultValue: false)
            self.overview = try container.decodeWrapper(key: .overview, defaultValue: "")
            self.release_date = try container.decodeWrapper(key: .release_date, defaultValue: "")
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
