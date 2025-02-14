import type { ComponentType } from "svelte";

export interface SidebarNavItem {
  title: string;
  href: string;
  icon?: ComponentType;
  disabled?: boolean;
}
