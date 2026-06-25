// BinaryFloatingPoint+Formatter.swift
// Stdlib integration: generic BinaryFloatingPoint.formatted(_:) routing through Formatter.Protocol.
//
// The formatting *capability* (the `Formatter.Protocol`) lives in
// swift-formatter-primitives. This file holds the *consumer entry point* —
// extensions that route stdlib BinaryFloatingPoint values through any
// `Formatter.Protocol`.
//
// See `swift-institute/Research/transformation-domain-architecture.md` v3.3.0
// for the Split B decision separating capability from vocabulary.

public import Formatter_Primitives

// MARK: - BinaryFloatingPoint + formatted()

extension BinaryFloatingPoint {
    /// Converts this value to formatted output using the specified formatter.
    ///
    /// - Parameter format: Formatter to apply.
    /// - Returns: Formatted output.
    @inlinable
    public func formatted<F>(_ format: F) -> F.Output
    where Self == F.Input, F: Formatter.`Protocol`, F.Failure == Never {
        format.format(self)
    }

    /// Converts this value to formatted output, converting to the formatter's input type first.
    ///
    /// - Parameter format: Formatter to apply.
    /// - Returns: Formatted output.
    @inlinable
    public func formatted<F>(_ format: F) -> F.Output
    where F: Formatter.`Protocol`, F.Input: Swift.BinaryFloatingPoint, F.Failure == Never {
        format.format(F.Input(self))
    }
}
