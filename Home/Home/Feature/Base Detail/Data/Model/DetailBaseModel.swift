import Foundation
import Components

public struct DetailBaseModel: Codable {
    public let adult: Bool?
    public let backdrop_path: String?
    public let budget: Int?
    public let genres: [Genre]?
    public let homepage: String?
    public let id: Int?
    public let imdb_id: String?
    public let original_language: String?
    public let original_title: String?
    public let overview: String?
    public let popularity: Double?
    public let poster_path: String?
    public let production_companies: [ProductionCompany]?
    public let production_countries: [ProductionCountry]?
    public let release_date: String?
    public let revenue: Int?
    public let runtime: Int?
    public let spoken_languages: [SpokenLanguage]?
    public let status: String?
    public let tagline: String?
    public let title: String?
    public let video: Bool?
    public let vote_average: Double?
    public let vote_count: Int?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decodeWrapper(key: .adult, defaultValue: false)
        self.backdrop_path = try container.decodeWrapper(key: .backdrop_path, defaultValue: "")
        self.budget = try container.decodeWrapper(key: .budget, defaultValue: 0)
        self.genres = try container.decodeWrapper(key: .genres, defaultValue: [])
        self.homepage = try container.decodeWrapper(key: .homepage, defaultValue: "")
        self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
        self.imdb_id = try container.decodeWrapper(key: .imdb_id, defaultValue: "")
        self.original_language = try container.decodeWrapper(key: .original_language, defaultValue: "")
        self.original_title = try container.decodeWrapper(key: .original_title, defaultValue: "")
        self.overview = try container.decodeWrapper(key: .overview, defaultValue: "")
        self.popularity = try container.decodeWrapper(key: .popularity, defaultValue: 0)
        self.poster_path = try container.decodeWrapper(key: .poster_path, defaultValue: "")
        self.production_companies = try container.decodeWrapper(key: .production_companies, defaultValue: [])
        self.production_countries = try container.decodeWrapper(key: .production_countries, defaultValue: [])
        self.release_date = try container.decodeWrapper(key: .release_date, defaultValue: "")
        self.revenue = try container.decodeWrapper(key: .revenue, defaultValue: 0)
        self.runtime = try container.decodeWrapper(key: .runtime, defaultValue: 0)
        self.spoken_languages = try container.decodeWrapper(key: .spoken_languages, defaultValue: [])
        self.status = try container.decodeWrapper(key: .status, defaultValue: "")
        self.tagline = try container.decodeWrapper(key: .tagline, defaultValue: "")
        self.title = try container.decodeWrapper(key: .title, defaultValue: "")
        self.video = try container.decodeWrapper(key: .video, defaultValue: false)
        self.vote_average = try container.decodeWrapper(key: .vote_average, defaultValue: 0)
        self.vote_count = try container.decodeWrapper(key: .vote_count, defaultValue: 0)
    }
    
    public struct Genre: Codable {
        public let id: Int?
        public let name: String?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
        }
    }

    public struct ProductionCompany: Codable {
        public let id: Int?
        public let logo_path: String?
        public let name: String?
        public let origin_country: String?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
            self.logo_path = try container.decodeWrapper(key: .logo_path, defaultValue: "")
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
            self.origin_country = try container.decodeWrapper(key: .origin_country, defaultValue: "")
        }
    }

    public struct ProductionCountry: Codable {
        public let iso_3166_1: String?
        public let name: String?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.iso_3166_1 = try container.decodeWrapper(key: .iso_3166_1, defaultValue: "")
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
        }
        
    }

    public struct SpokenLanguage: Codable {
        public let iso_639_1: String?
        public let name: String?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.iso_639_1 = try container.decodeWrapper(key: .iso_639_1, defaultValue: "")
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
        }
    }
}
