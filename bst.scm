(define make_empty
  (lambda ()
    (list)))

(define make_node
  (lambda (value left right)
    (list value left right)))

(define isempty
  (lambda (tree)
    (null? tree)))

(define getvalue
  (lambda (tree)
    (if (isempty tree)
        0
        (car tree))))

(define getleft
  (lambda (tree)
    (if (isempty tree)
        (make_empty)
        (car (cdr tree)))))

(define getright
  (lambda (tree)
    (if (isempty tree)
        (make_empty)
        (car (cdr (cdr tree))))))

(define insert_one_helper
  (lambda (tree val path)
    (if (isempty tree)
        (make_node val (make_empty) (make_empty))
        (if (= val (getvalue tree))
            (if (= path 0)
                (make_node (getvalue tree)
                          (insert_one_helper (getleft tree) val 1)
                          (getright tree))
                (make_node (getvalue tree)
                          (getleft tree)
                          (insert_one_helper (getright tree) val 0)))
            (if (> (getvalue tree) val)
                (make_node
                 (getvalue tree)
                 (insert_one_helper (getleft tree) val path)
                 (getright tree))
                (make_node
                 (getvalue tree)
                 (getleft tree)
                 (insert_one_helper (getright tree) val path)))))))

(define insert_one
  (lambda (tree val)
    (insert_one_helper tree val 0)))

(define bst
  (lambda (lst)
    (if (null? lst)
        (make_empty)
        (insert_one (bst (cdr lst)) (car lst)))))

(define insert
  (lambda (tree lst)
    (if (null? lst)
        tree
        (insert
         (insert_one tree (car lst))
         (cdr lst)))))

(define getlist_helper
  (lambda (tree result)
    (if (isempty tree)
        result
        (join_lists
         (getlist_helper (getleft tree) result)
         (cons (getvalue tree)
               (getlist_helper (getright tree) (list)))))))

(define getlist
  (lambda (tree)
    (if (isempty tree)
        (list)
        (getlist_helper tree (list)))))

(define join_lists
  (lambda (lst1 lst2)
    (if (null? lst1)
        lst2
        (cons (car lst1)
              (join_lists (cdr lst1) lst2)))))

(define gettree
  (lambda (tree)
    (if (isempty tree)
        (list)
        (list (getvalue tree)
              (gettree (getleft tree))
              (gettree (getright tree))))))