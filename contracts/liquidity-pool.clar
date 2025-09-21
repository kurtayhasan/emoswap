;; EmoSwap - Liquidity Pool Contract
;; Manages liquidity provision for emotion/ALGO pairs

(define-data-var admin principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
(define-data-var asset-id uint u0)
(define-data-var total-liquidity uint u0)
(define-data-var lp-token-supply uint u0)
(define-map liquidity-providers principal uint)
(define-map lp-tokens principal uint)
;; Error codes
(define-constant ERR-UNAUTHORIZED (err u300))
(define-constant ERR-INSUFFICIENT-LIQUIDITY (err u301))
(define-constant ERR-INVALID-AMOUNT (err u302))
(define-constant ERR-NOT-INITIALIZED (err u303))
;; Initialize pool
(define-public (initialize-pool (token-asset-id uint))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-UNAUTHORIZED)
    (asserts! (is-eq (var-get asset-id) u0) ERR-UNAUTHORIZED)
    (ok (var-set asset-id token-asset-id))
  ))
;; Add liquidity
(define-public (add-liquidity (algo-amount uint) (asset-amount uint))
  (let
    (
      (current-liquidity (var-get total-liquidity))
      (current-supply (var-get lp-token-supply))
    )
    (begin
      (asserts! (> algo-amount u0) ERR-INVALID-AMOUNT)
      (asserts! (> asset-amount u0) ERR-INVALID-AMOUNT)
      (asserts! (not (is-eq (var-get asset-id) u0)) ERR-NOT-INITIALIZED)
      
      (if (is-eq current-supply u0)
        ;; First liquidity provision
        (let
          (
            (liquidity-amount (+ algo-amount asset-amount))
            (lp-tokens liquidity-amount)
          )
          (ok (begin
            (var-set total-liquidity liquidity-amount)
            (var-set lp-token-supply lp-tokens)
            (map-set liquidity-providers (tx-sender) liquidity-amount)
            (map-set lp-tokens (tx-sender) lp-tokens)
            (ok true)
          ))
        )
        ;; Subsequent liquidity provision
        (let
          (
            (liquidity-amount (+ algo-amount asset-amount))
            (lp-tokens (/ (* liquidity-amount current-supply) current-liquidity))
          )
          (begin
            (asserts! (> lp-tokens u0) ERR-INSUFFICIENT-LIQUIDITY)
            (ok (begin
              (var-set total-liquidity (+ current-liquidity liquidity-amount))
              (var-set lp-token-supply (+ current-supply lp-tokens))
              (map-set liquidity-providers (tx-sender) (+ (default-to u0 (map-get? liquidity-providers (tx-sender))) liquidity-amount))
              (map-set lp-tokens (tx-sender) (+ (default-to u0 (map-get? lp-tokens (tx-sender))) lp-tokens))
              (ok true)
            ))
          )
        )
      )
    )
  ))
;; Remove liquidity
(define-public (remove-liquidity (lp-token-amount uint))
  (let
    (
      (current-liquidity (var-get total-liquidity))
      (current-supply (var-get lp-token-supply))
      (user-lp-tokens (default-to u0 (map-get? lp-tokens (tx-sender))))
    )
    (begin
      (asserts! (>= user-lp-tokens lp-token-amount) ERR-INSUFFICIENT-LIQUIDITY)
      (asserts! (> lp-token-amount u0) ERR-INVALID-AMOUNT)
      
      (let
        (
          (liquidity-share (/ (* lp-token-amount current-liquidity) current-supply))
          (algo-share (/ liquidity-share u2))
          (asset-share (/ liquidity-share u2))
        )
        (ok (begin
          (var-set total-liquidity (- current-liquidity liquidity-share))
          (var-set lp-token-supply (- current-supply lp-token-amount))
          (map-set liquidity-providers (tx-sender) (- (default-to u0 (map-get? liquidity-providers (tx-sender))) liquidity-share))
          (map-set lp-tokens (tx-sender) (- user-lp-tokens lp-token-amount))
          (ok true)
        ))
      )
    )
  ))
;; Get total liquidity
(define-read-only (get-total-liquidity)
  (ok (var-get total-liquidity))
)
;; Get LP token supply
(define-read-only (get-lp-token-supply)
  (ok (var-get lp-token-supply))
)
;; Get user LP tokens
(define-read-only (get-user-lp-tokens (user principal))
  (ok (default-to u0 (map-get? lp-tokens user)))
)
;; Get user liquidity
(define-read-only (get-user-liquidity (user principal))
  (ok (default-to u0 (map-get? liquidity-providers user)))
)
