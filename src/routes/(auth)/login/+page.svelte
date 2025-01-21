<script lang="ts">
	import { supabase } from '$lib/supabase/client';
	import { goto } from '$app/navigation';

	let email = '';
	let password = '';
	let loading = false;
	let error: string | null = null;

	async function handleLogin() {
		try {
			loading = true;
			error = null;

			const { error: signInError } = await supabase.auth.signInWithPassword({
				email,
				password
			});

			if (signInError) {
				error = signInError.message;
				return;
			}

			goto('/admin');
		} catch (e) {
			error = 'An unexpected error occurred';
			console.error('Login error:', e);
		} finally {
			loading = false;
		}
	}
</script>

<div class="flex min-h-screen items-center justify-center bg-gray-900 px-4 py-12 sm:px-6 lg:px-8">
	<div class="w-full max-w-md space-y-8">
		<div>
			<h2 class="mt-6 text-center text-3xl font-bold tracking-tight text-white">
				Sign in to your account
			</h2>
		</div>
		<form class="mt-8 space-y-6" on:submit|preventDefault={handleLogin}>
			<div class="-space-y-px rounded-md shadow-sm">
				<div>
					<label for="email-address" class="sr-only">Email address</label>
					<input
						id="email-address"
						name="email"
						type="email"
						required
						bind:value={email}
						class="relative block w-full rounded-t-md border-0 bg-gray-800 p-1.5 text-white placeholder-gray-400 ring-1 ring-inset ring-gray-700 focus:z-10 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
						placeholder="Email address"
					/>
				</div>
				<div>
					<label for="password" class="sr-only">Password</label>
					<input
						id="password"
						name="password"
						type="password"
						required
						bind:value={password}
						class="relative block w-full rounded-b-md border-0 bg-gray-800 p-1.5 text-white placeholder-gray-400 ring-1 ring-inset ring-gray-700 focus:z-10 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
						placeholder="Password"
					/>
				</div>
			</div>

			{#if error}
				<div class="rounded-md bg-red-500 p-4 text-sm text-white" role="alert">
					{error}
				</div>
			{/if}

			<div class="flex items-center justify-between">
				<div class="text-sm">
					<a href="/reset-password" class="font-medium text-red-600 hover:text-red-500"
						>Forgot your password?</a
					>
				</div>
				<div class="text-sm">
					<a href="/signup" class="font-medium text-red-600 hover:text-red-500">Create an account</a
					>
				</div>
			</div>

			<div>
				<button
					type="submit"
					disabled={loading}
					class="group relative flex w-full justify-center rounded-md bg-red-600 px-3 py-2 text-sm font-semibold text-white hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600 disabled:opacity-50"
				>
					{#if loading}
						<span class="absolute inset-y-0 left-0 flex items-center pl-3">
							<svg
								class="h-5 w-5 animate-spin text-white"
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
							>
								<circle
									class="opacity-25"
									cx="12"
									cy="12"
									r="10"
									stroke="currentColor"
									stroke-width="4"
								/>
								<path
									class="opacity-75"
									fill="currentColor"
									d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
								/>
							</svg>
						</span>
						Signing in...
					{:else}
						Sign in
					{/if}
				</button>
			</div>
		</form>
	</div>
</div>
