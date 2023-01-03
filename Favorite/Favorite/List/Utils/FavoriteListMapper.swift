import Foundation

final class FavoriteListMapper {
    static func detailBaseMapper(response: [FavoriteModel]) -> [FavoriteResult] {
        return response.map { data in
            return FavoriteResult(
                id: data.id ?? 0,
                popularity: data.popularity ?? 0,
                poster_path: data.poster_path ?? "",
                release_date: data.release_date ?? "",
                title: data.title ?? ""
            )
        }
    }
}
