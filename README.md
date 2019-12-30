# Overview

This task makes it easy to enable or disable a Puppet agent remotely.  It simply runs the `puppet agent --enable` or `puppet agent --disable` command for you on the remote host.  You can optionally supply a message for a disabled agent to report when someone tries to run the disabled agent.


# Parameters

The task takes one required parameter, and optionally a second.

## `action` (required)

Set to `enable` or `disable` to put the agent in the desired state.

## `message` (optional)

An optional message to append to the `--disable` flag.


# Usage

## Puppet Enterprise console

Once the module is available in your production code environment, it will become available in the console and you can use it just like any other task.

## Command Line

You'll need to supply the parameters on the command line, as in the following two examples.

```shell
bolt task run agent_disenable action=disable message='hand edits rock' \
  --user root --password --targets ssh://kermit,ssh://gonzo,ssh://animal

bolt task run agent_disenable action=enable \
  --user Administrator --password --targets winrm://hoggle,winrm://bowie
```
