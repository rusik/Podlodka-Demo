import Foundation

protocol HasPlaceholder: Identifiable {
    static func placeholder(id: Self.ID) -> Self
}

extension Array where Element: HasPlaceholder, Element.ID == Int {
    static func placeholders(count: Int) -> [Element] {
        (0..<count).map {
            Element.placeholder(id: $0)
        }
    }
}

extension Array where Element: HasPlaceholder, Element.ID == String {
    static func placeholders(count: Int) -> [Element] {
        (0..<count).map {
            Element.placeholder(id: "\($0)")
        }
    }
}

extension Array where Element: HasPlaceholder {
    static func placeholders(ids: [Element.ID]) -> [Element] {
        ids.map {
            Element.placeholder(id: $0)
        }
    }
}
