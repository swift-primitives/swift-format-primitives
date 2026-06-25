# Format Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Value-to-string formatting primitives for Swift — a `Format` namespace of decimal, percentage, and string-case styles, surfaced as `.formatted(_:)` on the standard-library numeric and string types, with zero platform dependencies.

---

## Quick Start

`Format` is a vocabulary of format *styles* — small value types that describe how to render a value as a `String`. Each style is reached through `.formatted(_:)`, an entry point added to `BinaryInteger`, `BinaryFloatingPoint`, and `StringProtocol`, so the call site reads the same whatever you are formatting. No `Foundation`, no `NumberFormatter`, no locale machinery — just the styles this package defines.

```swift
import Format_Primitives

// Decimal and percentage styles for floating-point values.
3.14159.formatted(.number)               // "3.14159"
0.75.formatted(.percent)                 // "75%"
0.755.formatted(.percent.precision(2))   // "75.50%"
3.14159.formatted(.number.precision(2))  // "3.14"
```

`Format.Decimal` is the floating-point style. It composes by chaining: `.precision(_:)` fixes the number of fractional digits (preserving trailing zeros), and `.rounded()` rounds to a whole number before formatting. `.number` renders the value as-is; `.percent` multiplies by 100 and appends a `"%"`.

Strings format through `Format.Case`, a transformation style that participates in the same `.formatted(_:)` API and works on `String` and `Substring` alike:

```swift
import Format_Primitives

"hello world".formatted(.upper)      // "HELLO WORLD"
"hello world".formatted(.title)      // "Hello World"
"HELLO WORLD".formatted(.sentence)   // "Hello world"

// Substrings work too, via StringProtocol.
let sub = "hello world"[...]
sub.formatted(.title)                // "Hello World"

// Custom transformations are just a closure.
let alternating = Format.Case { string in
    string.enumerated().map { index, character in
        index.isMultiple(of: 2) ? character.uppercased() : character.lowercased()
    }.joined()
}
"hello".formatted(alternating)       // "HeLlO"
```

A companion `Format.Case.Insensitive` folds case for hashing and equality rather than for output, making it a drop-in case-insensitive dictionary key:

```swift
import Format_Primitives

var headers: [Format.Case.Insensitive: String] = [:]
headers["Content-Type".caseInsensitive] = "text/html"
headers["content-type".caseInsensitive]  // "text/html"
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-format-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Format Primitives", package: "swift-format-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

The umbrella `Format Primitives` re-exports every module below; import a single sub-target when you want only one slice. The standard-library `.formatted(_:)` entry points live in the integration target.

| Product | Target | Purpose |
|---------|--------|---------|
| `Format Primitives` | `Sources/Format Primitives/` | Umbrella that re-exports every module below. |
| `Format Primitive` | `Sources/Format Primitive/` | The root `Format` namespace enum. |
| `Format Case Primitives` | `Sources/Format Case Primitives/` | `Format.Case` — case transformation (`.upper`, `.lower`, `.title`, `.sentence`, or a custom closure) — and `Format.Case.Insensitive`, a case-folding wrapper for dictionary keys and comparisons. |
| `Format Decimal Primitives` | `Sources/Format Decimal Primitives/` | `Format.Decimal` — `.number` and `.percent` styles for `BinaryFloatingPoint`, with `.rounded()` and `.precision(_:)` chaining. |
| `Format Numeric Primitives` | `Sources/Format Numeric Primitives/` | `Format.Numeric` configuration vocabulary: `.Notation`, `.Separator`, and `.Sign`. |
| `Format Primitives Standard Library Integration` | `Sources/Format Primitives Standard Library Integration/` | `.formatted(_:)` on `BinaryInteger`, `BinaryFloatingPoint`, `StringProtocol`, and `Tagged`, plus `String.caseInsensitive`. |
| `Format Primitives Test Support` | `Tests/Support/` | Re-exports the umbrella for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
