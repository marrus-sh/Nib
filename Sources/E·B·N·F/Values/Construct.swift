//  #  E·B·N·F :: Construct  #
//
//  Copyright © 2021 kibigo!
//
//  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Core

/// An enumerated type representing a substring, potentially lexed into a tree of symbols.
/// The substring itself can be accessed (as a `Text.SubSequence`) via the `.text` property.
///
/// `Construct.symbol`s have an associated `Symbol` and content which is an array of further `Construct`s.
/// They represent a single *instance* of a `Symbol`.
///
/// `Construct.string`s represent the text content of an instance of a terminal `Expression`.
public enum Construct <Symbol>
where Symbol: Symbolic {

	/// The text contents of an instance of a terminal `Expression`.
	case string (
		content: Text.SubSequence
	)

	/// A lexed instance of a `Symbol`.
	///
	/// The `content` must form a contiguous sequence from `.first.startIndex` to `.last.endIndex`.
	case symbol (
		Symbol,
		version: Symbol.Version,
		content: [Symbol.Construct]
	)

	/// If this `Symbol` is a `.symbol`, its `content`; otherwise, an array containing only this `Symbol`.
	@inlinable
	public var content: [Symbol.Construct] {
		switch self {
			case .string:
				return [self]
			case .symbol (
				_,
				version: _,
				content: let content
			): return content
		}
	}

	/// If this `Symbol` is a `.symbol`, its `symbol`; otherwise, `nil`.
	@inlinable
	public var symbol: Symbol? {
		switch self {
			case .string:
				return nil
			case .symbol (
				let symbol,
				version: _,
				content: _
			): return symbol
		}
	}

	/// The substring which this `Construct` lexes.
	@inlinable
	public var text: Text.SubSequence {
		switch self {
			case .string (
				content: let text
			): return text
			case .symbol (
				_,
				version: _,
				content: let children
			): return children.count == 0 ? Text.SubSequence() : Substring(children[0].text).base[children[0].text.startIndex..<children[children.count - 1].text.endIndex].unicodeScalars
		}
	}

	/// If this `Symbol` is a `.symbol`, its `version`; otherwise, `nil`.
	@inlinable
	public var version: Symbol.Version? {
		switch self {
			case .string:
				return nil
			case .symbol (
				_,
				version: let version,
				content: _
			): return version
		}
	}

}
