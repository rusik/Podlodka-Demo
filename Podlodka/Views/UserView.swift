import SwiftUI

struct UserView: View {

  @Environment(\.redactionReasons) private var redactedReasons

  let model: Model
  struct Model: Identifiable {
    let id: Int
    let imageUrl: URL
    let username: String
    let description: String

    enum Action {
      case tap
      case follow
    }
    var action: (Action) -> Void = { _ in }
  }

  var body: some View {
    VStack {
      FakeAsyncImage(url: model.imageUrl)
        .scaledToFill()
        .frame(width: 80, height: 80)
        .clipShape(Circle())
        .padding(.bottom)
        .overlay(alignment: .bottom) {
          if !redactedReasons.contains(.placeholder) {
            FollowButton().onTapGesture {
              self.model.action(.follow)
            }
          }
        }
      Text(model.username)
        .foregroundColor(.gray)
      Text(model.description)
        .font(.body)
    }
    .onTapGesture {
      self.model.action(.tap)
    }
  }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      UserView(model: .stub)
      UserView(model: .placeholder(id: 1))
        .redacted(reason: .placeholder)
    }
    .padding()
    .previewLayout(.sizeThatFits)
  }
}

// MARK: - Stubs and placeholders

extension UserView.Model {
  static let stub = UserView.Model(
    id: 1,
    imageUrl: "image.jpeg",
    username: "Jake",
    description: "I love SwiftUI"
  )
}

extension UserView.Model: HasPlaceholder {
  static func placeholder(id: Int) -> UserView.Model {
    .init(
      id: id,
      imageUrl: "image.jpeg",
      username: "aasasdasdda",
      description: "asdasd"
    )
  }
}
