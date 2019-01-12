venv
====

Python virtualenv management for fish shell.

Install
-------

For [fisher](https://github.com/jorgebucaran/fisher) user:

```bash
$ fisher add maralla/venv
```

Commands
--------

Create a virtualenv:

```bash
$ venv mk venv_name
```

Activate a virtualenv:

```bash
$ venv venv_name
# or
$ venv on venv_name
```

Deactivate a virtualenv:

```bash
$ venv off
```

List virtualenvs:

```bash
$ venv
```

Remove a virtualenv:

```bash
$ venv rm venv_name
```

Change directory to a virtualenv:

```bash
$ venv cd venv_name
```

License
-------

MIT license. See [LICENSE](LICENSE) for details.
