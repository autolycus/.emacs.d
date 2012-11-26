


; Setup Color Theme 
; (require 'color-theme-install)

(require 'color-theme)
(load-file "~/.emacs.d/modified-tty-dark.el")
(color-theme-tty-dark-modified)
; (color-theme-tty-dark)
  
;(load-file "/usr/share/emacs/site-list/xcscope.el")
(require 'xcscope)

(require 'git)

; Set Tab stops 
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

; This will allow us to select a given 
; number of lines and then delete them. 
(delete-selection-mode 1)

; Setup the proper indentation method 
; that I like for C, C++ 

(defun c-code-setup-hook() 
  "Hook function to setup c style files"
  ; Setup some code folding keys 
  (local-set-key (kbd "C-c <right>") 'hs-show-block)
  (local-set-key (kbd "C-c <left>") 'hs-hide-block) 
  (local-set-key (kbd "C-c <up>") 'hs-hide-all)
  (local-set-key (kbd "C-c <down>") 'hs-show-all)
  (hs-minor-mode t)
  ; Setup cscope hotkeys 
  (local-set-key (kbd "C-c s s") 'cscope-find-this-symbol)
  (local-set-key (kbd "C-c s d") 'cscope-find-global-definition)
  (local-set-key (kbd "C-c s G") 'cscope-find-global-definition-no-prompting)
  (local-set-key (kbd "C-c s c") 'cscope-find-functions-calling-this-function)
  (local-set-key (kbd "C-c s C") 'cscope-find-called-functions)
  (local-set-key (kbd "C-c s t") 'cscope-find-this-text-string)
  (local-set-key (kbd "C-c s e") 'cscope-find-egrep-pattern) 
  (local-set-key (kbd "C-c s f") 'cscope-find-this-file) 
  (local-set-key (kbd "C-c s i") 'cscope-find-files-including-file)
  ; Setup appropriate tab configuration that I like 
  (setq c-default-style "linux")
  (setq c-basic-offset 2)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close '+)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'inline-close 0)
  
)


; Callback function that gets invoked on 
; all C files. 
(add-hook 'c-mode-common-hook 'c-code-setup-hook)

; Python Call backs 

(defun cja-python-cb() 
  "Callback that get invoked when a python file gets opened"
  ; I don't know why this doesn't work 
  (message "Starting Python!")
  (setq python-guess-indent nil)
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  (message "setting python indent")
  (setq python-indent 2)
  (setq python-indent-offset 2)
  ; Setup some code folding keys 
  (local-set-key (kbd "C-c <right>") 'hs-show-block)
  (local-set-key (kbd "C-c <left>") 'hs-hide-block) 
  (local-set-key (kbd "C-c <up>") 'hs-hide-all)
  (local-set-key (kbd "C-c <down>") 'hs-show-all)
  (hs-minor-mode t)
)

;(custom-set-variables '(python-guess-indent nil) '(python-indent 2))

(add-hook 'python-mode-hook 'cja-python-cb)


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

;(global-set-key (kbd "s-down") 'page-down) 
;(global-set-key (kbd "s-up") 'page-up)
(global-set-key (kbd "M-<left>") 'beginning-of-line) 
(global-set-key (kbd "M-<right>") 'end-of-line) 

; CEDET - code completion and such 

;(require 'cedet)
;(load-library 'cedet)
;(load-file "/usr
; (require 'cedet-common/cedet.el) 
;(global-ede-mode 1)
;(semantic-load-enable-code-helpers)

;(setq boost-base-dir "/usr/include/boost")
;(semantic-add-system-include boost-base-dir 'c++-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Templates 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-skeleton cja-cpp-header
  "CPP Header Skeleton"
  "\n"          ; Not sure why this \n is required but doesn't work otherwise
  "// -*- c++ -*- \n" 
  "/*! \\file \n"
  " *  \\author \n"
  " *  \\date \n"
  " * \n" 
  " *  \\description \n" 
  " *    \n"
  " *    \n"
  " * \\copyright <NAME> (C) 2012 - ALL RIGHTS RESERVED\n" 
  " */ " 
)
  
