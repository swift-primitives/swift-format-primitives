/// Protocol for types that convert values to formatted output.
///
/// Conform to this protocol to create custom format styles that work with the `.formatted(_:)` API. Define the input and output types, then implement the `format(_:)` method with your formatting logic.
///
/// ## Example
///
/// ```swift
/// struct CurrencyStyle: Format.Style {
///     typealias Input = Double
///     typealias Output = String
///
///     @inlinable
///     func format(_ value: Double) -> String {
///         "$\(String(format: "%.2f", value))"
///     }
/// }
///
/// 42.5.formatted(CurrencyStyle())  // "$42.50"
/// ```
extension Format {
    public protocol Style<Input, Output>: Sendable {
        /// Input value type accepted by this format style
        associatedtype Input

        /// Output type produced by formatting
        associatedtype Output

        /// Converts a value to the formatted output type.
        ///
        /// - Parameter value: Value to format
        /// - Returns: Formatted output
        func format(_ value: Input) -> Output
    }
}

// MARK: - BinaryFloatingPoint + formatted()

extension BinaryFloatingPoint {
    /// Converts this value to formatted output using the specified format style.
    ///
    /// - Parameter format: Format style to apply
    /// - Returns: Formatted output
    @inlinable
    public func formatted<S>(_ format: S) -> S.Output
    where Self == S.Input, S: Format.Style {
        format.format(self)
    }

    /// Converts this value to formatted output, converting to the format's input type first.
    ///
    /// - Parameter format: Format style to apply
    /// - Returns: Formatted output
    @inlinable
    public func formatted<S>(_ format: S) -> S.Output
    where S: Format.Style, S.Input: BinaryFloatingPoint {
        format.format(S.Input(self))
    }
}

// MARK: - BinaryInteger + formatted()

extension BinaryInteger {
    /// Converts this value to formatted output using the specified format style.
    ///
    /// - Parameter format: Format style to apply
    /// - Returns: Formatted output
    @inlinable
    public func formatted<S>(_ format: S) -> S.Output
    where Self == S.Input, S: Format.Style {
        format.format(self)
    }

    /// Converts this value to formatted output, converting to the format's input type first.
    ///
    /// - Parameter format: Format style to apply
    /// - Returns: Formatted output
    @inlinable
    public func formatted<S>(_ format: S) -> S.Output
    where S: Format.Style, S.Input: BinaryInteger {
        format.format(S.Input(self))
    }
}
