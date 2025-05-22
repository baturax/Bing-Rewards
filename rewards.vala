#!/bin/env -S vala --pkg gio-2.0 --pkg gee-0.8

using GLib;
using Gee;

int main(string[] args) {
    var list = new LinkedList<string>();

    try {
        var file = File.new_for_path("./words");
        var dis = new DataInputStream(file.read());
        string? line;

        while ((line = dis.read_line(null)) != null) {
            list.add(line);
        }

        foreach (var item in list) {
            string encoded_query = Uri.escape_string(item, null, false);
            string command = "firefox https://www.bing.com/search?q=" + encoded_query + "&FORM=R5FD";

            GLib.Process.spawn_command_line_async(command);

            Thread.usleep(20000000);
        }

    } catch (Error e) {
        stderr.printf("Error reading file: %s\n", e.message);
        return 1;
    }

    return 0;
}

