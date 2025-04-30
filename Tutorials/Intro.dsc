#Intro - How to create your first script -
#Notice the red line under the name of the script? That's because the script type is incorrect. Denizen's visual studio code extention is detecting that the script is incorrectly formatted, or is not an excepted type. Changing the type and all other things in () will make the script acceptible.

#First task -
#Alter the script below to say hello - the type should be 'command'

#Setup for a command -
#Name
NameofScript:
#Types found here: https://meta.denizenscript.com/ - they can be searched for with -> 'script container system' on the search bar
  type: (type)
  description: (Example of a decription)
  name: (Name Used For Command Base)
  permission: (permission that is required)
  usage: /(Name Used For Command Base) (whatever other sub commands)
  #Below this 'Script:' is where your script goes - script is a set of instructions for what you need denizen to do.
  Script:
  #Two Prime examples are listed below:
    - execute as_server "cmi money pay all 1"
    # ^Non-Denizen Command -> When using in game commands, you must use the denizen 'execute' command just like the above.
    # Example: execute (as_server|as_op|as_player) "command"
    - announce "Banana and potato have arrived. That is all."
    # ^Denizen Command:
    # Using a denizen command does not require a 'execute' command prior to it. Denizen commands here -> https://meta.denizenscript.com/Docs/

#Intro 2 - Convert your command into a task and command

#Intro 3 - Convert your script to send hello to all online players - Try your task without the command with the ex command!

#Intro 4 - Create a condition with tags so the players do not recieve the welcome again!

#Intro 5 - Add another condition to check for player currency



