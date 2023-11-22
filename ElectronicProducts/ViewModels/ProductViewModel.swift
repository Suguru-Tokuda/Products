//
//  ProductViewModel.swift
//  ElectronicProducts
//
//  Created by Suguru Tokuda on 11/21/23.
//

import Foundation
import Combine
import CoreData
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [ElectronicProduct] = []
    @Published var filteredProducts: [ElectronicProduct] = []
    @Published var isErrorOccured: Bool = false
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    var total: Int?
    var cancellable = Set<AnyCancellable>()
    var customError: NetworkError?
    var networkManager: Networking
    var coreDataManager: CoreDataActions
    
    init(networkManager: Networking = NetworkManager(), coreDataManager: CoreDataActions = CoreDataManager(context: PersistenceController.shared.container.viewContext)) {
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
        getSQLitePath()
    }
    
    deinit {
        self.cancellable.removeAll()
    }
    
    func convertResultsToProducts(results: FetchedResults<ElectronicProductEntity>) {
        DispatchQueue.main.async {
            self.products = results.map { ElectronicProduct(id: Int($0.id), title: $0.title ?? "", description: $0.productDesc ?? "", brand: $0.brand ?? "", category: $0.category ?? "", thumbnail: $0.thumbnail ?? "", images: $0.images as! [String], price: Int($0.price), stock: Int($0.stock), discountPercentage: $0.discountPercentage, rating: $0.rating)}
            self.filterProducts(searchText: self.searchText)
        }
    }
    
    func loadProducts(urlString: String = Constants.apiEndpoint) {
        // if this condition meats, no api call is created
        guard total == nil || (total != nil && total! > products.count) else { return }
        guard let url = URL(string: "\(urlString)?skip=\(products.count)") else { return }

        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        networkManager.getDataFromNetworkLayer(url: url, type: ElectronicProductResponse.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case NetworkError.badUrl:
                        self.customError = NetworkError.badUrl
                    case NetworkError.parsing:
                        self.customError = NetworkError.parsing
                    case NetworkError.dataNotFound:
                        self.customError = NetworkError.dataNotFound
                    case NetworkError.serverNotFound:
                        self.customError = NetworkError.serverNotFound
                    default:
                        self.customError = NetworkError.dataNotFound
                    }
                    self.isErrorOccured = true
                    self.isLoading = false
                }
            } receiveValue: { res in
                self.products += res.products
                self.filterProducts(searchText: self.searchText)
                self.total = res.total
                self.customError = nil
                self.isLoading = false
                
                Task {
                    try await self.coreDataManager.saveDataIntoDatabase(list: self.products)
                }
            }
            .store(in: &cancellable)
    }
    
    func supressError() {
        self.isErrorOccured = false
        self.customError = nil
    }
    
    func refreshProducts() {
        DispatchQueue.main.async {
            self.products = []
            self.total = nil
            self.loadProducts()
        }
    }
    
    func filterProducts(searchText: String) {
        DispatchQueue.main.async {
            if searchText.isEmpty {
                self.filteredProducts = self.products
            } else {
                self.filteredProducts = self.products.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
        }
    }
    
    func getSQLitePath() {
        // .shared, .default, .standard - same thing
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            return
        }
        
        let sqlitePath = url.appendingPathComponent("ElectronicProducts")
        
        print(sqlitePath.absoluteString)
    }
}
