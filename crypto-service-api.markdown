---
layout: default
title: Crypto Service API
nav_order: 7
description: API for blockchain operations including EVM, Solana, and Bitcoin
---

# Crypto Service API

This guide provides direct API integration methods for blockchain operations. The Crypto Service handles wallet management, message signing, and transaction signing for EVM-compatible chains, Solana, and Bitcoin via JSON-RPC 2.0 protocol over HTTP.

## Base URL

- **Crypto Service**: `http://localhost:5050`

## EVM Operations

### Get Default EVM Wallet

**Endpoint**: `POST http://localhost:5050`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "getDefaultEvmWallet",
  "params": [],
  "id": "3"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "3",
  "result": {
    "status": "success",
    "address": "0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6"
  }
}
```

### Sign EVM Message

**Endpoint**: `POST http://localhost:5050`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "signEvmMessage",
  "params": ["0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6", "Hello, World!"],
  "id": "4"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "4",
  "result": {
    "status": "success",
    "message": "Hello, World!",
    "signature": "0x1234567890abcdef..."
  }
}
```

### Sign EVM Transaction

**Endpoint**: `POST http://localhost:5050`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "signEvmTransaction",
  "params": [
    "0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6",
    {
      "to": "0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6",
      "value": "0xde0b6b3a7640000",
      "gasLimit": "0x5208",
      "gasPrice": "0x3b9aca00"
    },
    "0x1"
  ],
  "id": "5"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "5",
  "result": {
    "status": "success",
    "signed_transaction": "0x1234567890abcdef..."
  }
}
```

### Sign EIP-712 Typed Data

**Endpoint**: `POST http://localhost:5050`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "signEip712TypedData",
  "params": [
    {
      "address": "0x742d35Cc6634C0532925a3b8D4C9db96C4b4d8b6",
      "typed_data": {
        "domain": { "name": "MyApp", "version": "1" },
        "types": { 
          "Person": [{ "name": "name", "type": "string" }] 
        },
        "primaryType": "Person",
        "message": { "name": "Alice" }
      }
    }
  ],
  "id": "6"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "6",
  "result": {
    "status": "success",
    "signature": "0x1234567890abcdef..."
  }
}
```

## Solana Operations

### Get Default Solana Wallet

**Endpoint**: `POST http://localhost:5050`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "getDefaultSvmWallet",
  "params": [],
  "id": "7"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "7",
  "result": {
    "status": "success",
    "address": "9WzDXwBbmkg8ZTbNMqUxvQRAyrZzDsGYdLVL9zYtAWWM"
  }
}
```

### Sign Solana Message

**Endpoint**: `POST http://localhost:5050`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "signSolanaMessage",
  "params": ["9WzDXwBbmkg8ZTbNMqUxvQRAyrZzDsGYdLVL9zYtAWWM", "Hello, Solana!"],
  "id": "8"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "8",
  "result": {
    "status": "success",
    "message": "Hello, Solana!",
    "signature": "base64-encoded-signature"
  }
}
```

### Sign Solana Transaction

**Endpoint**: `POST http://localhost:5050`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "signSolanaTransaction",
  "params": [
    {
      "address": "9WzDXwBbmkg8ZTbNMqUxvQRAyrZzDsGYdLVL9zYtAWWM",
      "transaction_base64": "base64-encoded-transaction"
    }
  ],
  "id": "9"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "9",
  "result": {
    "status": "success",
    "signed_transaction": "base64-encoded-signed-transaction"
  }
}
```

## Bitcoin Operations

### Get Default Bitcoin Wallet

**Endpoint**: `POST http://localhost:5050`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "getDefaultBitcoinWallet",
  "params": [],
  "id": "10"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "10",
  "result": {
    "status": "success",
    "address": "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"
  }
}
```

### Sign Bitcoin Message

**Endpoint**: `POST http://localhost:5050`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "signBitcoinMessage",
  "params": ["1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa", "Hello, Bitcoin!"],
  "id": "11"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "11",
  "result": {
    "status": "success",
    "message": "Hello, Bitcoin!",
    "signature": "signature-string"
  }
}
```

## Error Handling

All JSON-RPC responses follow this structure:

**Success Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "request-id",
  "result": {
    "status": "success",
    "data": "response-data"
  }
}
```

**Error Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "request-id",
  "error": {
    "code": -32601,
    "message": "Method not found"
  }
}
```
