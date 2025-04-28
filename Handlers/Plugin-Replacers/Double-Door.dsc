doubledoors_world:
    type: world
    debug: false
    events:
        on player right clicks *_door bukkit_priority:monitor:
        - if <context.location.material.name> == iron_door:
            - stop
        - define doorface <context.location.block_facing>
        - if <context.location.material.hinge> == left:
            - define doorface <[doorface].rotate_around_y[-<util.pi.div[2]>]>
        - else:
            - define doorface <[doorface].rotate_around_y[<util.pi.div[2]>]>
        - define door2 <context.location.add[<[doorface]>]>
        - define door1status <context.location.material.switched>
        - if <[door2].material.name> == <context.location.material.name> && <[door2].switched> == <[door1status]>:
            - switch <[door2]>