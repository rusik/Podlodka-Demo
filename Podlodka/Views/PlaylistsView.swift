import SwiftUI

struct PlaylistView: View {

  @Environment(\.redactionReasons) private var redactedReasons

  let model: Model
  struct Model: Identifiable {
    let id: Int
    let imageUrl: URL
    let name: String
    var onTap: () -> Void = {}
  }

  var body: some View {
    HStack {
      FakeAsyncImage(url: model.imageUrl)
        .scaledToFill()
        .frame(width: 60, height: 80)
        .clipped()
        .cornerRadius(12)
      Text(model.name)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, alignment: .leading)
      Circle()
        .stroke(lineWidth: 2)
        .foregroundColor(.primary.opacity(redactedReasons.contains(.placeholder) ? 0.3 : 1))
        .frame(width: 25, height: 25)
        .overlay {
          Text("▶")
        }
    }
    .frame(width: 200)
    .padding(8)
    .overlay {
      RoundedRectangle(cornerRadius: 12)
        .stroke(lineWidth: 1)
    }
    .contentShape(Rectangle())
    .onTapGesture {
      model.onTap()
    }
  }
}

struct PlaylistsView: View {

  let model: Model
  struct Model {
    let header: String
    let models: [PlaylistView.Model]
  }

  var body: some View {
    VStack(alignment: .leading) {
      Text(model.header)
        .fontWeight(.bold)
        .padding(.leading)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(model.models) {
            PlaylistView(model: $0)
          }
        }
        .padding()
      }
    }
  }
}

// MARK: - Preview

struct PlaylistsView_Previews: PreviewProvider {
  static var previews: some View {
    PlaylistView(model: .stubs[0])
      .padding()
      .previewLayout(.sizeThatFits)

    PlaylistsView(model: .stub)
      .padding(.vertical)
      .previewLayout(.sizeThatFits)
  }
}

// MARK: - Stubs

extension PlaylistsView.Model {
  static let stub = PlaylistsView.Model(
    header: "Header",
    models: .stubs
  )
  static let placeholder: PlaylistsView.Model = .stub
}

extension PlaylistView.Model: HasStubs {
  static let stubs: [PlaylistView.Model] = [
    .init(
      id: 1,
      imageUrl: "image.jpeg",
      name: "Jake"
    ),
    .init(
      id: 2,
      imageUrl: "image.jpeg",
      name: "Jake"
    ),
    .init(
      id: 3,
      imageUrl: "image.jpeg",
      name: "Jake"
    ),
    .init(
      id: 4,
      imageUrl: "image.jpeg",
      name: "Jake"
    ),
  ]
}
