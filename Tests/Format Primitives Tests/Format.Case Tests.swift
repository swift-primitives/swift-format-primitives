import Formatter_Primitives
import Testing

@testable import Format_Primitives

// MARK: - Format.Case — Presets

@Suite
struct `Format.Case - Upper` {

    @Test
    func `Lowercase to uppercase`() {
        #expect("hello world".formatted(.upper) == "HELLO WORLD")
    }

    @Test
    func `Already uppercase is unchanged`() {
        #expect("HELLO".formatted(.upper) == "HELLO")
    }

    @Test
    func `Empty string returns empty`() {
        #expect("".formatted(.upper).isEmpty)
    }

    @Test
    func `Mixed case lifts all to upper`() {
        #expect("HeLLo".formatted(.upper) == "HELLO")
    }
}

@Suite
struct `Format.Case - Lower` {

    @Test
    func `Uppercase to lowercase`() {
        #expect("HELLO WORLD".formatted(.lower) == "hello world")
    }

    @Test
    func `Already lowercase is unchanged`() {
        #expect("hello".formatted(.lower) == "hello")
    }

    @Test
    func `Empty string returns empty`() {
        #expect("".formatted(.lower).isEmpty)
    }
}

@Suite
struct `Format.Case - Title` {

    @Test
    func `Basic title case`() {
        #expect("hello world".formatted(.title) == "Hello World")
    }

    @Test
    func `Already title case is unchanged`() {
        #expect("Hello World".formatted(.title) == "Hello World")
    }

    @Test
    func `Single word is capitalized`() {
        #expect("hello".formatted(.title) == "Hello")
    }

    @Test
    func `Empty string returns empty`() {
        #expect("".formatted(.title).isEmpty)
    }

    @Test
    func `All caps are title-cased`() {
        #expect("HELLO WORLD".formatted(.title) == "Hello World")
    }
}

@Suite
struct `Format.Case - Sentence` {

    @Test
    func `First letter capitalized, rest lowered`() {
        #expect("hello world".formatted(.sentence) == "Hello world")
    }

    @Test
    func `All caps sentence-cased`() {
        #expect("HELLO WORLD".formatted(.sentence) == "Hello world")
    }

    @Test
    func `Single character`() {
        #expect("h".formatted(.sentence) == "H")
    }

    @Test
    func `Empty string returns empty`() {
        #expect("".formatted(.sentence).isEmpty)
    }
}

// MARK: - Format.Case — Custom

@Suite
struct `Format.Case - Custom` {

    @Test
    func `Identity transformation`() {
        let identity = Format.Case { $0 }
        #expect("hello".formatted(identity) == "hello")
    }

    @Test
    func `Closure is invoked with input string`() {
        let reverse = Format.Case { String($0.reversed()) }
        #expect("abc".formatted(reverse) == "cba")
    }
}

// MARK: - StringProtocol.formatted on Substring

@Suite
struct `StringProtocol.formatted - Substring` {

    @Test
    func `Substring formats via upper`() {
        let source = "hello world"
        let sub = source[...]
        #expect(sub.formatted(.upper) == "HELLO WORLD")
    }

    @Test
    func `Substring formats via title`() {
        let source = "hello world"
        let sub = source[...]
        #expect(sub.formatted(.title) == "Hello World")
    }
}

// MARK: - Formatter.Protocol conformance

@Suite
struct `Format.Case - Formatter.Protocol conformance` {

    @Test
    func `format() method applies transform`() {
        let upper: Format.Case = .upper
        #expect(upper.format("hello") == "HELLO")
    }

    @Test
    func `Works via generic formatted<F: Formatter.Protocol>`() {
        // Generic path: any Formatter.Protocol<String, String, Never> works
        // through the generic formatted(_:) overload.
        func applyAny<F: Formatter.`Protocol`>(_ style: F, to string: String) -> F.Output
        where F.Input == String, F.Failure == Never {
            string.formatted(style)
        }
        #expect(applyAny(Format.Case.lower, to: "HELLO") == "hello")
    }
}
