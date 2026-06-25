// BinaryFloatingPoint+Format.Decimal.swift
// Stdlib integration: BinaryFloatingPoint.formatted(_:Format.Decimal).

public import Format_Decimal_Primitives

// MARK: - BinaryFloatingPoint Extension

extension Swift.BinaryFloatingPoint {
    /// Converts this floating-point value to a string using the specified format.
    ///
    /// ## Example
    ///
    /// ```swift
    /// 0.75.formatted(.percent)                 // "75%"
    /// Float(0.5).formatted(.percent)           // "50%"
    /// 0.755.formatted(.percent.precision(2))   // "75.50%"
    /// ```
    ///
    /// - Parameter format: Format style to apply
    /// - Returns: Formatted string representation
    @inlinable
    public func formatted(_ format: Format.Decimal) -> String {
        format.format(self)
    }
}
