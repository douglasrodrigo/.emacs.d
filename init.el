(setq user-full-name "Douglas Rodrigo Ferreira")
(setq user-mail-address "douglasrodrigo@gmail.com")

(prefer-coding-system 'utf-8)

;; I keep my elisps in .emacs.d because the directory is already there
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(add-to-list 'load-path "~/.emacs.d/emacs-rails")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(add-to-list 'load-path "~/.emacs.d/rhtml")
(add-to-list 'load-path "~/.emacs.d/rinari")
(add-to-list 'load-path "~/.emacs.d/magit-0.7")
;(add-to-list 'load-path "~/.emacs.d/cedet-1.0pre6")

(load-file "~/.emacs.d/macros.el")

;; Lovely new hotkey commands
;;(global-set-key "\C-x\C-m" 'multi-term)
(global-set-key "\C-c\C-m" 'execute-extended-command)
;;(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key "\C-c\C-x\C-j" 'previous-buffer)
(global-set-key "\C-c\C-x\C-k" 'next-buffer)

;; Show colors on emacs shell window
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; F5 to refresh a file
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t))
(global-set-key [f5] 'refresh-file)

;; Remove all the unecessary gui stuff
;;(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; ido mode to interactively visit files and buffers
(require 'ido)
(ido-mode t)

;; Autoload rails mode and dependencies
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(autoload 'rhtml-mode "rhtml-mode" "Rhtml views rendered by rinari's rhtml" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.js\\'" . espresso-mode))
(autoload 'espresso-mode "espresso" nil t)

(require 'snippet)
(require 'find-recursive)
(require 'rails)

;; rinari
(require 'rinari)
(setq rinari-tags-file-name "TAGS")

;; rinari's rhtml mode
(require 'rhtml-erb)
(setq auto-mode-alist  (cons '(".rhtml$" . rhtml-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".html.erb$" . rhtml-mode) auto-mode-alist))

;; yaml mode
(require 'yaml-mode)
(setq auto-mode-alist  (cons '(".yml$" . yaml-mode) auto-mode-alist))

;; Put autosave files (ie #foo#) in one place, *not*
(defvar autosave-dir
 (concat "~/tmp/emacs_autosaves/" (user-login-name) "/"))
(make-directory autosave-dir t)
(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))
(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too.
(defvar backup-dir (concat "~/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; make emacs use the clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; prevent silly initial splash screen
(setq inhibit-splash-screen t)

;; initialize color themes
(require 'color-theme)
(color-theme-initialize)

;; favorite themes
;;(color-theme-dark-laptop)
;;(color-theme-charcoal-black)
;;(color-theme-gnome2)
(color-theme-custom)

;; ruby debug
(require 'rdebug)

;; delete trailing whitespaces on save
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(setq show-trailing-whitespace t)

(setq locale-coding-system 'latin-1)
(set-terminal-coding-system 'latin-1)
(set-keyboard-coding-system 'latin-1)
(set-selection-coding-system 'latin-1)
(prefer-coding-system 'latin-1)

;; multi-term
(require 'multi-term)
(setq multi-term-program "/bin/bash")
(put 'downcase-region 'disabled nil)

;; git
(require 'magit)

;; php mode
(require 'php-mode)

;; enable winner-mode
(winner-mode 1)

(add-to-list 'load-path "~/.emacs.d/scala")
(require 'scala-mode-auto)

;;auto-complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

;; After completion is started, operations in the following table will be enabled temporarily
;; TAB,  C-i 	ac-expand 	Completion by TAB
;; RET,  C-m 	ac-complete 	Completion by RET
;; down, M-n 	ac-next 	Select next candidate
;; up,   M-p 	ac-previous 	Select previous candidate
;; C-?,  f1 	ac-help 	Show buffer help
;; C-s
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(setq ac-menu-height 20)
;; that is a case that an user wants to complete without inserting any character or
;; a case not to start auto-complete-mode automatically by settings

(define-key ac-mode-map (kbd "M-1") 'auto-complete)
;;auto-complete

;;yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet-0.6.1c/snippets")

(setq yas/prompt-functions '( yas/dropdown-prompt yas/x-prompt  yas/ido-prompt yas/completing-prompt))
;;yasnippet


;;java-complete
(add-to-list 'ac-modes 'java-mode)


;;rvm
(require 'rvm)
(rvm-use-default)
;;rvm

;;(add-to-list 'auto-complete-mode 'interior-ruby-mode)

(defun lookup-google ()
  "Look up the word under cursor in google."
 (interactive)
 (let (myword myurl)
   (setq myword
         (if (and transient-mark-mode mark-active)
             (buffer-substring-no-properties (region-beginning) (region-end))
           (thing-at-point 'symbol)))

  (setq myword (replace-regexp-in-string " " "+" myword))
  (setq myurl (concat "http://www.google.com/search?q=" myword))
  (browse-url myurl)
   ))

(global-set-key "\C-c\C-s" 'lookup-google)

;;C-t transposition don't forget M-t two words
;; C-x C-t lines
