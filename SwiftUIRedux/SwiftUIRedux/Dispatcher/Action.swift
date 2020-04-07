import SwiftUIKit

/// Protocol of Redux Action - Different from User Action.
public protocol DispatcherActionProtocol {}

public class DispatcherReloadAction: DispatcherActionProtocol {
  public init() {}
}
