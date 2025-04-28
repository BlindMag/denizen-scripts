countEggsWorld:
    type: world
    debug: false
    events:
        after player opens chest:
          - if <player.has_permission[easter.event]>:
            - define countb:0
            - foreach <context.inventory.list_contents> as:checkedItem:
                - if <[checkedItem].material.name.contains[rabbit_spawn_egg]>:
                    - define countb:++
            - narrate <[countb]>

clearAllBp:
  type: command
  description: Clear all eggs
  name: clearAllBp
  permission: easter.ClearBP
  debug: false
  usage: /clearAllBp
  script:
  - foreach <server.online_players>:
    - execute as_op "bp clear <[value].name>"