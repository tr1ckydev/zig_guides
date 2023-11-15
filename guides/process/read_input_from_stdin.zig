const std = @import("std");

pub fn main() !void {
    std.debug.print("Enter your name: ", .{});
    var buffer: [100]u8 = undefined;
    const input = try std.io.getStdIn().reader().readUntilDelimiter(&buffer, '\n');
    std.debug.print("Your name is {s}.\n", .{input});
}
