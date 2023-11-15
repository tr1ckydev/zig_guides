const std = @import("std");

pub fn main() !void {
    // Sleep for 1 second
    std.time.sleep(1_000_000_000);
    std.debug.print("Hello, after 1 second.\n", .{});
}
