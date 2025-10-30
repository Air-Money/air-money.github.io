---
layout: default
title: React UI Library
nav_order: 4
description: Comprehensive React UI library for DEGN applications
---

# DEGN React UI Library

A comprehensive React UI library built with TypeScript, providing reusable components, hooks, and utilities for the DEGN application ecosystem. This library is designed for external developers to easily integrate DEGN's UI components into their applications.

## Installation

```bash
npm install @airmoney-degn/react-ui
# or
yarn add @airmoney-degn/react-ui
# or
pnpm add @airmoney-degn/react-ui
```

## Prerequisites

The React UI library requires the DEGN Controller SDK as a peer dependency:

```bash
npm install @airmoney-degn/controller-sdk
```

## Core Architecture

### AirMoneyModule

The `AirMoneyModule` is a namespace that provides all DEGN-specific functionality including components, hooks, and utilities for building DEGN dApps.

**Components:**
- `AirMoneyProvider` - Context provider component
- `Layout` - Main application layout component  

**Hooks:**
- `useAirMoney` - Hook to access DEGN context
- `useBack` - Hook for back navigation management (AirMoneyModule version - no keyEventManager needed)
- `useButton` - Hook for device button interactions (AirMoneyModule version - no keyEventManager needed)
- `useKeyEventListener` - Hook for keyboard event subscription (AirMoneyModule version - no keyEventManager needed)
- `useShift` - Hook for shift state management
- `useToast` - Hook for toast notifications

**Utilities:**
- `toast` - Utility function for creating toasts

> **Note:** The AirMoneyModule versions of `useBack`, `useButton`, and `useKeyEventListener` automatically use the `keyEventManager` from the DEGN context, so you don't need to pass it as a parameter. For general use outside of AirMoneyModule, import these hooks directly from `@airmoney-degn/react-ui` and pass the `keyEventManager` manually.

**Example:**
```tsx
import React from 'react';
import { AirMoneyModule } from '@airmoney-degn/react-ui';
import { createDefaultKeyEventManager } from '@airmoney-degn/controller-sdk';
import '@airmoney-degn/react-ui/style.css';

const { 
  AirMoneyProvider, 
  Layout, 
  useAirMoney, 
  useBack,
  useButton, 
  useKeyEventListener,
  useShift,
  useToast,
  toast
} = AirMoneyModule;

// Create key event manager once and persist across the app
const keyEventManager = createDefaultKeyEventManager();

function App() {
  return (
    <AirMoneyProvider keyEventManager={keyEventManager}>
      <Layout 
        debug={process.env.NODE_ENV === 'development'}
        version="1.0.0"
        healthCheckUrls={['https://api.example.com']}
      >
        <MyComponent />
      </Layout>
    </AirMoneyProvider>
  );
}

function MyComponent() {
  const { shift, setShift, keyEventManager } = useAirMoney();
  const { toast } = useToast();
  const { setLeftButton, setRightButton } = useButton();
  
  // Handle back navigation
  useBack(() => {
    console.log('Back button pressed');
  }, { name: 'MyComponent', priority: 1 });
  
  // Set up device buttons
  setLeftButton('left-icon.png', () => {
    console.log('Left button pressed');
    toast({ title: 'Left button!' });
  });
  
  setRightButton('right-icon.png', () => {
    console.log('Right button pressed');
    toast({ title: 'Right button!' });
  });
  
  // Handle keyboard events
  useKeyEventListener({
    triggers: [
      {
        condition: (event) => event.subType === "press" && event.data.key === 'Enter',
        trigger: () => toast({ title: 'Enter pressed!' })
      }
    ],
    name: 'MyComponent',
    priority: 1
  });

  return (
    <div>
      <p>Shift state: {shift ? 'Active' : 'Inactive'}</p>
      <button onClick={() => setShift(!shift)}>
        Toggle Shift
      </button>
      <button onClick={() => toast({ title: 'Hello from toast!', variant: 'successful' })}>
        Show Toast
      </button>
    </div>
  );
}

export default App;
```

> **Note:** AirMoneyModule is optional. You can also import components and hooks directly from `@airmoney-degn/react-ui` if you prefer not to use the module pattern.


