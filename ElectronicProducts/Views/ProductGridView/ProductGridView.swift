//
//  ProductGridView.swift
//  ElectronicProducts
//
//  Created by Suguru Tokuda on 11/21/23.
//

import SwiftUI
import CoreData

struct ProductGridView: View {
    @StateObject var vm: ProductViewModel = ProductViewModel()
    let columns = Array(repeating: GridItem(), count: 2)
    
    @FetchRequest(entity: ElectronicProductEntity.entity(), sortDescriptors: [])
    var results: FetchedResults<ElectronicProductEntity>
    var request: NSFetchRequest<ElectronicProductEntity> = ElectronicProductEntity.fetchRequest()

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach(vm.filteredProducts.indices, id: \.self) { i in
                            let product = vm.filteredProducts[i]
                            
                            ProductGridCellView(product: product, width: geometry.size.width / CGFloat(columns.count))
                                .padding(5)
                                .onAppear {
                                    if i == vm.products.count - 1 {
                                        vm.loadProducts()
                                    }
                                }
                        }
                    }
                }
                .searchable(text: $vm.searchText)
                .onChange(of: vm.searchText) { _, newVal in
                    vm.filterProducts(searchText: newVal)
                }
            }
        }
        .alert(isPresented: $vm.isErrorOccured, error: vm.customError, actions: {
            Button(action: {
                vm.supressError()
            }, label: {
                Text("OK")
            })
        })
        .refreshable {
            vm.refreshProducts()
        }
        .onAppear() {
            vm.convertResultsToProducts(results: results)
        }
        .task {
            vm.loadProducts()
        }
    }
}

#Preview {
    ProductGridView()
}
