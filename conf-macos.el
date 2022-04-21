;;; ../projects/emacs/doom.d/local.el -*- lexical-binding: t; -*-
;;;
(setq mac-command-modifier 'control)

(use-package! ctgtl)
(use-package! ctgwf)
(global-set-key (kbd "C-q") 'ctgwf-hydra-main/body)

(setq split-height-threshold nil)
(setq split-width-threshold 160)

;; TODO: add PATH (from customization file)
;; TODO: use this file for customization (or a local machine one?)
