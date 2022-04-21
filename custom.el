(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-all-windows 'all-frames)
 '(exec-path
   '("/Users/pedroabelleiraseco/opt/bin" "/opt/homebrew/bin" "/opt/homebrew/sbin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Library/TeX/texbin" "/Library/Apple/usr/bin" "/opt/homebrew/Cellar/emacs-plus@28/28.0.50/libexec/emacs/28.0.90/aarch64-apple-darwin21.1.0"))
 '(package-selected-packages
   '(devdocs org-web-tools selectric-mode vertico org-ml web-server))
 '(safe-local-variable-values
   '((elisp-lint-indent-specs
      (describe . 1)
      (it . 1)
      (org-element-map . defun)
      (org-roam-with-temp-buffer . 1)
      (org-with-point-at . 1)
      (magit-insert-section . defun)
      (magit-section-case . 0)
      (->> . 1)
      (org-roam-with-file . 2))
     (elisp-lint-ignored-validators "byte-compile" "package-lint")
     (org-roam-db-location . "~/projects/taxud-kb/conf/org-roam.db")
     (org-roam-directory . "~/projects/taxud-kb/repo")))
 '(warning-suppress-types '((emacs))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Fix PATH when running from dock
(setenv "PATH" (s-join ":" exec-path))
