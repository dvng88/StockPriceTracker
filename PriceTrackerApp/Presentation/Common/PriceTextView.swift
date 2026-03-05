//
//  PriceTextView.swift
//  PriceTrackerApp
//
//  Created by Devang Shah on 05/03/2026.
//

import SwiftUI

struct PriceTextView: View {
    let price: Double
    var body: some View {
        Text(price, format: .currency(code: "USD").precision(.fractionLength(2)))
    }
}

#Preview {
    PriceTextView(
        price: 30.3333
    )
}
