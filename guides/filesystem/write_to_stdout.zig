const std = @import("std");

pub fn main() !void {
    // `std.debug.print` prints to stderr and not stdout!
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello from {s}!\n", .{"stdout"});
}
