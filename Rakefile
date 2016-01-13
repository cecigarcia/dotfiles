home = ENV['HOME']
dotfiles = File.dirname(File.expand_path(__FILE__))

links = {
  '.config/fish/config.fish' => 'fish/config.fish',
  '.gitconfig' => 'git/gitconfig',
  '.hammerspoon/init.lua' => 'hammerspoon/init.lua',
  '.config/nvim/init.vim'  => 'nvim/init.vim',
  '.tmux.conf' => 'tmux/tmux.conf',
  '.tmuxinator/cica.yml' => 'tmuxinator/cica.yml',
  '.tmuxinator/cicaweb.yml' => 'tmuxinator/cicaweb.yml',
  '.tmuxinator/sai.yml' => 'tmuxinator/sai.yml'
}

desc "install dotfiles to home"
task :install do
  links.each do |dest, src|
    mkdir_p File.dirname(File.join(home,dest)) if dest.match /\//
    ln_s File.join(dotfiles, src), File.join(home, dest)
  end
end


desc "uninstall dotfiles from home"
task :uninstall do
  rm_f links.keys.map {|f| File.join home, f }
end

desc "reinstall dotfiles to home: uninstall + install"
task :reinstall => [:uninstall, :install]

task :default => :reinstall
