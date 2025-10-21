<!-- ---
layout: default
title: React UI Library
nav_order: 4
description: Comprehensive React UI library for AirMoney applications
---

# AirMoney React UI Library

A comprehensive React UI library built with TypeScript, providing reusable components, hooks, and utilities for the AirMoney application ecosystem. This library is designed for external developers to easily integrate AirMoney's UI components into their applications.

## Installation

```bash
npm install @airmoney-degn/react-ui
# or
yarn add @airmoney-degn/react-ui
# or
pnpm add @airmoney-degn/react-ui
```

## Prerequisites

The React UI library requires the AirMoney Controller SDK as a peer dependency:

```bash
npm install @airmoney-degn/controller-sdk
```

## Quick Start

### Basic Setup

```tsx
import React from 'react';
import { AppProvider, useApp } from '@airmoney-degn/react-ui';
import '@airmoney-degn/react-ui/style.css';

function App() {
  return (
    <AppProvider>
      <MyComponent />
    </AppProvider>
  );
}

function MyComponent() {
  const { setLog } = useApp();
  
  return (
    <div onClick={() => setLog('Component clicked!')}>
      Click me
    </div>
  );
}

export default App;
```

## Core Architecture

### AppProvider

The `AppProvider` is the central context provider that manages the application state and provides access to device functionality.

```tsx
import { AppProvider, useApp } from '@airmoney-degn/react-ui';

function App() {
  return (
    <AppProvider>
      <YourApp />
    </AppProvider>
  );
}

function YourApp() {
  const { 
    logs, 
    setLog, 
    leftImage, 
    setLeftImage, 
    rightImage, 
    setRightImage,
    shift,
    setShift,
    keyEventManager 
  } = useApp();
  
  // Use the context values
  return <div>Your app content</div>;
}
```

### Layout Component

The `Layout` component provides the main application structure with error boundaries, network checking, and debug tools.

```tsx
import { Layout } from '@airmoney-degn/react-ui';

function App() {
  return (
    <Layout debug={true} version="1.0.0">
      <YourContent />
    </Layout>
  );
}
```

## UI Components

### Basic Components



#### ErrorMessage
Display error messages with consistent styling.

```tsx
import { ErrorMessage } from '@airmoney-degn/react-ui';

<ErrorMessage error={errorMessage} />
```

#### SimpleLoading
Loading indicator component.

```tsx
import { SimpleLoading } from '@airmoney-degn/react-ui';

<SimpleLoading />
```


### Display Components

#### ColoredValue
Value display with color coding for positive/negative values.

```tsx
import { ColoredValue } from '@airmoney-degn/react-ui';

<ColoredValue 
  value={123.45}
  positiveColor="#14C784"
  negativeColor="#EA3943"
  zeroColor="#9E9E9E"
/>
```

### Keyboard Components

#### Keyboard
Full keyboard input component with multiple templates.

```tsx
import { Keyboard } from '@airmoney-degn/react-ui';

<Keyboard 
  searchValue={inputValue}
  onSearchValueChange={setInputValue}
  mode="keyboard"
  onModeChange={setMode}
  onReturn={handleSubmit}
  disabled={false}
  placeholder="Enter text..."
/>
```

#### KeyboardInput
Text input with keyboard integration.

```tsx
import { KeyboardInput } from '@airmoney-degn/react-ui';

<KeyboardInput 
  value={textValue}
  onClearValue={() => setTextValue('')}
  placeholder="Enter text..."
/>
```

#### KeyboardMaskedInput
Masked input for sensitive data.

```tsx
import { KeyboardMaskedInput } from '@airmoney-degn/react-ui';

<KeyboardMaskedInput 
  value={password}
  onClearValue={() => setPassword('')}
  showCharacters={false}
  placeholder="Enter password"
/>
```

### Layout Components

#### Frame
Main container component.

```tsx
import { Frame } from '@airmoney-degn/react-ui';

<Frame>
  <YourContent />
</Frame>
```

#### CenteredFlex
Flex container with centered content.

```tsx
import { CenteredFlex } from '@airmoney-degn/react-ui';

<CenteredFlex>
  <div>Centered content</div>
</CenteredFlex>
```

## Hooks

### Navigation Hooks

#### useCarousel
Carousel navigation hook with configurable behavior.

```tsx
import { useCarousel } from '@airmoney-degn/react-ui';

const [value, controls] = useCarousel(['A', 'B', 'C'], {
  loop: false,        // Non-looping by default
  throttleMs: 100     // Throttle navigation
});

// Controls
controls.goNext();    // Go to next item
controls.goPrev();    // Go to previous item
controls.goTo(1);     // Go to specific index
controls.goToById('B'); // Go to item by ID (for object arrays)
```

#### useBack
Handle back navigation.

```tsx
import { useBack } from '@airmoney-degn/react-ui';

const { goBack, canGoBack } = useBack();

if (canGoBack) {
  goBack();
}
```

### Input Hooks

#### useDeviceButton
Handle device button interactions.

```tsx
import { useDeviceButton } from '@airmoney-degn/react-ui';

const { setLeftButton, setRightButton, setBothButtons } = useDeviceButton();

// Set button with image and function
setLeftButton('button-image.png', () => {
  console.log('Left button pressed');
});

// Set button with multiple actions
setRightButton('button-image.png', [
  { keyAction: 'press', fn: () => console.log('Pressed') },
  { keyAction: 'longpressdown', fn: () => console.log('Long press down') }
]);
```

#### useKeyEventListener
Listen to keyboard events.

```tsx
import { useKeyEventListener } from '@airmoney-degn/react-ui';

useKeyEventListener({
  triggers: [
    {
      condition: (event) => event.subType === 'press' && event.data.key === 'Enter',
      trigger: () => console.log('Enter key pressed'),
    }
  ],
  priority: 10,
  name: 'MyComponent'
});
```

