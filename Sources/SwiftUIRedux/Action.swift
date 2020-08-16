import Foundation

// MARK: - ReduxAction

/// Protocol that defines Redux Action.
public protocol ReduxActionProtocol {
  /// The context be used to differentiate the source of the action.
  /// If multiple States share the same RootStore, you can pass`context` to the corresponding State,
  /// so action can be handled within the domain.
  var context: ReduxActionContext? { get }
}

/// Default implementation of `ReduxActionProtocol`.
public extension ReduxActionProtocol {
  /// The context be used to differentiate the source of the action.
  /// If multiple States share the same RootStore, you can pass`context` to the corresponding State,
  /// so action can be handled within the domain.
    var context: ReduxActionContext? { return nil }
}

// MARK: - ReduxAsyncActionProtocol

/// Protocol that defines async Redux Action.
public protocol ReduxAsyncActionProtocol: ReduxActionProtocol {}

/// Async Redux Action that can be excuted automatically by Thunk Middleware.
public struct ReduxAsyncBlockAction: ReduxAsyncActionProtocol {
  public let type: String
  public let executionBlock: () -> Void
  public let context: ReduxActionContext?
  public init(type: String,  executionBlock: @escaping () -> Void, context: ReduxActionContext? = nil) {
    self.type = type
    self.executionBlock = executionBlock
    self.context = context
  }
}

// MARK: - ReduxActionContext

/// The context be used to differentiate the source of the action.
public protocol ReduxActionContext: class {}
