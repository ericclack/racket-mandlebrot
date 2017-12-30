#lang racket

; Copyright Eric Clack 2017. 

; maximum iterations
(define tmax (make-parameter 100))

(define (m-set? c)
  ; is c in the mandelbrot set?
  (let iter ([x (make-rectangular 0.0 0.0)]
             [t 0])
    (cond
      [(>= t (tmax)) #t]
      [(> (magnitude x) 2) #f]
      [else (iter (+ (expt x 2) c)
                  (add1 t))])))

(define (scale n low high)
  ; represent n as a percentage between low and high
  (/
   (- n low)
   (- high low)))  

(define (plot-set dc width height real-min real-max imag-min imag-max)
  (let ([r-step (/ (- real-max real-min) width)]
        [i-step (/ (- imag-max imag-min) height)])

     (define (plot-point dc c)
      ; draw point representing this complex number
      (let ([x (* (scale (real-part c) real-min real-max) width)]
            [y (* (scale (imag-part c) imag-min imag-max) height)])
        (send dc draw-line x y x y)))
    
    (for ([r (in-range real-min real-max r-step)])
         (display ".")
         (for ([i (in-range imag-min imag-max i-step)])
              (let ([c (make-rectangular r i)])
                (when (m-set? c)
                  (plot-point dc c)))))))

(provide tmax
         m-set? 
         plot-set)




