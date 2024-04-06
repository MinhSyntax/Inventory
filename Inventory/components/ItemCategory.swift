

import Foundation


enum ItemCategory: String, CaseIterable, Identifiable {
    case books = "Bücher"
    case electronics = "Elektronik"
    case clothing = "Kleidung"

    var id: String { self.rawValue }
}

