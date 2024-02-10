const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // Getting args through an iterator
    var args1 = try std.process.argsWithAllocator(allocator);
    defer args1.deinit();
    while (args1.next()) |arg| {
        std.debug.print("{s}\n", .{arg});
    }

    // Getting args as an array
    const args2 = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args2);
    std.debug.print("{s}", .{args2});
}
