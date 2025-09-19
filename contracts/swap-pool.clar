;; EmoSwap - Swap Pool Contract
;; Constant-product AMM for emotion/ALGO pairs

(define-constant ADMIN (tx-sender))
(define-constant FEE-DENOMINATOR (u10000))
(define-constant FEE-NUMERATOR (u30)) ;; 0.3% fee

(define-data-var asset-id uint u0)
(define-data-var algo-reserve uint u0)
(define-data-var asset-reserve uint u0)
(define-data-var total-supply uint u0)

(define-map balances principal uint)

;; Error codes
(define-constant ERR-UNAUTHORIZED (err u200))
(define-constant ERR-INSUFFICIENT-LIQUIDITY (err u201))
(define-constant ERR-INSUFFICIENT-BALANCE (err u202))
(define-constant ERR-INVALID-AMOUNT (err u203))
(define-constant ERR-SLIPPAGE (err u204))

;; Initialize pool
(define-public (initialize-pool (token-asset-id uint))
  (begin
    (asserts! (is-eq (tx-sender) ADMIN) ERR-UNAUTHORIZED)
    (asserts! (is-eq (var-get asset-id) u0) ERR-UNAUTHORIZED)
    (ok (var-set asset-id token-asset-id))
  ))

;; Add liquidity
(define-public (add-liquidity (algo-amount uint) (asset-amount uint))
  (let
    (
      (algo-reserve (var-get algo-reserve))
      (asset-reserve (var-get asset-reserve))
      (total-supply (var-get total-supply))
    )
    (begin
      (asserts! (> algo-amount u0) ERR-INVALID-AMOUNT)
      (asserts! (> asset-amount u0) ERR-INVALID-AMOUNT)
      
      (if (is-eq total-supply u0)
        ;; First liquidity provision
        (ok (begin
          (var-set algo-reserve algo-amount)
          (var-set asset-reserve asset-amount)
          (var-set total-supply u1000000) ;; 1M LP tokens
          (map-set balances (tx-sender) u1000000)
          (ok true)
        ))
        ;; Subsequent liquidity provision
        (let
          (
            (algo-shares (/ (* algo-amount total-supply) algo-reserve))
            (asset-shares (/ (* asset-amount total-supply) asset-reserve))
            (shares (if (< algo-shares asset-shares) algo-shares asset-shares))
          )
          (begin
            (asserts! (> shares u0) ERR-INSUFFICIENT-LIQUIDITY)
            (ok (begin
              (var-set algo-reserve (+ algo-reserve algo-amount))
              (var-set asset-reserve (+ asset-reserve asset-amount))
              (var-set total-supply (+ total-supply shares))
              (map-set balances (tx-sender) (+ (default-to u0 (map-get? balances (tx-sender))) shares))
              (ok true)
            ))
          )
        )
      )
    )
  ))

;; Remove liquidity
(define-public (remove-liquidity (shares uint))
  (let
    (
      (algo-reserve (var-get algo-reserve))
      (asset-reserve (var-get asset-reserve))
      (total-supply (var-get total-supply))
      (user-balance (default-to u0 (map-get? balances (tx-sender))))
    )
    (begin
      (asserts! (>= user-balance shares) ERR-INSUFFICIENT-BALANCE)
      (asserts! (> shares u0) ERR-INVALID-AMOUNT)
      
      (let
        (
          (algo-amount (/ (* shares algo-reserve) total-supply))
          (asset-amount (/ (* shares asset-reserve) total-supply))
        )
        (ok (begin
          (var-set algo-reserve (- algo-reserve algo-amount))
          (var-set asset-reserve (- asset-reserve asset-amount))
          (var-set total-supply (- total-supply shares))
          (map-set balances (tx-sender) (- user-balance shares))
          (ok true)
        ))
      )
    )
  ))

;; Swap ALGO for Asset
(define-public (swap-algo-for-asset (algo-amount uint) (min-asset-amount uint))
  (let
    (
      (algo-reserve (var-get algo-reserve))
      (asset-reserve (var-get asset-reserve))
      (fee-amount (/ (* algo-amount FEE-NUMERATOR) FEE-DENOMINATOR))
      (algo-amount-after-fee (- algo-amount fee-amount))
      (asset-amount-out (/ (* asset-reserve algo-amount-after-fee) (+ algo-reserve algo-amount-after-fee)))
    )
    (begin
      (asserts! (> algo-amount u0) ERR-INVALID-AMOUNT)
      (asserts! (>= asset-amount-out min-asset-amount) ERR-SLIPPAGE)
      (asserts! (> algo-reserve u0) ERR-INSUFFICIENT-LIQUIDITY)
      (asserts! (> asset-reserve u0) ERR-INSUFFICIENT-LIQUIDITY)
      
      (ok (begin
        (var-set algo-reserve (+ algo-reserve algo-amount))
        (var-set asset-reserve (- asset-reserve asset-amount-out))
        (ok true)
      ))
    )
  ))

;; Swap Asset for ALGO
(define-public (swap-asset-for-algo (asset-amount uint) (min-algo-amount uint))
  (let
    (
      (algo-reserve (var-get algo-reserve))
      (asset-reserve (var-get asset-reserve))
      (fee-amount (/ (* asset-amount FEE-NUMERATOR) FEE-DENOMINATOR))
      (asset-amount-after-fee (- asset-amount fee-amount))
      (algo-amount-out (/ (* algo-reserve asset-amount-after-fee) (+ asset-reserve asset-amount-after-fee)))
    )
    (begin
      (asserts! (> asset-amount u0) ERR-INVALID-AMOUNT)
      (asserts! (>= algo-amount-out min-algo-amount) ERR-SLIPPAGE)
      (asserts! (> algo-reserve u0) ERR-INSUFFICIENT-LIQUIDITY)
      (asserts! (> asset-reserve u0) ERR-INSUFFICIENT-LIQUIDITY)
      
      (ok (begin
        (var-set algo-reserve (- algo-reserve algo-amount-out))
        (var-set asset-reserve (+ asset-reserve asset-amount))
        (ok true)
      ))
    )
  ))

;; Get reserves
(define-read-only (get-reserves)
  (ok (tuple (algo-reserve (var-get algo-reserve)) (asset-reserve (var-get asset-reserve))))
)

;; Get user balance
(define-read-only (get-balance (user principal))
  (ok (default-to u0 (map-get? balances user)))
)
