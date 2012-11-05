
; Solarized Color Schemes
;(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized")
;(require 'color-theme-solarized)

;(color-theme-solarized-dark)

(load-file "~/.emacs.d/modified-tty-dark.el")
(color-theme-tty-dark-modified)
; (color-theme-tty-dark)

;(load-file "~/.emacs.d/dark-emacs-theme.el")

; Set Tab stops 
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

; This will allow us to select a given 
; number of lines and then delete them. 
(delete-selection-mode 1)

; Setup the proper indentation method 
; that I like.

(defun c-code-setup-hook() 
  "Hook function to setup c style files"
  (setq c-default-style "linux")
  (setq c-basic-offset 2)
)

(add-hook 'c-mode-common-hook 'c-code-setup-hook)

;(c-set-offset 'substatement-open 0)
;(c-set-offset 'substatement-intro 0)

;; (defun my-c-code-common-hook() 
;;   " Invoked whenever we are starting a C/ C++ file " 
;;   (setq c-default-style "linux")
;;   (setq c-basic-offset 2) 

;;   (setq c++-tab-always-indent t) 
;;  )

;;(add-hook 'c-mode-common-hook 'my-c-code-common-hook)

(defun remove-indents-region()
  " Remove TAB-WIDTH spaces from the beginning of a set of lines 
    defined by the current region 
  "

  (interactive) 
  (setq start (region-beginning))
  (setq end (region-end))
  (save-excursion
    (goto-char start)
    (while (< (point) end)
      (if (and (< (current-indentation) tab-width)
            (not (looking-at "[ \t]*$")))
        (error "Can't Shift all lines enough!"))
      (forward-line)) 
    (indent-rigidly start end (- tab-width))))


(defun remove-indents() 
  " Remove TAB-WIDTH spaces fromt he beginning of this line or if 
    we are currently selecting a region we will tab shift the 
    entire line. 
  " 
  (interactive) 
  (setq start 0)
  (setq end 0) 
  (setq count tab-width) 
  (if mark-active
      (remove-indents-region)   ; Active Region 
    ; Non-Active Region 
    (indent-rigidly (line-beginning-position) (line-end-position) (- tab-width))
  )
)


(global-set-key (kbd "<backtab>") 'remove-indents)

(global-set-key (kbd "C-c g") 'goto-line)

(setq mac-command-modifier 'meta)
; (setq mac-command-key-is-meta t)