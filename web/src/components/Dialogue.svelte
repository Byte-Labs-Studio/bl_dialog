<script lang="ts">
    import { onMount } from 'svelte';
    import { Receive } from '@enums/events';
    import { ReceiveEvent, SendEvent } from '@utils/eventsHandlers';
    import HexSVG from '@components/hex.svg';

    interface Buttons {
        label: string;
        id?: string | number;
    }
    interface Dialogue {
        job: string;
        name: string;
        text: string;
        buttons: Buttons[];
        textSpeed?: number
    }

    let currentDialogue: Dialogue = {
        job: 'test',
        name: 'test',
        text: 'Test',
        buttons: [
            {
                label: 'test',
            },
            {
                label: 'test',
            },
            {
                label: 'test',
            },
            {
                label: 'test',
            },
            {
                label: 'test',
            },
            {
                label: 'test',
            },
            {
                label: 'test',
            },
        ],
    };

    let displayedText = '';
    let index = 0;
    let finish = false;

    function typeWriterEffect() {
        if (index < currentDialogue.text.length) {
            displayedText += currentDialogue.text.charAt(index);
            index++;
            setTimeout(typeWriterEffect, currentDialogue.textSpeed || 25);
        } else finish = true;
    }

    function refreshText() {
        index = 0
        displayedText = ''
        typeWriterEffect()
    }

    function selectButton(index: number, id?: string | number) {
        finish = false;
        SendEvent('dialog:click', {
            index,
            id,
        })
    }

    ReceiveEvent(Receive.showDialogue, (data: Dialogue) => {
        currentDialogue = data;
        refreshText()
    });

    ReceiveEvent(Receive.updateDialogue,(data: { type: string; value: string | Buttons[] }) => {
        currentDialogue = { ...currentDialogue, [data.type]: data.value }
        if (data.type === 'text') refreshText()
    });
</script>

<div
    class="w-full h-[60%] absolute bg-gradient-to-t from-black to-transparent"
></div>
<div class="min-w-[42vw] z-10 absolute bottom-[5%] min-h-[40vh]">
    <p class="text-[#5e5cf4] font-[700] text-[0.8vw]">{currentDialogue.job}</p>
    <p class="text-white text-[2vw] font-[700]">{currentDialogue.name}</p>
    <div class="dialog-background w-[42vw]">
        <p class="whitespace-normal break-words overflow-wrap break-word text-[0.8vw] font-[700]">{@html displayedText}</p>
    </div>

    <div class="grid grid-cols-2 gap-[0.7vw] w-[90%] mt-5">
        {#if finish}
            {#each currentDialogue.buttons as item, index}
                <button
                    on:click={() => selectButton(index + 1, item.id)}
                    class="dialog-button flex items-center gap-[0.7vw] text-left max-w-[20vw] whitespace-normal break-words overflow-wrap break-word text-[0.7vw]"
                >
                    <img src={HexSVG} alt="Hex Icon" class="w-[1vw] h-[1vw]" />
                    {item.label}</button
                >
            {/each}
        {/if}
    </div>
</div>
