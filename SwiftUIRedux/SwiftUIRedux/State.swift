import SwiftUIKit

/// Protocol of Redux State.
public protocol ReduxStateProtocol {
  /// Reacts to the `action`. Note that subscribers can filter action and choose whether to respond.
  ///
  /// - Note:
  /// Recommendation is to define conformance as struct and return deep copy of self,  e.g. var newSelf = self,
  /// to avoid duplicate mutations on the same model if with reference type.
  ///
  /// For example, if FeedList/FeedDetails shares the same `Feed` refence, LikeFeed action
  /// in FeedDetails will possibly mutate `Feed` instance twice by both `reduce(action:)`
  /// in FeedDetailsState and FeedListState.
  @discardableResult
  func reduce(action: ReduxActionProtocol) -> Self
}
