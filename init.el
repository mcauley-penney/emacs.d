;; Guides
;; create your own theme: https://www.youtube.com/watch?v=kCCIudu53Zg

;; packages we are interested in:
;; 1. helpful
;; 2. all-the-icons

;; TODO:
;; 1. Show white space chars
;; 2. write config in Org with Org Babel
;;    - https://www.youtube.com/watch?v=kkqVTDbfYp4
;;    - wtf is tangling?
;; 3. design our own theme
;; 4. get notifications for org mode
;; 5. write a command to quickly save in M-x
;; 6. custom statusline
;; 7. show time somewhere?
;; 9. other package managers?
;; 10. avy = hop.nvim
;; Evil:
;;   3. inc and dec nums (use evil-numbers)

;; Goals for Friday
;; 1. move this to Org Mode
;; 2. set up avy
;; 2. Set up LSP
;; 3. Pick from list above


;; Settings
(setq inhibit-startup-message t)
(setq initial-buffer-choice "/home/m/.emacs.d/init.el")

;; UI
(set-fringe-mode 10)
(set-fringe-mode 10)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(setq-default indicate-empty-lines t)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)


(set-face-attribute 'default nil :font "Terminus-11")

(show-paren-mode 1)

;; maps
;; interesting configs:  https://github.com/mbriggs/.emacs.d-oldv2/blob/master/init/init-keymaps.el
(global-set-key (kbd "<escape>") 'keyboard-quit)
;;(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;;(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;;(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;;(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;;(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(require 'package)
(setq package-archives '(("elpa" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Unless use-package is already installed, install it
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Ensure that all packages used via use-package are ensured
(setq use-package-always-ensure t)

;; packages
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-show-paren-range 1)
  ;; TODO: we like this but need to make escape work for it
  ;; (setq evil-want-minibuffer t)
  (setq evil-insert-state-cursor '((bar . 1) "yellow")
	evil-normal-state-cursor '(box "yellow")
	evil-operator-state-cursor '((hbar . 1) "yellow"))


  :config
  (evil-mode 1)
  ;; defaults: https://github.com/emacs-evil/evil/blob/a941e89a8cdd743eeccc0eabb5b833f51bf51cd1/evil-maps.el
  ;; TODO: map these with a function, save some space

  ;; left
  (define-key evil-normal-state-map "s" 'evil-backward-char)
  (define-key evil-visual-state-map "s" 'evil-backward-char)
  (define-key evil-motion-state-map "s" 'evil-backward-char)

  ;; right
  (define-key evil-normal-state-map "t" 'evil-forward-char)
  (define-key evil-visual-state-map "t" 'evil-forward-char)
  (define-key evil-motion-state-map "t" 'evil-forward-char)

  ; replace 't' with 'l'
  (define-key evil-motion-state-map "l" 'evil-find-char-to)
  (define-key evil-motion-state-map "L" 'evil-find-char-to-backward)

  ;; down
  (define-key evil-normal-state-map "n" 'evil-next-visual-line)
  (define-key evil-visual-state-map "n" 'evil-next-visual-line)
  (define-key evil-motion-state-map "n" 'evil-next-visual-line)
  (define-key evil-normal-state-map "N" 'evil-join)

  ;; up
  (define-key evil-normal-state-map "e" 'evil-previous-visual-line)
  (define-key evil-visual-state-map "e" 'evil-previous-visual-line)
  (define-key evil-motion-state-map "e" 'evil-previous-visual-line)

  ;; other
  (define-key evil-normal-state-map (kbd "SPC") 'evil-append)
  (define-key evil-visual-state-map (kbd "SPC") 'evil-insert)
  (define-key evil-normal-state-map (kbd "RET") 'execute-extended-command)
  (define-key evil-visual-state-map (kbd "RET") 'execute-extended-command))

(use-package evil-goggles
  :ensure t
  :config

  (setq evil-goggles-enable-delete nil)
  (setq evil-goggles-enable-change nil)
  (setq evil-goggles-enable-join nil)

  (evil-goggles-mode)
  (evil-goggles-use-diff-faces))

(use-package org)


;; https://two-wrongs.com/centered-cursor-mode-in-vanilla-emacs
(setq scroll-preserve-screen-position t
      scroll-conservatively 0
      maximum-scroll-margin 0.5
      scroll-margin 99999) 

;; TODO: change to use-package
(require 'evil-replace-with-register)
(setq evil-replace-with-register-key (kbd "r"))
(evil-replace-with-register-install) 

;; just for now, until we 
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t))


;; At this link(https://stackoverflow.com/a/5058752), they discuss
;; this snippet:
;;  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;;  (load custom-file)
;;
;; Keep it in mind in case we need to do any including. It also explains
;; the custom-set-variables shit below

;; TODO: what is this?
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(avy evil-goggles doom-themes centered-cursor-mode evil-replace-with-register use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-change-face ((t (:inherit diff-removed))))
 '(evil-goggles-delete-face ((t (:inherit diff-removed))))
 '(evil-goggles-paste-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-add-face ((t (:inherit diff-added))))
 '(evil-goggles-undo-redo-change-face ((t (:inherit diff-changed))))
 '(evil-goggles-undo-redo-remove-face ((t (:inherit diff-removed))))
 '(evil-goggles-yank-face ((t (:inherit diff-changed)))))
