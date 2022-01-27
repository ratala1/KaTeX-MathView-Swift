import SwiftUI
import WebKit

public struct KatexView: View {
  private let latex: String

  @State
  private var contentHeight: CGFloat = 0

  @State
  private var isLoaded = false

  public init(latex: String) {
    self.latex = latex
  }

  public static func resetHeightCache() {
    KatexMathViewRepresentable.heightCache = [Int: CGFloat]()
  }

  public var body: some View {
    ZStack {
      KatexMathViewRepresentable(latex: latex, contentHeight: $contentHeight, isLoaded: $isLoaded)
        .frame(height: contentHeight)
      if !isLoaded {
        ProgressView()
      }
    }.frame(maxWidth: .infinity)
  }
}

struct KatexMathViewRepresentable: UIViewRepresentable {
  // Caching heights prevents jumpy UI since the height calculation is
  // delayed only the first time the latex block is rendered.
  static var heightCache = [Int: CGFloat]()

  private let latex: String

  private let uiView = KatexMathView()

  @Binding var contentHeight: CGFloat
  @Binding var isLoaded: Bool

  init(latex: String, contentHeight: Binding<CGFloat>, isLoaded: Binding<Bool>) {
    self.latex = latex
    self._contentHeight = contentHeight
    self._isLoaded = isLoaded
  }

  func katexMathView(_ katexMathView: (KatexMathView) -> Void) -> KatexMathViewRepresentable {
    katexMathView(uiView)
    return self
  }

  func makeUIView(context: Context) -> KatexMathView {
    uiView.onLoaded = { height in
      isLoaded = true
      contentHeight = height
      var hasher = Hasher()
      hasher.combine(latex)
      Self.heightCache[hasher.finalize()] = height
    }
    return uiView
  }

  public func updateUIView(_ uiView: KatexMathView, context: Context) {
    var hasher = Hasher()
    hasher.combine(latex)
    let hash = hasher.finalize()

    if let height = Self.heightCache[hash] {
      DispatchQueue.main.async {
        contentHeight = height
      }
    }
    uiView.loadLatex(latex)
  }
}
