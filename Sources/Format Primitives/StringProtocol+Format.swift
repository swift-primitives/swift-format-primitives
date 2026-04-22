// StringProtocol+Format.swift
// Consumer entry points for case formatting on String / Substring.

// MARK: - StringProtocol.formatted

extension StringProtocol {
    /// Converts this string to formatted output using the specified Format.Case style.
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

    /// Converts this string to formatted output using any Format.Style whose Input is `String`.
    ///
    /// Generic counterpart that lets user-defined `Format.Style<String, _>` conformers
    /// participate in the same call-site API.
    ///
    /// - Parameter format: A Format.Style whose input type is `String`.
    /// - Returns: The format style's output.
    @inlinable
    public func formatted<S>(_ format: S) -> S.Output
    where S: Format.Style, S.Input == String {
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
