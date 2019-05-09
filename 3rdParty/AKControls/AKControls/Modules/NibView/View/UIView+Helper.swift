//
//  UIView+Helper.swift
//  AKControls
//
//  Created by Andy Kim on 20/7/18.
//  Copyright © 2018 Hoodles. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: - Class variables
    
    /// Prevents recursive call by loadNibNamed to itself. Safe as a static var since it is always called on the main thread, ie synchronously.
    private static var isLoadingFromNib = false
    
    public static var bundle: Bundle? {
        return Bundle(for: self)
    }
    
    static var classNameComponents: [String] {
        let fullClassName = NSStringFromClass(self) // Note: String(describing: self) does not include the moduleName prefix.
        return fullClassName.components(separatedBy: ".")
    }
    
    static var nibName: String {
        // Remove the <ProjectName>. prefix that Swift adds:
        return classNameComponents.last!
    }
    
    static var moduleName: String? {
        let components = classNameComponents
        return components.count > 1
            ? components.first!
            : nil
    }
    
    static var sizeFromNib: CGSize? {
        return (
            bundle?
                .loadNibNamed(nibName, owner:nil, options: [:])?
                .first as? UIView
            )?
            .frame.size
    }
    
    // MARK: - Instance functions
    
    func copyConstraints(from view: UIView) {
        translatesAutoresizingMaskIntoConstraints = view.translatesAutoresizingMaskIntoConstraints
        for constraint in view.constraints {
            if var firstItem = constraint.firstItem as? UIView {
                var secondItem = constraint.secondItem as? UIView
                if firstItem == view {
                    firstItem = self
                }
                if secondItem == view {
                    secondItem = self
                }
                let copiedConstraint = NSLayoutConstraint(
                    item: firstItem,
                    attribute: constraint.firstAttribute,
                    relatedBy: constraint.relation,
                    toItem: secondItem,
                    attribute: constraint.secondAttribute,
                    multiplier: constraint.multiplier,
                    constant: constraint.constant
                )
                addConstraint(copiedConstraint)
            } else {
                debugPrint("copyConstraintsFromView: error: firstItem is not a UIView")
            }
            for axis in [NSLayoutConstraint.Axis.horizontal, NSLayoutConstraint.Axis.vertical] {
                setContentCompressionResistancePriority(view.contentCompressionResistancePriority(for: axis), for: axis)
                setContentHuggingPriority(view.contentHuggingPriority(for: axis), for: axis)
            }
        }
    }
    
    // TODO: Remove this. Consolidate with the new nibView(fromNibNamed) functions below:
    
    @objc var viewFromNib: UIView? {
        guard let bundle = type(of: self).bundle
            else { return nil }
        let nibName = type(of: self).nibName
        return view(fromNibNamed: nibName, in: bundle)
    }
    
    func view(fromNibNamed nibName: String, in bundle: Bundle) -> UIView? {
        guard let nibViews = bundle.loadNibNamed(nibName, owner: nil, options: nil),
            let nibView = nibViews.first(where: { type(of: $0) == type(of: self) } ) as? UIView
            else {
                debugPrint("**** error: Could not find an instance of class \(type(of: self)) in \(nibName) xib")
                return nil
        }
        nibView.copyProperties(from: self)
        nibView.copyConstraints(from: self)
        return nibView
    }
    
    // TODO: Remove above
    
    static func nibView(fromNibNamed nibName: String? = nil, in bundle: Bundle? = nil) -> UIView? {
        guard !isLoadingFromNib
            else { return nil }
        isLoadingFromNib = true
        defer {
            isLoadingFromNib = false
        }
        let bundle = bundle ?? self.bundle!
        let nibName = nibName ?? self.nibName
        guard let nibViews = bundle.loadNibNamed(nibName, owner: nil, options: nil),
            let nibView = nibViews.first(where: { type(of: $0) == self } ) as? UIView
            else {
                fatalError("Could not find an instance of class \(self) in \(nibName) xib")
        }
        return nibView
    }
    
    @objc func replacedByNibView(fromNibNamed nibName: String? = nil, in bundle: Bundle? = nil) -> UIView {
        guard let nibView = type(of: self).nibView(fromNibNamed: nibName, in: bundle)
            else { return self}
        nibView.copyProperties(from: self)
        nibView.copyConstraints(from: self)
        return nibView
    }
    
    var copied: UIView {
        let copiedView = type(of: self).init(frame: frame)
        copiedView.copyProperties(from: self)
        return copiedView
    }
    
    func copied(withSubviews subviews: [UIView],
                includeConstraints: Bool) -> UIView {
        let copiedView = copied
        copiedView.copySubviews(subviews,
                                includeConstraints: includeConstraints)
        return copiedView
    }
    
    func copySubviews(_ subviews: [UIView],
                      includeConstraints: Bool)
    {
        for subview in subviews {
            let copiedSubview = type(of: subview).init(frame: frame)
            addSubview(copiedSubview)
            copiedSubview.copyProperties(from: subview)
            if includeConstraints {
                copiedSubview.copyConstraints(from: subview)
            }
            copiedSubview.copySubviews(subview.subviews,
                                       includeConstraints: includeConstraints)
        }
    }
    
    func copyAnimatableProperties(from view: UIView) {
        alpha = view.alpha
        if view.backgroundColor != nil {
            backgroundColor = view.backgroundColor
        }
        transform = view.transform
    }
    
}

