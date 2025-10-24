---
layout: default
title: AirMoney Service API
nav_order: 6
description: API for AirMoney device display and interaction services
---

# AirMoney Service API

This guide provides direct API integration methods for AirMoney device services. The AirMoney Service handles display operations, animations, and device interactions via JSON-RPC 2.0 protocol over HTTP.

## Base URL

- **AirMoney Service**: `http://localhost:4040`

## Display Images

Display static images on device screens.

**Endpoint**: `POST http://localhost:4040`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "setImage",
  "params": ["app-name/assets/images/welcome.png", "left"],
  "id": "1"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "1",
  "result": {
    "status": "success",
    "message": "Image displayed successfully"
  }
}
```

**Parameters**:
- `imagePath`: Full path to image relative to app assets (`app-name/assets/path/to/image.png`)
- `screen`: Screen identifier (`"left"` or `"right"`)

## Display Animations

Display animated GIFs on device screens.

**Endpoint**: `POST http://localhost:4040`

**Request**:
```json
{
  "jsonrpc": "2.0",
  "method": "setAnimate",
  "params": ["app-name/assets/animations/loading.gif", "right"],
  "id": "2"
}
```

**Response**:
```json
{
  "jsonrpc": "2.0",
  "id": "2",
  "result": {
    "status": "success",
    "message": "Animation displayed successfully"
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
