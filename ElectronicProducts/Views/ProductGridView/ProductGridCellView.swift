//
//  ProductGridCellView.swift
//  ElectronicProducts
//
//  Created by Suguru Tokuda on 11/21/23.
//

import SwiftUI

struct ProductGridCellView: View {
    var product: ElectronicProduct
    var width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                AsyncImage(url: URL(string: product.thumbnail)!) { img in
                    img
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width)
                        .frame(height: width, alignment: .top)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ProgressView()
                        .frame(width: width, height: width)
                }
            }
            VStack(alignment: .leading) {
                Group {
                    Text(product.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    HStack {
                        Text("$\(product.priceAfterDiscount.rounded(), specifier: "%.2f")")
                        Text("$\(product.price)")
                            .strikethrough()
                    }
                    Text(product.description)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .lineLimit(2)
                }
            }
            .padding(.horizontal, 10)
            .font(.caption)
        }
    }
}

#Preview {
    ProductGridCellView(product: PreviewData.products[0], width: 200)
}
