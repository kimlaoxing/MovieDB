import Foundation
import Components

public struct DetailBaseResponse: Codable {
    public let adult: Bool?
    public let backdropPath: String?
    public let budget: Int?
    public let genres: [Genre]?
    public let homepage: String?
    public let id: Int?
    public let imdbID: String?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]?
    public let productionCountries: [ProductionCountry]?
    public let releaseDate: String?
    public let revenue: Int?
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguage]?
    public let status: String?
    public let tagline: String?
    public let title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decodeWrapper(key: .adult, defaultValue: false)
        self.backdropPath = try container.decodeWrapper(key: .backdropPath, defaultValue: "")
        self.budget = try container.decodeWrapper(key: .budget, defaultValue: 0)
        self.genres = try container.decodeWrapper(key: .genres, defaultValue: [])
        self.homepage = try container.decodeWrapper(key: .homepage, defaultValue: "")
        self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
        self.imdbID = try container.decodeWrapper(key: .imdbID, defaultValue: "")
        self.originalLanguage = try container.decodeWrapper(key: .originalLanguage, defaultValue: "")
        self.originalTitle = try container.decodeWrapper(key: .originalTitle, defaultValue: "")
        self.overview = try container.decodeWrapper(key: .overview, defaultValue: "")
        self.popularity = try container.decodeWrapper(key: .popularity, defaultValue: 0)
        self.posterPath = try container.decodeWrapper(key: .posterPath, defaultValue: "")
        self.productionCompanies = try container.decodeWrapper(key: .productionCompanies, defaultValue: [])
        self.productionCountries = try container.decodeWrapper(key: .productionCountries, defaultValue: [])
        self.releaseDate = try container.decodeWrapper(key: .releaseDate, defaultValue: "")
        self.revenue = try container.decodeWrapper(key: .revenue, defaultValue: 0)
        self.runtime = try container.decodeWrapper(key: .runtime, defaultValue: 0)
        self.spokenLanguages = try container.decodeWrapper(key: .spokenLanguages, defaultValue: [])
        self.status = try container.decodeWrapper(key: .status, defaultValue: "")
        self.tagline = try container.decodeWrapper(key: .tagline, defaultValue: "")
        self.title = try container.decodeWrapper(key: .title, defaultValue: "")
        self.video = try container.decodeWrapper(key: .video, defaultValue: false)
        self.voteAverage = try container.decodeWrapper(key: .voteAverage, defaultValue: 0)
        self.voteCount = try container.decodeWrapper(key: .voteCount, defaultValue: 0)
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
        public let logoPath: String?
        public let name: String?
        public let originCountry: String?
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case logoPath = "logo_path"
            case name = "name"
            case originCountry = "origin_country"
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeWrapper(key: .id, defaultValue: 0)
            self.logoPath = try container.decodeWrapper(key: .logoPath, defaultValue: "")
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
            self.originCountry = try container.decodeWrapper(key: .originCountry, defaultValue: "")
        }
    }
    
    public struct ProductionCountry: Codable {
        public let iso: String?
        public let name: String?
        
        enum CodingKeys: String, CodingKey {
            case iso = "iso_3166_1"
            case name = "name"
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.iso = try container.decodeWrapper(key: .iso, defaultValue: "")
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
        }
        
    }
    
    public struct SpokenLanguage: Codable {
        public let iso: String?
        public let name: String?
        
        enum CodingKeys: String, CodingKey {
               case iso = "iso_639_1"
               case name = "name"
           }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.iso = try container.decodeWrapper(key: .iso, defaultValue: "")
            self.name = try container.decodeWrapper(key: .name, defaultValue: "")
        }
    }
}
