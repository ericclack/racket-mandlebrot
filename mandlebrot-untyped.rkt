#lang racket

; Copyright Eric Clack 2017. 

; maximum iterations
(define tmax (make-parameter 50))
; canvas width and height
(define width (make-parameter 800))
(define height (make-parameter 500))

; real maps to x axis
(define real-min (make-parameter -2.2))
(define real-max (make-parameter .6))
; imaginary to y axis
(define imag-min (make-parameter -1.2))
(define imag-max (make-parameter 1.2))

(define (m-set? c)
  ; is c in the mandelbrot set?
  (define (iter x t)
    (cond
      [(>= t (tmax)) #t]
      [(> (magnitude x) 2) #f]
      [else (iter (+ (expt x 2) c)
                  (add1 t))]))
  (iter (make-rectangular 0 0) 0))

(define (scale n low high)
  ; represent n as a percentage between low and high
  (/
   (- n low)
   (- high low)))  

; scale r and i for rendering on canvas
(define (scale-r r)
  (* (scale r (real-min) (real-max)) (real->double-flonum (width))))

(define (scale-i i)
  (* (scale i (imag-min) (imag-max)) (real->double-flonum (height))))

(define (plot-point dc c)
  ; draw point representing this complex number
  (let ([x (scale-r (real->double-flonum (real-part c)))]
        [y (scale-i (real->double-flonum (imag-part c)))])
    (send dc draw-line x y x y)))

(define (plot-set dc)
  (let ([r-step (/ (- (real-max) (real-min)) (real->double-flonum (width)))]
        [i-step (/ (- (imag-max) (imag-min)) (real->double-flonum (height)))])
    (for ([r (in-range (real-min) (real-max) r-step)])
         (display ".")
         (for ([i (in-range (imag-min) (imag-max) i-step)])
              (let ([c (make-rectangular r i)])
                (when (m-set? c)
                  (plot-point dc c)))))))

(provide width height
         real-min real-max 
         imag-min imag-max 
         m-set? 
         plot-set)




