import SwiftUI

/**
 Alternative protocol of List `Identifierable`, which doesn't require `id` prop that possiblity conflicts with model prop.
 
 ### Example
 public struct Feed: ListDiffable {
   public var diffId = UUID()
   public var isLiked: Bool { didSet { updateDiffId() } }
 }
 
 In List, `ForEach(feeds, id: \.diffId)`.
 */
public protocol ListDiffable {
  /// Diffable id be used for List identifierable.
  var diffId: UUID { get set}
  
  /// Updates `diffId` to trigger list cell reload.
  mutating func updateDiffId()
}

public extension ListDiffable {
  /// Updates `diffId` to trigger list reload.
  mutating func updateDiffId() {
    diffId = UUID()
  }
}
