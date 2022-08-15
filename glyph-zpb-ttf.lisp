;;;zpb-ttf
(in-package :glyph)

(defmethod glyph:index ((glyph zpb-ttf::glyph))
  (zpb-ttf:font-index glyph))
(defmethod glyph:name ((glyph zpb-ttf::glyph))
  (aref (zpb-ttf::postscript-glyph-names (glyph:font glyph)) (glyph:index glyph)))
(defmethod glyph:character ((glyph zpb-ttf::glyph))
  (code-char (glyph:code-point glyph)))
(defmethod glyph:code-point ((glyph zpb-ttf::glyph))
  (zpb-ttf:code-point glyph))

;(defmethod glyph:character ((glyph zpb-ttf::glyph)))


(defmethod bounding-box ((glyph zpb-ttf::glyph) &optional ppem)
  (zpb-ttf:bounding-box glyph))
(defmethod x-min ((glyph zpb-ttf::glyph)&optional ppem)
  (aref (zpb-ttf:bounding-box glyph) 0))
(defmethod y-min ((glyph zpb-ttf::glyph)&optional ppem)
  (aref (zpb-ttf:bounding-box glyph) 1))
(defmethod x-max ((glyph zpb-ttf::glyph)&optional ppem)
  (aref (zpb-ttf:bounding-box glyph)2))
(defmethod y-max ((glyph zpb-ttf::glyph)&optional ppem)
  (aref (zpb-ttf:bounding-box glyph)3))

(defmethod advance-width  ((glyph zpb-ttf::glyph)&optional ppem)
  (zpb-ttf:advance-width glyph))
(defmethod advance-height ((glyph zpb-ttf::glyph)&optional ppem)
 ; (zpb-ttf:advance-height glyph) why isn't this in zpb? get someone to add it
  0)

(defmethod right-side-bearing ((glyph zpb-ttf::glyph)&optional ppem)
  (zpb-ttf:right-side-bearing glyph))
(defmethod left-side-bearing ((glyph zpb-ttf::glyph)&optional ppem)
  (zpb-ttf:left-side-bearing glyph))
;;same with top-side bottom-side, someone needs to decode the vertical metrics

(defmethod glyph:kerning ((glyph1 zpb-ttf::glyph) glyph2 &optional ppem)
  (let ((font (font glyph1)))
    (reify? (zpb-ttf:kerning-offset glyph1 (font:glyph glyph2 font) font) glyph1 ppem)))

(defmethod glyph:data ((glyph zpb-ttf::glyph))
  (zpb-ttf:contours glyph))
(defmethod glyph:paths ((glyph zpb-ttf::glyph) &key (offset (cons 0 0)) (scale-x 1) (scale-y scale-x))
  (net.tuxee.paths-ttf:paths-from-glyph glyph :offset offset :scale-x scale-x :scale-y scale-y :auto-orient :cw))
(defmethod glyph:font ((glyph zpb-ttf::glyph))
  (zpb-ttf::font-loader glyph))

