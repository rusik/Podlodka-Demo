import SwiftUI

struct FollowButton: View {
  var body: some View {
    Circle()
      .frame(width: 30, height: 30)
      .overlay {
        Text("+")
          .font(.system(size: 25, weight: .medium))
          .foregroundColor(Color.primary)
          .colorInvert()
          .offset(y: -1)
      }
  }
}

// MARK: - Preview

struct FollowButton_Previews: PreviewProvider {
    static var previews: some View {
        FollowButton()
    }
}
