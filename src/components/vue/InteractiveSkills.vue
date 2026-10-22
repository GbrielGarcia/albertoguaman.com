<script setup lang="ts">
// Stack interactivo (← interactive_skills.dart): al elegir una herramienta muestra dónde la usé.
import { computed, ref } from 'vue';
import type { ProjectLink, SkillGroupProp } from './types';

const props = defineProps<{
  groups: SkillGroupProp[];
  /** herramienta → proyectos (con enlace si es público). */
  usage: Record<string, ProjectLink[]>;
}>();

const selected = ref<string | null>(null);
const projects = computed(() => (selected.value ? (props.usage[selected.value] ?? []) : []));

function toggle(skill: string) {
  selected.value = selected.value === skill ? null : skill;
}
</script>

<template>
  <div class="skills">
    <div v-for="g in groups" :key="g.title" class="card-box">
      <h3>{{ g.title }}</h3>
      <p class="muted sub">{{ g.subtitle }}</p>
      <ul class="chips">
        <li v-for="s in g.items" :key="s">
          <button
            type="button"
            :class="{ active: selected === s, used: usage[s]?.length }"
            :aria-pressed="selected === s"
            @click="toggle(s)"
          >
            {{ s }}
          </button>
        </li>
      </ul>
    </div>
  </div>

  <div class="usage card-box" aria-live="polite">
    <template v-if="!selected">
      <p class="muted hint">Toca una herramienta para ver en qué proyectos la usé.</p>
    </template>
    <template v-else>
      <p class="eyebrow">{{ selected }}</p>
      <ul v-if="projects.length" class="list">
        <li v-for="p in projects" :key="p.title">
          <a v-if="p.url" :href="p.url" target="_blank" rel="noopener">{{ p.title }} ↗</a>
          <span v-else>{{ p.title }}</span>
        </li>
      </ul>
      <p v-else class="muted hint">La uso en el día a día; todavía no tengo un proyecto público para mostrar con ella.</p>
    </template>
  </div>
</template>

<style scoped>
.skills {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(min(100%, 19rem), 1fr));
  gap: var(--space-l);
}

h3 {
  font-size: 1.25rem;
  margin-bottom: var(--space-xs);
}

.sub {
  font-size: 0.875rem;
}

.chips li {
  padding: 0;
  border: 0;
  background: none;
}

button {
  padding: 0.25rem 0.7rem;
  border-radius: 999px;
  border: 1px solid var(--hairline);
  background: var(--elevated);
  color: var(--text);
  font: inherit;
  cursor: pointer;
}

button.used {
  border-color: color-mix(in srgb, var(--blue) 45%, transparent);
}

button:hover {
  border-color: var(--blue);
}

button.active {
  background: var(--blue);
  border-color: var(--blue);
  color: #fff;
}

.usage {
  margin-top: var(--space-l);
}

.hint {
  margin: 0;
  font-size: 1rem;
}

.list {
  margin: 0;
  padding-left: 1.2rem;
}

.list li + li {
  margin-top: var(--space-xs);
}
</style>
