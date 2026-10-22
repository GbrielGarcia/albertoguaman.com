<script setup lang="ts">
// Galería con visor a pantalla completa (← gallery_page.dart).
// Se renderiza en el servidor (grilla de enlaces normales) y al hidratar abre las fotos en un visor.
import { onBeforeUnmount, onMounted, ref, watch } from 'vue';
import type { GalleryImage } from './types';

const props = defineProps<{ images: GalleryImage[] }>();

const current = ref<number | null>(null);
const dialog = ref<HTMLDialogElement | null>(null);

function open(index: number, event: MouseEvent) {
  // Ctrl/Cmd + clic sigue abriendo la imagen en otra pestaña.
  if (event.metaKey || event.ctrlKey || event.shiftKey) return;
  event.preventDefault();
  current.value = index;
}

function close() {
  current.value = null;
}

function step(delta: number) {
  if (current.value === null) return;
  const n = props.images.length;
  current.value = (current.value + delta + n) % n;
}

function onKey(event: KeyboardEvent) {
  if (current.value === null) return;
  if (event.key === 'ArrowRight') step(1);
  if (event.key === 'ArrowLeft') step(-1);
}

watch(current, (value) => {
  if (value !== null && !dialog.value?.open) dialog.value?.showModal();
  if (value === null && dialog.value?.open) dialog.value.close();
});

// Solo en el navegador (el componente también se renderiza en el servidor).
onMounted(() => window.addEventListener('keydown', onKey));
onBeforeUnmount(() => window.removeEventListener('keydown', onKey));
</script>

<template>
  <ul class="gallery">
    <li v-for="(img, i) in images" :key="img.full">
      <a :href="img.full" @click="open(i, $event)">
        <img
          :src="img.thumb"
          :srcset="img.thumbSrcset"
          sizes="(max-width: 640px) 50vw, (max-width: 1100px) 33vw, 280px"
          :width="img.width"
          :height="img.height"
          :alt="img.alt"
          loading="lazy"
          decoding="async"
        />
      </a>
    </li>
  </ul>

  <dialog ref="dialog" class="viewer" aria-label="Visor de fotos" @close="close" @click.self="close">
    <template v-if="current !== null">
      <img :src="images[current].full" :alt="images[current].alt" />
      <p class="counter">{{ current + 1 }} / {{ images.length }}</p>
      <button type="button" class="nav prev" aria-label="Foto anterior" @click="step(-1)">‹</button>
      <button type="button" class="nav next" aria-label="Foto siguiente" @click="step(1)">›</button>
      <button type="button" class="close" aria-label="Cerrar" @click="close">✕</button>
    </template>
  </dialog>
</template>

<style scoped>
.gallery {
  list-style: none;
  margin: 0;
  padding: 0;
  columns: 3 14rem;
  column-gap: var(--space-m);
}

.gallery li {
  break-inside: avoid;
  margin-bottom: var(--space-m);
}

.gallery a {
  display: block;
  border-radius: var(--radius);
  overflow: hidden;
  border: 1px solid var(--hairline);
}

.gallery img {
  width: 100%;
  height: auto;
  transition: transform 0.3s ease;
}

.gallery a:hover img {
  transform: scale(1.03);
}

.viewer {
  width: 100vw;
  height: 100dvh;
  max-width: none;
  max-height: none;
  margin: 0;
  padding: 0;
  border: 0;
  background: rgb(0 0 0 / 0.92);
  color: #fff;
}

.viewer[open] {
  display: grid;
  place-items: center;
}

.viewer::backdrop {
  background: rgb(0 0 0 / 0.6);
}

.viewer img {
  max-width: min(92vw, 1100px);
  max-height: 84dvh;
  width: auto;
  height: auto;
  border-radius: 8px;
}

.counter {
  position: absolute;
  bottom: 1rem;
  left: 50%;
  transform: translateX(-50%);
  margin: 0;
  font-family: var(--font-sans);
  font-size: 0.875rem;
  opacity: 0.8;
}

button {
  position: absolute;
  display: grid;
  place-items: center;
  width: 3rem;
  height: 3rem;
  border: 0;
  border-radius: 50%;
  background: rgb(255 255 255 / 0.12);
  color: #fff;
  font-size: 1.75rem;
  line-height: 1;
  cursor: pointer;
}

button:hover {
  background: rgb(255 255 255 / 0.24);
}

.prev {
  left: 1rem;
  top: 50%;
  transform: translateY(-50%);
}

.next {
  right: 1rem;
  top: 50%;
  transform: translateY(-50%);
}

.close {
  top: 1rem;
  right: 1rem;
  font-size: 1.25rem;
}
</style>
