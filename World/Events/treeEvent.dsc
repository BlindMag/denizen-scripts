#Listener all tree planting and growing 
#checks to see if the player has planted the sprouts before continuing to count the growth by reading the two flags - <player.flag[counttrees]> (which is planting) and <player.flag[countgrowtrees]>. If the counttrees isn't high enough, it notifies the player to plant more trees before continuing.

#It counts the tree growth, then checks if the player's amount they have grown is higher than anyone on the top 5 list. It then checks for each place on the top 5 and runs task scripts to move around the players to the proper places.

#Once the players take their places on the top 5, the scoreboard is updated for everyone with the flag that they enable when they use the command /planevent sidebar

Tree_Listener_World:
  type: world
  debug: false
  events:
    after player places oak_sapling|spruce_sapling|birch_sapling|jungle_sapling|acacia_sapling|dark_oak_sapling|cherry_sapling|mangrove_propagule:
      - if <server.has_flag[tree_event]>:
        - flag player counttrees:++
    after tree|acacia|big_tree|cherry|dark_oak|cocoa_tree|jungle|mangrove|mega_redwood|redwood|small_jungle|birch|tall_birch|tall_mangrove|tall_redwood grows from bonemeal:
      - if <server.has_flag[tree_event]> && !<player.has_flag[noPlantEvent]>:
        - if !<player.flag[countgrowtrees]>:
          - flag player countgrowtrees:++
        - else:
          - if <player.flag[counttrees].is_more_than[<player.flag[countgrowtrees]>]>:
            - flag player countgrowtrees:++
            - if <player.flag[countgrowtrees].is_more_than<server.flag[ph5]>:
              - if <player.flag[countgrowtrees]> > <server.flag[ph5]>:
                - if <player.flag[countgrowtrees]> > <server.flag[ph1]>:
                  - run Set1stPlace
                - else if <player.flag[countgrowtrees]> > <server.flag[ph2]>:
                  - run Set2ndPlace
                - else if <player.flag[countgrowtrees]> > <server.flag[ph3]>:
                  - run Set3rdPlace
                - else if <player.flag[countgrowtrees]> > <server.flag[ph4]>:
                  - run Set4thPlace
                - else:
                  - flag server ph5:<player.flag[countgrowtrees]>
                  - flag server name5th:<player.name>
                  - run Sidebar_handler
            - if !<player.has_flag[notiTotals]>:
              - narrate "<&a><&l>Tree event totals:<&nl> <&2>Sprouts Planted: <&a><player.flag[counttrees]> <&nl> <&2>Trees Grown: <player.flag[countgrowtrees]><&nl><&7><&o>To view the plant event leaderboard, use /plantevent sidebar"
              - flag player notiTotals expire:300s
          - else:
            - if !<player.has_flag[notiGrowCD]>:
              - narrate "<&7>[<&3>Event<&7>]<&b> You must plant more saplings for your count to continue!"
              - flag player notiGrowCD expire:15s

#Placeholder handler to set each player to the proper place on the top 5 chart
Set1stPlace:
  type: task
  debug: false
  script:
    - if <player.name> == <server.flag[name2nd]>:
      - flag server ph2:<server.flag[ph1]>
      - flag server name2nd:<server.flag[name1st]>
    - if <player.name> == <server.flag[name3rd]>:
      - flag server ph3:<server.flag[ph2]>
      - flag server name3rd:<server.flag[name2nd]>
      - flag server ph2:<server.flag[ph1]>
      - flag server name2nd:<server.flag[name1st]>
    - if <player.name> == <server.flag[name4th]>:
      - flag server ph4:<server.flag[ph3]>
      - flag server name4th:<server.flag[name3rd]>
      - flag server ph3:<server.flag[ph2]>
      - flag server name3rd:<server.flag[name2nd]>
      - flag server ph2:<server.flag[ph1]>
      - flag server name2nd:<server.flag[name1st]>
    - if <player.name> == <server.flag[name5th]>:
      - flag server ph5:<server.flag[ph4]>
      - flag server name5th:<server.flag[name4th]>
      - flag server ph4:<server.flag[ph3]>
      - flag server name4th:<server.flag[name3rd]>
      - flag server ph3:<server.flag[ph2]>
      - flag server name3rd:<server.flag[name2nd]>
      - flag server ph2:<server.flag[ph1]>
      - flag server name2nd:<server.flag[name1st]>
    - flag server ph1:<player.flag[countgrowtrees]>
    - flag server name1st:<player.name>
    - run Sidebar_handler  

