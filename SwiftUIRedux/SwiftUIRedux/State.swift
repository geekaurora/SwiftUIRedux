import SwiftUIKit

/// Protocol of Redux State.
public protocol ReduxStateProtocol {
  /// Reacts to the `action`. Note that subscribers can filter action and choose whether to respond.
  func reduce(action: ReduxActionProtocol)
}