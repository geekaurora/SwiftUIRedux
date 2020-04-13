import SwiftUI

/// Build `AnyView` with `View`.
public func anyView<V: View>(block: () -> V) -> AnyView {
  let view = block()
  return AnyView(view)
}