Set2ndPlace:
  type: task
  debug: false
  script:
    - if <player.name> == <server.flag[name3rd]>:
      - flag server ph3:<server.flag[ph2]>
      - flag server name3rd:<server.flag[name2nd]>
    - if <player.name> == <server.flag[name4th]>:
      - flag server ph4:<server.flag[ph3]>
      - flag server name4th:<server.flag[name3rd]>
      - flag server ph3:<server.flag[ph2]>
      - flag server name3rd:<server.flag[name2nd]>
    - if <player.name> == <server.flag[name5th]>:
      - flag server ph5:<server.flag[ph4]>
      - flag server name5th:<server.flag[name4th]>
      - flag server ph4:<server.flag[ph3]>
      - flag server name4th:<server.flag[name3rd]>
      - flag server ph3:<server.flag[ph2]>
      - flag server name3rd:<server.flag[name2nd]>
    - flag server ph2:<player.flag[countgrowtrees]>
    - flag server name2nd:<player.name>
    - run Sidebar_handler

Set3rdPlace:
  type: task
  debug: false
  script:
    - if <player.name> == <server.flag[name4th]>:
      - flag server ph4:<server.flag[ph3]>
      - flag server name4th:<server.flag[name3rd]>
    - if <player.name> == <server.flag[name5th]>:
      - flag server ph5:<server.flag[ph4]>
      - flag server name5th:<server.flag[name4th]>
      - flag server ph4:<server.flag[ph3]>
      - flag server name4th:<server.flag[name3rd]>
    - flag server ph3:<player.flag[countgrowtrees]>
    - flag server name3rd:<player.name>
    - run Sidebar_handler

Set4thPlace:
  type: task
  debug: false
  script:
    - if <player.name> == <server.flag[name5th]>:
      - flag server ph5:<server.flag[ph4]>
      - flag server name5th:<server.flag[name4th]>
    - flag server ph4:<player.flag[countgrowtrees]>
    - flag server name4th:<player.name>
    - run Sidebar_handler


#Start, Stop, reset, sidebar, and count cmds

