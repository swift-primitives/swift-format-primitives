// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

public import Tagged_Primitives

// MARK: - Formatted Output

extension Tagged where Tag: ~Copyable, RawValue: BinaryFloatingPoint {
    /// Converts this tagged value to a string using the specified format.
    ///
    /// This allows formatting the underlying raw value while keeping the Tagged API clean.
    /// The format is applied to the raw value directly.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let x: SVGSpace.X = 100.5
    /// x.formatted(.number)               // "100.5"
    /// x.formatted(.number.precision(2))  // "100.50"
    /// ```
    ///
    /// - Parameter format: Format style to apply
    /// - Returns: Formatted string representation
    @inlinable
    public func formatted(_ format: Format.Decimal) -> String {
        format.format(rawValue)
    }
}
