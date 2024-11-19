;;; Package Management

(setq package-archives
      '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
(require 'use-package-ensure)
(setq use-package-always-ensure t)


;;; Appearance

(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(menu-bar-mode -1)
(add-to-list 'default-frame-alist
	     '(font . "DejaVu Sans Mono-17"))


;;; Workspace
;; All actions towards a particular codebase are gatherred in
;; a project-based session. The meaning of project here follows
;; definition given by Emacs.

;; Emacs can not find the true root of project in case there are
;; submodules of submodules.
(require 'project)

(setq project-mode-line t)

(defun chu--stabilize-on (f v)
  (let ((new-v (funcall f v)))
    (if (equal new-v v)
	v
      (chu--stabilize-on f new-v))))

(defun chu--project-try-vc (tag-d)
  (project-try-vc (caddr tag-d)))
	
(defun chu--find-vc-root (d)
  (chu--stabilize-on 'chu--project-try-vc (project-try-vc d)))

(add-to-list 'project-find-functions 'chu--find-vc-root)

;; Emacs only supports constant paths to search for the desktop file.
;; So this is the most dynamic way I can use to specify search path.
;; The custom is to go to the root of the project, run Emacs, then
;; Emacs will create a new session or continue the previous session
;; saved in this directory.
(setq desktop-path '("."))
(desktop-save-mode 1)

;; Instead of editing multiple files at same time in different windows
;; of a frame, I preserve screen space for referencing when editing.
;; Multiple editings are seperated to different tabs.
(setq tab-bar-tab-hints t)
(setq tab-bar-select-tab-modifiers '(control))
(tab-bar-mode)


;; startup actions

(setq inhibit-startup-screen t)


;;; Miscellaneous

(setq dired-maybe-use-globstar t)
(setq dired-listing-switches "-ahl")
(setq dired-isearch-filenames t)


;; packages


(use-package python
  :custom
  (python-shell-interpreter "uv")
  (python-shell-interpreter-args "run -q python -i"))

(use-package eglot
  :custom (eglot-extend-to-xref t)
  :config
  (add-to-list 'eglot-server-programs '(python-mode . ("uv" "run" "ruff" "server")))
  :bind (:map eglot-mode-map
	      ("C-c h" . eldoc)
	      ("C-c f" . xref-find-definitions))
  :hook
  ((c-mode . eglot-ensure)
   (c++-mode . eglot-ensure)
   (python-mode . eglot-ensure)
   (lean4-mode . eglot-ensure)))

(use-package lean4-mode
  :vc (:url "https://github.com/leanprover/lean4-mode"
            :rev :newest))

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
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'xref--xref-buffer-mode 'emacs)
  (evil-set-initial-state 'help-mode 'emacs))

(use-package magit)

(use-package rime
  :custom
  (default-input-method "rime")
  (rime-disable-predicates
   '(rime-predicate-after-alphabet-char-p
     rime-predicate-prog-in-code-p)))


;; customization

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((lean4-mode :url "https://github.com/leanprover/lean4-mode")))
 '(warning-suppress-log-types '((python python-shell-prompt-regexp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
