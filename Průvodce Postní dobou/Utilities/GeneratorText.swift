//
//  GeneratorText.swift
//  Průvodce Postní dobou
//
//  Created by Petr Hracek on 24.02.2021.
//  Copyright © 2021 Biskupství Brněnské. All rights reserved.
//

import Foundation
import UIKit
import BonMot

func generateContent(text: String, size: CGFloat = 16, color: UIColor = UIColor.darkGray ) -> NSAttributedString {

    let font_name : String = "Helvetica"
    let baseStyle = StringStyle(
        .font(UIFont(name: font_name, size: size)!),
        .lineHeightMultiple(1)
    )
    let big = baseStyle.byAdding(
        .font(UIFont(name: font_name, size: size+10)!.bold())
    )
    
    let strong = baseStyle.byAdding(
        .font(UIFont(name: font_name, size: size)!.bold())
    )
    let emphasized = baseStyle.byAdding(
        .font(UIFont(name: font_name, size: size)!.italic())
    )
    let small = baseStyle.byAdding(
        .font(UIFont(name: font_name, size: size-4)!)
    )
    let paragraph = baseStyle.byAdding(
        .paragraphSpacingBefore(20)
    )

    let redStyle = StringStyle(
        .color(.red)
    )

    let rules: [XMLStyleRule] = [
        .style("em", emphasized),
        .style("i", emphasized),
        .style("b", strong),
        .style("small", small),
        .style("p", paragraph),
        .style("br", paragraph),
        .style("red", redStyle),
        .style("h2", big)
    ]

    let content = baseStyle.byAdding(
        .color(color),
        .xmlRules(rules)
    )
    var generated_text = text
    generated_text = generated_text.replacingOccurrences(of: "<p>\n", with: "<p>")
    generated_text = generated_text.replacingOccurrences(of: "<ul>", with: "- ")
    generated_text = generated_text.replacingOccurrences(of: "</ul>", with: "<br>")
    generated_text = generated_text.replacingOccurrences(of: "\n</p>", with: "</p>")
    generated_text = generated_text.replacingOccurrences(of: "[\\t\\n\\r][\\t\\n\\r]+", with: "\n", options: .regularExpression)
    generated_text = generated_text.replacingOccurrences(of: "<p>", with: "")
    generated_text = generated_text.replacingOccurrences(of: "</p>", with: "\n\n")
    generated_text = generated_text.replacingOccurrences(of: "<br>", with: "\n")
    generated_text = generated_text.trimmingCharacters(in: .whitespacesAndNewlines)
    return generated_text.styled(with: content)
    
}

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
