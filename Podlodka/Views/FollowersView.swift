import SwiftUI

struct FollowersView: View {

  let model: Model
  struct Model {
    let header: String
    let followers: [UserView.Model]
  }

  var body: some View {
    VStack(alignment: .leading) {
      Text(model.header)
        .fontWeight(.bold)
        .padding(.leading)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 16) {
          ForEach(model.followers) { user in
            UserView(model: user)
          }
        }
        .padding()
      }
    }
  }
}

// MARK: - Preview

struct FollowersView_Previews: PreviewProvider {
  static var previews: some View {

    FollowersView(model: .stub)
      .padding(.vertical)
      .previewDisplayName("Light")
      .previewLayout(.sizeThatFits)

    FollowersView(model: .stub)
      .padding(.vertical)
      .preferredColorScheme(.dark)
      .previewDisplayName("Dark")
      .previewLayout(.sizeThatFits)

    FollowersView(model: .placeholder)
      .padding(.vertical)
      .previewDisplayName("Placeholders")
      .redacted(reason: .placeholder)
      .previewLayout(.sizeThatFits)
  }
}

// MARK: - Stubs and placeholders

extension FollowersView.Model {
  static let stub: FollowersView.Model = .init(
    header: "People you might like",
    followers: .stubs
  )
}

extension UserView.Model: HasStubs {
  static let stubs: [UserView.Model] = [
    .init(
      id: 1,
      imageUrl: "image.jpeg",
      username: "Jake",
      description: "Hello"
    ),
    .init(
      id: 2,
      imageUrl: "image.jpeg",
      username: "Jake",
      description: "Hello"
    ),
    .init(
      id: 3,
      imageUrl: "image.jpeg",
      username: "Jake",
      description: "Hello"
    ),
    .init(
      id: 4,
      imageUrl: "image.jpeg",
      username: "Jake",
      description: "Hello"
    ),
    .init(
      id: 5,
      imageUrl: "image.jpeg",
      username: "Jake",
      description: "Hello"
    ),
    .init(
      id: 6,
      imageUrl: "image.jpeg",
      username: "Jake",
      description: "Hello"
    )
  ]
}

extension FollowersView.Model {
  static let placeholder: FollowersView.Model = .init(
    header: "Header",
    followers: .placeholders(count: 5)
  )
}
