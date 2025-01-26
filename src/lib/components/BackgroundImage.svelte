<script lang="ts">
	export let src: string;
	export let alt: string;
	export let opacity = 1;
	export let zIndex = -10;
	export let className = '';
</script>

<div class="fixed left-0 top-0 h-full w-full {className}" style:z-index={zIndex} style:opacity={opacity}>
	<img {src} {alt} class="h-full w-full object-cover" />
</div>