**Features:**
- **Shift Indicator**: Shows a red bar in the top-left corner when shift is active
- **Error Boundaries**: Catches and displays errors gracefully
- **Network Status**: Monitors and displays connection status to specified URLs
- **Debug Mode**: Shows outline borders when `debug={true}`

## UI Components

### Basic Components

#### ErrorMessage
Display error messages with consistent styling and automatic error type handling.

**Props:**
- `error?: Error | null | string` - Error to display (Error object, string, or null)
- `className?: string` - Additional CSS classes
- `...props` - Additional HTML div attributes

**Example:**
```tsx
import { ErrorMessage } from '@airmoney-degn/react-ui';

function MyComponent() {
  const [error, setError] = useState(null);
  
  return (
    <div>
      <ErrorMessage error={error} />
      <button onClick={() => setError('Something went wrong!')}>
        Trigger Error
      </button>
    </div>
  );
}
```

#### SimpleLoading
Animated loading indicator with customizable speed and dot count.

**Props:**
- `speed?: number` - Animation speed in milliseconds (default: 300)
- `length?: number` - Number of dots to display (default: 3)
- `...props` - Additional HTML span attributes

**Example:**
```tsx
import { SimpleLoading } from '@airmoney-degn/react-ui';

function MyComponent() {
  return (
    <div>
      <p>Loading...</p>
      <SimpleLoading speed={200} length={4} />
    </div>
  );
}
```

### Display Components

#### ColoredValue
Value display with automatic color coding for positive, negative, and zero values.

**Props:**
- `value?: number` - Numeric value to display and color
- `defaultTextColor?: string` - Default text color when no value
- `positiveColor?: string` - Color for positive values (default: '#00BB74')
- `negativeColor?: string` - Color for negative values (default: '#FF404B')
- `zeroColor?: string` - Color for zero values (default: '#FFC10E')
- `children?: ReactNode` - Content to display (if no value provided)
- `className?: string` - Additional CSS classes
- `...props` - Additional HTML span attributes

**Example:**
```tsx
import { ColoredValue } from '@airmoney-degn/react-ui';

function MyComponent() {
  const profit = 123.45;
  const loss = -67.89;
  const zero = 0;
  
  return (
    <div>
      <ColoredValue value={profit}>+{profit}</ColoredValue>
      <ColoredValue value={loss}>{loss}</ColoredValue>
      <ColoredValue value={zero}>{zero}</ColoredValue>
      <ColoredValue 
        value={profit}
        positiveColor="#14C784"
        negativeColor="#EA3943"
        zeroColor="#9E9E9E"
      >
        Custom Colors: {profit}
      </ColoredValue>
    </div>
  );
}
```

### Keyboard Components

#### Keyboard
Full keyboard input component with multiple templates and customizable input components.

**Props:**
- `searchValue?: string` - Current input value
- `onSearchValueChange?: (value: string) => void` - Value change handler
- `components?: { Input?: FC<KeyboardInputProps> }` - Custom input component
- `onKeyClick?: (key: Key) => void` - Key click handler
- `onClearClick?: () => void` - Clear button click handler
- `onReturn?: (value: string) => void` - Return key handler
- `options?: TOption[]` - List of options for list mode
- `mode: 'keyboard' | 'list'` - Display mode
- `onModeChange?: (mode: 'keyboard' | 'list') => void` - Mode change handler
- `value?: TOption` - Selected option value
- `defaultTemplate?: keyof typeof KEYBOARD_TEMPLATES` - Keyboard layout template
- `disabled?: boolean` - Disable keyboard interaction
- `placeholder?: string` - Input placeholder text

**Types:**
- `TradingPair` - Object with `id`, `marketType`, `baseAsset`, `quoteAsset`, `change24h?`, `loading?`
- `Key` - Object with `id`, `value`, `row`, `column`
- `KeyboardRef` - Ref object with `onKeyChange`, `onKeyValueChange`

**Templates:**
- `ALPHABET` - Standard QWERTY layout
- `SHIFT_ALPHABET` - Uppercase letters
- `NUMBER` - Numbers and symbols
- `SPECIAL` - Special characters
- `COMPACT_ALPHABET` - Compact layout without function keys

