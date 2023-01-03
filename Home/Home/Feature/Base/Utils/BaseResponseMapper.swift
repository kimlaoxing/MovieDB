import Foundation

final class BaseResponseMapper {
    static func baseResponseMapper(result: [BaseResponse.Result], response: BaseResponse) -> [BaseResult] {
        return result.map { data in
          return BaseResult(
            id: data.id ?? 0,
            title: data.title ?? "",
            poster_path: data.posterPath ?? "",
            release_date: data.releaseDate ?? "",
            popularity: Int(data.popularity ?? 0),
            total_pages: response.totalPages ?? 0,
            page: response.page ?? 0
          )
        }
    }
}
