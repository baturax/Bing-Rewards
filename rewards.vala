#!/bin/env -S vala --pkg gio-2.0 --pkg gee-0.8

int main(string[] args) {
    var list = new Gee.LinkedList<string>();

    try {
        var f = File.new_for_path("./words");
        var dis = new DataInputStream(f.read());
        string? line;

        while ((line = dis.read_line(null)) != null) {
            list.add(line);
        }

        foreach (var i in list) {
            string e = Uri.escape_string(i, null, false);
            string c = "microsoft-edge-stable https://www.bing.com/search?q=" + e + "&FORM=R5FD";

            GLib.Process.spawn_command_line_async(c);

            Thread.usleep(20000000);
        }

    } catch (GLib.Error e) {
        stderr.printf(e.message);
        return 1;
    }

    return 0;
}

