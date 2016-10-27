# Setting up https://github.com/junegunn/fzf
class fzf {
    $shell_home = '/home/vagrant'
    $shell_user = 'vagrant'

    # git::clone {'fzf':
    #     url    => 'https://github.com/junegunn/fzf.git',
    #     dst    => "${vagrant_home}/.fzf",
    #     owner  => $shell_user,
    #     unless => "test -d $shell_home/.fzf"
    # }

    vcsrepo { "$shell_home/.fzf":
        ensure   => present,
        provider => git,
        owner    => $shell_user,
        source   => 'https://github.com/junegunn/fzf.git',
    } ->

    exec{'install fzf':
        command     => "$shell_home/.fzf/install",
        environment => ["HOME=$shell_home"],
        user        => $shell_user,
        path        => ['/usr/bin','/bin',]
    }
}
