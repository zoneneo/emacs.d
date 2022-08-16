(require 'init-elpa)
(require-package 'python-mode)
(require 'python-mode)

(use-package python
  :mode ("\\.py" . python-mode)
  :config
  (setq python-indent-soffset 4)
  (elpy-enable))

(use-package pyvenv
  :ensure t
  :config
  (setenv "WORKON_HOME" "~/envs")
  (setq python-shell-interpreter "python3")
  (pyvenv-mode t)
)

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
  (setq elpy-rpc-backend "jedi")
  )

(use-package flycheck
  :ensure t
  :defer t
  :init
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'elpy-mode-hook 'flycheck-mode)
  )

(use-package dap-python
  :defer t
  )


(provide 'init-python)
