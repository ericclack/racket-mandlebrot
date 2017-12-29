#lang racket

; Copyright Eric Clack 2017.

(require racket/draw)
(require "mandlebrot-untyped.rkt")

; canvas size
(define width 800)
(define height 500)

; real maps to x axis
(define real-min -2.2)
(define real-max .6)
; imaginary to y axis
(define imag-min -1.2)
(define imag-max 1.2)

(define bmp (make-bitmap width height))
(define dc (send bmp make-dc))
(send dc clear)

(define-values (res cpu real gc)
     (time-apply plot-set (list dc
                                width height
                                real-min real-max
                                imag-min imag-max)))

(printf "Rendered in ~a ms, ~a CPU ms" real cpu)

(newline)
bmp