//
//  View.swift
//  Cards
//
//  Created by Valid Mohammadi on 2.10.2023.
//


// MARK: - NO NEED TO THIS EXTENSION!!!

import Foundation
import SwiftUI


extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    alignment: Alignment = .leading,
                                    @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
