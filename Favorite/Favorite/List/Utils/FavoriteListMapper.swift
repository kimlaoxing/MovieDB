import Foundation

final class FavoriteListMapper {
    static func detailBaseMapper(response: [FavoriteModel]) -> [FavoriteResult] {
        return response.map { i in
            return FavoriteResult(id: i.id ?? 0, popularity: i.popularity ?? 0, poster_path: i.poster_path ?? "", release_date: i.release_date ?? "", title: i.title ?? "")
        }
    }
}
