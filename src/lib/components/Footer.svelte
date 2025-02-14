<script lang="ts">
  // Footer component logic can go here if needed
</script>

<footer class="bg-neutral-100 p-8 py-12 dark:bg-neutral-800">
  <div class="mx-auto max-w-7xl">
    <!-- <div class="grid items-center gap-8 max-sm:grid-cols-1 lg:grid-cols-3">
      <h4 class="text-lg font-semibold leading-relaxed text-white lg:col-span-2">
        Join our newsletter to keep up to date with us!<br /> Enter your email Subscribe
      </h4>
      <div
        class="flex rounded-full border border-gray-600 bg-transparent px-1 py-1 max-lg:max-w-md"
      >
        <input
          type="email"
          placeholder="Enter your email"
          class="w-full bg-transparent pl-4 text-sm text-gray-400 outline-none"
        />
        <button
          type="button"
          class="rounded-full bg-blue-600 px-4 py-2 text-sm text-white transition-all hover:bg-blue-700"
          >Subscribe</button
        >
      </div>
    </div> -->

    <hr class="my-6 border-neutral-700" />

    <div class="grid max-lg:grid-cols-2 max-lg:gap-8 max-sm:grid-cols-1 lg:grid-cols-5 lg:gap-20">
      <div>
        <h4 class="mb-4 text-lg font-semibold dark:text-white">Admin</h4>
        <ul class="space-y-4">
          <li>
            <a href="/admin" class="text-sm text-neutral-400 hover:text-neutral-500">Dashboard</a>
          </li>
          <li>
            <a href="/admin/overlays" class="text-sm text-neutral-400 hover:text-neutral-500"
              >Overlays</a
            >
          </li>
          <li>
            <a href="/admin/teams" class="text-sm text-neutral-400 hover:text-neutral-500">Teams</a>
          </li>
        </ul>
      </div>

      <div>
        <h4 class="mb-4 text-lg font-semibold dark:text-white">League</h4>
        <ul class="space-y-4">
          <li>
            <a href="#" class="text-sm text-neutral-400 hover:text-neutral-500">My Team</a>
          </li>
          <li>
            <a href="#" class="text-sm text-neutral-400 hover:text-neutral-500">Schedule</a>
          </li>
          <li>
            <a href="#" class="text-sm text-neutral-400 hover:text-neutral-500">Divisions</a>
          </li>
        </ul>
      </div>
    </div>

    <p class="mt-8 text-sm text-gray-400">
      © {new Date().getFullYear()} Serenyx League
    </p>
  </div>
</footer>
