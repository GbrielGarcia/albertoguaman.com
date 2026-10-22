export interface GalleryImage {
  thumb: string;
  thumbSrcset: string;
  full: string;
  width: number;
  height: number;
  alt: string;
}

export interface SkillGroupProp {
  title: string;
  subtitle: string;
  items: string[];
}

export interface ProjectLink {
  title: string;
  url?: string;
}
