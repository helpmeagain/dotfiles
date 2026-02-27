# Dotfiles

<div>
  <a href="Arch Linux" alt="Arch Linux">
  <img src="https://img.shields.io/badge/-Arch%20Linux-1793D1?style=for-the-badge&logo=archlinux&logoColor=white" target="_blank"></a>
  
  <a href="https://helpmeagain.github.io/curriculum-vitae/" alt="Email">
  <img src="https://img.shields.io/badge/-hyprland-58E1FF?style=for-the-badge&logo=hyprland&logoColor=black" target="_blank"></a>
</div>

Dotfiles and docs for Arch Linux, Hyprland, Niri, Zsh and other tools. Built around my personal workflow.

## Docs

- [Arch Post Install](./docs/arch-post-install.md)
- [Packages and Other Configs](./docs/packages.md)

## Local installation

1. Clone the repository:

```bash
git clone <repository-url>
```

2. Navigate to the project directory:

```bash
cd <project-directory>
```

3. Install Stow:

```bash
sudo pacman -S stow
```

4. Create the symbolic links:

```bash
`stow -t ~ .`
```