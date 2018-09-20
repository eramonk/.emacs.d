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

(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(global-set-key [f11] 'toggle-fullscreen)
;;подсветка строки с курсором
(global-hl-line-mode 1)
;;
(iswitchb-mode 1)
;;переключение буферов
;;(global-set-key [?\C-,] 'previous-buffer)
;;(global-set-key [?\C-.] 'next-buffer)
;;сохранение сессии
(desktop-save-mode 1)

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
;;(global-linum-mode 1)
;;(setq linum-format "%d ")

(global-set-key [C-down] (lambda () (interactive) (scroll-up 1)))
(global-set-key [C-up] (lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "<f2>") 'bs-show)

(use-package clojure-mode)

(use-package auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(use-package projectile)

(use-package idea-darkula-theme)
(push (substitute-in-file-name "~/.emacs.d/idea-darkula-theme/") custom-theme-load-path)
(load-theme 'idea-darkula t)

(use-package intellij-theme :ensure t)

;; it will not affect your main font, set independently e.g.
(add-to-list 'default-frame-alist '(font . "Hack-12"))


(use-package ac-cider)
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(require 'cider)

(defadvice 4clojure-open-question (around 4clojure-open-question-around)
  "Start a cider/nREPL connection if one hasn't already been started when
opening 4clojure questions"
  ad-do-it
  (unless cider-current-clojure-buffer
    (cider-jack-in)))

(use-package better-defaults)
(use-package smooth-scrolling)
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 5)

;;(use-package doom-themes)
;;(use-package solarized-theme)

(use-package cider
  :config
   (eval-after-load 'clojure-mode
  '(progn
     (define-key clojure-mode-map (kbd "C-c j") #'cider-jack-in)
     (define-key clojure-mode-map (kbd "C-c M-J") #'cider-jack-in-clojurescript)
     (define-key clojure-mode-map (kbd "C-c M-c") #'cider-connect))))


;; (use-package nlinum)
;; (require 'nlinum)
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

;;Window resize
(require 'bs)
(setq bs-configurations
      '(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))

(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the
middle"
  (let* ((win-edges (window-edges))
	 (this-window-y-min (nth 1 win-edges))
	 (this-window-y-max (nth 3 win-edges))
	 (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the
middle"
  (let* ((win-edges (window-edges))
	 (this-window-x-min (nth 0 win-edges))
	 (this-window-x-max (nth 2 win-edges))
	 (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
   (t (message "nil"))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
   (t (message "nil"))))

(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -1))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 1))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -1))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 1))))

(global-set-key [M-down] 'win-resize-minimize-vert)
(global-set-key [M-up] 'win-resize-enlarge-vert)
(global-set-key [M-left] 'win-resize-minimize-horiz)
(global-set-key [M-right] 'win-resize-enlarge-horiz)
(global-set-key [M-up] 'win-resize-enlarge-horiz)
(global-set-key [M-down] 'win-resize-minimize-horiz)
(global-set-key [M-left] 'win-resize-enlarge-vert)
(global-set-key [M-right] 'win-resize-minimize-vert)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-mode t nil (cua-base))
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (idea-darkula)))
 '(custom-safe-themes
   (quote
    ("420689cc31d01fe04b8e3adef87b8838ff52faa169e69ca4e863143ae9f3a9f9" "a63355b90843b228925ce8b96f88c587087c3ee4f428838716505fd01cf741c8" "82b67c7e21c3b12be7b569af7c84ec0fb2d62105629a173e2479e1053cff94bd" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "77bddca0879cb3b0ecdf071d9635c818827c57d69164291cb27268ae324efa84" "3481e594ae6866d72c40ad77d86a1ffa338d01daa9eb0977e324f365cef4f47c" "6be42070d23e832a7493166f90e9bb08af348a818ec18389c1f21d33542771af" "554b7f0439155d6eb648d4837ef03902f51124cacee021217e76f39e9dd314c2" "0a3a41085c19d8121ed0ad3eb658a475ccb948a70a83604641ee7d4c3575a4d5" "73e35ffa5ca98b57a9923954f296c3854ce6d8736b31fdbdda3d27502d4b4d69" "2e1d19424153d41462ad31144549efa41f55dacda9b76571f73904612b15fd0a" "a7e7804313dbf827a441c86a8109ef5b64b03011383322cbdbf646eb02692f76" "d0404bd38534a00ee72a4f887a987d6bff87f4cf8d8f85149e32849b262465a5" default)))
 '(display-time-mode t)
 '(ensime-sem-high-faces
   (quote
    ((var :foreground "#000000" :underline
          (:style wave :color "yellow"))
     (val :foreground "#000000")
     (varField :foreground "#600e7a" :slant italic)
     (valField :foreground "#600e7a" :slant italic)
     (functionCall :foreground "#000000" :slant italic)
     (implicitConversion :underline
                         (:color "#c0c0c0"))
     (implicitParams :underline
                     (:color "#c0c0c0"))
     (operator :foreground "#000080")
     (param :foreground "#000000")
     (class :foreground "#20999d")
     (trait :foreground "#20999d" :slant italic)
     (object :foreground "#5974ab" :slant italic)
     (package :foreground "#000000")
     (deprecated :strike-through "#000000"))))
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
 '(menu-bar-mode nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   (quote
    (## 4clojure solarized-theme sr-speedbar smartscan guide-key undo-tree smart-mode-line smartparens nlinum doom-themes better-defaults cider clojure-mode auto-compile use-package)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tool-bar-mode nil)
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
 '(default ((t (:family "Input Mono" :foundry "FBI " :slant normal :weight normal :height 120 :width normal))))
 '(rainbow-delimiters-base-face ((t (:inherit nil))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "dark slate gray"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "dodger blue"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "red"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "lime green"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "medium purple"))))
 '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :foreground "violet"))))
 '(rainbow-delimiters-depth-7-face ((t (:inherit rainbow-delimiters-base-face :foreground "tan1"))))
 '(rainbow-delimiters-depth-8-face ((t (:inherit rainbow-delimiters-base-face :foreground "DeepPink2"))))
 '(rainbow-delimiters-depth-9-face ((t (:inherit rainbow-delimiters-base-face :foreground "RoyalBlue1")))))
