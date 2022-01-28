// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
  name: "KatexMathView",
  platforms: [.iOS(.v14), .macOS(.v11)],
  products: [
    .library(
      name: "KatexMathView",
      targets: ["KatexMathView"])
  ],
  targets: [
    .target(
      name: "KatexMathView",
      path: ".",
      exclude: [
        "Example",
        "README.md",
      ],
      sources: [
        "KatexMathView.swift",
        "KatexView.swift",
      ],
      resources: [
        .copy("katex")
      ],
      swiftSettings: [
        .define("SPM_PACKAGE")
      ]
    )
  ]
)
