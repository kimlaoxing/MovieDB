import Foundation
import Favorite

final class DetailBaseMapper {
    
    static func detailBaseMapper(response: DetailBaseResponse) -> DetailBaseResult {
        var gendreName = ""
        var spokenLangugageName = ""
        var productionCompanies = ""
        
        if response.genres != nil {
            gendreName = response.genres!.map({ $0.name ?? ""}).joined(separator: ", ")
        }
        
        if response.spokenLanguages != nil {
            spokenLangugageName = response.spokenLanguages!.map({ $0.name ?? ""}).joined(separator: ", ")
        }
        
        if response.productionCompanies != nil {
            productionCompanies = response.productionCompanies!.map({ $0.name ?? ""}).joined(separator: ", ")
        }
        
        let result: DetailBaseResult = DetailBaseResult(id: response.id ?? 0,
                                                        title: response.title ?? "",
                                                        backdrop_path: response.backdropPath ?? "",
                                                        release_date: response.releaseDate ?? "",
                                                        vote_average: response.voteAverage ?? 0,
                                                        gendreName: gendreName,
                                                        spokenLanguageName: spokenLangugageName,
                                                        popularity: response.popularity ?? 0,
                                                        poster_path: response.posterPath ?? "",
                                                        production_companies: productionCompanies,
                                                        overview: response.overview ?? "")
        return result
    }
    
    static func favoriteResultToResponse(result: FavoriteResult) -> FavoriteModel {
        let result: FavoriteModel = FavoriteModel(id: result.id,
                                                  popularity: result.popularity,
                                                  poster_path: result.poster_path,
                                                  release_date: result.release_date,
                                                  title: result.title)
        return result
    }
}
