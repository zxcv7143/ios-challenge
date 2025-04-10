//
//  AdListLocalDataManager.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//
import CoreData
// MARK: - Protocol
protocol AdListLocalDataManagerProtocol: AnyObject {
    func isFavouriteAd(propertyCode: String) -> Bool
    func saveFavouriteAd(propertyCode: String, completion: (Bool, FavouriteAd?) -> (Void))
    func removeFavouriteAd(propertyCode: String, removed completion: (Bool) -> (Void))
    func fetchFavouriteAdSavingDate(by propertyCode: String) -> Date?
}


// MARK: - Class
final class AdListLocalDataManager: AdListLocalDataManagerProtocol {
    
    func isFavouriteAd(propertyCode: String) -> Bool {
        let fetchRequest: NSFetchRequest<FavouriteAd> = FavouriteAd.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyCode)
        do {
            let results = try PersistenceManager.shared.managedContext.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            return false
        }
    }
    
    func saveFavouriteAd(propertyCode: String, completion: (Bool, FavouriteAd?) -> (Void)) {
        let ad = FavouriteAd(context: PersistenceManager.shared.managedContext)
        ad.propertyCode = propertyCode
        ad.savingDate = Date()
        PersistenceManager.shared.saveContext()
        completion(true, ad)
    }

    func removeFavouriteAd(propertyCode: String, removed completion: (Bool) -> (Void)) {
        let fetchRequest: NSFetchRequest<FavouriteAd> = FavouriteAd.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyCode)
        do {
            guard let result = try PersistenceManager.shared.managedContext.fetch(fetchRequest).first else { return }
            PersistenceManager.shared.managedContext.delete(result)
            PersistenceManager.shared.saveContext()
            completion(true)
        } catch {
            completion(false)
        }
    }

    
    func fetchFavouriteAdSavingDate(by propertyCode: String) -> Date? {
        let fetchRequest: NSFetchRequest<FavouriteAd> = FavouriteAd.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyCode)
        do {
            let results = try PersistenceManager.shared.managedContext.fetch(fetchRequest)
            return results.first?.savingDate
        } catch {
            print("Error fetching FavouriteAd date for propertyCode \(propertyCode): \(error)")
            return nil
        }
    }

}
