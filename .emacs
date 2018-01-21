;; add package repos
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(add-to-list 'package-archives
	                  '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(package-initialize)

;; package installation
(unless (package-installed-p 'elpy)
  (package-install 'elpy))
(unless (package-installed-p 'cider)
  (package-install 'cider))
(unless (package-installed-p 'company)
  (package-install 'company))
(unless (package-installed-p 'company-jedi)
  (package-install 'company-jedi))
(unless (package-installed-p 'git-gutter)
  (package-install 'git-gutter))
(unless (package-installed-p 'smartparens)
  (package-install 'smartparens))
(unless (package-installed-p 'ac-cider)
  (package-install 'ac-cider))
(unless (package-installed-p 'rainbow-delimiters)
  (package-install 'rainbow-delimiters))
(unless (package-installed-p 'neotree)
  (package-install 'neotree))
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))
(unless (package-installed-p 'flycheck)
  (package-install flycheck))
(elpy-enable)


;; package requires
(require 'ac-cider)
(require 'smartparens-config)
(require 'yaml-mode)
(require 'neotree)
(require 'multiple-cursors)
(require 'web-mode)
(require 'cider)
(require 'rust-mode)
(require 'flycheck)

;; key bindings
(when (fboundp 'windmove-default-keybindings)
    (windmove-default-keybindings))
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "TAB") #'company-indent-or-complete-common)

;; global modes
(global-git-gutter-mode)
(global-company-mode)
(global-linum-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; hooks
(add-hook 'cider-mode-hook #'eldoc-mode)
(add-hook 'cider-repl-mode-hook #'eldoc-mode)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(add-hook 'cider-mode-hook 'smartparens-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-mode)
(add-hook 'elpy-mode 'smartparens-mode)
(add-hook 'elpy-mode #'rainbow-delimiters-mode)
(add-hook 'cider-mode-hook #'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)

;; misc
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)

(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)
(setq racer-cmd "/Users/micperez/.cargo/bin/racer")
(setq racer-rust-src-path "/usr/local/src/rust/src/")
(setq company-tooltip-align-annotations t)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-elm))
(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
(eval-after-load 'company
  '(push 'company-jedi company-backends))
(add-hook 'elm-mode-hook
          (lambda ()
            (setq company-backends '(company-elm))))

(with-eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))
(add-hook 'after-init-hook #'global-flycheck-mode)
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-elm))
(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
(add-hook 'elm-mode-hook
	  (lambda ()
	                (setq company-backends '(company-elm))))
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))
(setq exec-path (append exec-path '("/usr/local/bin")))
(setq linum-format "%4d \u2502 ")
(setq cider-cljs-lein-repl
            "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")
(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")


(defun cider-figwheel-repl ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
        (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/start-figwheel!) ; idempotent
             (figwheel-sidecar.repl-api/cljs-repl)")
	(cider-repl-return)))

(global-set-key (kbd "C-c C-f") #'cider-figwheel-repl)
