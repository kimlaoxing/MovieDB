import Foundation
import Alamofire
import Components

protocol DetailBaseRemote {
    mutating func getDetailMovie(with id: Int, completion: @escaping (DetailBaseModel) -> Void)
}

struct DetailBaseRemoteData: DetailBaseRemote {
    mutating func getDetailMovie(with id: Int, completion: @escaping (DetailBaseModel) -> Void) {
        let endpoint = "\(APIService.detailBasePath)/\(id)?api_key=\(APIService.apiKey)"
        AF.request(endpoint,
                   method: .get,
                   encoding: JSONEncoding.default
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DetailBaseModel.self) { data in
                switch data.result {
                case .success(let data):
                    completion(data)
                case .failure:
                    break
                }
            }
    }
}
