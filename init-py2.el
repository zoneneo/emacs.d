;; .emacs.d/init.el
;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support

(require 'package)


(setq package-enable-at-startup nil)
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;(provide 'init)

(with-eval-after-load 'package (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/")))


;; Initializes the package infrastructure
(package-initialize)

(use-package elpy
  :init
  (elpy-enable)
  (advice-add 'python-mode :before 'elpy-enable)  
  (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
  :bind (
    :map elpy-mode-map
    ("<M-left>" . nil)
    ("<M-right>" . nil)
    ("<M-S-left>" . elpy-nav-indent-shift-left)
    ("<M-S-right>" . elpy-nav-indent-shift-right)
    ("M-." . elpy-goto-definition)
    ("M-," . pop-tag-mark))
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (setq elpy-rpc-backend "jedi"))

(use-package python
  :mode ("\\.py" . python-mode)
  :config
  (setq python-indent-offset 4)
  (elpy-enable))
  

(use-package pyenv-mode
  :init
  (add-to-list 'exec-path "~/envs")
  (setenv "WORKON_HOME" "~/envs/")
  :config
  (pyenv-mode)
  :bind
  ("C-x p e" . pyenv-activate-current-project))

(defun pyenv-activate-current-project ()
  "Automatically activates pyenv version if .python-version file exists."
  (interactive)
  (f-traverse-upwards
   (lambda (path)
     (message path)
     (let ((pyenv-version-path (f-expand ".python-version" path)))
       (if (f-exists? pyenv-version-path)
            (let ((pyenv-current-version (s-trim (f-read-text pyenv-version-path 'utf-8))))
              (pyenv-mode-set pyenv-current-version)
              (message (concat "Setting virtualenv to " pyenv-current-version))))))))



(defvar pyenv-current-version nil nil)

(defun pyenv-init()
  "Initialize pyenv's current version to the global one."
  (let ((global-pyenv (replace-regexp-in-string "\n" "" (shell-command-to-string "pyenv global"))))
    (message (concat "Setting pyenv version to " global-pyenv))
    (pyenv-mode-set global-pyenv)
    (setq pyenv-current-version global-pyenv)))

(add-hook 'after-init-hook 'pyenv-init)


(defun pyenv-activate-current-project ()
  "Automatically activates pyenv version if .python-version file exists."
  (interactive)
  (let ((python-version-directory (locate-dominating-file (buffer-file-name) ".python-version")))
    (if python-version-directory
        (let* ((pyenv-version-path (f-expand ".python-version" python-version-directory))
               (pyenv-current-version (s-trim (f-read-text pyenv-version-path 'utf-8))))
          (pyenv-mode-set pyenv-current-version)
          (message (concat "Setting virtualenv to " pyenv-current-version))))))
	  
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (pyenv-mode virtualenvwrapper use-package rust-mode rainbow-delimiters python-mode py-autopep8 material-theme magit golden-ratio flycheck elpygen elpy cargo better-defaults atom-one-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
