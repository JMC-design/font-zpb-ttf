(asdf:defsystem "font-zpb-ttf"
  :depends-on ("glyph" "font" "zpb-ttf" "cl-vectors")
  :components ((:file "glyph-zpb-ttf")
               (:file "font-zpb-ttf")))
