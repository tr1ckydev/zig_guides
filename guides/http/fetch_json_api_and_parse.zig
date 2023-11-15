const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();
    var fetch_result = try client.fetch(allocator, .{
        .location = .{ .url = "https://api.github.com/repos/ziglang/zig" },
    });
    defer fetch_result.deinit();
    const parsed = try std.json.parseFromSlice(std.json.Value, allocator, fetch_result.body.?, .{});
    defer parsed.deinit();
    const response_json = parsed.value.object;
    std.debug.print("{s}\n", .{response_json.get("description").?.string});
}
