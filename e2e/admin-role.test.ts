import { test, expect } from '@playwright/test';

test.describe('Admin Role Test', () => {
  test('should login as admin and verify role', async ({ page }) => {
    try {
      console.log('Starting test...');

      // Navigate to login page
      console.log('Navigating to login page...');
      await page.goto('http://localhost:5173/login');
      console.log('Waiting for page load...');
      await page.waitForLoadState('networkidle');
      console.log('Page loaded');

      // Verify login form is present
      console.log('Checking for login form...');
      const emailInput = await page.waitForSelector('input[type="email"]', { timeout: 5000 });
      const passwordInput = await page.waitForSelector('input[type="password"]', { timeout: 5000 });
      const submitButton = await page.waitForSelector('button[type="submit"]', { timeout: 5000 });
      console.log('Login form elements found');

      // Fill in login form
      console.log('Filling login form...');
      await emailInput.fill('admin@serenyx.com');
      await passwordInput.fill('admin123');
      console.log('Form filled');
      
      // Take screenshot before submitting
      console.log('Taking pre-login screenshot...');
      await page.screenshot({ path: 'before-login.png' });
      
      // Submit form
      console.log('Submitting login form...');
      await submitButton.click();
      console.log('Form submitted');

      // Wait for navigation
      console.log('Waiting for navigation...');
      await Promise.race([
        page.waitForURL('http://localhost:5173/admin', { timeout: 10000 }),
        page.waitForSelector('text=Invalid login credentials', { timeout: 10000 })
          .then(() => {
            throw new Error('Login failed - invalid credentials');
          })
      ]);
      console.log('Navigation complete');

      // Wait for page load
      console.log('Waiting for admin page load...');
      await page.waitForLoadState('networkidle');
      console.log('Admin page loaded');

      // Take screenshot after navigation
      console.log('Taking post-login screenshot...');
      await page.screenshot({ path: 'after-login.png' });

      // Get and log the JWT token
      console.log('Checking JWT token...');
      const jwt = await page.evaluate(() => {
        const token = localStorage.getItem('sb-token');
        console.log('Token from localStorage:', token);
        return token;
      });
      console.log('JWT found:', jwt ? 'Yes' : 'No');

      // Check for access level text
      console.log('Looking for access level text...');
      const accessLevelElement = await page.waitForSelector('text=Access Level:', { 
        timeout: 10000,
        state: 'visible'
      });
      console.log('Access level element found');

      const accessLevel = await accessLevelElement.textContent();
      console.log('Access Level text:', accessLevel);
      expect(accessLevel).toContain('Admin');

      // Take final screenshot
      console.log('Taking admin page screenshot...');
      await page.screenshot({ path: 'admin-page.png' });

    } catch (error) {
      console.error('Test failed with error:', error);
      
      // Take error screenshot
      console.log('Taking error state screenshot...');
      await page.screenshot({ path: 'error-state.png' });
      
      // Log current URL
      const currentUrl = page.url();
      console.log('Current URL at error:', currentUrl);
      
      // Log page content
      const content = await page.content();
      console.log('Page content at error:', content);
      
      throw error;
    } finally {
      console.log('Starting cleanup...');
      try {
        // Attempt to logout
        console.log('Navigating to admin page for logout...');
        await page.goto('http://localhost:5173/admin');
        await page.waitForLoadState('networkidle');
        
        console.log('Looking for logout button...');
        const logoutButton = await page.waitForSelector('button:has-text("Logout")', { 
          timeout: 10000,
          state: 'visible'
        });
        
        console.log('Clicking logout button...');
        await logoutButton.click();
        
        console.log('Waiting for redirect to login...');
        await page.waitForURL('http://localhost:5173/login', { timeout: 10000 });
        console.log('Cleanup complete');
      } catch (error) {
        console.error('Cleanup failed:', error);
      }
    }
  });
}); 