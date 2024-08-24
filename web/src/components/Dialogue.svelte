<script lang="ts">
    import { Receive } from '@enums/events';
    import { ReceiveEvent } from '@utils/eventsHandlers';
    import HexSVG from '@components/hex.svg';

    ReceiveEvent(Receive.imageResize, (value: number) => {
    });
</script>

<div class="w-[35%] h-[40%]">
    <p class="text-[#8685EF]">TAXI SERVICE</p>
    <p class="text-white text-[36px] font-[700]">Mason Gazaway</p>
    <div class="dialogue-background">
        <p>Lorem ipsum dolor sit amet consectetur. Vitae arcu at in donec iaculis. Interdum in habitasse vivamus vel eu nulla. At eget rutrum ultrices bibendum. Nec orci cursus accumsan vel metus tortor vestibulum.</p>
    </div>

    <div class="grid grid-cols-2 gap-4 w-[90%] mt-5">
        <button class="dialogue-button selected flex items-center gap-5"><img src={HexSVG} alt="Hex Icon" width="18" height="18" /> I’d like to browse what you have</button>
        <button class="dialogue-button">Leave Conversation</button>
        <button class="dialogue-button">Slap the shit outta him</button>
        <button class="dialogue-button">test</button>
    </div>
</div>
