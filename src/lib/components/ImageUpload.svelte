<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import { createEventDispatcher } from 'svelte';

  export let currentImageUrl: string | null = null;

  const dispatch = createEventDispatcher<{
    upload: { url: string };
    error: { message: string };
  }>();

  let uploading = false;
  let error: string | null = null;
  let fileInput: HTMLInputElement;

  async function uploadImage(event: Event) {
    try {
      const target = event.target as HTMLInputElement;
      const file = target.files?.[0];
      if (!file) return;

      // Validate file type
      if (!file.type.startsWith('image/')) {
        throw new Error('Please upload an image file');
      }

      // Validate file size (max 2MB)
      if (file.size > 2 * 1024 * 1024) {
        throw new Error('Image size should be less than 2MB');
      }

      uploading = true;
      error = null;

      // Generate a unique file name
      const fileExt = file.name.split('.').pop();
      const fileName = `${crypto.randomUUID()}.${fileExt}`;
      const filePath = `team-logos/${fileName}`;

      // Upload the file to Supabase Storage
      const { error: uploadError, data } = await supabase.storage
        .from('logos')
        .upload(filePath, file, {
          upsert: true,
          contentType: file.type
        });

      if (uploadError) throw uploadError;

      // Get the public URL
      const {
        data: { publicUrl }
      } = supabase.storage.from('logos').getPublicUrl(filePath);

      dispatch('upload', { url: publicUrl });

      // Clear the file input
      if (fileInput) {
        fileInput.value = '';
      }
    } catch (e) {
      error = e.message;
      dispatch('error', { message: e.message });
    } finally {
      uploading = false;
    }
  }

  async function removeImage() {
    if (!currentImageUrl || !confirm('Are you sure you want to remove this image?')) return;

    try {
      // Extract the file path from the URL
      const url = new URL(currentImageUrl);
      const pathMatch = url.pathname.match(/logos\/(.+)/);
      if (!pathMatch) return;

      const filePath = pathMatch[1];

      const { error: deleteError } = await supabase.storage.from('logos').remove([filePath]);

      if (deleteError) throw deleteError;

      dispatch('upload', { url: '' });
    } catch (e) {
      error = e.message;
      dispatch('error', { message: e.message });
    }
  }
</script>

<div class="space-y-4">
  <div class="flex items-center space-x-4">
    {#if currentImageUrl}
      <img
        src={currentImageUrl}
        alt="Current logo"
        class="h-20 w-20 flex-shrink-0 rounded-full border-2 border-gray-700 object-cover"
      />
    {:else}
      <div
        class="h-20 w-20 flex-shrink-0 rounded-full border-2 border-dashed border-gray-700 bg-neutral-800"
      />
    {/if}

    <div class="flex flex-col space-y-2">
      <label
        class="inline-flex cursor-pointer items-center rounded-md bg-neutral-700 px-3 py-2 text-sm font-semibold text-white hover:bg-neutral-600"
      >
        <span>{uploading ? 'Uploading...' : 'Upload Logo'}</span>
        <input
          bind:this={fileInput}
          type="file"
          accept="image/*"
          on:change={uploadImage}
          class="hidden"
          disabled={uploading}
        />
      </label>

      {#if currentImageUrl}
        <button
          type="button"
          on:click={removeImage}
          class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white hover:bg-red-500"
        >
          Remove Logo
        </button>
      {/if}
    </div>
  </div>

  {#if error}
    <p class="text-sm text-red-500">{error}</p>
  {/if}

  <p class="text-xs text-gray-400">Supported formats: JPG, PNG, GIF. Maximum file size: 2MB</p>
</div>
