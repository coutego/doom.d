;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Pedro Abelleira Seco"
      user-mail-address "coutego@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Noto Mono" :size 12 :weight 'regular))
(setq-default line-spacing 0.3)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-opera-light)
;; (setq doom-theme 'doom-ephemeral)
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;; local added code

;; Anything in extra-packages gets loaded first. Useful for developing
;; packages
(add-to-list 'load-path "~/.doom.d/extra-packages/")

;;; Keyboard shorcuts useful for an Spacemacs expat

;; Double SPC is M-x
(map! :leader
      :desc "M-x" "SPC" #'counsel-M-x)

;; Same keybindings for expand-region than in SM
(map! :leader
      :desc "Expand selection" "v" #'er/expand-region)
(setq expand-region-contract-fast-key "V")

;; Make the ',' work as in SM (act as a "major mode leader").
(setq evil-snipe-override-evil-repeat-keys nil)
(setq doom-localleader-key ",")
(setq doom-localleader-alt-key "C-,")
(setq doom-leader-alt-key "C-SPC")

;; Avy configuration
(setq avy-all-windows 'all-frames)

;; Some extra keybindings
(map! :leader
      :desc "Goto word" "j a" #'avy-goto-word-1)

(map! :leader
      :desc "Change window" "w w" #'ace-window)

(map! :leader
      :desc "Next workspace" "TAB j" #'+workspace/switch-right)

(map! :leader
      :desc "Previous workspace" "TAB k" #'+workspace/switch-left)

(map! :leader
      :desc "Window resize/nav" "w e" #'+hydra/window-nav/body)

(map! :leader
      :desc "Other frame"
      "w f"
      #'other-frame)

(map! :nv "gc"    #'comment-or-uncomment-region)

;; Function and keybinding to open the current buffer in treemacs
(defun ctg/open-current-in-treemacs ()
  (interactive)
  (treemacs-find-file)
  (treemacs-select-window))

(map! :leader
      :desc "Find file in project sidebar and focus" "o o" #'ctg/open-current-in-treemacs)

;; Function and keybindings to open the current selected file
;; as a buffer and close treemeacs
(defun ctg/goto-file-and-close-treemacs()
  (interactive)
  (treemacs-RET-action)
  (+treemacs/toggle))

(map! :leader
      :desc "Open file and close treemacsin project sidebar and focus"
      "o c"
      #'ctg/goto-file-and-close-treemacs)

(map! :map (evil-treemacs-state-map treemacs-mode-map)
      "L"
      :desc "Open file and close treemacsin project sidebar and focus"
      #'ctg/goto-file-and-close-treemacs)

;; Functions + keybindings to reolace $ and ^ with
;; easier to type and more convenient alternatives
(defun ctg-evil-first-non-blank-or-zero ()
  (interactive)
  (let ((p (point))
        (pn))
    (evil-first-non-blank)
    (setq pn (point))
    (when (equal p pn)
      (evil-beginning-of-line))))

(map! :map evil-normal-state-map
      :desc "Move to first non blank character"
      "H"
      #'ctg-evil-first-non-blank-or-zero)

(defun ctg-evil-last-non-blank-or-end ()
  (interactive)
  (let ((p (point))
        (pn))
    (evil-last-non-blank)
    (setq pn (point))
    (when (equal p pn)
      (evil-end-of-line))))

(map! :map evil-normal-state-map
      :desc "Move to last non blank character"
      "L"
      #'ctg-evil-last-non-blank-or-end)

;;; Extra packages
;;; Packages used here must be included in packages.el
;;; (or come from a module in init.el )

(use-package! company
  :config
  (map! :map 'company-active-map
        "C-p"
        #'evil-complete-previous)
  (map! :map 'company-active-map
        "C-n"
        #'evil-complete-next))

(use-package! company-quickhelp
  :config
  (map! :leader
      :desc "Toggle company-quickhelp"
      "h E"
      #'company-quickhelp-mode)
  (when (display-graphic-p)
    (company-quickhelp-mode)))

(use-package! lsp-tailwindcss
  :init (setq lsp-tailwindcss-add-on-mode t))

(use-package org-ml)

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package! embark
  :bind
  (("C-;" . embark-act)
   ;("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package! ranger)

(use-package! 2048-game)
(use-package! xkcd
  :config
  (map! :leader
        "j f x"
        #'xkcd-get-latest))

(use-package! parinfer
  :bind
  (("C-," . parinfer-toggle-mode))
  :init
  (progn
    (setq parinfer-extensions
          '(defaults       ; should be included.
             pretty-parens  ; different paren styles for different modes.
             ;evil           ; If you use Evil.
             paredit        ; Introduce some paredit commands.
             smart-tab      ; C-b & C-f jump pos and smart shift with tab & S-tab.
             smart-yank))   ; Yank behavior depend on mode.
    (setq parinfer-auto-switch-indent-mode t)))
    ;; This are commented because of the 'evil-define-key' error when loading parinfer
    ;; (add-hook 'clojure-mode-hook #'parinfer-mode)
    ;; (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
    ;; (add-hook 'common-lisp-mode-hook #'parinfer-mode)
    ;; (add-hook 'scheme-mode-hook #'parinfer-mode)
    ;; (add-hook 'lisp-mode-hook #'parinfer-mode)))

(use-package! evil-string-inflection
  :after evil
  :config
  (map! :leader
        :desc "Cycle string case" "e c" #'string-inflection-all-cycle))

(use-package! ivy-prescient
  :after counsel
  :config
  (ivy-prescient-mode))

;(use-package! ox-tailwind)

(use-package! ts)

(use-package! ctg-win
  :after evil
  :config
  (map! :leader
        (:prefix
         ("j w" . "windows")
         :desc "Save window state" "s" #'ctg-win-save-window-state
         :desc "Restore window state" "r" #'ctg-win-restore-window-state
         :desc "Delete window state" "d" #'ctg-win-delete-window-state
         :desc "Toggle window split" "o" #'ctg-win-toggle-window-split)))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (progn
      (setq org-roam-ui-sync-theme t
            org-roam-ui-follow t
            org-roam-ui-update-on-save t
            org-roam-ui-open-on-start t)
      (setq org-roam-dailies-directory "journals/")
      (setq org-capture-templates
            '(("r" "Anti-procrastinate: quickly put down an idea" entry
               (file "~/org/roam/procrastination-pad.org")
               "* TODO %?\n  %i\n  %a")
              ("j" "Journal" entry (file+datetree "~/org/journal.org")
               "* %?\nEntered on %U\n  %i\n  %a")))
      (defun pas--open-procrastination-pad ()
        (interactive)
        (find-file (s-concat org-directory "roam/procrastination-pad.org")))
      (defun pas--add-todo-to-procrastination-pad ()
        (interactive)
        (org-capture t "r"))
      (map! :leader
        :desc "Open Procrastination Pad" "j h P" #'pas--open-procrastination-pad)
      (map! :leader
        :desc "Add to Procrastination Pad" "j h p" #'pas--add-todo-to-procrastination-pad)))

(use-package! org-web-tools
  :after org-roam
  :config
  (map! :leader
        :desc "Insert webpage link from clipboard" "j h i" #'org-web-tools-insert-link-for-url)
  (map! :leader
        :desc "Insert webpage contents from clipboard" "j h I" #'org-web-tools-insert-web-page-as-entry)
  (map! :leader
        :desc "Attach webpage contents from clipboard" "j h a" #'org-web-tools-archive-attach))

;; Load a local configuration file if it exists
(let* ((env-conf-file "~/.doom.d/my-env")
       (env (if (f-exists-p env-conf-file)
                (f-read-text env-conf-file)
              "default"))
       (env (s-trim env))
       (file (s-concat "~/.doom.d/my-" env ".el")))
  (condition-case err
      (progn
        (load file)
        (setq custom-file file)
        (message "Loaded local config from '%s'" file))
    (user-error "Error loading %s: %s" file err)))
