# OutlineView

A small, simple implementation of a hierarchical outline view in SwiftUI. This project contains a small example application.

![OutlineView Screenshot](OutlineView-screenshot.png)

N.B. This is a real work in progress.

This implementation uses an instance of a class to store the open/closed state of items with children, because otherwise SwiftUI would lose the open-closed state of folders when they aren't visible.

There are a few branches where I've attempted to work around this issue in a few ways, thus far unsuccessfully. But hey, it runs nicely as a proof of concept!
