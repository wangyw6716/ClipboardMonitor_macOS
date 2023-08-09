import Foundation
import Cocoa

class ClipboardObserver {
    private let pasteboard: NSPasteboard
    private var lastChangeCount: Int
    private var lastCopiedString: String?

    init() {
        // Initialize the clipboard instance and variables
        pasteboard = NSPasteboard.general
        lastChangeCount = pasteboard.changeCount
        lastCopiedString = pasteboard.string(forType: .string)

        // Create a timer to check for clipboard changes every second
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.checkPasteboard()
        }
    }

    private func checkPasteboard() {
        // Check if the clipboard change count is different
        if pasteboard.changeCount != lastChangeCount {
            lastChangeCount = pasteboard.changeCount

            // Get the newly copied text content
            if let newCopiedString = pasteboard.string(forType: .string) {
                // Check if the new content is different from the last one
                if newCopiedString != lastCopiedString {
                    lastCopiedString = newCopiedString
                    print("CLIPBOARD_CHANGE")  // Print change notification
                    fflush(stdout)
                }
            }
        }
    }

    deinit {
        // Clean up timer if needed
    }
}

let observer = ClipboardObserver()

// Keep the program running
RunLoop.main.run()
