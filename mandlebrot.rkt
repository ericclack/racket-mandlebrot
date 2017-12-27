#lang typed/racket

; Copyright Eric Clack 2017. 

; maximum iterations
(define tmax (make-parameter 25))
; canvas width and height
(define width (make-parameter 800))
(define height (make-parameter 500))

; real maps to x axis
(define real-min (make-parameter -2.2))
(define real-max (make-parameter .6))
; imaginary to y axis
(define imag-min (make-parameter -1.2))
(define imag-max (make-parameter 1.2))

(: m-set? (-> Complex Boolean))
(define (m-set? c)
  ; is c in the mandelbrot set?
  (: iter (-> Complex Integer Boolean))
  (define (iter x t)
    (cond
      [(>= t (tmax)) #t]
      [(> (magnitude x) 2) #f]
      [else (iter (+ (expt x 2) c)
                  (add1 t))]))
  (iter (make-rectangular 0 0) 0))

(: scale (-> Real Real Real Real))
(define (scale n low high)
  ; represent n as a percentage between low and high
  (/
   (- n low)
   (- high low)))  

; scale r and i for rendering on canvas
(: scale-r (-> Real Real))
(define (scale-r r)
  (* (width) (scale r (real-min) (real-max))))

(: scale-i (-> Real Real))
(define (scale-i i)
  (* (height) (scale i (imag-min) (imag-max))))

(define-type Dc<%>
  (Class [draw-line (-> Number Number Number Number Void)]))                        

(: plot-point (-> (Instance Dc<%>) Complex Void))
(define (plot-point dc c)
  ; draw point representing this complex number
  (let ([x (scale-r (real-part c))]
        [y (scale-i (imag-part c))])
    (send dc draw-line x y x y)))

(: plot-set (-> (Instance Dc<%>) Void))
(define (plot-set dc)
  (let ([r-step (/ (- (real-max) (real-min)) (width))]
        [i-step (/ (- (imag-max) (imag-min)) (height))])
    (for ([r : Real (in-range (real-min) (real-max) r-step)])
         (display ".")
         (for ([i : Real (in-range (imag-min) (imag-max) i-step)])
              (let ([c (make-rectangular r i)])
                (when (m-set? c)
                  (plot-point dc c)))))))

(provide width height
         real-min real-max 
         imag-min imag-max 
         m-set? 
         plot-set)