### State Management Hooks

#### usePairValue
Manage paired values (e.g., currency pairs).

```tsx
import { usePairValue } from '@airmoney-degn/react-ui';

const { 
  value, 
  usdValue, 
  setValue, 
  setUsdValue 
} = usePairValue({
  decimalPlaces: 2,
  usdDecimalPlaces: 2,
  price: 0.000025,
  usdStep: 0.01,
  defaultUsdValue: '100'
});
```

#### useNetworkStatus
Monitor network connectivity.

```tsx
import { useNetworkStatus } from '@airmoney-degn/react-ui';

const { isOnline, isChecking, retry } = useNetworkStatus('https://api.example.com');
```

#### useThrottle
Throttle function calls for performance.

```tsx
import { useThrottle } from '@airmoney-degn/react-ui';

const throttledFunction = useThrottle(100); // 100ms throttle

const handleScroll = () => {
  throttledFunction(() => {
    console.log('Scroll event throttled');
  });
};
```

### Utility Hooks

#### useLatestCallback
Ensure callback always has latest values.

```tsx
import { useLatestCallback } from '@airmoney-degn/react-ui';

const latestCallback = useLatestCallback((value) => {
  console.log('Latest value:', value);
});
```

#### useScrollIntoView
Scroll element into view.

```tsx
import { useScrollIntoView } from '@airmoney-degn/react-ui';

const scrollRef = useScrollIntoView();

<div ref={scrollRef}>This will scroll into view</div>
```

#### useFitText
Auto-adjusts font size so that text fits within its container.

```tsx
import { useFitText } from '@airmoney-degn/react-ui';

const { fontSize, textRef } = useFitText({
  text: "This is a long text that needs to fit",
  minFontSize: 12,
  maxFontSize: 48
});

<div style={&#123; width: 200, height: 100 &#125;}>
  <span 
    ref={textRef} 
    style={&#123; fontSize: fontSize + 'px' &#125;}
  >
    {text}
  </span>
</div>
```

## Utilities

### Formatter
Comprehensive formatting utilities.

```tsx
import { 
  currency, 
  percentize, 
  round, 
  formatAddress,
  display 
} from '@airmoney-degn/react-ui';

// Currency formatting
currency(1234.56, { prefix: '$' }); // "$1,234.56"

// Percentage formatting
percentize(0.1234, 1); // 12.3

// Rounding
round(123.456, 2); // 123.46

// Address formatting
formatAddress('0x1234567890abcdef'); // "0x1234...cdef"

// Display with loading state
display(value, { 
  loading: isLoading,
  transform: (v) => `$${v}` 
});
```

### Validation
Input validation utilities.

```tsx
import { 
  isNumber, 
  isNumberLike, 
  toNumberOrZero,
  toNumberOrUndefined 
} from '@airmoney-degn/react-ui';

isNumber(123); // true
isNumberLike("123.45"); // true
toNumberOrZero("abc"); // 0
toNumberOrUndefined("123"); // 123
```


## Styling

The library uses Tailwind CSS with a custom `am-` prefix to avoid conflicts. Import the CSS file:

```tsx
import '@airmoney-degn/react-ui/style.css';
```

### Custom CSS Variables

The library supports CSS custom properties for theming:

```css
:root {
  --background: 0 0% 100%;
  --foreground: 222.2 84% 4.9%;
  --primary: 221.2 83.2% 53.3%;
  --primary-foreground: 210 40% 98%;
  /* ... more variables */
}
```

## TypeScript Support

The library is fully typed with TypeScript. All components, hooks, and utilities include comprehensive type definitions.

## Device Integration

This library is designed to work with AirMoney's hardware devices. It includes:

- Device button handling
- Key event management
- Image display on device screens
- Hardware-specific interactions

## Best Practices

### 1. Always Use AppProvider

Wrap your application with the `AppProvider` for full functionality:

```tsx
import { AppProvider } from '@airmoney-degn/react-ui';

function App() {
  return (
    <AppProvider>
      <YourApp />
    </AppProvider>
  );
}
```

### 2. Use Layout for Main Structure

Use the `Layout` component for the main application structure:

```tsx
import { Layout } from '@airmoney-degn/react-ui';

function App() {
  return (
    <Layout debug={process.env.NODE_ENV === 'development'}>
      <YourContent />
    </Layout>
  );
}
```

### 3. Leverage Hooks for State Management

Use the provided hooks for common patterns:

```tsx
import { useCarousel, useDeviceButton } from '@airmoney-degn/react-ui';

function MyComponent() {
  const [selectedItem, controls] = useCarousel(items);
  const { setLeftButton } = useDeviceButton();
  
  // Component logic
}
```

## Examples

### Complete Form Example

```tsx
import React, { useState } from 'react';
import { 
  AppProvider, 
  useCarousel,
  useApp 
} from '@airmoney-degn/react-ui';

function FormExample() {
  const { setLog } = useApp();
  
  const [selectedCurrency, controls] = useCarousel(
    ['USD', 'EUR', 'BTC', 'ETH'],
    { loop: false }
  );
  
  const handleSubmit = () => {
    setLog(`Submitted: ${selectedCurrency}`);
  };
  
  return (
    <div>
      <div>
        Currency: {selectedCurrency}
        <button onClick={controls.goNext}>Next</button>
        <button onClick={controls.goPrev}>Prev</button>
      </div>
      
      <div onClick={handleSubmit}>
        Submit
      </div>
    </div>
  );
}

function App() {
  return (
    <AppProvider>
      <FormExample />
    </AppProvider>
  );
}
```

 -->
