const std = @import("std");

pub fn main() !void {
    var data = [_]u8{ 7, 4, 8, 23, 2, 0, 1 };
    std.debug.print("Original:\n{any}\n", .{data});
    std.debug.print("Ascending:\n", .{});
    std.mem.sort(u8, &data, {}, std.sort.asc(u8));
    std.debug.print("{any}\n", .{data});
    std.debug.print("Descending:\n", .{});
    std.mem.sort(u8, &data, {}, std.sort.desc(u8));
    std.debug.print("{any}\n", .{data});
}
