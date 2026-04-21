/// Namespace containing formatting types and protocols.
///
/// Use this namespace to access format styles for converting values to strings. Provides built-in support for integers (decimal, binary, octal) and floating-point numbers (decimal, percentage). Additional format styles can be created by conforming to `Format.Style`.
///
/// ## Example
///
/// ```swift
/// 42.formatted(.binary)            // "0b101010"
/// 0.75.formatted(.percent)         // "75%"
/// 3.14159.formatted(.number)       // "3.14159"
/// ```
public enum Format {}
