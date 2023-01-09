import IGListKit
import UIKit

final class IGListKitModel: NSObject {
    let id: Int32?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String?
    
    init(
        id: Int32?,
        popularity: Double?,
        poster_path: String?,
        release_date: String?,
        title: String?
    )  {
        self.id = id
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
    }
}

extension IGListKitModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
