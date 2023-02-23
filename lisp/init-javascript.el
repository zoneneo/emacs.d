(require 'init-elpa)
(require 'js2-mode)

(use-package javascript
  :ensure t  
  :mode ("\\.js" . js2-mode)
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  (add-hook 'js2-mode-hook 'js2-minor-mode #'js2-imenu-extras-mode)
  :config
  (elpy-enable))

(provide 'init-javascript)
