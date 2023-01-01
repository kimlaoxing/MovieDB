import Foundation

final class BaseResponseMapper {
    static func baseResponseMapper(result: [BaseResponse.Result], response: BaseResponse) -> [BaseResult] {
        return result.map { i in
          return BaseResult(
            id: i.id ?? 0,
            title: i.title ?? "",
            poster_path: i.poster_path ?? "",
            release_date: i.release_date ?? "",
            popularity: Int(i.popularity ?? 0),
            total_pages: response.total_pages ?? 0,
            page: response.page ?? 0
          )
        }
    }
}
