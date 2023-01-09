import Foundation

final class IGListKitDataMapper {
    static func BaseResponseToIGListKitModel(result: [BaseResponse.Result], response: BaseResponse) -> [IGListKitModel] {
        return result.map { data in
          return IGListKitModel(
            id: Int32(data.id ?? 0),
            popularity: data.popularity ?? 0,
            poster_path: data.poster_path ?? "",
            release_date: data.release_date ?? "",
            title: data.title ?? ""
          )
        }
    }
}
