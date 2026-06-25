// StringProtocol+Format.swift
// Consumer entry points for case formatting on String / Substring.

public import Formatter_Primitives

// MARK: - StringProtocol.formatted

extension StringProtocol {
    /// Converts this string to formatted output using the specified Format.Case formatter.
    ///
    /// ## Example
    ///
    /// ```swift
    /// "hello world".formatted(.upper)     // "HELLO WORLD"
    /// "hello world".formatted(.title)     // "Hello World"
    /// let sub = "hello world"[...]; sub.formatted(.upper)  // "HELLO WORLD"
    /// ```
    ///
    /// - Parameter format: Case transformation to apply.
    /// - Returns: The transformed string.
    @inlinable
    public func formatted(_ format: Format.Case) -> String {
        format.format(String(self))
    }

    /// Converts this string to formatted output using a `Formatter.Protocol` whose Input is `String`.
    ///
    /// Generic counterpart that lets user-defined `Formatter.Protocol<String, _, Never>`
    /// conformers participate in the same call-site API.
    ///
    /// - Parameter format: A Formatter.Protocol whose input type is `String`.
    /// - Returns: The formatter's output.
    @inlinable
    public func formatted<F>(_ format: F) -> F.Output
    where F: Formatter.`Protocol`, F.Input == String, F.Failure == Never {
        format.format(String(self))
    }
}

// MARK: - String.caseInsensitive

extension String {
    /// A case-insensitive wrapper for the string, suitable as a dictionary key.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var headers: [Format.Case.Insensitive: String] = [:]
    /// headers["Content-Type".caseInsensitive] = "text/html"
    /// headers["content-type".caseInsensitive]  // "text/html"
    /// ```
    @inlinable
    public var caseInsensitive: Format.Case.Insensitive {
        Format.Case.Insensitive(self)
    }
}
