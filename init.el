;; package management

(setq package-archives
      '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
(require 'use-package-ensure)
(setq use-package-always-ensure t)


;; appearance

(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(menu-bar-mode -1)
(add-to-list 'default-frame-alist
	     '(font . "DejaVu Sans Mono-17"))


;; workspace

(setq desktop-path '("."))
(desktop-save-mode 1)

(setq tab-bar-tab-hints t)
(setq tab-bar-select-tab-modifiers '(control))
(tab-bar-mode)

(setq dired-maybe-use-globstar t)


;; startup actions

(setq inhibit-startup-screen t)


;; packages

(setq python-shell-interpreter "uv")
(setq python-shell-interpreter-args "run -q python -i")

(use-package eglot
  :custom (eglot-extend-to-xref t)
  :bind (:map eglot-mode-map
	      ("C-c h" . eldoc)
	      ("C-c f" . xref-find-definitions))
  :hook
  ((c-mode . eglot-ensure)))


(use-package helm
  :demand t
  :config
  (helm-mode 1)
  :bind
  (("M-x" . helm-M-x)
   ("C-x r b" . helm-filtered-bookmarks)
   ("C-x C-f" . helm-find-files)))

(use-package evil
  :demand t
  :config
  (evil-mode 1)
  (evil-set-initial-state 'Info-mode 'emacs)
  (evil-set-initial-state 'help-mode 'emacs))

(use-package magit)

(use-package rime
  :custom
  (default-input-method "rime")
  :config
  (setq rime-disable-predicates
	'(rime-predicate-after-alphabet-char-p
	  rime-predicate-prog-in-code-p)))


;; customization

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(warning-suppress-log-types '((python python-shell-prompt-regexp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
