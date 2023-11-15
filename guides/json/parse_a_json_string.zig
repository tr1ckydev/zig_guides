const std = @import("std");

const Location = struct {
    name: []const u8,
    lat: f32,
    long: f32,
};

pub fn main() !void {
    const json_string =
        \\{
        \\    "name": "Zigland",
        \\    "lat": 40.684540,
        \\    "long": -74.401422
        \\}
    ;
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // Parsing the json_string using known struct
    const parsed = try std.json.parseFromSlice(Location, allocator, json_string, .{});
    defer parsed.deinit();
    const location = parsed.value;
    std.debug.print("{s}\n{d:.6}\n{d:.6}\n\n", .{ location.name, location.lat, location.long });

    // Parsing the json_string arbitrarily
    const parsed2 = try std.json.parseFromSlice(std.json.Value, allocator, json_string, .{});
    defer parsed2.deinit();
    const location2 = parsed2.value.object;
    std.debug.print("{s}\n{d:.6}\n{d:.6}\n", .{
        location2.get("name").?.string,
        location2.get("lat").?.float,
        location2.get("long").?.float,
    });
}
