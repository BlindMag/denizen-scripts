easterNPC:
    type: assignment
    debug: false
    actions:
        on assignment:
        - trigger name:click state:true
        - trigger name:chat state:true cooldown:false radius:5
        - trigger name:proximity state:true radius:5
    interact scripts:
    - easterNPCTask

easterNPCTask:
    type: interact
    debug: false
    steps:
        1:
          click trigger:
            script:
               - ratelimit <player> 20s
               - if <server.has_flag[eventStart]> && !<player.has_flag[EasterKitGiven]>:
                 - narrate "<yellow><npc.name><dark_aqua>: <white>Why hello <player.name>, let's see what kits I have for you to choose from<dark_aqua>!"
                 - execute as_op "dm open bunny <player.name>"
                 - stop
               - if <player.has_flag[EasterKitGiven]>:
                 - if <player.inventory.contains_item[black_bundle]>:
                   - narrate "<yellow><npc.name><dark_aqua>: <white>You have a bundle in your inventory, be sure to store all your eggs before getting a new kit! You can drop your bundle in a hopper!"
                   - narrate "<dark_aqua>[<aqua>!<dark_aqua>] <white>Click <npc.name> again when you're ready to get a new kit!"
                   - zap step:2
                   - stop
                 - if <player.inventory.contains_item[ghast_spawn_egg]>:
                   - narrate "<yellow><npc.name><dark_aqua>: <white>You have mob catching eggs in your inventory! Please store all your eggs before coming to get a new kit!"
                   - stop
                 - else:
                   - narrate "<yellow><npc.name><dark_aqua>: <white>Hi there, lookin for a new kit? Here, let me open the menu for you!"
                   - execute as_server "clear <player.name>"
                   - execute as_op "dm open bunny <player.name>"
        2:
          click trigger:
            script:
              - ratelimit <player> 20s
              - if <player.inventory.contains_item[ghast_spawn_egg]>:
                - narrate "<yellow><npc.name><dark_aqua>: <white>You have mob catching eggs in your inventory! Please store all your eggs before coming to get a new kit!"
                - stop
              - else:
                - narrate "<yellow><npc.name><dark_aqua>: <white>Hi there, lookin for a new kit? Here, let me open the menu for you!"
                - execute as_server "clear <player.name>"
                - execute as_op "dm open bunny <player.name>"
                - zap step:1