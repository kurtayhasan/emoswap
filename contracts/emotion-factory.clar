;; EmoSwap - Emotion Factory Contract
;; Manages emotion token creation and daily minting

(define-data-var admin principal 'STQTJN7JQ90K7B9TVBRWYC924HAXJD308VSA51X)
(define-constant EMOTION-COUNT (u0))
(define-constant MINT-AMOUNT (u1000000)) ;; 1M microALGO per emotion
(define-constant PAUSED (false))
(define-non-fungible-token emotion-token uint)
(define-data-var emotion-count uint EMOTION-COUNT)
(define-data-var mint-amount uint MINT-AMOUNT)
(define-data-var paused bool PAUSED)
(define-map emotion-to-asset string uint)
;; Error codes
(define-constant ERR-UNAUTHORIZED (err u100))
(define-constant ERR-PAUSED (err u101))
(define-constant ERR-INVALID-EMOTION (err u102))
(define-constant ERR-ALREADY-EXISTS (err u103))
;; Create new emotion token
(define-public (create-emotion (emotion-name string))
  (begin
    (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
    (asserts! (not (var-get paused)) ERR-PAUSED)
    (asserts! (is-none (map-get? emotion-to-asset emotion-name)) ERR-ALREADY-EXISTS)
    (ok (begin
          (var-set emotion-count (+ (var-get emotion-count) u1))
          (map-set emotion-to-asset emotion-name (var-get emotion-count))
          (mint-nft emotion-token (var-get emotion-count) emotion-name)
          (ok true)
        ))
  ))
;; Get emotion asset ID
(define-read-only (get-emotion-asset-id (emotion-name string))
  (ok (map-get? emotion-to-asset emotion-name))
)
;; Get total emotion count
(define-read-only (get-emotion-count)
  (ok (var-get emotion-count))
)
;; Admin functions
(define-public (set-mint-amount (amount uint))
  (begin
    (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
    (ok (var-set mint-amount amount))
  ))
(define-public (set-paused (status bool))
  (begin
    (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
    (ok (var-set paused status))
  ))
(define-public (emergency-pause)
  (begin
    (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
    (ok (var-set paused true))
  ))
