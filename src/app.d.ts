/// <reference types="svelte-clerk/env" />

declare global {
  namespace App {
    // interface Error {}
    interface Locals {
      auth: {
        userId: string | null;
        sessionId: string | null;
        session?: any;
        user?: {
          id: string;
          username?: string;
          firstName?: string;
          lastName?: string;
          primaryEmailAddress?: string;
          emailAddresses?: string[];
          publicMetadata?: {
            role?: string;
            [key: string]: any;
          };
          [key: string]: any;
        } | null;
        actor?: any;
        organization?: any;
      };
    }
    interface PageData {
      userId?: string;
      user?: Locals["auth"]["user"];
      isAdmin?: boolean;
      cookies?: Record<string, string>;
    }
    // interface PageState {}
    // interface Platform {}
  }
}

export {};
