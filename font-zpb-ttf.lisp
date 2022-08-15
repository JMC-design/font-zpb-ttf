(in-package :font)
;;;; zpb-ttf

(defmethod %open (font (type (eql :ttf)))
  (zpb-ttf:open-font-loader font))
(defmethod open ((font zpb-ttf::font-loader))
  (zpb-ttf:open-font-loader font))
(defmethod close ((font zpb-ttf::font-loader))
  (zpb-ttf:close-font-loader font))

(defmethod family ((font zpb-ttf::font-loader))
  (zpb-ttf:family-name font))
(defmethod subfamily ((font zpb-ttf::font-loader))
  (zpb-ttf:subfamily-name font))
(defmethod name ((font zpb-ttf::font-loader))
  (zpb-ttf:full-name font))

(defmethod font:em ((font zpb-ttf::font-loader))
  (zpb-ttf:units/em font))
(defmethod ascent ((font zpb-ttf::font-loader) &optional ppem)
    (reify? (zpb-ttf:ascender font) (em font) ppem))
(defmethod descent ((font zpb-ttf::font-loader) &optional ppem)
    (reify? (zpb-ttf:descender font) (em font) ppem))
(defmethod bounding-box ((font zpb-ttf::font-loader) &optional ppem)
    (reify? (zpb-ttf:bounding-box font) (em font) ppem))
(defmethod line-gap ((font zpb-ttf::font-loader) &optional ppem)
   (reify?  (zpb-ttf:line-gap font) (em font) ppem))
(defmethod underline ((font zpb-ttf::font-loader) &optional ppem)
  (list (reify? (zpb-ttf:underline-position font) (em font) ppem)
        (reify? (zpb-ttf:underline-thickness font) (em font) ppem)))
(defmethod fixed-width ((font zpb-ttf::font-loader));specify to return size if fixed.
  (when (zpb-ttf:fixed-pitch-p font)
    (let ((bbox (zpb-ttf:bounding-box (zpb-ttf:find-glyph #\a font))))
      (- (aref bbox 2) (aref bbox 0)))))

(defmethod glyph (char-or-code (font zpb-ttf::font-loader))
  (zpb-ttf:find-glyph char-or-code font))

(defmethod font:kerning (font charA charB &optional ppem)
  (reify? (zpb-ttf:kerning-offset charA charB font) (em font) ppem))

(defmethod font:index ((glyph zpb-ttf::glyph) (font zpb-ttf::font-loader))
  (zpb-ttf::font-index glyph))
(defmethod font:tables ((font zpb-ttf::font-loader))
  (u:loop-hash (key value (zpb-ttf::tables font ))
    :collect (zpb-ttf::name value)))
(defmethod font:table ((table string) (font zpb-ttf::font-loader))
  (let* ((info (zpb-ttf::table-info table font))
         (result (make-array (zpb-ttf::size info) :element-type '(unsigned-byte 8))))
    (zpb-ttf::seek-to-table info font)
    (read-sequence result (zpb-ttf::input-stream font))
    result))

(defmethod font:glyphs ((font zpb-ttf::font-loader))
  (zpb-ttf::glyph-cache font))
(defmethod font:glyph-count ((font zpb-ttf::font-loader))
  (zpb-ttf:glyph-count font))
(defmethod font:code-points ((font zpb-ttf::font-loader))
  (loop :for glyph :across (font:glyphs font)
        :when glyph
          :collect (glyph:code-point glyph)))