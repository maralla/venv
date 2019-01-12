function venv -d 'Python virtualenv automation.'
    set -l cmd "__venv__$argv[1]"
    if functions -q $cmd
        set -e argv[1]
        eval $cmd $argv
    else if set -q argv[1]
        __venv__on $argv[1]
    else
        __venv__ls
    end
end

function __venv__on -a env
    __venv__set_home
    set -l ACTIVATE_ENV "$VIRTUALENV_HOME/$env"
    if test -n "$VIRTUAL_ENV"; and test -d $ACTIVATE_ENV
        __venv__off
    end
    if test -n "$env"; and test -d $ACTIVATE_ENV
        set -gx VIRTUAL_ENV "$VIRTUALENV_HOME/$env"
        set -gx _OLD_VIRTUAL_PATH $PATH
        set -gx PATH "$VIRTUAL_ENV/bin" $PATH
    else
        __venv__ls
    end
end

function __venv__off
    if test -n "$_OLD_VIRTUAL_PATH"
        set -gx PATH $_OLD_VIRTUAL_PATH
        set -e _OLD_VIRTUAL_PATH
    end
    set -e VIRTUAL_ENV
end

function __venv__ls
    __venv__set_home
    pushd $VIRTUALENV_HOME
    for f in */bin/python
        echo $f | sed 's#/bin/python##'
    end
    popd
end

function __venv__mk
    __venv__set_home
    if not set -q argv[1]
        echo 'Usage: mkenv <env_name> <virtualenv_args>'
        exit 1
    end
    set -l DEST "$VIRTUALENV_HOME/$argv[1]"
    virtualenv $argv[2..-1] $DEST
end

function __venv__rm
    __venv__set_home
    if not set -q argv[1]
        echo 'Usage: rmenv <env_name>'
        exit 1
    end
    if test -d "$VIRTUALENV_HOME/$argv[1]"
        rm -rf "$VIRTUALENV_HOME/$argv[1]"
    end
end

function __venv__cd
    __venv__set_home
    if not set -q argv[1]
        if test -n "$VIRTUAL_ENV"
            cd $VIRTUAL_ENV
            exit 0
        end
        echo 'Usage: cdenv <env_name>'
        exit 1
    end
    if test -d "$VIRTUALENV_HOME/$argv[1]"
        cd "$VIRTUALENV_HOME/$argv[1]"
    end
end

function __venv__set_home
    # Set virtualenv home directory.
    set -q VIRTUALENV_HOME; or set -gx VIRTUALENV_HOME "$HOME/.dotfiles/virtualenvs"
end