public protocol Morphable {
    
    func copyProperties(from view: UIView)
    
}

extension UIView: Morphable {
    
    @objc public func copyProperties(from view: UIView) {
        copyAnimatableProperties(from: view)
        frame = view.frame
        tag = view.tag
        isUserInteractionEnabled = view.isUserInteractionEnabled
        isHidden = view.isHidden
    }
    
    open override func copy() -> Any {
        let copy = type(of: self).init(frame: frame)
        copy.copyProperties(from: self)
        return copy
    }
    
}

public extension UILabel {
    
    public override func copyProperties(from view: UIView) {
        super.copyProperties(from: view)
        guard let label = view as? UILabel
            else { return }
        text = label.text
        font = label.font
        textColor = label.textColor
        // TODO: Figure out why the next two lines cause a segmentation fault in Swift 4
        /*
         shadowColor = label.shadowColor
         shadowOffset = label.shadowOffset
         */
        textAlignment = label.textAlignment
        lineBreakMode = label.lineBreakMode
        attributedText = label.attributedText
        highlightedTextColor = label.highlightedTextColor
        numberOfLines = label.numberOfLines
        adjustsFontSizeToFitWidth = label.adjustsFontSizeToFitWidth
        baselineAdjustment = label.baselineAdjustment
        minimumScaleFactor = label.minimumScaleFactor
        preferredMaxLayoutWidth = label.preferredMaxLayoutWidth
        isHighlighted = label.isHighlighted
        isEnabled = label.isEnabled
        tintColor = label.tintColor
    }
    
    public func copyNonDefaultProperties(from view: UIView) {
        guard let label = view as? UILabel
            else { return }
        if let sourceAttributedText = label.attributedText,
            let attributes = attributedText?.attributes(at: 0, effectiveRange: nil)
        {
            attributedText = sourceAttributedText.keepingTraitsAndColorButAdding(attributes: attributes)
        }
    }
    
}

public extension UIImageView {
    
    public override func copyProperties(from view: UIView) {
        super.copyProperties(from: view)
        guard let imageView = view as? UIImageView
            else { return }
        image = imageView.image
        highlightedImage = imageView.highlightedImage
        isHighlighted = imageView.isHighlighted
        animationImages = imageView.animationImages
    }
    
    public func copyNonDefaultProperties(from view: UIView) {
        guard let imageView = view as? UIImageView
            else { return }
        if let sourceImage = imageView.image {
            image = sourceImage
        }
    }
    
}

public extension UITableViewCell {
    
    override func copyProperties(from view: UIView) {
        super.copyProperties(from: view)
        guard let cell = view as? UITableViewCell
            else { return }
        accessoryType = cell.accessoryType
        editingAccessoryType = cell.editingAccessoryType
        selectionStyle = cell.selectionStyle
        indentationLevel = cell.indentationLevel
        indentationWidth = cell.indentationWidth
        shouldIndentWhileEditing = cell.shouldIndentWhileEditing
        separatorInset = cell.separatorInset
        if #available(iOS 9, *) {
            focusStyle = cell.focusStyle
        }
    }
    
}

public extension NSAttributedString {
    public func keepingTraitsAndColorButAdding(attributes: TextAttributes) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        enumerateAttributes(in: NSRange(location: 0, length: length), options: [])
        { (attributes, range, stop) in
            if let color = attributes[NSAttributedString.Key.foregroundColor] as? UIColor,
                ![UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1), .black].contains(color)
            {
                attributedString.addAttributes([NSAttributedString.Key.foregroundColor : color], range: range)
            }
            if let font = attributes[NSAttributedString.Key.font] as? UIFont,
                !font.fontDescriptor.symbolicTraits.isEmpty,
                let oldFont = attributedString.attribute(NSAttributedString.Key.font,
                                                         at: range.location,
                                                         longestEffectiveRange: nil,
                                                         in: range) as? UIFont
            {
                let newFont = oldFont.addingSymbolicTraits(font.fontDescriptor.symbolicTraits)
                attributedString.addAttributes([NSAttributedString.Key.font : newFont], range: range)
            }
        }
        return NSAttributedString(attributedString: attributedString)
    }
}

public typealias TextAttributes = [NSAttributedString.Key : Any]

// extension TextAttributes
public extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject {
    
}

public extension UIFont {
    
    public func addingSymbolicTraits(_ symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard !symbolicTraits.isEmpty
            else { return self }
        var combinedTraits = fontDescriptor.symbolicTraits
        combinedTraits.insert(symbolicTraits)
        let newFontDescriptor: UIFontDescriptor
        if let combinedFontDescriptor = fontDescriptor.withSymbolicTraits(combinedTraits) {
            newFontDescriptor = combinedFontDescriptor
        } else {
            // Fallback to below for pre-iOS 10 which returns nil from above and doesn't seem to work with symbolicTraits:
            if combinedTraits.contains(.traitBold) {
                let traitsDictionary = [UIFontDescriptor.TraitKey.weight : UIFont.Weight.bold]
                let fontAttributes: [UIFontDescriptor.AttributeName : Any] = [
                    .family : familyName,
                    .traits : traitsDictionary
                ]
                newFontDescriptor = UIFontDescriptor(fontAttributes: fontAttributes)
            } else {
                newFontDescriptor = fontDescriptor
            }
        }
        let font = UIFont(descriptor: newFontDescriptor, size: pointSize)
        return font
    }
}
