# KaTeX-MathView-Swift
WKWebView to render TeX expressions inline with text in swift



# Usage
* Add katex folder and KatexMathView.swift to your project.
* Now you are ready to use KatexMathView in your story board.
* Add a WKWebView to your parent view. and change the class to KatexMathView.
* Add the WKWebView as IBOutlet in your controller. 

```
   @IBOutlet weak var mathView: KatexMathView!
```

You can load the latex expression as shown below
```
  let latex: String = "Find the value of $k$, if $x + 6$ is a factor of $- k + x^{3} + 16 x^{2} + 76 x$"
  mathView.loadLatex(latex)
```

"$" is the default delimitter. If you have other character in your LaTeX expression, change the delimitter in KatexMathView.swift
