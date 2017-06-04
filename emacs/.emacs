(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)

; list the packages you want
(setq package-list '(use-package
                      dashboard
                      jbeans-theme
                      noctilux-theme
                      evil
                      evil-leader
                      neotree
                      linum
                      linum-relative
                      base16-theme
                      company
                      flycheck
                      company-quickhelp
                      js2-mode
                      js2-refactor
                      tern
                      company-tern
                      spaceline powerline))

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; General config
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq truncate-partial-width-windows t)
(set-language-environment "UTF-8")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-width 2)

(use-package company
  :init
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0)
  (setq company-tooltip-align-annotations t)
  (setq company-minimum-prefix-length 1)
  :config
  (company-mode t)
  (add-hook 'after-init-hook 'global-company-mode)
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle))

(use-package company-quickhelp
  :ensure company
  :config
  (company-quickhelp-mode 1))

(use-package dashboard
	:config
	(dashboard-setup-startup-hook))

(eval-when-compile
  (require 'use-package))

(use-package powerline
  :ensure t
  :demand t
  :init
  (setq powerline-height 20)
  (setq powerline-default-separator 'utf-8)
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme))

(use-package noctilux-theme
  :config
  (load-theme 'noctilux t))

(use-package evil
  :init
  (setq evil-shift-width 2)
  :config
  (evil-mode t))

(use-package evil-leader
    :ensure evil
	:config
	(global-evil-leader-mode t)
	(evil-leader/set-leader "<SPC>")
	(evil-leader/set-key
	"w l" 'windmove-right
	"w h" 'windmove-left
	"w q" 'evil-quit
	"w j" 'windmove-down
	"w k" 'windmove-up
	"b b" 'buffer-menu
	"w v" 'split-window-right
	"w b" 'split-window-below))

(use-package neotree
  :ensure evil-leader
	:init
	(setq neo-theme 'arrow)
	:config
	(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
	(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
	(evil-leader/set-key
	"b t" 'neotree-toggle))

(use-package linum
  :config
  (linum-mode t)
  (linum-on))

(use-package linum-relative
  :ensure linum
	:config
	(linum-relative-on)
	(global-linum-mode t)
	(column-number-mode t))

;; scrolling setuprn
(setq scroll-conservatively 10000)

;; font setup
(set-default-font "monospace 11")

(use-package js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
  (require 'js2-refactor)
  (add-hook 'js2-mode-hook #'js2-refactor-mode))

(use-package flycheck
  :init
  (setq-default flycheck-temp-prefix ".flycheck")
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (setq-default flycheck-disabled-checkers
    (append flycheck-disabled-checkers
      '(javascript-jshint)))
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (defun my/use-eslint-from-node-modules ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
          (eslint (and root
                        (expand-file-name "node_modules/eslint/bin/eslint.js"
                                          root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint))))
  (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules))



(use-package company-tern
  :ensure company
  :config
  (add-to-list 'company-backends 'company-tern))
 


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d5b121d69e48e0f2a84c8e4580f0ba230423391a78fcb4001ccb35d02494d79e" "5a39d2a29906ab273f7900a2ae843e9aa29ed5d205873e1199af4c9ec921aaab" default)))
 '(package-selected-packages
   (quote
    (company-quickhelp noctilux-theme jbeans-theme blackboard-theme spaceline base16-theme neotree auto-complete powerline linum-relative use-package clues-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
