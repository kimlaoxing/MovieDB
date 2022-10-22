import Foundation
import CoreData

public protocol FavoriteLocal {
    func getAllFavoriteGame(completion: @escaping(_ members: [FavoriteModel]) -> Void)
    func getFavorite(_ id: Int, completion: @escaping(_ bool: Bool) -> Void)
    func addFavorite(_ favoriteModel: FavoriteModel) throws
    func deleteFavorite(_ id: Int) throws
}

public class FavoriteLocalData: FavoriteLocal {

    let frameworkBundleID   = "com.personal.MovieDB.Favorite"
    let modelName           = "LocalDataSource"
    
    public init () { }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let frameworkBundle = Bundle(identifier: self.frameworkBundleID)
        let modelURL = frameworkBundle!.url(forResource: self.modelName,
                                            withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        let container = NSPersistentContainer(name: self.modelName,
                                              managedObjectModel: managedObjectModel ?? NSManagedObjectModel())
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()
    
    func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    public func getAllFavoriteGame(completion: @escaping(_ members: [FavoriteModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var favorites: [FavoriteModel] = []
                for result in results {
                    let favorite = FavoriteModel(
                        id: result.value(forKeyPath: "id") as? Int32,
                        popularity: result.value(forKeyPath: "popularity") as? Double,
                        poster_path: result.value(forKeyPath: "poster_path") as? String,
                        release_date: result.value(forKeyPath: "release_date") as? String,
                        title: result.value(forKeyPath: "title") as? String
                    )
                    favorites.append(favorite)
                }
                completion(favorites)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    public func getFavorite(_ id: Int, completion: @escaping(_ bool: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if (try taskContext.fetch(fetchRequest).first) != nil {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    public func addFavorite(_ favoriteModel: FavoriteModel) throws {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
                let favorite = NSManagedObject(entity: entity, insertInto: taskContext)
                favorite.setValue(favoriteModel.id, forKey: "id")
                favorite.setValue(favoriteModel.popularity, forKey: "popularity")
                favorite.setValue(favoriteModel.release_date, forKey: "release_date")
                favorite.setValue(favoriteModel.poster_path, forKey: "poster_path")
                favorite.setValue(favoriteModel.title, forKey: "title")
                do {
                    try taskContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    public func deleteFavorite(_ id: Int) throws {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            do {
                try taskContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
        }
    }
}
