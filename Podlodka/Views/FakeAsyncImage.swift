import SwiftUI

struct FakeAsyncImage: View {
  let url: URL
  var body: some View {
    Image(url.absoluteString)
      .resizable()
      .background(Color.gray.opacity(0.2))
  }
}

// MARK: - Preview

struct FakeAsyncImage_Previews: PreviewProvider {
  static var previews: some View {
    FakeAsyncImage(url: "asds")
      .clipShape(Circle())
      .frame(width: 100, height: 100)
      .border(Color.gray, width: 1)
  }
}

// MARK: - Extensions

extension Image {
  init(url: URL) {
    self.init(url.absoluteString)
  }
}

extension String {
  var url: URL {
    URL(string: self)!
  }
}

extension URL: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.init(string: value)!
  }
}
