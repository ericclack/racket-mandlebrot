#lang typed/racket

; Copyright Eric Clack 2017. 

; maximum iterations
(define tmax (make-parameter 100))

(: m-set? (-> Float-Complex Boolean))
(define (m-set? c)
  ; is c in the mandelbrot set?
  (let iter ([x : Float-Complex (make-rectangular 0.0 0.0)]
             [t : Integer 0])
    (cond
      [(>= t (tmax)) #t]
      [(> (magnitude x) 2) #f]
      [else (iter (+ (expt x 2) c)
                  (add1 t))])))

(: scale (-> Flonum Flonum Flonum Flonum))
(define (scale n low high)
  ; represent n as a percentage between low and high
  (/
   (- n low)
   (- high low)))  

(define-type Dc<%>
  (Class [draw-line (-> Number Number Number Number Void)]))                        

(: plot-set (-> (Instance Dc<%>) Real Real Flonum Flonum Flonum Flonum Void))
(define (plot-set dc width height real-min real-max imag-min imag-max)
  (let* ([w (real->double-flonum width)]
         [h (real->double-flonum height)]
         [r-step (/ (- real-max real-min) w)]
         [i-step (/ (- imag-max imag-min) h)])

    (: plot-point (-> (Instance Dc<%>) Float-Complex Void))
    (define (plot-point dc c)
      ; draw point representing this complex number
      (let ([x (* (scale (real-part c) real-min real-max) w)]
            [y (* (scale (imag-part c) imag-min imag-max) h)])
        (send dc draw-line x y x y)))
    
    (for ([r : Flonum (in-range real-min real-max r-step)])
         (display ".")
         (for ([i : Flonum (in-range imag-min imag-max i-step)])
              (let ([c (make-rectangular r i)])
                (when (m-set? c)
                  (plot-point dc c)))))))

(provide tmax
         m-set? 
         plot-set)




