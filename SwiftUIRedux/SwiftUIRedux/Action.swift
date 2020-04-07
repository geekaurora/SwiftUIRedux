import SwiftUIKit

/// Protocol that defines Redux Action - different from User Action.
public protocol ReduxActionProtocol {}

/// Redux Action that triggers UI reload.
public class ReduxReloadAction: ReduxActionProtocol {
  public init() {}
}
