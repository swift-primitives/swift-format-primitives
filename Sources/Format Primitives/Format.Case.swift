// Format.Case.swift
// Case transformation format style for strings.

extension Format {
    /// Format style for case transformation of strings.
    ///
    /// Conforms to `Format.Style<String, String>`, letting it participate in the generic
    /// `.formatted(_:)` API alongside `Format.Decimal`, `Format.Numeric`, etc.
    ///
    /// ## Example
    ///
    /// ```swift
    /// "hello world".formatted(.upper)     // "HELLO WORLD"
    /// "hello world".formatted(.lower)     // "hello world"
    /// "hello world".formatted(.title)     // "Hello World"
    /// "hello world".formatted(.sentence)  // "Hello world"
    ///
    /// // Works on Substring via StringProtocol.
    /// let sub = "hello world"[...]
    /// sub.formatted(.upper)               // "HELLO WORLD"
    ///
    /// // Custom case transformations:
    /// let alternating = Format.Case { string in
    ///     string.enumerated().map { i, c in
    ///         i.isMultiple(of: 2) ? c.uppercased() : c.lowercased()
    ///     }.joined()
    /// }
    /// "hello".formatted(alternating)      // "HeLlO"
    /// ```
    public struct Case: Sendable, Format.Style {
        public typealias Input = String
        public typealias Output = String

        @usableFromInline
        let transform: @Sendable (String) -> String

        /// Creates a case transformation from a closure.
        ///
        /// - Parameter transform: A closure that produces the transformed string.
        @inlinable
        public init(_ transform: @escaping @Sendable (String) -> String) {
            self.transform = transform
        }

        /// Applies this case transformation to a string.
        ///
        /// - Parameter value: The string to transform.
        /// - Returns: The transformed string.
        @inlinable
        public func format(_ value: String) -> String {
            transform(value)
        }

        /// Uppercase transformation (HELLO WORLD).
        public static let upper: Self = Self { $0.uppercased() }

        /// Lowercase transformation (hello world).
        public static let lower: Self = Self { $0.lowercased() }

        /// Title case transformation (Hello World).
        ///
        /// Splits on ASCII space and capitalizes the first character of each word.
        /// Does not apply Unicode word-boundary rules (UAX #29); callers needing
        /// strict Unicode semantics should use `Swift.String.capitalized`.
        public static let title: Self = Self { string in
            string.split(separator: " ")
                .map { word in
                    guard let first = word.first else { return "" }
                    return first.uppercased() + word.dropFirst().lowercased()
                }
                .joined(separator: " ")
        }

        /// Sentence case transformation (Hello world).
        ///
        /// Capitalizes only the first character of the string; lowercases the remainder.
        public static let sentence: Self = Self { string in
            guard let first = string.first else { return string }
            return first.uppercased() + string.dropFirst().lowercased()
        }
    }
}
