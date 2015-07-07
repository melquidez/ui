;;; Main todos.
;; TODO: Magit.
;; TODO: Filesystem navigation, opening files, managing buffers etc.
;; TODO: Helm.
;; TODO: Terminal/eshell/zsh.
;; TODO: Pandoc mode.
;; TODO: Use use-package to lazy load packages.
;; TODO: Emmet.
;; TODO: Learn elisp.
;; TODO: Expand region.
;; TODO: Multiple cursors.
;; TODO: Flycheck.
;; TODO: Paredit.
;; TODO: MPD client.
;; TODO: Image viewer.
;; TODO: IRC.
;; TODO: Mail.
;; TODO: RSS.

;;; Lower priority todos.
;; TODO: Use evil-mode-like keybindings for pdf-view-mode.
;; TODO: Get "Completion List", `list-packages`, "Compile-log" buffers to use
;; evil mode bindings.
;; TODO: Remove right fringe in pdf-view-mode.
;; TODO: Bittorrent client.
;; TODO: Export color theme configuration to scheme specific file.
;; TODO: Statusbar colors and customisation.
;; TODO: Highlight TODOs.
;; TODO: Figure out how to show trailing newlines.

;;; Packages.
(setq evil-want-C-u-scroll t)
(setq evil-cross-lines t)
(setq evil-shift-width 2)

(add-hook 'python-mode-hook
  (function (lambda ()
    (setq evil-shift-width python-indent))))

