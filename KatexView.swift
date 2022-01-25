import SwiftUI
import WebKit

public struct KatexView: UIViewRepresentable {
  private let latex: String

  private let uiView = KatexMathView()

  @Binding var contentHeight: CGFloat

  public init(latex: String, contentHeight: Binding<CGFloat>) {
    self.latex = latex
    self._contentHeight = contentHeight
  }

  public func katexMathView(_ katexMathView: (KatexMathView) -> Void) -> KatexView {
    katexMathView(uiView)
    return self
  }

  public func makeUIView(context: Context) -> KatexMathView {
    uiView.onLoaded = { height in
      contentHeight = height
    }
    return uiView
  }

  public func updateUIView(_ uiView: KatexMathView, context: Context) {
    uiView.loadLatex(latex)
  }
}
