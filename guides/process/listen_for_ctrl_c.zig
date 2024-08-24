const std = @import("std");

pub fn main() !void {
    std.posix.sigaction(std.posix.SIG.INT, &.{
        .handler = .{ .handler = handleSIGINT },
        .mask = std.posix.empty_sigset,
        .flags = 0,
    }, null);
    // Wait for user to press Ctrl + C
    std.time.sleep(999_999_999_999);
}

fn handleSIGINT(_: c_int) callconv(.C) void {
    std.debug.print("\nCtrl + C was pressed.\n", .{});
    std.process.exit(0);
}
