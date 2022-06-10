import Foundation

final class CommunityScreenViewModel: CommunityScreenViewModelProtocol {

    let network = RealNetwork()
    let router = Router()

    @Published var model: CommunityScreen<CommunityScreenViewModel>.Model? = nil
    func load() {
        network.loadCommunity { json in
            self.model = UserDataTransformer(
                onUserTap: { userJson in
                    self.router.openUserScreen(id: userJson.id)
                },
                onUserFollow: { userJson in
                    self.network.followUser(id: userJson.id)
                },
                onPlaylistTap: { playlistJson in
                    self.router.openPlaylistScreen(id: playlistJson.id)
                }
            )
            .transform(json: json)
        }
    }
}

// MARK: - Data Transformer

struct UserDataTransformer {
    let onUserTap: (UserJson) -> Void
    let onUserFollow: (UserJson) -> Void
    let onPlaylistTap: (PlaylistJson) -> Void

    func transform<VM>(json: CommunityScreenJson) -> CommunityScreen<VM>.Model {
        return CommunityScreen.Model(
            playlists: PlaylistsView.Model(
                header: json.playlistsHeader,
                models: json.playlists.map { playlistJson in
                    PlaylistView.Model(
                        id: playlistJson.id,
                        imageUrl: playlistJson.imageUrl.url,
                        name: playlistJson.name,
                        onTap: {
                            self.onPlaylistTap(playlistJson)
                        }
                    )
                }),
            followers: FollowersView.Model(
                header: json.followersHeader,
                followers: json.followers.map { userJson in
                    UserView.Model(
                        id: userJson.id,
                        imageUrl: userJson.imageUrl.url,
                        username: userJson.username,
                        description: userJson.description,
                        action: { action in
                            switch action {
                            case .tap:
                                self.onUserTap(userJson)
                            case .follow:
                                self.onUserFollow(userJson)
                            }
                        }
                    )
                }
            ),
            posts: PostsView.Model(
                header: json.postsHeader,
                posts: json.posts.map { postJson in
                    PostView.Model(
                        id: postJson.id,
                        userImageUrl: postJson.imageUrl.url,
                        username: postJson.username,
                        imageUrl: postJson.imageUrl.url
                    )
                }
            )
        )
    }
}