#permissions seperate for the administrative cmds and the player cmds
Tree_Event_CMDs:
  type: command
  debug: false
  description: Command handler for tree event
  name: plantevent
  usage: /plantevent [command]
  tab completions:
      1: count|sidebar|scoreboard|join|leave
      2: <context.args.first.equals[goto].if_true[<server.flag[warps].keys>].if_false[]>
      3: <context.args.first.equals[player].if_true[<server.flag[warps].keys>].if_false[]>
  script:
    - define eventTag <&7>[<&3>Event<&7>]<&b>
    - define argument <context.args.get[1]>
    - choose <context.args.first>:
      - case stop:
        - if <player.has_permission[event.toggle]>:
          - if <player.has_permission[event.toggle]>:
            - narrate "<[eventTag]> You have stopped the event! No more trees will be counted. <&nl><&6>To continue the current event, use /plantevent continue!"
            - flag server tree_event:!
      - case pause:
        - if <player.has_permission[event.toggle]>:
          - if <player.has_permission[event.toggle]>:
            - narrate "<[eventTag]> You have stopped the event! No more trees will be counted. <&nl><&6>To continue the current event, use /plantevent continue!"
            - flag server tree_event:!
      - case reset:
        - if <player.has_permission[event.toggle.admin]>:
          - narrate "<[eventTag]> You've reset all the event counters!"
          - flag server ph1:!
          - flag server name1st:!
          - flag server ph2:!
          - flag server name2nd:!
          - flag server ph3:!
          - flag server name3rd:!
          - flag server ph4:!
          - flag server name4th:!
          - flag server ph5:!
          - flag server name5th:!
          - foreach <server.players>:
            - flag <[value]> counttrees:!
            - flag <[value]> countgrowtrees:!
          - flag server tree_event:!
      - case start:
        - if <player.has_permission[event.toggle]> && !<server.has_flag[tree_event]>:
          - execute as_server 'cmi broadcast !<&8>---------------------------------------<&nl>{#00e6ca>}<&l>HT's 6th Year Tree{#188377<>}&l Planting Event Has Begun!&l{#00e6ca<} <&nl><&nl><&a><&l>Plant sprouts<&color[#00e6ca]> & grow them with <&n><&2><&l>bonemeal<&color[#00e6ca]> to earn your place on the &lLeaderboard<&color[#00e6ca]>! <&nl><&nl>Use command <&a><&l>/plantevent sidebar <&color[#00e6ca]>to view the leaderboard and <&a><&l>/plantevent count <&color[#00e6ca]>for your totals!<&nl><&a>| <&7><&o>To opt out, use the command /plantevent leave!<&a> | <&8>---------------------------------------'
          - flag server tree_event
          - flag server ph1:1
          - flag server ph2:1
          - flag server ph3:1
          - flag server ph4:1
          - flag server ph5:1
          - flag server name1st:n/a
          - flag server name2nd:n/a
          - flag server name3rd:n/a
          - flag server name4th:n/a
          - flag server name5th:n/a
        - else if <player.has_permission[event.toggle]>:
          - narrate "<[eventTag]> You attempted to start a new event before resetting the old event! Use /plantevent reset before starting a new event!
      - case continue:
        - if <player.has_permission[event.toggle]>:
          - flag server tree_event
          - narrate "<[eventTag]> You have resumed the current event!"
      - case count:
        - if <player.has_flag[counttrees]> && !<player.has_flag[noPlantEvent]>:
          - narrate "<[eventTag]> You have planted and grown <player.flag[countgrowtrees]> trees!"
        - else:
          - narrate "<[eventTag]> You must plant and grow trees to see your count!"
      - case sidebar:
        - if <server.has_flag[tree_event]> && !<player.has_flag[noPlantEvent]>:
          - flag player sidebarStick duration:60s
          - run Sidebar_handler
          - wait 60s
          - sidebar remove
        - else if !<server.has_flag[tree_event]>:
          - narrate "<[eventTag]> No event is currently active!"
      - case scoreboard:
        - if <server.has_flag[tree_event]> && !<player.has_flag[noPlantEvent]>:
          - if <player.has_flag[counttrees]>:
            - narrate "<&a><&l>Your current tree event totals:<&nl> <&2>Planted: <&a><player.flag[counttrees]> <&nl> <&2>Grown: <player.flag[countgrowtrees]>"
          - flag player sidebarStick duration:60s
          - run Sidebar_handler
          - wait 60s
          - sidebar remove
        - else if !<server.has_flag[tree_event]>:
          - narrate "<[eventTag]> No event is currently active!"
      - case leave:
        - if <server.has_flag[tree_event]>:
          - flag player noPlantEvent expire:5d
          - narrate "<[eventTag]> You have opted out of the planting event! To join back, use the command /plantevent join."
      - case join:
        - if <server.has_flag[tree_event]>:
          - narrate "<[eventTag]> You have rejoined the planting event! Best of luck!"
          - flag player noPlantEvent:!


#Task for sidebar to set it and gives a flag with a cooldown, players with this flag are automatically updated when anyone changes in the top 5 places.
Sidebar_handler:
  type: task
  debug: false
  script:
    - sidebar set "title:<&b><&l>| <&color[#00b37d]><&l>Current Top Arborists<&b> <&l>|" "values:<&6>1st: <&e><server.flag[name1st]>|<&6>2nd: <&e><server.flag[name2nd]>|<&6>3rd: <&e><server.flag[name3rd]>|<&6>4th: <&e><server.flag[name4th]>|<&6>5th: <&e><server.flag[name5th]>" scores:<server.flag[ph1]>|<server.flag[ph2]>|<server.flag[ph3]>|<server.flag[ph4]>|<server.flag[ph5]>    players:<server.players_flagged[sidebarStick]> per_player
