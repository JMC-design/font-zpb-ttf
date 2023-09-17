(in-package :asdf-user)
(asdf:defsystem "font-zpb-ttf"
  :depends-on ("font" "zpb-ttf" "cl-vectors" "cl-paths-ttf")
  :components ((:file "package")
               (:file "glyph-zpb-ttf")
               (:file "font-zpb-ttf")))
