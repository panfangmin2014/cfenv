function __fish_cfenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'cfenv' ]
    return 0
  end
  return 1
end

function __fish_cfenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c cfenv -n '__fish_cfenv_needs_command' -a '(cfenv commands)'
for cmd in (cfenv commands)
  complete -f -c cfenv -n "__fish_cfenv_using_command $cmd" -a "(cfenv completions $cmd)"
end
