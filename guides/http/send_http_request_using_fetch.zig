const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();
    var fetch_result = try client.fetch(allocator, .{
        .location = .{ .url = "http://example.com/" },
    });
    defer fetch_result.deinit();
    std.debug.print("{?s}", .{fetch_result.body});
}
