;; PathLens Core Contract

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))

;; Data structures
(define-map career-paths 
  principal 
  {path-name: (string-utf8 64),
   industry: (string-utf8 32),
   milestones: (list 10 uint),
   certifications: (list 5 uint)}
)

(define-map milestones
  uint
  {name: (string-utf8 64),
   description: (string-utf8 256),
   required-skills: (list 5 (string-utf8 32))}
)

;; Public functions
(define-public (create-path (path-name (string-utf8 64)) (industry (string-utf8 32)))
  (let ((path {path-name: path-name,
              industry: industry,
              milestones: (list),
              certifications: (list)}))
    (ok (map-insert career-paths tx-sender path)))
)

(define-public (add-milestone 
  (milestone-id uint)
  (name (string-utf8 64))
  (description (string-utf8 256))
  (skills (list 5 (string-utf8 32))))
  (ok (map-set milestones 
    milestone-id
    {name: name,
     description: description,
     required-skills: skills}))
)

;; Read only functions
(define-read-only (get-path (user principal))
  (ok (map-get? career-paths user))
)

(define-read-only (get-milestone (id uint))
  (ok (map-get? milestones id))
)
