;; EmoSwap - Governance Contract
;; Manages protocol parameters and voting
(define-data-var admin principal 'STQTJN7JQ90K7B9TVBRWYC924HAXJD308VSA51X)
(define-constant VOTING-PERIOD (u10080)) ;; 1 week in blocks
(define-constant QUORUM-THRESHOLD (u5000)) ;; 50%
(define-data-var proposal-count uint u0)
(define-data-var voting-period uint VOTING-PERIOD)
(define-data-var quorum-threshold uint QUORUM-THRESHOLD)
(define-map proposals uint 
  (tuple 
    (proposer principal)
    (description (string-utf8 1000))
    (start-block uint)
    (end-block uint)
    (for-votes uint)
    (against-votes uint)
    (executed bool)
  )
)
(define-map votes (tuple (proposal-id uint) (voter principal)) bool)
(define-map voter-weights principal uint)
;; Error codes
(define-constant ERR-UNAUTHORIZED (err u500))
(define-constant ERR-PROPOSAL-NOT-FOUND (err u501))
(define-constant ERR-PROPOSAL-EXPIRED (err u502))
(define-constant ERR-ALREADY-VOTED (err u503))
(define-constant ERR-PROPOSAL-NOT-EXECUTABLE (err u504))
(define-constant ERR-INSUFFICIENT-VOTES (err u505))
;; Create proposal
(define-public (create-proposal (description (string-utf8 1000)))
  (let
    (
      (proposal-id (var-get proposal-count))
      (start-block (block-height))
      (end-block (+ start-block (var-get voting-period)))
    )
    (begin
      (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
      
      (ok (begin
        (map-set proposals proposal-id 
          (tuple 
            (proposer (tx-sender))
            (description description)
            (start-block start-block)
            (end-block end-block)
            (for-votes u0)
            (against-votes u0)
            (executed false)
          ))
        (var-set proposal-count (+ proposal-id u1))
        (ok proposal-id)
      ))
    )
  ))
;; Vote on proposal
(define-public (vote (proposal-id uint) (support bool))
  (let
    (
      (proposal (unwrap! (map-get? proposals proposal-id) ERR-PROPOSAL-NOT-FOUND))
      (current-block (block-height))
      (voter-weight (default-to u0 (map-get? voter-weights (tx-sender))))
      (has-voted (is-some (map-get? votes (tuple (proposal-id proposal-id) (voter (tx-sender))))))
    )
    (begin
      (asserts! (>= current-block (get start-block proposal)) ERR-PROPOSAL-NOT-FOUND)
      (asserts! (< current-block (get end-block proposal)) ERR-PROPOSAL-EXPIRED)
      (asserts! (not has-voted) ERR-ALREADY-VOTED)
      (asserts! (> voter-weight u0) ERR-INSUFFICIENT-VOTES)
      
      (ok (begin
        (map-set votes (tuple (proposal-id proposal-id) (voter (tx-sender))) support)
        
        (if support
          (map-set proposals proposal-id 
            (tuple 
              (proposer (get proposer proposal))
              (description (get description proposal))
              (start-block (get start-block proposal))
              (end-block (get end-block proposal))
              (for-votes (+ (get for-votes proposal) voter-weight))
              (against-votes (get against-votes proposal))
              (executed (get executed proposal))
            ))
          (map-set proposals proposal-id 
            (tuple 
              (proposer (get proposer proposal))
              (description (get description proposal))
              (start-block (get start-block proposal))
              (end-block (get end-block proposal))
              (for-votes (get for-votes proposal))
              (against-votes (+ (get against-votes proposal) voter-weight))
              (executed (get executed proposal))
            ))
        )
        (ok true)
      ))
    )
  ))
;; Execute proposal
(define-public (execute-proposal (proposal-id uint))
  (let
    (
      (proposal (unwrap! (map-get? proposals proposal-id) ERR-PROPOSAL-NOT-FOUND))
      (current-block (block-height))
      (total-votes (+ (get for-votes proposal) (get against-votes proposal)))
      (quorum-threshold (var-get quorum-threshold))
    )
    (begin
      (asserts! (>= current-block (get end-block proposal)) ERR-PROPOSAL-NOT-EXECUTABLE)
      (asserts! (not (get executed proposal)) ERR-PROPOSAL-NOT-EXECUTABLE)
      (asserts! (>= total-votes quorum-threshold) ERR-INSUFFICIENT-VOTES)
      (asserts! (> (get for-votes proposal) (get against-votes proposal)) ERR-INSUFFICIENT-VOTES)
      
      (ok (begin
        (map-set proposals proposal-id 
          (tuple 
            (proposer (get proposer proposal))
            (description (get description proposal))
            (start-block (get start-block proposal))
            (end-block (get end-block proposal))
            (for-votes (get for-votes proposal))
            (against-votes (get against-votes proposal))
            (executed true)
          ))
        (ok true)
      ))
    )
  ))
;; Get proposal
(define-read-only (get-proposal (proposal-id uint))
  (ok (map-get? proposals proposal-id))
)
;; Get proposal count
(define-read-only (get-proposal-count)
  (ok (var-get proposal-count))
)
;; Get voter weight
(define-read-only (get-voter-weight (voter principal))
  (ok (default-to u0 (map-get? voter-weights voter)))
)
;; Set voter weight (admin only)
(define-public (set-voter-weight (voter principal) (weight uint))
  (begin
    (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
    (ok (map-set voter-weights voter weight))
  ))
;; Set quorum threshold
(define-public (set-quorum-threshold (threshold uint))
  (begin
    (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
    (ok (var-set quorum-threshold threshold))
  ))
;; Set voting period
(define-public (set-voting-period (period uint))
  (begin
    (asserts! (is-eq (tx-sender) (var-get admin)) ERR-UNAUTHORIZED)
    (ok (var-set voting-period period))
  ))
