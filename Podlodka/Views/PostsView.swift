import SwiftUI

struct PostView: View {
  let model: Model
  struct Model: Identifiable {
    let id: Int
    let userImageUrl: URL
    let username: String
    let imageUrl: URL
  }
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        FakeAsyncImage(url: model.userImageUrl)
          .scaledToFill()
          .frame(width: 20, height: 20)
          .clipShape(Circle())
        Text(model.username)
          .lineLimit(1)
          .minimumScaleFactor(0.2)
        Spacer()
        Text("➕ Follow")
          .fontWeight(.bold)
          .lineLimit(1)
          .minimumScaleFactor(0.2)
      }
      PostViewImage(url: model.imageUrl)
        .aspectRatio(2/3, contentMode: .fit)
    }
  }
}

struct PostsView: View {
  let model: Model
  struct Model {
    let header: String
    let posts: [PostView.Model]
  }
  var body: some View {
    VStack(alignment: .leading) {
      Text(model.header)
        .fontWeight(.bold)
        .padding(.bottom)
      LazyVGrid(columns: Array(repeating: GridItem(.flexible(), alignment: .top), count: 2), spacing: 16) {
        ForEach(model.posts) { post in
          PostView(model: post)
        }
      }
    }
    .padding()
  }
}

struct PostViewImage: View {
  let url: URL
  var body: some View {
    GeometryReader { proxy in
      FakeAsyncImage(url: url)
        .scaledToFill()
        .frame(width: proxy.frame(in: .local).width,
               height: proxy.frame(in: .local).height
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
  }
}

// MARK: - Preview

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostView(model: .stubs[0])
      .frame(width: 250)
      .padding()
      .previewLayout(.sizeThatFits)

    PostsView(model: .stub)
      .padding()
      .previewLayout(.sizeThatFits)
  }
}

// MARK: - Stubs and placeholders

extension PostsView.Model {
  static let stub: PostsView.Model = .init(
    header: "Header",
    posts: PostView.Model.stubs
  )
  static let placeholder: PostsView.Model = .stub
}

extension PostView.Model: HasStubs {
  static let stubs: [PostView.Model] = [
    .init(
      id: 1,
      userImageUrl: "image.jpeg",
      username: "Jake",
      imageUrl: "image.jpeg"
    ),
    .init(
      id: 2,
      userImageUrl: "image.jpeg",
      username: "Jake",
      imageUrl: "image.jpeg"
    ),
    .init(
      id: 3,
      userImageUrl: "image.jpeg",
      username: "Jake",
      imageUrl: "image.jpeg"
    ),
    .init(
      id: 4,
      userImageUrl: "image.jpeg",
      username: "Jake",
      imageUrl: "image.jpeg"
    )
  ]
}
