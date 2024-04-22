const std = @import("std");

pub fn main() !void {
    // Sleep for 1 second
    std.time.sleep(1e9);
    std.debug.print("Hello, after 1 second.\n", .{});
}
