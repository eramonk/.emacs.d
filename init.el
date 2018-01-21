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

(use-package cider
  :config
   (eval-after-load 'clojure-mode
  '(progn
     (define-key clojure-mode-map (kbd "C-r j") #'cider-jack-in)
     (define-key clojure-mode-map (kbd "C-r M-J") #'cider-jack-in-clojurescript)
     (define-key clojure-mode-map (kbd "C-r M-c") #'cider-connect)))
   (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-r C-d") 'cider-doc-map)
    (define-key map (kbd "C-r ,")   'cider-test-commands-map)
    (define-key map (kbd "C-r C-t") 'cider-test-commands-map)
    (define-key map (kbd "M-.") #'cider-find-var)
    (define-key map (kbd "C-r C-.") #'cider-find-ns)
    (define-key map (kbd "C-r C-:") #'cider-find-keyword)
    (define-key map (kbd "M-,") #'cider-pop-back)
    (define-key map (kbd "C-r M-.") #'cider-find-resource)
    (define-key map (kbd "RET") #'cider-repl-return)
    (define-key map (kbd "TAB") #'cider-repl-tab)
    (define-key map (kbd "C-<return>") #'cider-repl-closing-return)
    (define-key map (kbd "C-j") #'cider-repl-newline-and-indent)
    (define-key map (kbd "C-r C-o") #'cider-repl-clear-output)
    (define-key map (kbd "C-r M-n") #'cider-repl-set-ns)
    (define-key map (kbd "C-r C-u") #'cider-repl-kill-input)
    (define-key map (kbd "C-S-a") #'cider-repl-bol-mark)
    (define-key map [S-home] #'cider-repl-bol-mark)
    (define-key map (kbd "C-<up>") #'cider-repl-backward-input)
    (define-key map (kbd "C-<down>") #'cider-repl-forward-input)
    (define-key map (kbd "M-p") #'cider-repl-previous-input)
    (define-key map (kbd "M-n") #'cider-repl-next-input)
    (define-key map (kbd "M-r") #'cider-repl-previous-matching-input)
    (define-key map (kbd "M-s") #'cider-repl-next-matching-input)
    (define-key map (kbd "C-r C-n") #'cider-repl-next-prompt)
    (define-key map (kbd "C-r C-p") #'cider-repl-previous-prompt)
    (define-key map (kbd "C-r C-b") #'cider-interrupt)
    (define-key map (kbd "C-r C-c") #'cider-interrupt)
    (define-key map (kbd "C-r C-m") #'cider-macroexpand-1)
    (define-key map (kbd "C-r M-m") #'cider-macroexpand-all)
    (define-key map (kbd "C-r C-z") #'cider-switch-to-last-clojure-buffer)
    (define-key map (kbd "C-r M-o") #'cider-repl-switch-to-other)
    (define-key map (kbd "C-r M-s") #'cider-selector)
    (define-key map (kbd "C-r M-d") #'cider-display-connection-info)
    (define-key map (kbd "C-r C-q") #'cider-quit)
    (define-key map (kbd "C-r M-i") #'cider-inspect)
    (define-key map (kbd "C-r M-p") #'cider-repl-history)
    (define-key map (kbd "C-r M-t v") #'cider-toggle-trace-var)
    (define-key map (kbd "C-r M-t n") #'cider-toggle-trace-ns)
    (define-key map (kbd "C-r C-x") #'cider-refresh)
    (define-key map (kbd "C-x C-e") #'cider-eval-last-sexp)
    (define-key map (kbd "C-r C-r") #'cider-eval-region)
    ))

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
(use-package solarized-theme)

(use-package nlinum)
(require 'nlinum)
(setq linum-format "%d ")
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
(my/defshortcut ?o "~/clojure/my-app/src/my_app/core.clj")
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
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (doom-spacegrey)))
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "77bddca0879cb3b0ecdf071d9635c818827c57d69164291cb27268ae324efa84" "3481e594ae6866d72c40ad77d86a1ffa338d01daa9eb0977e324f365cef4f47c" "6be42070d23e832a7493166f90e9bb08af348a818ec18389c1f21d33542771af" "554b7f0439155d6eb648d4837ef03902f51124cacee021217e76f39e9dd314c2" "0a3a41085c19d8121ed0ad3eb658a475ccb948a70a83604641ee7d4c3575a4d5" "73e35ffa5ca98b57a9923954f296c3854ce6d8736b31fdbdda3d27502d4b4d69" "2e1d19424153d41462ad31144549efa41f55dacda9b76571f73904612b15fd0a" "a7e7804313dbf827a441c86a8109ef5b64b03011383322cbdbf646eb02692f76" "d0404bd38534a00ee72a4f887a987d6bff87f4cf8d8f85149e32849b262465a5" default)))
 '(fci-rule-color "#383a42")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(jdee-db-active-breakpoint-face-colors (cons "#f0f0f0" "#4078f2"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#f0f0f0" "#50a14f"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#f0f0f0" "#9ca0a4"))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   (quote
    (solarized-theme sr-speedbar smartscan guide-key undo-tree smart-mode-line smartparens nlinum doom-themes better-defaults cider clojure-mode auto-compile use-package)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background "#f0f0f0")
 '(vc-annotate-background-mode nil)
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
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
