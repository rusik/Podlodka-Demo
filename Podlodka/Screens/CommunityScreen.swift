import SwiftUI

protocol CommunityScreenViewModelProtocol: ObservableObject {
  var model: CommunityScreen<Self>.Model? { get }
  func load()
}

struct CommunityScreen<ViewModel: CommunityScreenViewModelProtocol>: View {

  @ObservedObject var viewModel: ViewModel

  struct Model {
    let playlists: PlaylistsView.Model
    let followers: FollowersView.Model
    let posts: PostsView.Model
  }

  var body: some View {
    ScrollView {
      VStack {
        PlaylistsView(model: viewModel.model?.playlists ?? .placeholder)
        FollowersView(model: viewModel.model?.followers ?? .placeholder)
        PostsView(model: viewModel.model?.posts ?? .placeholder)
      }
    }
    .redacted(reason: viewModel.model == nil ? .placeholder : [])
    .onAppear {
      viewModel.load()
    }
  }
}

struct CommunityView_Previews: PreviewProvider {
  static var previews: some View {
    
    CommunityScreen(viewModel: StubCommunityScreenViewModel())

    CommunityScreen(viewModel: EmptyCommunityScreenViewModel())
      .previewDisplayName("Loading")
  }
}

// MARK: - Preview

extension CommunityScreen.Model {
  static var stub: CommunityScreen.Model {
    .init(
      playlists: .stub,
      followers: .stub,
      posts: .stub
    )
  }
}

// MARK: - Stubs and placeholders

final class StubCommunityScreenViewModel: CommunityScreenViewModelProtocol {
  @Published var model: CommunityScreen<StubCommunityScreenViewModel>.Model? = .stub
  func load() {}
}

final class EmptyCommunityScreenViewModel: CommunityScreenViewModelProtocol {
  @Published var model: CommunityScreen<EmptyCommunityScreenViewModel>.Model?
  func load() {}
}
