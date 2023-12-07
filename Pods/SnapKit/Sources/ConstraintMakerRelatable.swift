//
//  SnapKit
//
//  Copyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public class ConstraintMakerRelatable {
    let description: ConstraintDescription

    init(_ description: ConstraintDescription) {
        self.description = description
    }

    func relatedTo(_ other: ConstraintRelatableTarget, relation: ConstraintRelation, file: String, line: UInt) -> ConstraintMakerEditable {
        let related: ConstraintItem
        let constant: ConstraintConstantTarget

        if let other = other as? ConstraintItem {
            guard other.attributes == ConstraintAttributes.none ||
                other.attributes.layoutAttributes.count <= 1 ||
                other.attributes.layoutAttributes == description.attributes.layoutAttributes ||
                other.attributes == .edges && description.attributes == .margins ||
                other.attributes == .margins && description.attributes == .edges ||
                other.attributes == .directionalEdges && description.attributes == .directionalMargins ||
                other.attributes == .directionalMargins && description.attributes == .directionalEdges
            else {
                fatalError("Cannot constraint to multiple non identical attributes. (\(file), \(line))")
            }

            related = other
            constant = 0.0
        } else if let other = other as? ConstraintView {
            related = ConstraintItem(target: other, attributes: ConstraintAttributes.none)
            constant = 0.0
        } else if let other = other as? ConstraintConstantTarget {
            related = ConstraintItem(target: nil, attributes: ConstraintAttributes.none)
            constant = other
        } else if #available(iOS 9.0, OSX 10.11, *), let other = other as? ConstraintLayoutGuide {
            related = ConstraintItem(target: other, attributes: ConstraintAttributes.none)
            constant = 0.0
        } else {
            fatalError("Invalid constraint. (\(file), \(line))")
        }

        let editable = ConstraintMakerEditable(description)
        editable.description.sourceLocation = (file, line)
        editable.description.relation = relation
        editable.description.related = related
        editable.description.constant = constant
        return editable
    }

    @discardableResult
    public func equalTo(_ other: ConstraintRelatableTarget, _ file: String = #file, _ line: UInt = #line) -> ConstraintMakerEditable {
        return relatedTo(other, relation: .equal, file: file, line: line)
    }

    @discardableResult
    public func equalToSuperview(_ file: String = #file, _ line: UInt = #line) -> ConstraintMakerEditable {
        guard let other = description.item.superview else {
            fatalError("Expected superview but found nil when attempting make constraint `equalToSuperview`.")
        }
        return relatedTo(other, relation: .equal, file: file, line: line)
    }

    @discardableResult
    public func lessThanOrEqualTo(_ other: ConstraintRelatableTarget, _ file: String = #file, _ line: UInt = #line) -> ConstraintMakerEditable {
        return relatedTo(other, relation: .lessThanOrEqual, file: file, line: line)
    }

    @discardableResult
    public func lessThanOrEqualToSuperview(_ file: String = #file, _ line: UInt = #line) -> ConstraintMakerEditable {
        guard let other = description.item.superview else {
            fatalError("Expected superview but found nil when attempting make constraint `lessThanOrEqualToSuperview`.")
        }
        return relatedTo(other, relation: .lessThanOrEqual, file: file, line: line)
    }

    @discardableResult
    public func greaterThanOrEqualTo(_ other: ConstraintRelatableTarget, _ file: String = #file, line: UInt = #line) -> ConstraintMakerEditable {
        return relatedTo(other, relation: .greaterThanOrEqual, file: file, line: line)
    }

    @discardableResult
    public func greaterThanOrEqualToSuperview(_ file: String = #file, line: UInt = #line) -> ConstraintMakerEditable {
        guard let other = description.item.superview else {
            fatalError("Expected superview but found nil when attempting make constraint `greaterThanOrEqualToSuperview`.")
        }
        return relatedTo(other, relation: .greaterThanOrEqual, file: file, line: line)
    }
}
