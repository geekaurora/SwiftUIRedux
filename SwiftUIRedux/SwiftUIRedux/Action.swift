import SwiftUIKit

/// Protocol of Redux Action - different from User Action.
public protocol ReduxActionProtocol {}

public class ReduxReloadAction: ReduxActionProtocol {
  public init() {}
}
