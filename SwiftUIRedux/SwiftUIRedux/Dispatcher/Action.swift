import SwiftUIKit
import SwiftUI
import Combine

/// Framework Action - Different from User Action.
public protocol DispatcherActionProtocol {}

public class DispatcherReloadAction: DispatcherActionProtocol {
  public init() {}
}