**Example:**
```tsx
import { Keyboard } from '@airmoney-degn/react-ui';

function MyComponent() {
  const [inputValue, setInputValue] = useState('');
  
  return (
    <Keyboard
      searchValue={inputValue}
      onSearchValueChange={setInputValue}
      mode="keyboard"
      defaultTemplate="ALPHABET"
      placeholder="Enter text..."
      onReturn={(value) => console.log('Submitted:', value)}
    />
  );
}
```

#### KeyboardInputs
Collection of input components for keyboard integration with 3 variants:

```tsx
import { KeyboardInputs } from '@airmoney-degn/react-ui';

const { Input, MaskedInput, ButtonInput } = KeyboardInputs;
```

**1. KeyboardInput (Basic Input)**
Standard input component for text entry.

```tsx
<KeyboardInputs.Input 
  value={textValue}
  onClearValue={() => setTextValue('')}
  placeholder="Enter text..."
/>
```

**2. KeyboardMaskedInput (Masked Input)**
Input component with character masking for sensitive data.

```tsx
<KeyboardInputs.MaskedInput 
  value={password}
  onClearValue={() => setPassword('')}
  showCharacters={false}
  placeholder="Enter password"
/>
```

**3. KeyboardButtonInput (Input with Button)**
Input component with an integrated action button.

```tsx
<KeyboardInputs.ButtonInput 
  value={inputValue}
  onClearValue={() => setInputValue('')}
  onButtonClick={handleButtonClick}
  active={isButtonActive}
  ButtonLabel="Action"
  placeholder="Enter value..."
/>
```

**KeyboardInputs Props:**
- `value: string` - Current input value
- `onClearValue?: () => void` - Clear button handler
- `placeholder?: string` - Input placeholder
- `disabled?: boolean` - Disable input
- `showCharacters?: boolean` - (MaskedInput) Show characters temporarily
- `onButtonClick?: (e: React.MouseEvent<HTMLButtonElement>) => void` - (ButtonInput) Button click handler
- `active?: boolean` - (ButtonInput) Button active state
- `ButtonLabel?: ReactNode` - (ButtonInput) Button label content

### Layout Components

#### Frame
Main container component that fits the device screen dimensions.

**Props:**
- `children: ReactNode` - Content to render inside the frame
- `debug?: boolean` - Show outline border for debugging
- `className?: string` - Additional CSS classes
- `...props` - Additional HTML div attributes

**Features:**
- Fixed dimensions: 800px width × 480px height (device screen size)
- Positioned with 2px left offset
- Optional debug outline when `debug={true}`

**Example:**
```tsx
import { Frame } from '@airmoney-degn/react-ui';

function MyApp() {
  return (
    <Frame debug={process.env.NODE_ENV === 'development'}>
      <div>Your app content here</div>
    </Frame>
  );
}
```

#### CenteredFlex
Flex container component with centered content alignment.

**Props:**
- `children: ReactNode` - Content to center
- `className?: string` - Additional CSS classes
- `...props` - Additional HTML div attributes

**Features:**
- Uses flexbox with `items-center` and `justify-center`
- Forward ref support

**Example:**
```tsx
import { CenteredFlex } from '@airmoney-degn/react-ui';

function MyComponent() {
  return (
    <CenteredFlex className="h-64">
      <div>This content is perfectly centered</div>
    </CenteredFlex>
  );
}
```

#### StatefulBox
Interactive box component with visual state feedback and animations.

**Props:**
- `children: ReactNode` - Content to render inside the box
- `active?: boolean` - Active state (triggers animation)
- `focused?: boolean` - Focused state (shows border)
- `activeColor?: string` - Color for active state (default: '#3CDA24')
- `focusedColor?: string` - Color for focused state (default: '#C4C4C4')
- `borderWidth?: string` - Border width (default: '1px')
- `onClick?: (e: React.MouseEvent<HTMLDivElement>) => void` - Click handler
- `className?: string` - Additional CSS classes
- `...props` - Additional HTML div attributes

**Features:**
- Automatic scale animation on active state (75ms duration)
- Visual feedback with colored borders
- Click interaction support
- CSS custom properties for colors

