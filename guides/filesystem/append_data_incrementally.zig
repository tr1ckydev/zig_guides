const std = @import("std");

pub fn main() !void {
    // Creating/opening the file and appending data to it
    const file = try std.fs.cwd().createFile("file.txt", .{ .truncate = false, .read = true });
    defer file.close();
    try file.seekFromEnd(0);
    _ = try file.write("some ");
    _ = try file.write("data ");

    // Reading the contents of the file
    try file.seekTo(0);
    var buffer: [100]u8 = undefined;
    const len = try file.readAll(&buffer);
    std.debug.print("{s}", .{buffer[0..len]});
}
