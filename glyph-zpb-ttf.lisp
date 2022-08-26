;;;zpb-ttf
(in-package :font-zpb-ttf)

(defmethod glyph:index ((glyph zpb-ttf::glyph))
  (zpb-ttf:font-index glyph))
(defmethod glyph:name ((glyph zpb-ttf::glyph))
  (aref (zpb-ttf::postscript-glyph-names (glyph:font glyph)) (glyph:index glyph)))
(defmethod glyph:character ((glyph zpb-ttf::glyph))
  (code-char (glyph:code-point glyph)))
(defmethod glyph:code-point ((glyph zpb-ttf::glyph))
  (zpb-ttf:code-point glyph))

;(defmethod glyph:character ((glyph zpb-ttf::glyph)))


(defmethod glyph:bounding-box ((glyph zpb-ttf::glyph) &optional ppem)
  (let ((bbox (zpb-ttf:bounding-box glyph)))
    (if (null ppem)
        bbox
        (let ((em (glyph:em glyph)))
          (map 'vector (lambda (x) (* x (/ ppem em))) bbox)))))
(defmethod glyph:x-min ((glyph zpb-ttf::glyph)&optional ppem)
  (glyph:reify? (aref (zpb-ttf:bounding-box glyph) 0) glyph ppem))
(defmethod glyph:y-min ((glyph zpb-ttf::glyph)&optional ppem)
  (glyph:reify? (aref (zpb-ttf:bounding-box glyph) 1) glyph ppem))
(defmethod glyph:x-max ((glyph zpb-ttf::glyph)&optional ppem)
  (glyph:reify? (aref (zpb-ttf:bounding-box glyph)2) glyph ppem))
(defmethod glyph:y-max ((glyph zpb-ttf::glyph)&optional ppem)
  (glyph:reify? (aref (zpb-ttf:bounding-box glyph)3) glyph ppem))

(defmethod glyph:advance-width  ((glyph zpb-ttf::glyph)&optional ppem)
  (glyph:reify? (zpb-ttf:advance-width glyph) glyph ppem))
(defmethod glyph:advance-height ((glyph zpb-ttf::glyph)&optional ppem)
  (declare (ignore ppem))
 ; (zpb-ttf:advance-height glyph) why isn't this in zpb? get someone to add it
  0)

(defmethod glyph:right-side-bearing ((glyph zpb-ttf::glyph)&optional ppem)
  (glyph:reify? (zpb-ttf:right-side-bearing glyph) glyph ppem))
(defmethod glyph:left-side-bearing ((glyph zpb-ttf::glyph)&optional ppem)
  (glyph:reify? (zpb-ttf:left-side-bearing glyph) glyph ppem))
;;same with top-side bottom-side, someone needs to decode the vertical metrics

(defmethod glyph:kerning ((glyph1 zpb-ttf::glyph) glyph2 &optional ppem)
  (let ((font (glyph:font glyph1)))
    (glyph:reify? (zpb-ttf:kerning-offset glyph1 (font:glyph glyph2 font) font) glyph1 ppem)))
(defmethod glyph:kerning ((glyph1 zpb-ttf::glyph)(glyph2 zpb-ttf::glyph) &optional ppem)
  (let ((font (glyph:font glyph1)))
    (glyph:reify? (zpb-ttf:kerning-offset glyph1 glyph2 font) glyph1 ppem)))

(defmethod glyph:data ((glyph zpb-ttf::glyph))
  (zpb-ttf:contours glyph))

(defun paths (glyph &key (offset (cons 0 0)) (scale-x 1) (scale-y scale-x) (auto-orient :cw))
  (net.tuxee.paths-ttf:paths-from-glyph glyph :offset offset :scale-x scale-x :scale-y scale-y :auto-orient auto-orient))

;;cripple to only square pixels, how will we deal with 50 year old technology?
(defmethod glyph:paths ((glyph zpb-ttf::glyph) &key ppem (offset (cons 0 0)))
  (let ((scale-x (if (null ppem) 1.0 (/ ppem (glyph:em glyph)))))
    (paths glyph :offset offset :scale-x scale-x :scale-y scale-x)))

(defmethod glyph:font ((glyph zpb-ttf::glyph))
  (zpb-ttf::font-loader glyph))

