import SwiftUI

@main
struct PodlodkaApp: App {
  var body: some Scene {
    WindowGroup {
      CommunityScreen(viewModel: CommunityScreenViewModel())
    }
  }
}
