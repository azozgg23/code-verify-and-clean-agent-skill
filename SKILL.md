SKILL-NAME: AI-OPTIMIZE
--------------------------
DESCRIPTION: A specialized engineering skill for AI Agents to systematically diagnose, refactor, and clean Next.js 15 and React 19 codebases. It ensures architectural integrity by enforcing server/client boundaries, resolving hydration mismatches, and optimizing data fetching patterns.
--------------------------
Content-skill :
1. Core Diagnostic Logic
Before performing any code modifications, the agent must audit the input code against the following technical criteria:
Asynchronous Request APIs: Verify if params, searchParams, cookies(), and headers() are handled as Promises. In Next.js 15, these must be explicitly awaited before accessing properties
.
Caching Defaults: Check fetch requests for caching intent. Next.js 15 has shifted the default from force-cache to no-store
. GET Route Handlers are also no longer cached by default
.
Hydration Consistency: Scan for non-deterministic data generation (e.g., new Date(), Math.random()) or browser-only APIs (window, localStorage) used directly in the component body, which causes mismatches between server and client renders
.
Architectural Boundaries: Identify "use client" directives used unnecessarily on top-level pages or layouts, which increases bundle size and disables server-side benefits like direct database access
.
Internal Network Hops: Detect if Server Components are calling local Route Handlers via fetch instead of calling logic or database queries directly
.
2. Refactoring & Optimization Workflow
Step 1: Version-Specific Corrections
Convert synchronous property access on params and searchParams to asynchronous using await
.
Explicitly define caching behavior for fetch (e.g., { cache: 'force-cache' }) if the data is static or requires revalidation
.
Step 2: Resolving Hydration & Rendering Issues
Wrap browser-dependent logic inside a useEffect hook or a mounted state check to ensure the initial client render matches the server render
.
Use dynamic imports with { ssr: false } for components that rely entirely on client-side APIs
.
Ensure valid HTML nesting (e.g., no <div> inside a <p>) to prevent browser auto-correction that triggers hydration errors
.
Step 3: Structural Refactoring (Clean Architecture)
Apply the React Composition pattern: Move stateful logic to the smallest possible Client Component and pass Server Components as children to keep the majority of the tree on the server
.
Replace standard <a> tags with the Next.js <Link> component to enable automatic prefetching and faster client-side transitions
.
Move redirect() calls outside of try/catch blocks because they function by throwing an internal Next.js error
.
Step 4: Data Fetching Efficiency
Identify sequential requests ("waterfalls") and refactor them into parallel fetches using Promise.all()
.
Use React Suspense boundaries to wrap dynamic components, allowing the page to stream and show loading skeletons instead of blocking the entire UI
.
3. Code Cleaning & Standards
Serialization Audit: Ensure no functions or non-serializable objects are passed across the server-to-client boundary
.
Accessibility & Performance: Ensure every <Image /> component has defined width, height, and alt text to prevent layout shifts and improve SEO
.
Parallel Routing Safety: Verify that every Parallel Route slot has a default.tsx file to prevent 404 errors during hard navigations or page refreshes
.
Logging: Remove production-level console.log statements. In Next.js 15 development, recognize that server logs are automatically forwarded to the browser console for better visibility
.
4. Strict Rules
Rule 1: Never pass a plain function as a prop from a Server Component to a Client Component; use Server Actions with the "use server" directive instead
.
Rule 2: Do not use "use client" in layout.tsx unless absolutely necessary for a global Context Provider
.
Rule 3: All metadata must be exported using the static metadata object or the generateMetadata function
.
