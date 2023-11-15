const std = @import("std");

pub fn main() !void {
    try std.os.sigaction(std.os.SIG.INT, &.{
        .handler = .{ .handler = handleSIGINT },
        .mask = std.os.empty_sigset,
        .flags = 0,
    }, null);
    while (true) {}
}

fn handleSIGINT(_: c_int) callconv(.C) void {
    std.debug.print("\nCtrl + C was pressed.\n", .{});
    std.process.exit(0);
}