**Example:**
```tsx
import { StatefulBox } from '@airmoney-degn/react-ui';

function MyComponent() {
  const [isActive, setIsActive] = useState(false);
  const [isFocused, setIsFocused] = useState(false);
  
  return (
    <StatefulBox
      active={isActive}
      focused={isFocused}
      activeColor="#3CDA24"
      focusedColor="#C4C4C4"
      borderWidth="2px"
      onClick={() => setIsActive(true)}
      onMouseEnter={() => setIsFocused(true)}
      onMouseLeave={() => setIsFocused(false)}
    >
      <div>Interactive content</div>
    </StatefulBox>
  );
}
```

### Input Components

#### NumPad
Numeric input pad for number entry with decimal support and validation.

**Props:**
- `value?: string` - Current numeric value
- `onChange?: (value: string) => void` - Value change handler
- `onError?: (message: string) => void` - Error handler for invalid input
- `decimalPlaces?: number` - Maximum decimal places allowed

**Types:**
- `NumPadRef` - Ref object with `key.onKeyChange` method
- `NumKey` - String values: '0'-'9', '.', 'singleClear'

**Example:**
```tsx
import { NumPad } from '@airmoney-degn/react-ui';

function MyComponent() {
  const [value, setValue] = useState('0');
  
  return (
    <NumPad
      value={value}
      onChange={setValue}
      onError={(message) => console.error(message)}
      decimalPlaces={2}
    />
  );
}
```

### Network Components

#### NetworkConnection
Network status checking wrapper that shows connection status when offline.

**Props:**
- `children: ReactNode` - Content to render when online
- `healthCheckUrls?: string | string[]` - URLs to check for network connectivity
- `keyEventManager: AirMoneyKeyEventManager` - Key event manager instance

**Example:**
```tsx
import { NetworkConnection } from '@airmoney-degn/react-ui';
import { createDefaultKeyEventManager } from '@airmoney-degn/controller-sdk';

const keyEventManager = createDefaultKeyEventManager();

function App() {
  return (
    <NetworkConnection 
      healthCheckUrls={['https://api.example.com']}
      keyEventManager={keyEventManager}
    >
      <YourAppContent />
    </NetworkConnection>
  );
}
```

#### NetworkConnectionStatus
Network connection status display component with retry functionality.

**Props:**
- `healthCheckUrls?: string | string[]` - URLs to check for network connectivity
- `keyEventManager: AirMoneyKeyEventManager` - Key event manager instance
- `attempt: number` - Current attempt number
- `counter: number` - Connection attempt counter
- `errorMessage?: string` - Error message to display
- `result?: any` - Network check result
- `retry: () => void` - Retry connection function
- `setIsOnline: (online: boolean) => void` - Set online status function
- `loading: boolean` - Loading state
- `isOnline: boolean` - Current online status

**Example:**
```tsx
import { NetworkConnectionStatus } from '@airmoney-degn/react-ui';
import { createDefaultKeyEventManager } from '@airmoney-degn/controller-sdk';

const keyEventManager = createDefaultKeyEventManager();

function MyComponent() {
  const { isOnline, loading, errorMessage, retry } = useNetworkStatus(['https://api.example.com']);
  
  return (
    <NetworkConnectionStatus
      healthCheckUrls={['https://api.example.com']}
      keyEventManager={keyEventManager}
      isOnline={isOnline}
      loading={loading}
      errorMessage={errorMessage}
      retry={retry}
      // ... other props from useNetworkStatus
    />
  );
}
```

### Error Handling Components

#### ErrorScreen
Error boundary with fallback UI for handling loading and error states.

**Props:**
- `value?: T` - Data value
- `loading: boolean` - Loading state
- `error?: string` - Error message
- `children: (value: Exclude<T, undefined>) => ReactNode` - Render function for valid data
- `onBack?: () => void` - Back navigation handler
- `keyEventManager?: AirMoneyKeyEventManager` - Key event manager instance

**Example:**
```tsx
import { ErrorScreen } from '@airmoney-degn/react-ui';
import { createDefaultKeyEventManager } from '@airmoney-degn/controller-sdk';

const keyEventManager = createDefaultKeyEventManager();

function MyComponent() {
  const { data, loading, error } = useData();
  
  return (
    <ErrorScreen
      value={data}
      loading={loading}
      error={error}
      keyEventManager={keyEventManager}
      onBack={() => console.log('Back pressed')}
    >
      {(validData) => <div>Data: {validData}</div>}
    </ErrorScreen>
  );
}
```

