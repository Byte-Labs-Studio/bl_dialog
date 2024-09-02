# BL Dialog

Docs: https://docs.byte-labs.net/bl_dialog/exports

Preview: https://streamable.com/gz0get

## Code used for preview 

```lua
exports.bl_dialog:showDialog({
    ped = ped,
    dialog = {
        {
            id = 'initial_fisherman_talk',
            job = 'Fisher Man',
            name = 'Robert',
            text = 'Give me fish then ill let you go',
            buttons = {
                {
                    id = 'leave1',
                    label = 'Don\'t give him fish',
                    nextDialog = 'fisherman_second', -- switch to second dialog
                    onSelect = function(switchDialog)
                        -- you can make ped hit you bcs you didnt give him fish?
                    end
                },
                {
                    id = 'leave1',
                    label = 'Give him fish',
                    nextDialog = 'fisherman_talk_end', -- switch to third dialog
                },
            },
        },
        {
            id = 'fisherman_second',
            job = 'Fisher Man',
            name = 'Robert',
            text = 'You cant run from me, im catching you!',
            buttons = {
                {
                    id = 'leave2',
                    label = 'Ok, ill give you',
                    nextDialog = 'initial_fish_talk',
                },
            },
        },
        {
            id = 'fisherman_talk_end',
            job = 'Fisher Man',
            name = 'Robert',
            text = 'Robert is happy now!',
            buttons = {
                {
                    id = 'end',
                    label = 'End conversation', --end conversation
                    close = true,
                },
            },
        },
    }
})
```
