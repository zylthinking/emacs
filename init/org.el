; 通过 use-package 直接安装 org 和 org-plus-contrib 会报错，故这里直接安装。
(dolist (package '(org org-plus-contrib ob-go ox-reveal))
   (unless (package-installed-p package)
       (package-install package)))

(use-package org
  :ensure org-plus-contrib
  :config
  (setq org-goto-auto-isearch nil)
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c b") 'org-switchb))

; 美化 org-mode 的 heading 和 list。
(use-package org-superstar
  :ensure
  :demand
  :after (org)
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

; 美化 TODO 和 printing。
(use-package org-fancy-priorities
  :ensure t
  :after (org)
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(use-package posframe :ensure t)
(use-package org-download
  :ensure t
  :demand t
  :after (posframe)
  :init
  ;; org 模式下，支持图片拖拽保存或 F2 保存剪贴板中的图片。
  (shell-command "pngpaste -v &>/dev/null || brew install pngpaste")
  :bind ("<f2>" . org-download-screenshot)
  :config
  (setq org-download-method 'directory)
  (setq-default org-download-image-dir "./images/")
  (setq org-download-display-inline-images 'posframe)
  (setq org-download-screenshot-method "pngpaste %s")
  (setq org-download-image-attr-list '("#+ATTR_HTML: :width 80% :align center"))
  (add-hook 'dired-mode-hook 'org-download-enable)
  (org-download-enable))

; org babel 中执行 go 代码片段。
(use-package ob-go
  :after (org)
  :config
  (org-babel-do-load-languages 'org-babel-load-languages '((go . t))))

(use-package ox-reveal :after (org))
