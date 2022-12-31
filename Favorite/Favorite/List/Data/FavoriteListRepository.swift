import Foundation

public protocol FavoriteListRepositoryProtocol {
    func getAllFavoriteGame(completion: @escaping(_ members: [FavoriteModel]) -> Void)
    func getFavorite(_ id: Int, completion: @escaping(_ bool: Bool) -> Void)
    func addFavorite(_ favoriteModel: FavoriteModel)
    func deleteFavorite(_ id: Int)
}

public class FavoriteListRepository: NSObject {
    public typealias FavoriteInstance = (FavoriteLocalDataSource) -> FavoriteListRepository
    
    fileprivate let localData: FavoriteLocalDataSource
    
    public init(localData: FavoriteLocalDataSource) {
        self.localData = localData
    }
    
    public static let sharedInstance: FavoriteInstance = { localRepo in
        return FavoriteListRepository(localData: localRepo)
    }
}

extension FavoriteListRepository: FavoriteListRepositoryProtocol {
    public func getAllFavoriteGame(completion: @escaping ([FavoriteModel]) -> Void) {
        self.localData.getAllFavoriteGame { members in
            completion(members)
        }
    }
    
    public func getFavorite(_ id: Int, completion: @escaping (Bool) -> Void) {
        self.localData.getFavorite(id) { bool in
            completion(bool)
        }
    }
    
    public func addFavorite(_ favoriteModel: FavoriteModel) {
        do {
            try self.localData.addFavorite(favoriteModel)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteFavorite(_ id: Int) {
        do {
            try self.localData.deleteFavorite(id)
        } catch {
            print(error.localizedDescription)
        }
    }
}
