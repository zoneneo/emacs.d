(require 'init-elpa)
(require-package 'python-mode)
(require 'python-mode)

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


;; Enable Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode);全局开启
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells)
(venv-initialize-eshell)
(setq venv-location "~/venv/");
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (virtualenvwrapper use-package rust-mode material-theme magit flycheck elpygen elpy cargo better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
