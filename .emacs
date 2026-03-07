(require 'package)

(setq warning-minimum-level :error)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(defun my/ensure-package-installed (&rest packages)
  (dolist (pkg packages)
    (unless (package-installed-p pkg)
      (package-install pkg))))

(my/ensure-package-installed
 'ccls
 'clang-format
 'company
 'dockerfile-mode
 'gruber-darker-theme
 'haskell-mode
 'lsp-mode
 'lsp-tailwindcss
 'lsp-ui
 'magit
 'markdown-mode
 'rust-mode
 'svelte-mode
 'toml-mode
 'typescript-mode
 'yaml-mode)

;; Appearance

(column-number-mode 1)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)

(when (fboundp 'menu-bar-mode)
  (menu-bar-mode 0))

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode 0))

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode 0))

(load-theme 'gruber-darker t)

;; Autocompletion

(require 'company)
(global-company-mode 1)

;; C / C++

(setq c-default-style "linux")
(setq c-basic-offset 4)

(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)

;; Dockerfile

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; Font

(when (eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(font . "Iosevka-16")))

;; Git

(global-set-key (kbd "C-c g") 'magit-status)

;; Haskell

(require 'haskell-mode)
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))

;; LSP

(require 'lsp-mode)
(setq lsp-headerline-breadcrumb-enable nil)

(add-hook 'rust-mode-hook #'lsp)
(add-hook 'svelte-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)

;; Markdown

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Rust

(require 'rust-mode)

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(setq rust-format-on-save t)

(add-hook 'rust-mode-hook
          (lambda ()
            (setq lsp-rust-analyzer-cargo-watch-command "clippy")
            (setq lsp-rust-analyzer-cargo-watch-extra-args
                  ["--" "-D" "warnings"])))

;; Svelte

(require 'svelte-mode)
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . svelte-mode))

;; Tailwind

(require 'lsp-tailwindcss)

;; TOML

(require 'toml-mode)
(add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-mode))

;; TypeScript

(require 'typescript-mode)

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-mode))

;; YAML

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))

;; Assembly

(add-to-list 'auto-mode-alist '("\\.asm\\'" . asm-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . asm-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
