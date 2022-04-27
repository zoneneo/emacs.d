;; .emacs.d/init.el

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support

(require 'package)

;; Adds the Melpa archive to the list of available repositories

(when (>= emacs-major-version 24)
  (add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
  )

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

;(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(provide 'init)

(package-initialize)

;; ===================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message
(load-theme 'material t)            ;; Load material theme
(global-linum-mode t)               ;; Enable line numbers globally

;; User-Defined init.el ends here


(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))


;; ====================================
;; Development Setup
;; ====================================

(use-package elpy
  :ensure t
  :defer t
  :init
  (elpy-enable)
  (advice-add 'python-mode :before 'elpy-enable)
  :hook
  (elpy-mode . flycheck-mode) ;; 添加flycheck, 替换flymake
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  )

(use-package flycheck
  :ensure t
  :defer t
  :init
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  :hook
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'elpy-mode-hook 'flycheck-mode)
  )


(use-package virtualenvwrapper
  :init
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell)
  (setq venv-location "~/envs");
  (setq WORKON_HOME "~/envs/")
  )
