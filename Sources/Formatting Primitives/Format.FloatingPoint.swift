// Format.Decimal.swift
// Formatting for Decimal types.

import Standard_Library_Extensions

extension Format {
    /// Format style for converting floating-point values to strings with optional percentage and precision control.
    ///
    /// Use this format to display decimal numbers or percentages. Works with `BinaryFloatingPoint` types including `Double` and `Float`. Chain methods to configure rounding and decimal precision.
    ///
    /// When precision is specified, trailing zeros are preserved to match the requested precision.
    ///
    /// Does not conform to `Format.Style` because it works across multiple input types within the BinaryFloatingPoint category, not a single Input type.
    ///
    /// ## Example
    ///
    /// ```swift
    /// 0.75.formatted(.percent)                   // "75%"
    /// 0.755.formatted(.percent.precision(2))     // "75.50%"
    /// 3.14159.formatted(.number.precision(2))    // "3.14"
    /// 10.0.formatted(.number.precision(1))       // "10.0" (preserves trailing zero)
    /// ```
    public struct Decimal: Sendable {
        @usableFromInline
        let isPercent: Bool
        public let shouldRound: Bool
        public let precisionDigits: Int?

        @usableFromInline
        init(isPercent: Bool, shouldRound: Bool, precisionDigits: Int?) {
            self.isPercent = isPercent
            self.shouldRound = shouldRound
            self.precisionDigits = precisionDigits
        }

        public init(shouldRound: Bool = false, precisionDigits: Int? = nil) {
            self.isPercent = false
            self.shouldRound = shouldRound
            self.precisionDigits = precisionDigits
        }
    }
}

// MARK: - Format.Decimal Format Method

extension Format.Decimal {
    /// Converts the floating-point value to a string using this format's configuration.
    ///
    /// - Parameters:
    ///   - value: Floating-point value to format
    ///   - isPercent: Whether to format as percentage
    ///   - shouldRound: Whether to round to whole number
    ///   - precisionDigits: Optional number of decimal places
    /// - Returns: Formatted string representation
    public static func format<T: Swift.BinaryFloatingPoint>(
        _ value: T,
        isPercent: Bool,
        shouldRound: Bool,
        precisionDigits: Int?
    ) -> String {
        var workingValue = value

        if isPercent {
            workingValue *= T(100)
        }

        if shouldRound {
            workingValue = workingValue.rounded()
        }

        let result: String
        if let precision = precisionDigits {
            result = formatWithPrecision(workingValue, precision: precision)
        } else {
            // Auto mode: strip trailing ".0" for whole numbers
            var autoResult = "\(workingValue)"
            if autoResult.hasSuffix(".0") {
                autoResult.removeLast(2)
            }
            result = autoResult
        }

        return isPercent ? result + "%" : result
    }

    /// Formats a value with specified decimal precision, padding with zeros if needed.
    @usableFromInline
    static func formatWithPrecision<T: Swift.BinaryFloatingPoint>(_ value: T, precision: Int) -> String {
        guard precision > 0 else {
            return "\(Int(value.rounded()))"
        }

        let isNegative = value < 0
        let absValue = abs(value)

        var multiplier: T = 1
        for _ in 0..<precision {
            multiplier *= 10
        }

        let rounded = (absValue * multiplier).rounded() / multiplier
        let intPart = Int(rounded)
        let fracPart = rounded - T(intPart)

        let sign = isNegative ? "-" : ""

        if fracPart == 0 {
            return sign + "\(intPart)." + String(repeating: "0", count: precision)
        }

        // Calculate fractional digits
        var fracValue = fracPart
        var fracString = ""
        for _ in 0..<precision {
            fracValue *= 10
            let digit = Int(fracValue) % 10
            fracString += "\(digit)"
        }

        return sign + "\(intPart).\(fracString)"
    }

    /// Converts the floating-point value to a string using this format's configuration.
    ///
    /// - Parameter value: Floating-point value to format
    /// - Returns: Formatted string representation
    @inlinable
    public func format<T: Swift.BinaryFloatingPoint>(_ value: T) -> String {
        Self.format(
            value,
            isPercent: isPercent,
            shouldRound: shouldRound,
            precisionDigits: precisionDigits
        )
    }
}

// MARK: - Format.Decimal Static Properties

extension Format.Decimal {
    /// Standard decimal format for floating-point values
    ///
    /// ## Example
    ///
    /// ```swift
    /// 3.14159.formatted(.number)  // "3.14159"
    /// ```
    @inlinable
    public static var number: Self {
        .init(isPercent: false, shouldRound: false, precisionDigits: nil)
    }

    /// Percentage format that multiplies by 100 and appends "%" symbol
    @inlinable
    public static var percent: Self {
        .init(isPercent: true, shouldRound: false, precisionDigits: nil)
    }
}

// MARK: - Format.Decimal Chaining Methods

extension Format.Decimal {
    /// Returns a format that rounds to the nearest whole number.
    ///
    /// ## Example
    ///
    /// ```swift
    /// 0.755.formatted(.percent.rounded())  // "76%"
    /// ```
    @inlinable
    public func rounded() -> Self {
        .init(isPercent: isPercent, shouldRound: true, precisionDigits: precisionDigits)
    }

    /// Returns a format that displays the specified number of decimal places.
    ///
    /// ## Example
    ///
    /// ```swift
    /// 0.12345.formatted(.percent.precision(2))  // "12.35%"
    /// ```
    @inlinable
    public func precision(_ digits: Int) -> Self {
        .init(isPercent: isPercent, shouldRound: shouldRound, precisionDigits: digits)
    }
}

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
