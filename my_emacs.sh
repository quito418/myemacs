
#IDO-mode for file browsing 
cd /tmp
git clone https://github.com/nonsequitur/smex.git
git clone https://github.com/flymake/emacs-flymake.git

cd ~/.emacs.d/lisp && git clone https://github.com/joaotavora/yasnippet.git

mkdir -p ~/.emacs.d/lisp

cp /tmp/smex/*.el /tmp/emacs-flymake/*.el ~/.emacs.d/lisp

cat <<EOF >> ~/.emacs
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(ac-config-default)
(global-auto-complete-mode t)

;add load path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;ido config
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)
(ido-mode 1)

;YAsnippet
(add-to-list 'load-path
              "~/.emacs.d/lisp/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;smex config
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;flymake
(require 'flymake)
(setq flymake-max-parallel-syntax-checks 8)
(setq flymake-run-in-place nil)
;; This lets me say where my temp dir is.
(setq temporary-file-directory "~/.emacs.d/tmp/")
(setq flymake-number-of-errors-to-display nil)



;;electric pair
;; auto close bracket insertion. New in emacs 24
(electric-pair-mode 1)

EOF

emacs -e "(progn (package-initialize)(package-install 'auto-complete))"