#### ErrorDetail
Detailed error information display with optional debug mode and reset functionality.

**Props:**
- `error: any` - Error object to display
- `debug?: boolean` - Show debug information (stack trace)
- `reset?: () => void` - Reset function for error recovery

**Example:**
```tsx
import { ErrorDetail } from '@airmoney-degn/react-ui';

function MyComponent() {
  const [error, setError] = useState(null);
  
  return (
    <ErrorDetail
      error={error}
      debug={process.env.NODE_ENV === 'development'}
      reset={() => setError(null)}
    />
  );
}
```

#### FullscreenMessage
Full-screen message display with optional loading indicator.

**Props:**
- `children: ReactNode` - Message content to display
- `loading?: boolean` - Show loading indicator
- `className?: string` - Additional CSS classes
- `...props` - Additional HTML div attributes

**Example:**
```tsx
import { FullscreenMessage } from '@airmoney-degn/react-ui';

function MyComponent() {
  return (
    <FullscreenMessage loading={isLoading}>
      <div>Processing your request...</div>
    </FullscreenMessage>
  );
}
```

## Hooks

### Navigation Hooks

#### useCarousel
Carousel navigation hook for array navigation with configurable behavior.

**Parameters:**
- `options: T` - Array of items to navigate (primitive or object arrays)
- `config: CarouselConfig<IdKey, Id>` - Configuration options

**Returns:** `[value, controls]` - Current value and navigation controls

**Configuration:**
- `loop?: boolean` - Whether to loop around when reaching ends (default: false)
- `idKey?: IdKey` - Key to use as identifier for object arrays
- `fallbackId?: Id` - Fallback ID for initialization
- `throttleMs?: number` - Minimum milliseconds between navigation calls (default: 0)

**Controls:**
- `goNext()` - Navigate to next item
- `goPrev()` - Navigate to previous item
- `goTo(index: number)` - Go to specific index
- `goToById(id: Id)` - Go to item by ID (object arrays)
- `currentIndex: number` - Current index
- `prevIndex: number` - Previous index
- `nextIndex: number` - Next index

#### useBack
Handle back navigation with key event management.

**Parameters:**
- `keyEventManager?: AirMoneyKeyEventManager` - Key event manager instance
- `onBack?: () => void` - Back navigation handler
- `config?: QuickKeyEventTriggerConfig` - Event trigger configuration

### Device Integration Hooks

#### useButton
Handle device button interactions with image display.

**Returns:**
- `setLeftButton(imageName: string, fnConfig: FnInput)` - Set left button
- `setRightButton(imageName: string, fnConfig: FnInput)` - Set right button
- `setBothButtons(imageName: string, fnConfig: FnInput)` - Set both buttons

**FnInput Types:**
- `Fn` - Single function
- `FnConfig[]` - Array of function configurations
- `FnConfig` - `{ fn?: Fn; keyAction: 'press' | 'longpressdown' | 'longpressup' }`

#### useKeyEventListener
Listen to keyboard events with subscription management.

**Parameters:**
- `keyEventManager?: AirMoneyKeyEventManager` - Key event manager
- `config?: AMKeyEventTriggerGroupConfig` - Event trigger group configuration

#### useShift
Handle shift state management with key event integration.

**Parameters:**
- `config: QuickKeyEventTriggerConfig & { resetOnUnmount?: boolean }` - Configuration

### State Management Hooks

#### useNetworkStatus
Monitor network connectivity with health check URLs.

**Parameters:**
- `networkCheckingUrl?: string | string[]` - URLs to check for connectivity

**Returns:**
- `isOnline: boolean` - Network connectivity status
- `attempt: number` - Current attempt number
- `errorMessage?: string` - Error message if connection fails
- `loading: boolean` - Loading state during checks
- `retry: () => void` - Retry connection
- `counter: number` - Timeout counter
- `setIsOnline: (online: boolean) => void` - Manually set online status
- `result: { [url: string]: boolean }` - Results for each URL

### Utility Hooks

#### useThrottle
Throttle function calls based on time intervals for performance optimization.

**Parameters:**
- `throttleMs: number` - Minimum milliseconds between function calls (0 = no throttling)

