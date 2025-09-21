;; EmoSwap - Staking Rewards Contract
;; Manages LP token staking and $MOOD token rewards

(define-data-var admin principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

(define-constant EMISSION-RATE (u100)) ;; 100 MOOD per block
(define-constant REWARD-DENOMINATOR (u1000000))
(define-data-var total-staked uint u0)
(define-data-var emission-rate uint EMISSION-RATE)
(define-data-var last-reward-block uint u0)
(define-data-var reward-per-token-stored uint u0)
(define-map staked-balances principal uint)
(define-map user-reward-per-token-paid principal uint)
(define-map rewards principal uint)
;; Error codes
(define-constant ERR-UNAUTHORIZED (err u400))
(define-constant ERR-INSUFFICIENT-BALANCE (err u401))
(define-constant ERR-INVALID-AMOUNT (err u402))
(define-constant ERR-NO-REWARDS (err u403))
;; Stake LP tokens
(define-public (stake (amount uint))
  (let
    (
      (current-reward-per-token (get-reward-per-token))
      (user-staked (default-to u0 (map-get? staked-balances (tx-sender))))
    )
    (begin
      (asserts! (> amount u0) ERR-INVALID-AMOUNT)
      
      (ok (begin
        ;; Update user rewards
        (if (> user-staked u0)
          (map-set rewards (tx-sender) (+ (default-to u0 (map-get? rewards (tx-sender))) 
            (* user-staked (- current-reward-per-token (default-to u0 (map-get? user-reward-per-token-paid (tx-sender)))))))
        )
        
        ;; Update user staked balance
        (map-set staked-balances (tx-sender) (+ user-staked amount))
        (map-set user-reward-per-token-paid (tx-sender) current-reward-per-token)
        
        ;; Update total staked
        (var-set total-staked (+ (var-get total-staked) amount))
        
        (ok true)
      ))
    )
  ))
;; Unstake LP tokens
(define-public (unstake (amount uint))
  (let
    (
      (current-reward-per-token (get-reward-per-token))
      (user-staked (default-to u0 (map-get? staked-balances (tx-sender))))
    )
    (begin
      (asserts! (>= user-staked amount) ERR-INSUFFICIENT-BALANCE)
      (asserts! (> amount u0) ERR-INVALID-AMOUNT)
      
      (ok (begin
        ;; Update user rewards
        (map-set rewards (tx-sender) (+ (default-to u0 (map-get? rewards (tx-sender))) 
          (* user-staked (- current-reward-per-token (default-to u0 (map-get? user-reward-per-token-paid (tx-sender)))))))
        
        ;; Update user staked balance
        (map-set staked-balances (tx-sender) (- user-staked amount))
        (map-set user-reward-per-token-paid (tx-sender) current-reward-per-token)
        
        ;; Update total staked
        (var-set total-staked (- (var-get total-staked) amount))
        
        (ok true)
      ))
    )
  ))
;; Claim rewards
(define-public (claim-rewards)
  (let
    (
      (current-reward-per-token (get-reward-per-token))
      (user-staked (default-to u0 (map-get? staked-balances (tx-sender))))
      (pending-rewards (+ (default-to u0 (map-get? rewards (tx-sender))) 
        (* user-staked (- current-reward-per-token (default-to u0 (map-get? user-reward-per-token-paid (tx-sender)))))))
    )
    (begin
      (asserts! (> pending-rewards u0) ERR-NO-REWARDS)
      
      (ok (begin
        (map-set rewards (tx-sender) u0)
        (map-set user-reward-per-token-paid (tx-sender) current-reward-per-token)
        (ok true)
      ))
    )
  ))
;; Get reward per token
(define-read-only (get-reward-per-token)
  (let
    (
      (total-staked (var-get total-staked))
      (last-block (var-get last-reward-block))
      (current-block (block-height))
    )
    (if (is-eq total-staked u0)
      (var-get reward-per-token-stored)
      (+ (var-get reward-per-token-stored) 
        (/ (* (var-get emission-rate) (- current-block last-block)) total-staked))
    )
  ))
;; Get user pending rewards
(define-read-only (get-pending-rewards (user principal))
  (let
    (
      (current-reward-per-token (get-reward-per-token))
      (user-staked (default-to u0 (map-get? staked-balances user)))
    )
    (+ (default-to u0 (map-get? rewards user)) 
      (* user-staked (- current-reward-per-token (default-to u0 (map-get? user-reward-per-token-paid user)))))
  ))
;; Get user staked balance
(define-read-only (get-staked-balance (user principal))
  (ok (default-to u0 (map-get? staked-balances user)))
)
;; Get total staked
(define-read-only (get-total-staked)
  (ok (var-get total-staked))
)
;; Admin functions
(define-public (set-emission-rate (rate uint))
  (begin
    (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
    (ok (var-set emission-rate rate))
  ))
(define-public (update-reward-per-token)
  (begin
    (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
    (ok (begin
      (var-set reward-per-token-stored (get-reward-per-token))
      (var-set last-reward-block (block-height))
      (ok true)
    ))
  ))
