#lang racket

; Copyright Eric Clack 2017.

(require racket/draw)
(require "mandlebrot-typed.rkt")

; speed up
(tmax 100)

(real-min -.9)
(real-max -0.7)

(imag-min -.2)
(imag-max 0.0)

(define bmp (make-bitmap (width) (height)))
(define dc (send bmp make-dc))
(send dc clear)

(define-values (res cpu real gc)
     (time-apply plot-set (list dc)))

(printf "Rendered in ~a ms, ~a CPU ms" real cpu)

(newline)
bmp