**Returns:** Throttled function that wraps the original function

#### useLatestCallback
Ensure callback always has the latest values to prevent stale closures.

**Parameters:**
- `fn: T` - Function to wrap

**Returns:** Latest callback function

#### useScrollIntoView
Scroll element into view when focused.

**Parameters:**
- `focused: boolean` - Whether element should be scrolled into view

**Returns:** Ref to attach to the element

#### useFitText
Auto-adjust font size so text fits within its container.

**Parameters:**
- `text: string | undefined` - Text to fit
- `textRef?: RefObject<T | null>` - Optional ref to text element
- `minFontSize: number` - Minimum font size allowed
- `maxFontSize: number` - Maximum font size allowed

**Returns:**
- `fontSize: number` - Calculated font size
- `textRef: RefObject<T | null>` - Text element ref

#### useFakeTransactionMessage
Simulate transaction messages with loading states and toast notifications.

**Returns:**
- `fakeTransactionMessage: (loadingMessage: string, successMessage?: string, timeout?: number) => Promise<boolean>` - Transaction message function

**Parameters:**
- `loadingMessage: string` - Message to show during loading
- `successMessage?: string` - Success message (default: "Success!")
- `timeout?: number` - Loading timeout in ms (default: 1000)

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
percentize(0.1234, 1, Decimal.Rounding.HALF_UP); // 12.3

// Rounding
round(123.456, 2, Decimal.Rounding.HALF_UP); // 123.46

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

### Back Navigation

#### isBack
Check if an event is a back navigation event.

```tsx
import { isBack } from '@airmoney-degn/react-ui';

const handleKeyEvent = (event) => {
  if (isBack(event)) {
    // Handle back navigation
  }
};
```

## Styling

The library uses Tailwind CSS with a custom `am-` prefix to avoid conflicts. Import the CSS file:

```tsx
import '@airmoney-degn/react-ui/style.css';
```


## TypeScript Support

The library is fully typed with TypeScript. All components, hooks, and utilities include comprehensive type definitions.

## Device Integration

This library is designed to work with DEGN's hardware devices. It includes:

- Device button handling
- Key event management
- Image display on device screens
- Hardware-specific interactions

## API Reference

### Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `AirMoneyProvider` | Context provider for DEGN functionality | `{ children: ReactNode, keyEventManager: AirMoneyKeyEventManager }` |
| `Layout` | Main application layout with error boundaries and network checking | `{ children: ReactNode, debug?: boolean, version?: string, healthCheckUrls?: string \| string[] }` |
| `Frame` | Main container that fits device screen dimensions | `{ children: ReactNode, debug?: boolean }` |
| `CenteredFlex` | Flex container with centered content alignment | `{ children: ReactNode, className?: string }` |
| `StatefulBox` | Interactive box with visual state feedback and animations | `{ children: ReactNode, active?: boolean, focused?: boolean, activeColor?: string, focusedColor?: string, borderWidth?: string, onClick?: (e: MouseEvent) => void }` |
| `Keyboard` | Full keyboard input component with multiple templates | `{ searchValue?: string, onSearchValueChange?: (value: string) => void, mode: 'keyboard' \| 'list', defaultTemplate?: string, onReturn?: (value: string) => void, disabled?: boolean, placeholder?: string }` |
| `KeyboardInputs` | Collection of input components for keyboard integration | `{ Input, MaskedInput, ButtonInput }` |
| `NumPad` | Numeric input pad for number entry with decimal support | `{ value?: string, onChange?: (value: string) => void, onError?: (message: string) => void, decimalPlaces?: number }` |
| `ColoredValue` | Value display with automatic color coding | `{ value?: number, positiveColor?: string, negativeColor?: string, zeroColor?: string, children?: ReactNode }` |
| `ErrorMessage` | Error message display with consistent styling | `{ error?: Error \| null \| string, className?: string }` |
| `SimpleLoading` | Animated loading indicator | `{ speed?: number, length?: number }` |
| `NetworkConnection` | Network status checking wrapper | `{ children: ReactNode, healthCheckUrls?: string \| string[], keyEventManager: AirMoneyKeyEventManager }` |
| `NetworkConnectionStatus` | Network connection status display | `{ healthCheckUrls?: string \| string[], keyEventManager: AirMoneyKeyEventManager, isOnline: boolean, loading: boolean, errorMessage?: string, retry: () => void }` |
| `ErrorScreen` | Error boundary with fallback UI | `{ value?: T, loading: boolean, error?: string, children: (value: Exclude<T, undefined>) => ReactNode, onBack?: () => void, keyEventManager?: AirMoneyKeyEventManager }` |
| `ErrorDetail` | Detailed error information display | `{ error: any, debug?: boolean, reset?: () => void }` |
| `FullscreenMessage` | Full-screen message display | `{ children: ReactNode, loading?: boolean, className?: string }` |

