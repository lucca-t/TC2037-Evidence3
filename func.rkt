#lang racket

;; Main function that sorts inputs and calls the recursive matcher
(define (solve-bersu boys girls)
  (let ([sorted-boys (sort boys <)]
        [sorted-girls (sort girls <)])
    (max-pairs sorted-boys sorted-girls)))

;; Purely functional recursive matcher
(define (max-pairs boys girls)
  (cond
    ;; Base Case: If either list is empty, 0 pairs can be formed.
    [(or (null? boys) (null? girls)) 0]
    
    ;; Case 1: Valid pair found. Add 1 and recurse on both tails.
    [(<= (abs (- (car boys) (car girls))) 1)
     (+ 1 (max-pairs (cdr boys) (cdr girls)))]
    
    ;; Case 2: Boy's skill is too low. Recurse with the rest of the boys.
    [(< (car boys) (- (car girls) 1))
     (max-pairs (cdr boys) girls)]
    
    ;; Case 3: Girl's skill is too low. Recurse with the rest of the girls.
    [else
     (max-pairs boys (cdr girls))]))

;; ---------------------------------------------------------
;; Simple Test Suite
;; ---------------------------------------------------------

;; Helper function to print test results cleanly
(define (run-test test-name expected boys girls)
  (let ([result (solve-bersu boys girls)])
    (display test-name)
    (display " -> Expected: ")
    (display expected)
    (display ", Result: ")
    (displayln result)))

;; Executing the 8 test cases
(run-test "Test 1 (Standard case)" 3 '(1 2 4 6) '(1 5 5 7 9))
(run-test "Test 2 (No possible matches)" 0 '(1 1 1 1) '(10 14 37 47))
(run-test "Test 3 (Unsorted inputs)" 3 '(3 1 2) '(3 2 1))
(run-test "Test 4 (Empty lists)" 0 '() '())
(run-test "Test 5 (One empty list)" 0 '(1 2 3) '())
(run-test "Test 6 (Exact matches)" 3 '(1 2 3) '(1 2 3))
(run-test "Test 7 (Multiple identical/offset by 1)" 3 '(1 1 1) '(2 2 2))
(run-test "Test 8 (Large gaps, match at end)" 1 '(10 20 30) '(5 15 31))