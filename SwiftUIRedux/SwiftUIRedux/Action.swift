import SwiftUIKit

/// Protocol that defines Redux Action - different from User Action.
public protocol ReduxActionProtocol {}

/// Protocol that defines Redux Command - asynchronous Action.
public protocol ReduxCommandProtocol {}

/// Redux Action that triggers UI reload.
public class ReduxReloadAction: ReduxActionProtocol {
  public init() {}
}