### Hooks

| Hook | Description | Returns |
|------|-------------|---------|
| `useAirMoney` | Access DEGN context | `{ shift: boolean \| undefined, setShift: (shift: boolean) => void, keyEventManager: AirMoneyKeyEventManager }` |
| `useBack` | Handle back navigation with key event management | `void` |
| `useButton` | Handle device button interactions with image display | `{ setLeftButton: (imageName: string, fnConfig: FnInput) => void, setRightButton: (imageName: string, fnConfig: FnInput) => void, setBothButtons: (imageName: string, fnConfig: FnInput) => void }` |
| `useKeyEventListener` | Listen to keyboard events with subscription management | `void` |
| `useShift` | Handle shift state management with key event integration | `void` |
| `useToast` | Manage toast notifications with state | `{ toasts: ToasterToast[], toast: (props: Toast) => { id: string, dismiss: () => void, update: (props: Toast) => void }, dismiss: (toastId?: string) => void, update: (toastId: string, props: Toast) => void }` |
| `useCarousel` | Carousel navigation for array navigation | `[value, controls]` |
| `useNetworkStatus` | Monitor network connectivity with health check URLs | `{ isOnline: boolean, attempt: number, errorMessage?: string, loading: boolean, retry: () => void, counter: number, setIsOnline: (online: boolean) => void, result: { [url: string]: boolean } }` |
| `useThrottle` | Throttle function calls for performance optimization | `(fn: () => T) => T \| undefined` |
| `useLatestCallback` | Ensure callback always has latest values | `(fn: T) => T` |
| `useScrollIntoView` | Scroll element into view when focused | `RefObject<T>` |
| `useFitText` | Auto-adjust font size to fit container | `{ fontSize: number, textRef: RefObject<T \| null> }` |
| `useFakeTransactionMessage` | Simulate transaction messages with loading states | `(loadingMessage: string, successMessage?: string, timeout?: number) => Promise<boolean>` |

### Utilities

| Utility | Description | Parameters |
|---------|-------------|------------|
| `toast` | Create toast notifications programmatically | `(props: Toast) => { id: string, dismiss: () => void, update: (props: Toast) => void }` |
| `currency` | Currency formatting utility | `(value: number \| string \| undefined, options?: { prefix?: string, isSign?: boolean, intlOptions?: Intl.NumberFormatOptions }) => string \| undefined` |
| `percentize` | Percentage formatting utility | `(value: any, decimalPlaces: number, roundingMode: Decimal.Rounding) => number \| undefined` |
| `round` | Rounding utility | `(value: number \| string \| undefined, decimalPlaces: number, roundingMode: Decimal.Rounding) => number \| undefined` |
| `formatAddress` | Address formatting utility | `(address: string, startChars?: number, endChars?: number) => string` |
| `display` | Display utility with loading state | `(value: any, options?: { loading?: boolean, Skeleton?: ReactNode, transform?: (v: ValueGuard<T>) => any }) => ReactNode` |
| `isNumber` | Check if value is a number | `(value: any) => boolean` |
| `isNumberLike` | Check if value is number-like | `(value: any) => boolean` |
| `toNumberOrZero` | Convert to number or return zero | `(value: any) => number` |
| `toNumberOrUndefined` | Convert to number or return undefined | `(value: any) => number \| undefined` |
| `isBack` | Check if event is a back navigation event | `(event: AMEvent<'key-event'>) => boolean` |
| `debounce` | Debounce function calls | `(func: T, delay: number) => (...args: Parameters<T>) => void` |
| `sign` | Get sign of a number | `(value: number \| string \| undefined) => '+' \| '-' \| ''` |