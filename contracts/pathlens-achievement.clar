;; PathLens Achievement NFT Contract

;; Token definitions
(define-non-fungible-token pathlens-achievement uint)

;; Constants
(define-constant contract-owner tx-sender)

;; Storage
(define-map achievement-data
  uint
  {name: (string-utf8 64),
   description: (string-utf8 256),
   milestone-id: uint}
)

(define-data-var achievement-counter uint u0)

;; Public functions
(define-public (mint-achievement 
  (recipient principal)
  (name (string-utf8 64))
  (description (string-utf8 256))
  (milestone-id uint))
  (let ((achievement-id (var-get achievement-counter)))
    (try! (nft-mint? pathlens-achievement achievement-id recipient))
    (map-set achievement-data
      achievement-id
      {name: name,
       description: description,
       milestone-id: milestone-id})
    (ok (var-set achievement-counter (+ achievement-id u1))))
)

;; Read only functions
(define-read-only (get-achievement (id uint))
  (ok (map-get? achievement-data id))
)
