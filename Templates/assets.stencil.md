// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

{% if catalogs %}
{% set enumName %}{{param.enumName|default:"Asset"}}{% endset %}
{% set arResourceGroupType %}{{param.arResourceGroupTypeName|default:"ARResourceGroupAsset"}}{% endset %}
{% set colorType %}{{param.colorTypeName|default:"ColorAsset"}}{% endset %}
{% set dataType %}{{param.dataTypeName|default:"DataAsset"}}{% endset %}
{% set imageType %}{{param.imageTypeName|default:"ImageAsset"}}{% endset %}
{% set forceNamespaces %}{{param.forceProvidesNamespaces|default:"false"}}{% endset %}
{% set accessModifier %}{% if param.publicAccess %}public{% else %}internal{% endif %}{% endset %}
import SwiftUI
import UIKit


// MARK: - Colors Extensions
{% macro colorsBlock assets %}
  {% for catalog in catalogs %}
    {% for asset in catalog.assets %}
    {% if asset.type == "color" %}
    static let {{asset.name|swiftIdentifier:"pretty"|lowerFirstWord|escapeReservedKeywords}} = Color("{{asset.value}}")
    {% endif %}
    {% endfor %}
  {% endfor %}
{% endmacro %}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name
{{accessModifier}} extension Color {
    {% call colorsBlock catalogs.first.assets %}
}
{% macro colorsBlock assets %}
  {% for catalog in catalogs %}
    {% for asset in catalog.assets %}
    {% if asset.type == "color" %}
    static let {{asset.name|swiftIdentifier:"pretty"|lowerFirstWord|escapeReservedKeywords}} = UIColor(named: "{{asset.value}}")
    {% endif %}
    {% endfor %}
  {% endfor %}
{% endmacro %}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name
{{accessModifier}} extension UIColor {
    {% call colorsBlock catalogs.first.assets %}
}
{% macro imageBlock assets %}
  {% for asset in assets %}
   {% if asset.type == "image" %}
    static let {{asset.name|swiftIdentifier:"pretty"|lowerFirstWord|escapeReservedKeywords}} = Image("{{asset.value}}")
   {% endif %}
  {% endfor %}
{% endmacro %}

// MARK: - Images Extensions
// swiftlint:enable identifier_name line_length nesting type_body_length type_name
{{accessModifier}} extension Image {
  {% call imageBlock catalogs.first.assets %}
}
{% macro imageBlock assets %}
  {% for asset in assets %}
   {% if asset.type == "image" %}
    static let {{asset.name|swiftIdentifier:"pretty"|lowerFirstWord|escapeReservedKeywords}} = UIImage(named: "{{asset.value}}")
   {% endif %}
  {% endfor %}
{% endmacro %}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name
{{accessModifier}} extension UIImage {
    {% call imageBlock catalogs.first.assets %}
}
{% else %}
// No assets found
{% endif %}

