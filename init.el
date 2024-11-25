(require 'org)
(let* ((conf-name "my-emacs.org")
       (conf (expand-file-name conf-name user-emacs-directory))
       (script (file-name-with-extension conf "el")))
  (if (or (not (file-exists-p script))
	  (file-newer-than-file-p conf script))
      (org-babel-tangle-file conf))
  (load-file script))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
