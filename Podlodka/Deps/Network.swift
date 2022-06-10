import Foundation

final class Network {
  func loadCommunity(completion: (CommunityScreenJson) -> Void) {
    completion(.stub)
  }
}

final class RealNetwork {
  func loadCommunity(completion: @escaping (CommunityScreenJson) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(.stub)
    }
  }
  func followUser(id: Int) {
    print("Follow user \(id)")
  }
}

// MARK: - JSONs

struct PlaylistJson {
  let id: Int
  let imageUrl: String
  let name: String
}

struct UserJson {
  let id: Int
  let imageUrl: String
  let username: String
  let description: String
}

struct PostJson {
  let id: Int
  let userImageUrl: String
  let username: String
  let imageUrl: String
}

struct CommunityScreenJson {
  let playlistsHeader: String
  let playlists: [PlaylistJson]

  let followersHeader: String
  let followers: [UserJson]

  let postsHeader: String
  let posts: [PostJson]
}

// MARK: - Stubs

extension CommunityScreenJson {
  static let stub = CommunityScreenJson(
    playlistsHeader: "Playlists",
    playlists: .stubs,
    followersHeader: "People you might like",
    followers: .stubs,
    postsHeader: "Top posts",
    posts: .stubs
  )
}

extension UserJson: HasStubs {
  static let stubs: [UserJson] = [
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

extension PlaylistJson: HasStubs {
  static let stubs: [PlaylistJson] = [
    .init(id: 1, imageUrl: "image.jpeg", name: "Jake"),
    .init(id: 2, imageUrl: "image.jpeg", name: "Jake"),
    .init(id: 3, imageUrl: "image.jpeg", name: "Jake"),
    .init(id: 4, imageUrl: "image.jpeg", name: "Jake"),
  ]
}

extension PostJson: HasStubs {
  static let stubs: [PostJson] = [
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
