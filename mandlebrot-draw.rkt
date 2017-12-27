#lang racket

; Copyright Eric Clack 2017.

(require racket/draw)
(require "mandlebrot.rkt")

;(real-max 0.0)
;(imag-max 0.0)

(define bmp (make-bitmap (width) (height)))
(define dc (send bmp make-dc))
(send dc clear)

(plot-set dc)

(newline)
bmp