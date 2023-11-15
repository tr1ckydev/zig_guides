const std = @import("std");

const Place = struct {
    name: []const u8,
    location: []const u8,
    coordinates: struct {
        lat: f32,
        long: f32,
    },
    isAccessible: bool,
};

pub fn main() !void {
    // Reading the JSON file
    var buffer: [200]u8 = undefined;
    const contents_buf = try std.fs.cwd().readFile("guides/json/sample.json", &buffer);

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // Parsing the contents_buf using known struct
    const parsed = try std.json.parseFromSlice(Place, allocator, contents_buf, .{});
    defer parsed.deinit();
    const place = parsed.value;
    std.debug.print("{s}\n{s}\n{d:.6}\n{d:.6}\n{}\n\n", .{
        place.name,
        place.location,
        place.coordinates.lat,
        place.coordinates.long,
        place.isAccessible,
    });

    // Parsing the contents_buf arbitrarily
    const parsed2 = try std.json.parseFromSlice(std.json.Value, allocator, contents_buf, .{});
    defer parsed2.deinit();
    const place2 = parsed2.value.object;
    std.debug.print("{s}\n{s}\n{d:.6}\n{d:.6}\n{}\n", .{
        place2.get("name").?.string,
        place2.get("location").?.string,
        place2.get("coordinates").?.object.get("lat").?.float,
        place2.get("coordinates").?.object.get("long").?.float,
        place2.get("isAccessible").?.bool,
    });
}
