Brawl:
  type: command
  description: Brawl handler
  name: brawl
  permission: brawl.commands
  debug: false
  usage: /brawl
  tab completions:
    1: nextround|endround|count|stop|start|totals
  script:
    - define argument <context.args.get[1]>
    - choose <context.args.first>:
      - case start:
        - if <server.flag[brawlRound]> > 0:
          - narrate "<aqua>[<dark_aqua>3!<aqua>]<&r> Before starting a new game, please use the command /brawl stop! If you are looking to start a new round, please use the command /brawl nextround."
          - stop
        - flag server brawlStart
        - flag server brawlRound:1
      - case stop:
        - narrate "<aqua>[<dark_aqua>3!<aqua>]<&r> Cleared all game stats from the brawl!"
        - flag server brawlStart:!
        - foreach <server.players_flagged[brawlEggCounter]>:
          - flag <[value]> brawlEggCounter:!
        - define checkAll 1
        - while <[checkAll]> < 6:
          - if <server.has_flag[r<[checkAll]>1stPlace]>:
            - flag server r<[checkAll]>1stPlace:!
            - flag server r<[checkAll]>2ndPlace:!
            - flag server r<[checkAll]>3rdPlace:!
            - flag server r<[checkAll]>1stPScore:!
            - flag server r<[checkAll]>2ndPScore:!
            - flag server r<[checkAll]>3rdPScore:!
            - define checkAll:++
          - else:
            - define checkAll:7
      # Might be smart to add a double checker here just to reconfirm this is what the user wants - nextround
      - case nextround:
        - if <server.flag[brawlRound]> < 6:
          - flag server brawlStart
          - flag server brawlRound:++
          - foreach <server.players_flagged[brawlEggCounter]>:
            - flag <[value]> brawlEggCounter:!
      - case pause:
        - flag server brawlStart:!
      - case count:
        - define curRound <server.flag[brawlRound]>
        - define FirstPoints 0
        - define SecondPoints 0
        - define ThirdPoints 0
        - define 1stPlace null
        - define 2ndPlace null
        - define 3rdPlace null
        - foreach <server.players_flagged[brawlEggCounter]>:
            - if <[value].flag[brawlEggCounter]> > <[FirstPoints]>:
                - define 1stPlace <[value].name>
                - define FirstPoints <[value].flag[brawlEggCounter]>
            - else if <[value].flag[brawlEggCounter]> > <[SecondPoints]>:
                - define 2ndPlace <[value].name>
                - define SecondPoints <[value].flag[brawlEggCounter]>
            - else if <[value].flag[brawlEggCounter]> > <[ThirdPoints]>:
                - define 3rdPlace <[value].name>
                - define ThirdPoints <[value].flag[brawlEggCounter]>
        - narrate "<aqua>[<dark_aqua>3!<aqua>]<&r> Winners of round <server.flag[brawlRound]> are: <&nl>1st Place: <[1stPlace]> at <[FirstPoints]><&nl>2nd Place: <[2ndPlace]> at <[SecondPoints]><&nl>3rd Place: <[3rdPlace]> at <[ThirdPoints]>"
        - flag server r<[curRound]>1stPlace <[1stPlace]>
        - flag server r<[curRound]>1stPScore <[FirstPoints]>
        - flag server r<[curRound]>2ndPlace <[2ndPlace]>
        - flag server r<[curRound]>2ndPScore <[SecondPoints]>
        - flag server r<[curRound]>3rdPlace <[3rdPlace]>
        - flag server r<[curRound]>3rdPScore <[ThirdPoints]>
      - case totals:
        - define checkAll 1
        - while <[checkAll]> < 6:
          - if <server.has_flag[r<[checkAll]>1stPlace]>:
            - define FirstPoints <server.has_flag[r<[checkAll]>FirstPoints]>
            - define SecondPoints <server.has_flag[r<[checkAll]>SecondPoints]>
            - define ThirdPoints <server.has_flag[r<[checkAll]>ThirdPoints]>
            - define 1stPlace <server.has_flag[r<[checkAll]>1stPlace]>
            - define 2ndPlace <server.has_flag[r<[checkAll]>2ndPlace]>
            - define 3rdPlace <server.has_flag[r<[checkAll]>3rdPlace]>
            - narrate "<aqua>[<dark_aqua>3!<aqua>]<&r> Winners of round <dark_aqua><server.flag[brawlRound]> <&r>are: <&nl>1st Place: <[1stPlace]> at <[FirstPoints]><&nl>2nd Place: <[2ndPlace]> at <[SecondPoints]><&nl>3rd Place: <[3rdPlace]> at <[ThirdPoints]>"
            - define checkAll:++
          - else:
            - define checkAll:7
countEggsPickedUp:
    type: world
    debug: false
    events:
        after player right clicks rabbit with:ghast_spawn_egg:
          - if <player.world.name> == spring2024:
            - if <server.has_flag[brawlStart]>:
                - if <player.inventory.contains_item[rabbit_spawn_egg]>:
                    - flag player brawlEggCounter:++
                    - take item:rabbit_spawn_egg from:<player.inventory>
