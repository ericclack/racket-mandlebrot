#lang racket

; Copyright Eric Clack 2017.

(require racket/draw)
(require "mandlebrot-typed.rkt")

;(real-max 0.0)
;(imag-max 0.0)

(define bmp (make-bitmap (width) (height)))
(define dc (send bmp make-dc))
(send dc clear)

(define-values (res cpu real gc)
     (time-apply plot-set (list dc)))

(printf "Rendered in ~a ms, ~a CPU ms" real cpu)

(newline)
bmp