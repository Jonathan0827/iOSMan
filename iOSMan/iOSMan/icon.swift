import SwiftUI

struct appIcon: View {
    let size: CGFloat
    var body: some View {
        ZStack {
            Image(systemName: "iphone.gen3")
                .font(.system(size: size))
            Image(systemName: "hammer.fill")
                .font(.system(size: size/4))
        }
    }
}
