import Foundation

final class DetailBaseMapper {
    
    static func detailBaseMapper(response: DetailBaseResponse) -> DetailBaseResult {
        let i = response
        var gendreName = ""
        var spokenLangugageName = ""
        var production_companies = ""
        
        if i.genres != nil {
            gendreName = i.genres!.map({ $0.name ?? ""}).joined(separator: ", ")
        }
        
        if i.spoken_languages != nil {
            spokenLangugageName = i.spoken_languages!.map({ $0.name ?? ""}).joined(separator: ", ")
        }
        
        if i.production_companies != nil {
            production_companies = i.production_companies!.map({ $0.name ?? ""}).joined(separator: ", ")
        }
        
        let result: DetailBaseResult = DetailBaseResult(id: i.id ?? 0,
                                                        title: i.title ?? "",
                                                        backdrop_path: i.backdrop_path ?? "",
                                                        release_date: i.release_date ?? "",
                                                        vote_average: i.vote_average ?? 0,
                                                        gendreName: gendreName,
                                                        spokenLanguageName: spokenLangugageName,
                                                        popularity: i.popularity ?? 0,
                                                        poster_path: i.poster_path ?? "",
                                                        production_companies: production_companies,
                                                        overview: i.overview ?? "")
        return result
    }
}
