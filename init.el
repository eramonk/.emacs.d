(package-initialize)

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))

;;(package-refresh-contents)

;;(add-to-list 'load-path "~/elisp")
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

(display-time-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)

(use-package clojure-mode)

(use-package auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(use-package projectile)

(use-package cider)

(use-package ac-cider)
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(use-package better-defaults)

(use-package doom-themes)

(use-package nlinum)
(require 'nlinum)
(setq linum-format "%d")
(global-linum-mode 1)

(use-package paredit)
(add-hook 'clojure-mode-hook #'paredit-mode)

(use-package rainbow-delimiters)
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t) 
    (setq undo-tree-visualizer-diff t)))

(use-package neotree)
(require 'neotree)
(global-set-key [f3] 'neotree-toggle)

(use-package windmove
  :bind
  (("<f1> <right>" . windmove-right)
   ("<f1> <left>" . windmove-left)
   ("<f1> <up>" . windmove-up)
   ("<f1> <down>" . windmove-down)
   ))

(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))


(defvar my/refile-map (make-sparse-keymap))

(defmacro my/defshortcut (key file)
  `(progn
     (set-register ,key (cons 'file ,file))
     (define-key my/refile-map
       (char-to-string ,key)
       (lambda (prefix)
         (interactive "p")
         (let ((org-refile-targets '(((,file) :maxlevel . 6)))
               (current-prefix-arg (or current-prefix-arg '(4))))
           (call-interactively 'org-refile))))))


  (define-key my/refile-map "," 'my/org-refile-to-previous-in-file)

(my/defshortcut ?i "~/.emacs.d/init.el")
(my/defshortcut ?o "~/personal/organizer.org")
(my/defshortcut ?s "~/personal/sewing.org")
(my/defshortcut ?b "~/personal/business.org")
(my/defshortcut ?p "~/personal/google-inbox.org")
(my/defshortcut ?P "~/personal/google-ideas.org")
(my/defshortcut ?B "~/Dropbox/books")
(my/defshortcut ?e "~/code/emacs-notes/tasks.org")
(my/defshortcut ?w "~/Dropbox/public/sharing/index.org")
(my/defshortcut ?W "~/Dropbox/public/sharing/blog.org")
(my/defshortcut ?j "~/personal/journal.org")
(my/defshortcut ?I "~/Dropbox/Inbox")
(my/defshortcut ?g "~/sachac.github.io/evil-plans/index.org")
(my/defshortcut ?c "~/code/dev/elisp-course.org")
(my/defshortcut ?C "~/personal/calendar.org")
(my/defshortcut ?l "~/dropbox/public/sharing/learning.org")
(my/defshortcut ?q "~/personal/questions.org")


(require 'bs)
(setq bs-configurations
      '(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))

(global-set-key (kbd "<f2>") 'bs-show)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (doom-one)))
 '(custom-safe-themes
   (quote
    ("73e35ffa5ca98b57a9923954f296c3854ce6d8736b31fdbdda3d27502d4b4d69" "2e1d19424153d41462ad31144549efa41f55dacda9b76571f73904612b15fd0a" "a7e7804313dbf827a441c86a8109ef5b64b03011383322cbdbf646eb02692f76" "d0404bd38534a00ee72a4f887a987d6bff87f4cf8d8f85149e32849b262465a5" default)))
 '(fci-rule-color "#383a42")
 '(jdee-db-active-breakpoint-face-colors (cons "#f0f0f0" "#4078f2"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#f0f0f0" "#50a14f"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#f0f0f0" "#9ca0a4"))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   (quote
    (sr-speedbar smartscan guide-key undo-tree smart-mode-line smartparens nlinum doom-themes better-defaults cider clojure-mode auto-compile use-package)))
 '(vc-annotate-background "#f0f0f0")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50a14f")
    (cons 40 "#6c943f")
    (cons 60 "#79791f")
    (cons 80 "#986801")
    (cons 100 "#a16c1f")
    (cons 120 "#bc793f")
    (cons 140 "#da8548")
    (cons 160 "#c95a79")
    (cons 180 "#bc2d94")
    (cons 200 "#a626a4")
    (cons 220 "#bc1f94")
    (cons 240 "#c93f79")
    (cons 260 "#e45649")
    (cons 280 "#c86e6e")
    (cons 300 "#ba7e7e")
    (cons 320 "#ac8e8e")
    (cons 340 "#383a42")
    (cons 360 "#383a42")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