(add-to-list 'load-path "~/etsi/el-get")
(require 'el-get)
(el-get-bundle tarao/el-get-lock)
(el-get-bundle! evil)
(el-get-bundle! evil-matchit)
(el-get-bundle! evil-nerd-commenter)
(el-get-bundle! evil-surround)
(el-get-bundle! fill-column-indicator)
(el-get-bundle! auto-complete)
(el-get-bundle! yasnippet)
(el-get-bundle pdf-tools)
(el-get-bundle startling/firebelly)
(setq el-get-lock-file "~/etsi/el-get.lock")

(require 'paren)
(require 'ibuffer)

(yas-global-mode t)
(setq ac-use-quick-help nil)

;;; Appearance.
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)
(set-face-italic-p 'italic nil)
(mapc
 (lambda (face)
   (set-face-attribute face nil :weight 'normal :underline nil))
 (face-list))

(global-hl-line-mode t)
(fringe-mode '(0 . nil))

;; Enables `gj` and `gk` etc. to move up and down visually wrapped lines.
(setq line-move-visual nil)

;; Visually wrap long lines at right window edge.
(global-visual-line-mode t)
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (visual-line-mode nil)))

;; These get disabled for whatever reason.
(setq-default visual-line-fringe-indicators t)

(setq-default fill-column 80)
(define-globalized-minor-mode my-global-fci-mode fci-mode turn-on-fci-mode)
(my-global-fci-mode t)

(global-whitespace-mode t)
(setq whitespace-style '(face tabs trailing))

(setq show-paren-delay 0)
(show-paren-mode t)

;; Ibuffer.
;; Use human readable Size column instead of original one.
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer formats.
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 18 18 :left :elide)
              " "
              (size-h 9 -1 :right)
              "  "
              (mode 16 16 :left :elide)
              " "
              filename-and-process)))

;; PDF Tools.
(pdf-tools-install)

;; Associate .pdf files with pdf-view-mode.
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

;;; Theme.
(add-to-list 'custom-theme-load-path "~/.emacs.d/el-get/firebelly")
(load-theme 'firebelly t)

;; Some themes may need the following method to load instead.
; (if (daemonp)
;     (add-hook 'after-make-frame-functions
;               (lambda (frame)
;               (select-frame frame)
;                 (load-theme 'sanityinc-tomorrow-night t)))
;     (load-theme 'sanityinc-tomorrow-night t))

(let
  ((c0 "#ac4142")
   (c1 "#d28445")
   (c2 "#f4bf75")
   (c3 "#90a959")
   (c4 "#75b5aa")
   (c5 "#6a9fb5")
   (c6 "#aa759f")
   (c7 "#8f5536")

   (g0 "#222222")
   (g1 "#292929")
   (g2 "#444444")
   (g3 "#555555")
   (g4 "#666666")
   (g5 "#777777")
   (g6 "#888888")
   (g7 "#999999"))

  (custom-set-faces
   `(cursor
     ((t (:background, c0))))
   `(font-lock-comment-delimiter-face
     ((t (:foreground, g2))))
   `(font-lock-string-face
     ((t (:background, g0))))
   `(font-lock-variable-name-face
     ((t (:foreground, c0))))
   `(fringe
     ((t (:background, g1))))
   `(hl-line
     ((t (:background, g1))))
   `(isearch
     ((t (:background, c2 :foreground, g0))))
   `(lazy-highlight
     ((t (:background, c5 :foreground, g0))))
   `(linum
     ((t (:background, g0 :foreground, g2))))
   `(show-paren-match
     ((t (:background, c5 :foreground, g0))))
   `(trailing-whitespace
     ((t (:background, c7))))
   `(vertical-border
     ((t (:background, g0))))
   `(whitespace-tab
     ((t (:background, c7))))
   `(whitespace-trailing
     ((t (:background, c7))))

   `(sh-quoted-exec
     ((t (:foreground, c4)))))

  (setq fci-rule-color g1))

;;; Basic.
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq require-final-newline t)

(setq-default auto-fill-function 'do-auto-fill)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(setq recenter-positions '(0.25))
(mouse-avoidance-mode 'banish)
(custom-set-variables
 '(mouse-avoidance-banish-position
   '((frame-or-window . frame)
     (side . right)
     (side-pos . 0)
     (top-or-bottom . bottom)
     (top-or-bottom-pos . 0))))

;;; Hooks.
(add-hook 'evil-visual-state-entry-hook
          (lambda () (setq-local global-hl-line-mode nil)))
(add-hook 'evil-visual-state-exit-hook
          (lambda () (setq-local global-hl-line-mode t)))

;;; Advice.
(defun my-previous-line-advice (&optional CURRENT-COMMAND)
  (evil-previous-line))

(advice-add 'evil-command-window-ex :after #'my-previous-line-advice)
(advice-add 'evil-command-window-search-forward :after #'my-previous-line-advice)

;;; Keybindings.
(defun my-minibuffer-keyboard-quit ()
  "Abort recursive edit.
  In Delete Selection mode, if the mark is active, just deactivate it;
  then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(defun my-exit-evil-command-window ()
  "Exit evil command window."
  (interactive)
  (other-window -1)
  (other-window 1)
  (kill-this-buffer)
  (evil-window-delete))

;; Escape quits emacs things as a vim user would expect.
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'my-minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'my-minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)
(evil-define-key 'normal evil-command-window-mode-map [escape] 'my-exit-evil-command-window)

;; Paves the way for "," to be used as 'leader'.
(define-key evil-normal-state-map "\\" 'evil-repeat-find-char-reverse)
(define-key evil-visual-state-map "\\" 'evil-repeat-find-char-reverse)

(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key evil-normal-state-map "H" 'evil-first-non-blank)
(define-key evil-visual-state-map "H" 'evil-first-non-blank)
(define-key evil-normal-state-map "L" 'evil-end-of-line)
(define-key evil-visual-state-map "L" 'evil-end-of-line)
(define-key evil-normal-state-map "M" 'evil-jump-item)
(define-key evil-operator-state-map "M" 'evil-jump-item)
(define-key evil-visual-state-map "M" 'evil-jump-item)

(defun my-evil-yank-to-end-of-line ()
  "Yank from cursor position to end of line."
  (interactive)
  (evil-yank (point) (point-at-eol)))

(define-key evil-normal-state-map [tab] 'evil-ex)
(define-key evil-visual-state-map [tab] 'evil-ex)
(define-key evil-normal-state-map "gs" 'evil-write)
(define-key evil-normal-state-map "Y" 'my-evil-yank-to-end-of-line)

(define-key evil-normal-state-map "gcc" 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map "gc" 'comment-or-uncomment-region)

(defun my-evil-edit-dot-emacs ()
  "Edit .emacs (or init.el) file."
  (interactive)
  (evil-edit "~/etsi/emacs/.emacs.d/init.el"))

(define-key evil-normal-state-map ",," 'evil-switch-to-windows-last-buffer)
(define-key evil-normal-state-map ",bd" 'kill-this-buffer)
(define-key evil-normal-state-map ",ee" 'my-evil-edit-dot-emacs)
(define-key evil-normal-state-map ",el" 'el-get-lock)
(define-key evil-normal-state-map ",f" 'fill-paragraph)
(define-key evil-visual-state-map ",f" 'fill-paragraph)
(define-key evil-normal-state-map ",l" 'ibuffer)
(define-key evil-normal-state-map ",q" 'evil-command-window-ex)
(define-key evil-visual-state-map ",q" 'evil-command-window-ex)
(define-key evil-normal-state-map ",we" 'balance-windows)
(define-key evil-normal-state-map ",wo" 'delete-other-windows)
(define-key evil-normal-state-map ",x" 'execute-extended-command)
(define-key evil-visual-state-map ",x" 'execute-extended-command)
(define-key evil-normal-state-map ",z" 'recenter-top-bottom)

(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(evil-define-key 'insert yas-minor-mode-map (kbd "C-s") 'yas-expand)
(evil-define-key 'insert yas-minor-mode-map (kbd "C-f") 'yas-next-field)

(eval-after-load 'auto-complete
  '(progn
     (define-key evil-insert-state-map (kbd "S-<iso-lefttab>") 'ac-previous)))

(eval-after-load 'ibuffer
  '(progn
     (evil-set-initial-state 'ibuffer-mode 'normal)
     (evil-define-key 'normal ibuffer-mode-map
       (kbd "0") 'digit-argument
       (kbd "1") 'digit-argument
       (kbd "2") 'digit-argument
       (kbd "3") 'digit-argument
       (kbd "4") 'digit-argument
       (kbd "5") 'digit-argument
       (kbd "6") 'digit-argument
       (kbd "7") 'digit-argument
       (kbd "8") 'digit-argument
       (kbd "9") 'digit-argument

       (kbd "m") 'ibuffer-mark-forward
       (kbd "t") 'ibuffer-toggle-marks
       (kbd "u") 'ibuffer-unmark-forward
       (kbd "=") 'ibuffer-diff-with-file
       (kbd "j") 'evil-next-line
       (kbd "J") 'ibuffer-jump-to-buffer
       (kbd "M-g") 'ibuffer-jump-to-buffer
       (kbd "M-s a C-s") 'ibuffer-do-isearch
       (kbd "M-s a M-C-s") 'ibuffer-do-isearch-regexp
       (kbd "M-s a C-o") 'ibuffer-do-occur
       (kbd "DEL") 'ibuffer-unmark-backward
       (kbd "M-DEL") 'ibuffer-unmark-all
       (kbd "* *") 'ibuffer-unmark-all
       (kbd "* M") 'ibuffer-mark-by-mode
       (kbd "* m") 'ibuffer-mark-modified-buffers
       (kbd "* u") 'ibuffer-mark-unsaved-buffers
       (kbd "* s") 'ibuffer-mark-special-buffers
       (kbd "* r") 'ibuffer-mark-read-only-buffers
       (kbd "* /") 'ibuffer-mark-dired-buffers
       (kbd "* e") 'ibuffer-mark-dissociated-buffers
       (kbd "* h") 'ibuffer-mark-help-buffers
       (kbd "* z") 'ibuffer-mark-compressed-file-buffers
       (kbd ".") 'ibuffer-mark-old-buffers

       (kbd "d") 'ibuffer-mark-for-delete
       (kbd "C-d") 'evil-scroll-down
       (kbd "k") 'evil-previous-line
       (kbd "x") 'ibuffer-do-kill-on-deletion-marks

       ;; Immediate operations.
       (kbd "n") 'ibuffer-forward-line
       (kbd "SPC") 'forward-line
       (kbd "p") 'ibuffer-backward-line
       (kbd "M-}") 'ibuffer-forward-next-marked
       (kbd "M-{") 'ibuffer-backwards-next-marked
       (kbd "l") 'ibuffer-visit-buffer
       (kbd "g") 'ibuffer-update
       "`" 'ibuffer-switch-format
       "-" 'ibuffer-add-to-tmp-hide
       "+" 'ibuffer-add-to-tmp-show
       "b" 'ibuffer-bury-buffer
       (kbd ",") 'ibuffer-toggle-sorting-mode
       (kbd "s i") 'ibuffer-invert-sorting
       (kbd "s a") 'ibuffer-do-sort-by-alphabetic
       (kbd "s v") 'ibuffer-do-sort-by-recency
       (kbd "s s") 'ibuffer-do-sort-by-size
       (kbd "s f") 'ibuffer-do-sort-by-filename/process
       (kbd "s m") 'ibuffer-do-sort-by-major-mode

       (kbd "/ m") 'ibuffer-filter-by-used-mode
       (kbd "/ M") 'ibuffer-filter-by-derived-mode
       (kbd "/ n") 'ibuffer-filter-by-name
       (kbd "/ c") 'ibuffer-filter-by-content
       (kbd "/ e") 'ibuffer-filter-by-predicate
       (kbd "/ f") 'ibuffer-filter-by-filename
       (kbd "/ >") 'ibuffer-filter-by-size-gt
       (kbd "/ <") 'ibuffer-filter-by-size-lt
       (kbd "/ r") 'ibuffer-switch-to-saved-filters
       (kbd "/ a") 'ibuffer-add-saved-filters
       (kbd "/ x") 'ibuffer-delete-saved-filters
       (kbd "/ d") 'ibuffer-decompose-filter
       (kbd "/ s") 'ibuffer-save-filters
       (kbd "/ p") 'ibuffer-pop-filter
       (kbd "/ !") 'ibuffer-negate-filter
       (kbd "/ t") 'ibuffer-exchange-filters
       (kbd "/ TAB") 'ibuffer-exchange-filters
       (kbd "/ o") 'ibuffer-or-filter
       (kbd "/ g") 'ibuffer-filters-to-filter-group
       (kbd "/ P") 'ibuffer-pop-filter-group
       (kbd "/ D") 'ibuffer-decompose-filter-group
       (kbd "/ /") 'ibuffer-filter-disable

       (kbd "M-n") 'ibuffer-forward-filter-group
       "\t" 'ibuffer-forward-filter-group
       (kbd "M-p") 'ibuffer-backward-filter-group
       [backtab] 'ibuffer-backward-filter-group
       (kbd "M-j") 'ibuffer-jump-to-filter-group
       (kbd "C-k") 'evil-window-up
       (kbd "C-y") 'ibuffer-yank
       (kbd "/ S") 'ibuffer-save-filter-groups
       (kbd "/ R") 'ibuffer-switch-to-saved-filter-groups
       (kbd "/ X") 'ibuffer-delete-saved-filter-groups
       (kbd "/ \\") 'ibuffer-clear-filter-groups

       [escape] 'ibuffer-quit
       (kbd "q") 'ibuffer-quit
       (kbd "h") 'describe-mode
       (kbd "?") 'describe-mode

       (kbd "% n") 'ibuffer-mark-by-name-regexp
       (kbd "% m") 'ibuffer-mark-by-mode-regexp
       (kbd "% f") 'ibuffer-mark-by-file-name-regexp

       (kbd "C-t") 'ibuffer-visit-tags-table

       (kbd "|") 'ibuffer-do-shell-command-pipe
       (kbd "!") 'ibuffer-do-shell-command-file
       (kbd "~") 'ibuffer-do-toggle-modified

       ;; Marked operations
       (kbd "A") 'ibuffer-do-view
       (kbd "D") 'ibuffer-do-delete
       (kbd "E") 'ibuffer-do-eval
       (kbd "F") 'ibuffer-do-shell-command-file
       (kbd "I") 'ibuffer-do-query-replace-regexp
       (kbd "H") 'evil-first-non-blank
       (kbd "N") 'ibuffer-do-shell-command-pipe-replace
       (kbd "M") 'evil-jump-item
       (kbd "O") 'ibuffer-do-occur
       (kbd "P") 'ibuffer-do-print
       (kbd "Q") 'ibuffer-do-query-replace
       (kbd "R") 'ibuffer-do-rename-uniquely
       (kbd "S") 'ibuffer-do-save
       (kbd "T") 'ibuffer-do-toggle-read-only
       (kbd "U") 'ibuffer-do-replace-regexp
       (kbd "V") 'ibuffer-do-revert
       (kbd "W") 'ibuffer-do-view-and-eval
       (kbd "X") 'ibuffer-do-shell-command-pipe

       ;; 'ibuffer-do-kill-lines is the function deleted here.
       (kbd "w") 'ibuffer-copy-filename-as-kill

       (kbd "RET") 'ibuffer-visit-buffer
       (kbd "e") 'ibuffer-visit-buffer
       (kbd "f") 'ibuffer-visit-buffer
       (kbd "C-x C-f") 'ibuffer-find-file
       (kbd "o") 'ibuffer-visit-buffer-other-window
       (kbd "C-o") 'ibuffer-visit-buffer-other-window-noselect
       (kbd "M-o") 'ibuffer-visit-buffer-1-window
       (kbd "v") 'ibuffer-do-view
       (kbd "C-x v") 'ibuffer-do-view-horizontally
       (kbd "C-c C-a") 'ibuffer-auto-mode
       (kbd "C-x 4 RET") 'ibuffer-visit-buffer-other-window
       (kbd "C-x 5 RET") 'ibuffer-visit-buffer-other-frame)))

;;; Leftover mode activation.
(evil-mode t)
(global-evil-surround-mode t)
(global-evil-matchit-mode t)
