// Format.Case.Insensitive.swift
// Case-insensitive string wrapper for hashing and equality.

extension Format.Case {
    /// A case-insensitive string wrapper for use as dictionary keys and in comparisons.
    ///
    /// Provides case-insensitive hashing and equality checking, enabling case-insensitive
    /// lookups in dictionaries and sets. Use this when you need to treat strings like
    /// `"Content-Type"` and `"content-type"` as equal.
    ///
    /// Conceptually distinct from `Format.Case` the transformation style: this wrapper
    /// folds case for comparison purposes, it does not transform strings for output.
    /// Co-located under `Format.Case` because case-related discovery is a single
    /// namespace.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var headers: [Format.Case.Insensitive: String] = [:]
    /// headers["Content-Type".caseInsensitive] = "text/html"
    /// headers["content-type".caseInsensitive]  // "text/html"
    /// ```
    public struct Insensitive: Hashable, Comparable, Sendable {
        public let value: String

        /// Creates a case-insensitive wrapper over the given string.
        @inlinable
        public init(_ value: some StringProtocol) {
            self.value = String(value)
        }

        @inlinable
        public func hash(into hasher: inout Hasher) {
            value.lowercased().hash(into: &hasher)
        }

        @inlinable
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.value.lowercased() == rhs.value.lowercased()
        }

        @inlinable
        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.value.lowercased() < rhs.value.lowercased()
        }
    }
}
