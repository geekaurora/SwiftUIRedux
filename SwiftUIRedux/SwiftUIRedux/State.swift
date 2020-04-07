import SwiftUIKit

/// Protocol that defines Redux State.
public protocol ReduxStateProtocol {
  /// Reduce function that generates new State of self with the input `action`.
  /// i.e. (oldState, action) => newState
  ///
  /// P.S. State can update parts of deep copy of itself or filter `action` and choose whether to respond.
  ///
  /// - Note:
  /// Recommendation is to define conformance as struct and return deep copy of self,  e.g. var newSelf = self,
  /// to avoid duplicate mutations on the same instance if `self` is reference type.
  /// If you have to use reference type, workaround is to return deep copy of `self`.
  ///
  /// For example, if FeedList/FeedDetails shares the same `Feed` class reference, LikeFeed action
  /// in FeedDetails will possibly mutate `Feed` instance twice by `reduce(action:)` function
  /// in both FeedDetailsState and FeedListState.
  ///
  /// - Parameter action: The action that dispatchs to the current state.
  /// - Returns: The new State of self after reducing `action`.
  @discardableResult
  func reduce(action: ReduxActionProtocol) -> Self
}
