import SwiftUIKit
import SwiftUI
import Combine

/// Framework Action - Different from User Action.
public protocol ElementDispatcherAction {}

public class ElementDispatcherReloadAction: ElementDispatcherAction {
  public init() {}
}
