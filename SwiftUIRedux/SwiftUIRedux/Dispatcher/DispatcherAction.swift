import SwiftUIKit
import SwiftUI
import Combine

/// Framework Action - Different from User Action.
public protocol DispatcherAction {}

public class DispatcherReloadAction: DispatcherAction {
  public init() {}
}
