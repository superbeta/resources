;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;;(setq inhibit-default-init t)

;;(setq warning-minimum-level :error)
(setq warning-suppress-types '((initialization )))

;; (defadvice display-warning
;;     (around no-warn-.emacs.d-in-load-path (type message &rest unused) activate)
;;   "Ignore the warning about the `.emacs.d' directory being in `load-path'."
;;   (unless (and (eq type 'initialization)
;;                (string-prefix-p "Your `load-path` seems to contain\nyour `.emacs.d` directory"
;;                                 message t))
;;     ad-do-it))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/") t)
(package-initialize)
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
  '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; Doesn't really add anything I want right now:
;; (add-to-list
;;  'load-path
;;  (expand-file-name "~/software/emacs/wordpress-mode/"))
;; (require 'wordpress-mode)

(require 'highlight)
(set-face-attribute 'highlight nil :background "DarkBlue")

(use-package ensime
  :ensure t
  :pin melpa-stable)

(global-auto-revert-mode)
(setq auto-revert-interval 3)

(setq desktop-path '("." "~/work/" "~/.emacs.d/"))
(desktop-save-mode 1)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

(if (and window-system (< (x-display-pixel-width) 2000))
    (progn
      (print (x-display-pixel-width))
      (print 'Laptop)
      (set-face-attribute 'default nil :height 88)
      (add-to-list 'default-frame-alist
		   (cons 'height 80)) )
  (print (x-display-pixel-width))
  (print 'Desktop)
  (set-face-attribute 'default nil :height 80)
  (add-to-list 'default-frame-alist
	       (cons 'height 80)))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq split-window-preferred-function 'display-buffer-use-some-frame)
(setq temp-buffer-resize-mode 0)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
(setq transient-mark-mode t)

(require 'cc-mode)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;; default to unified diffs
(setq diff-switches "-u")

(setq gdb-many-windows t)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (setq c-tab-always-indent nil)
	    (subword-mode 1)))
(normal-erase-is-backspace-mode t)

(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)
(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c i") 'indent-region)
(global-set-key (kbd "C-c b") 'compile)
(global-set-key (kbd "C-c r") 'recompile)
(global-set-key (kbd "C-c n") 'next-error)
(global-set-key (kbd "C-c e") 'eval-last-sexp)
(global-set-key (kbd "C-c h") 'highlight-regexp)
(global-set-key (kbd "S-<down>") 'scroll-other-window)
(global-set-key (kbd "S-<up>") 'scroll-other-window-down)
(global-set-key (kbd "C-x w p") 'toggle-window-dedicated)
(global-set-key (kbd "C-x c n") 'indium-debugger-step-over)
(global-set-key (kbd "C-x c i") 'indium-debugger-step-into)
(global-set-key (kbd "C-x c o") 'indium-debugger-step-out)
(global-set-key (kbd "C-x c c") 'indium-debugger-resume)
(global-set-key (kbd "C-x c r") 'indium-run-node)
(global-set-key (kbd "C-x c R") 'indium-restart-node)

(defun toggle-window-dedicated ()
(interactive)
(message 
 (if (let (window (get-buffer-window (current-buffer)))
       (set-window-dedicated-p window 
        (not (window-dedicated-p window))))
    "Window '%s' is dedicated"
    "Window '%s' is normal")
 (current-buffer)))


;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-default-style
   (quote
    ((c-mode . "ellemtel")
     (c++-mode . "ellemtel")
     (java-mode . "java")
     (other . "gnu"))))
 '(c-ignore-auto-fill (quote (string cpp code)))
 '(c-offsets-alist nil)

(defun p-php-mode-hook ()
  "PHP mode configuration."
  (setq indent-tabs-mode nil
        tab-width 4
        c-basic-offset 4))
(add-hook 'web-mode-hook 'p-php-mode-hook)
(add-hook 'php-mode-hook 'p-php-mode-hook)

(defun my-font-lock-mode-setup ()
  (when (equal major-mode 'web-mode) (setq font-lock-mode nil)))
(add-hook 'font-lock-mode-hook 'my-font-lock-mode-setup)

'(custom-safe-themes
   (quote
    ("a56a6bf2ecb2ce4fa79ba636d0a5cf81ad9320a988ec4e55441a16d66b0c10e0" "2e1e2657303116350fe764484e8300ca2e4cf45a73cdbd879bc0ca29cb337147" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "5e2dc1360a92bb73dafa11c46ba0f30fa5f49df887a8ede4e3533c3ab6270e08" "c158c2a9f1c5fcf27598d313eec9f9dceadf131ccd10abc6448004b14984767c" "6f11ad991da959fa8de046f7f8271b22d3a97ee7b6eca62c81d5a917790a45d9" "4182c491b5cc235ba5f27d3c1804fc9f11f51bf56fb6d961f94788be034179ad" "604648621aebec024d47c352b8e3411e63bdb384367c3dd2e8db39df81b475f5" "d6922c974e8a78378eacb01414183ce32bc8dbf2de78aabcc6ad8172547cb074" "551596f9165514c617c99ad6ce13196d6e7caa7035cea92a0e143dbe7b28be0e" "4e4d9f6e1f5b50805478c5630be80cce40bee4e640077e1a6a7c78490765b03f" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (ensime use-package php-mode web-mode green-phosphor-theme cider markdown-mode rjsx-mode indium spacemacs-theme madhat2r-theme cyberpunk-theme apropospriate-theme alect-themes rimero-theme rebecca-theme lush-theme flatui-dark-theme exotica-theme ample-theme doom-themes ample-zen-theme abyss-theme birds-of-paradise-plus-theme zerodark-theme twilight-anti-bright-theme sourcerer-theme spacegray-theme planet-theme seti-theme kooten-theme idea-darkula-theme green-is-the-new-black-theme dakrone-theme badwolf-theme atom-dark-theme afternoon-theme nyx-theme ein melpa-upstream-visit solidity-mode go-mode)))
 '(sr-speedbar-auto-refresh nil)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-skip-other-window-p t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
