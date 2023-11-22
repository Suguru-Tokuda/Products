//
//  CoreDataManager.swift
//  ElectronicProducts
//
//  Created by Suguru Tokuda on 11/21/23.
//

import Foundation
import CoreData

protocol CoreDataActions {
    func saveDataIntoDatabase(list: [ElectronicProduct]) async throws
    func getDataFromDatabase() async throws -> [ElectronicProduct]
    func deleteFromDatabase(entry: ElectronicProductEntity) async throws
}

class CoreDataManager: CoreDataActions {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveDataIntoDatabase(list: [ElectronicProduct]) async throws {
        try await clearAllRecord()
        
        list.forEach { product in
            let productEntity = ElectronicProductEntity(context: self.context)
            
            productEntity.id = Int32(product.id)
            productEntity.title = product.title
            productEntity.productDesc = product.description
            productEntity.brand = product.brand
            productEntity.category = product.category
            productEntity.discountPercentage = product.discountPercentage
            productEntity.images = product.images as [NSString] as NSArray
            productEntity.thumbnail = product.thumbnail
            productEntity.rating = product.rating
            productEntity.stock = Int32(product.stock)
            productEntity.price = Int32(product.price)
        }
        
        do {
            try save()
        } catch {
            throw error
        }
    }
    
    func getDataFromDatabase() async throws -> [ElectronicProduct] {
        let request: NSFetchRequest<ElectronicProductEntity> = ElectronicProductEntity.fetchRequest()
        let allRecords = try self.context.fetch(request)
        
        var retVal: [ElectronicProduct] = []
        
        allRecords.forEach { entity in
            if let product = ElectronicProduct(entity: entity) {
                retVal.append(product)
            }
        }
        
        return retVal
    }
    
    func deleteFromDatabase(entry: ElectronicProductEntity) async throws {
        self.context.delete(entry)

        do {
            try save()
        } catch {
            throw error
        }
    }
    
    func save() throws {
        do {
            try self.context.save()
        } catch {
            throw error
        }
    }
    
    func clearAllRecord() async throws {
        let request: NSFetchRequest<ElectronicProductEntity> = ElectronicProductEntity.fetchRequest()
        let allRecords = try self.context.fetch(request)
        allRecords.forEach { self.context.delete($0) }
        try self.context.save()
    }
}
