;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'default-frame-alist '(foreground-color . "white"))
(add-to-list 'default-frame-alist '(background-color . "dark slate gray"))
(add-to-list 'default-frame-alist '(cursor-color . "coral"))

;; Fonts
(set-face-attribute 'default nil
                    :family "Monospace"
                    :height 100
                    :weight 'normal
                    :width 'normal)

;; Disable toolbar
(tool-bar-mode -1)

;; Load my emacs packages
(setq load-path
      (cons (expand-file-name "~/emacs-packages") load-path))

;; If needed, set proxy to access internet
;; (setq url-proxy-services   '(
;;     ("http" . "<url>.com:911")
;;     ("https" . "<url>.com:912")))

;; Melpa package installer
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Clang Format
(require 'clang-format)
(defun clang-format-save-hook-for-this-buffer ()
  "Create a buffer local save hook."
  (add-hook 'before-save-hook
            (lambda ()
              (when (locate-dominating-file "." ".clang-format")
                (clang-format-buffer))
              ;; Continue to save.
              nil)
            nil
            ;; Buffer local hook.
            t))

;; Run this for each mode you want to use the hook.
(add-hook 'c-mode-hook (lambda () (clang-format-save-hook-for-this-buffer)))
(add-hook 'c++-mode-hook (lambda () (clang-format-save-hook-for-this-buffer)))

;; Magit shortcuts
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

;; Tramp
;; Works with PuTTy
(setq tramp-default-method "plink")
;; (require 'tramp-sh nil t)
;; (setq tramp-terminal-type "dumb")
;; (setf tramp-ssh-controlmaster-options (concat "-o SendEnv TRAMP=yes " tramp-ssh-controlmaster-options))


;; Shortcut to revert buffer without confirmation
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm))

(global-set-key (kbd "C-c r") 'revert-buffer-no-confirm)

;; List open buffers
(ido-mode 1)

;; turn on highlight matching brackets when cursor is on one
(show-paren-mode 1)

;; For traversing camelCase
(subword-mode 1)

;; disable auto-backup
(setq make-backup-files nil)

(add-to-list 'auto-mode-alist '("\\.cl\\'" . c++-mode))

(require 'llvm-mode)
(add-to-list 'auto-mode-alist '("\\.ll\\'" . llvm-mode))

(require 'mlir-mode)
(add-to-list 'auto-mode-alist '("\\.mlir\\'" . mlir-mode))

(require 'tablegen-mode)
(add-to-list 'auto-mode-alist '("\\.td\\'" . tablegen-mode))

(require 'cmake-mode)

(require 'yaml-mode)

(require 'protobuf-mode)
(add-to-list 'auto-mode-alist '("\\.pb\\'" . protobuf-mode))

;; Use Verilog syntax highlighting for .v.tmpl files
(add-to-list 'auto-mode-alist '("\\.v.tmpl\\'" . verilog-mode))

;; Tab align preprocess macros
(c-set-offset (quote cpp-macro) 0 nil)

;; Change alignment after open paranthesis in c/c++
(add-hook 'cc-mode-hook
          (lambda()
            (c-set-offset 'arglist-cont-nonempty '+)
            (c-set-offset 'arglist-intro '+)
            (c-set-offset 'arglist-close 0)))

(add-hook 'c++-mode-hook
          (lambda()
            (c-set-offset 'arglist-cont-nonempty '+)
            (c-set-offset 'arglist-intro '+)
            (c-set-offset 'arglist-close 0)))

;; Align of C++ class access labels
(c-set-offset 'access-label 1)

;; CSV files
(require 'csv-mode)
(add-to-list 'auto-mode-alist '("\\.csv\\'" . csv-mode))

;; disable startup msg
(setq inhibit-startup-message t)

;; NO TABS
(setq-default indent-tabs-mode nil)

;; Disable VC (version control) mode
;; Causes severe slow downs when opening files
(setq vc-handled-backends nil)

;; Python settings
(add-hook 'python-mode-hook '(lambda ()
                               (setq python-indent 4)))

;; Perl settings
;;(defalias 'perl-mode 'cperl-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package python-black clang-format haskell-mode magit ## zenburn-theme yasnippet undo-tree mic-paren hl-line+ highlight-symbol column-marker)))
 '(perl-close-paren-offset -2)
 '(perl-indent-level 2)
 '(ps-paper-type (quote a4))
 '(ps-print-color-p nil)
 '(show-paren-mode t nil (paren)))


;; The package is "python" but the mode is "python-mode":
(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode))

;; To run shell command
(global-set-key (kbd "M-q") 'shell-command)

;; To open a new terminal buffer
(global-set-key (kbd "C-c C-t") 'ansi-term)

;;(global-set-key (kbd "M-[") nil)
;;(global-set-key (kbd "C-[") nil)
;;(global-set-key (kbd "C-M-[") nil)

;; scrolling line-by-line
(global-set-key (quote [M-down]) (quote scroll-up-line))
(global-set-key (quote [M-up]) (quote scroll-down-line))

;; Show column number
(setq column-number-mode t)

;; Windmove
(global-set-key (quote [C-M-left])  (quote windmove-left))
(global-set-key (quote [C-M-right]) (quote windmove-right))
(global-set-key (quote [C-M-up])    (quote windmove-up))
(global-set-key (quote [C-M-down])  (quote windmove-down))

;; Resizing windows
(global-set-key (kbd "C-c C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-c C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-c C-<down>") 'shrink-window)
(global-set-key (kbd "C-c C-<up>") 'enlarge-window)

;; Winner Mode: restoring window configurations
(when (fboundp 'winner-mode)
  (winner-mode 1))

(require 'ws-trim)
;; Remove trailing whitespace when saving a file
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-ws-trim-mode t)


;; buffer-move
(require 'windmove)

;;;###autoload
(defun buf-move-up ()
  "Swap the current buffer and the buffer above the split.
If there is no split, ie now window above the current one, an
error is signaled."
  ;;  "Switches between the current buffer, and the buffer above the
  ;;  split, if possible."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'up))
         (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-down ()
  "Swap the current buffer and the buffer under the split.
If there is no split, ie now window under the current one, an
error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'down))
         (buf-this-buf (window-buffer (selected-window))))
    (if (or (null other-win)
            (string-match "^ \\*Minibuf" (buffer-name (window-buffer other-win))))
        (error "No window under this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-left ()
  "Swap the current buffer and the buffer on the left of the split.
If there is no split, ie now window on the left of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'left))
         (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No left split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-right ()
  "Swap the current buffer and the buffer on the right of the split.
If there is no split, ie now window on the right of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'right))
         (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No right split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))


(provide 'buffer-move)

(global-set-key (kbd "<M-S-up>")     'buf-move-up)
(global-set-key (kbd "<M-S-down>")   'buf-move-down)
(global-set-key (kbd "<M-S-left>")   'buf-move-left)
(global-set-key (kbd "<M-S-right>")  'buf-move-right)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Rename buffer
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(global-set-key (kbd "C-c f") 'rename-file-and-buffer)

;; Swap text
(defun swap-text (str1 str2 beg end)
  "Changes all STR1 to STR2 and all STR2 to STR1 in beg/end region."
  (interactive "sString A: \nsString B: \nr")
  (if mark-active
      (setq deactivate-mark t)
    (setq beg (point-min) end (point-max)))
  (goto-char beg)
  (while (re-search-forward
          (concat "\\(?:\\b\\(" (regexp-quote str1) "\\)\\|\\("
                  (regexp-quote str2) "\\)\\b\\)") end t)
    (if (match-string 1)
        (replace-match str2 t t)
      (replace-match str1 t t))))

;; ITERM2 MOUSE SUPPORT
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
  )

;; Copy-Paste to/from OSX
;;(defun copy-from-osx ()
;;  (shell-command-to-string "pbpaste"))
;;
;;(defun paste-to-osx (text &optional push)
;;  (let ((process-connection-type nil))
;;    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;      (process-send-string proc text)
;;      (process-send-eof proc))))
;;
;;(setq interprogram-cut-function 'paste-to-osx)
;;(setq interprogram-paste-function 'copy-from-osx)

;; Fix END key for Mac/iTerm2
(define-key input-decode-map "\e[4~" 'end-of-line)
(global-set-key (kbd "\e[4~") 'end-of-line)

;; Cycle between snake case, camel case, etc.
(require 'string-inflection)
(global-set-key (kbd "C-c i") 'string-inflection-cycle)
(global-set-key (kbd "C-c C") 'string-inflection-camelcase)        ;; Force to CamelCase
(global-set-key (kbd "C-c L") 'string-inflection-lower-camelcase)  ;; Force to lowerCamelCase
(global-set-key (kbd "C-c U") 'string-inflection-underscore)  ;; Force to under_score
(global-set-key (kbd "C-c A") 'string-inflection-upcase) ;; Force to CAPITAL_UNDER_SCORE
;;(global-set-key (kbd "C-c J") 'string-inflection-java-style-cycle) ;; Cycle through Java styles

;; Very large files
(require 'vlf-setup)
