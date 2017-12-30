# racket-mandlebrot

A simple Mandlebrot in Racket to explore performance of Typed Racket, Flonums and Reals.

Open up `mandlebrot-draw.rkt` and pick the version to test. 

## Performance

All using:

Canvas: 800x500
Iterations: tmax = 100

(define real-min -2.2)
(define real-max .6)
(define imag-min -1.2)
(define imag-max 1.2)

### Typed with Flonums - 2db1e34

Rendered in 9287 ms, 8926 CPU ms

### Typed with Reals - 

Rendered in 16164 ms, 15545 CPU ms

### Untyped - c69a509

Rendered in 16988 ms, 16238 CPU ms
