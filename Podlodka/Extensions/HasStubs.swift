import Foundation

protocol HasStubs {
  static var stubs: [Self] { get }
}

extension Array where Element: HasStubs {
  static var stubs: [Element] { Element.stubs }
}
