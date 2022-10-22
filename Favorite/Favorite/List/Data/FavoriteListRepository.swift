import Foundation

public protocol FavoriteListRepository {
    func getAllFavoriteGame(completion: @escaping(_ members: [FavoriteModel]) -> Void)
    func getFavorite(_ id: Int, completion: @escaping(_ bool: Bool) -> Void)
    func addFavorite(_ favoriteModel: FavoriteModel)
    func deleteFavorite(_ id: Int)
}

public class FavoriteListRepositoryData: FavoriteListRepository {
    
    private var localData: FavoriteLocal
    
    public init(
        localData: FavoriteLocalData = FavoriteLocalData()
    ) {
        self.localData = localData
    }
    
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
