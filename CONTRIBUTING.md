# Contribution Guidelines

## General Guidelines

- **Min iOS SDK**: 9.0
- **Min macOS SDK**: 10.10
- **Language**: Swift (v3)
- **Tests**: Yes, please

#### Architecture guidelines

- Avoid singletons that don't encapsulate a finite resource
- Never expose mutable state
- Public API designed to be called safely from any thread
- Keep classes/methods sharply focused
- Stay generic

## Style Guide

#### Base style:

Please add new code to this project based on the following style guidelines:

- [Apple's Coding Guidelines for Cocoa](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html)
- [NYTimes Objective C Style Guidelines](https://github.com/NYTimes/objective-c-style-guide)

#### Additions:

- Prefix all class names with `YM`
- Group related methods with `//MARK:`
- Keep as much of the API private as is practically possible
