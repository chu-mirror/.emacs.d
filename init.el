(require 'org)
(if (or (not (file-exists-p "my-emacs.el"))
	(file-newer-than-file-p "my-emacs.org" "my-emacs.el"))
    (org-babel-tangle-file "my-emacs.org"))
(load-file "my-emacs.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(eglot evil-org f flycheck helm ht jupyter lv magit markdown-mode
	   rime spinner)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
