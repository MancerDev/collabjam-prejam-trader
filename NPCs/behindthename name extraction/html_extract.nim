import std/[paths, dirs, os, files, streams, strutils, sets, unicode]


var html_dir = Path(currentSourcePath()).parentDir() / Path("page html")
if not html_dir.dirExists():
    quit("read directory not found", 1)

var write_dir = Path(currentSourcePath()).parentDir() / Path("first names")
if not html_dir.dirExists():
    quit("write directory not found", 1)

var letter_set: HashSet[Rune]
var count = 0
for file_path in html_dir.walkDir():
    if file_path.kind == pcFile:
        if file_path.path.fileExists():
            if $file_path.path.extractFilename() == ".gdignore":
                continue
            # let write_f = open($(write_dir / Path("txt") / Path("f_" & $file_path.path.extractFilename())), fmWrite)
            # defer: write_f.close()
            # let write_m = open($(write_dir / Path("txt") / Path("m_" & $file_path.path.extractFilename())), fmWrite)
            # defer: write_m.close()
            let write_f = open($(write_dir / Path("f_" & $file_path.path.extractFilename().changeFileExt("tres"))), fmWrite)
            defer: write_f.close()
            let write_m = open($(write_dir / Path("m_" & $file_path.path.extractFilename().changeFileExt("tres"))), fmWrite)
            defer: write_m.close()
            write_f.writeLine("[gd_resource type=\"Resource\" script_class=\"NPCFirstnameList\" load_steps=2 format=3]\n\n[ext_resource type=\"Script\" path=\"res://NPCs/npc_firstname_list.gd\" id=\"1_hmai5\"]\n\n[resource]\nscript = ExtResource(\"1_hmai5\")")
            write_m.writeLine("[gd_resource type=\"Resource\" script_class=\"NPCFirstnameList\" load_steps=2 format=3]\n\n[ext_resource type=\"Script\" path=\"res://NPCs/npc_firstname_list.gd\" id=\"1_hmai5\"]\n\n[resource]\nscript = ExtResource(\"1_hmai5\")")

            echo(file_path)
            var html_stream = newFileStream($file_path.path, fmRead)
            if not isNil(html_stream):
                var html_stack: seq[(string, string)]
                var bracket_stack = 0
                var read_buffer = newStringOfCap(20)
                var tag_buffer = newStringOfCap(100)
                var tag_close = false
                var tag_kind = newStringOfCap(5)
                var reached_space = false

                var name = ""
                var gender = ""
                var desc = ""
                var all_names_f: seq[string]
                var all_names_m: seq[string]
                var all_descs_f: seq[string]
                var all_descs_m: seq[string]
                var count_f: int
                var count_m: int
                while not html_stream.atEnd():
                    var c = html_stream.readChar()
                    # read_buffer.add(c)
                    case c:
                        of '<':
                            if len(html_stack) == 0:
                                # if gender notin ["f", "m"]:
                                #     echo(gender)
                                # echo(name, " ", gender, " ", desc)
                                if gender.contains("f"):
                                    # write_f.write(name)
                                    # write_f.write("\t")
                                    # write_f.write(desc)
                                    # write_f.write("\n")
                                    all_names_f &= name
                                    all_descs_f &= desc
                                    count_f += 1
                                if gender.contains("m"):
                                    # write_m.write(name)
                                    # write_m.write("\t")
                                    # write_m.write(desc)
                                    # write_m.write("\n")
                                    all_names_m &= name
                                    all_descs_m &= desc
                                    count_m += 1
                                count += 1
                                for r in name.toRunes():
                                    letter_set.incl(r)
                                name = ""
                                gender = ""
                                desc = ""
                            bracket_stack += 1
                            # tag_close = html_stream.peekChar() == '/'
                            let peeked = html_stream.peekStr(3)
                            tag_close = peeked[0] == '/'
                            var should_echo = false
                            case peeked[if tag_close: 1 else: 0]:
                                of 'i', 'a':
                                    should_echo = false
                                of 'b':
                                    should_echo = peeked[if tag_close: 2 else: 1] != 'r'
                                else:
                                    should_echo = true
                            if should_echo:
                                if len(read_buffer.strip()) > 0:
                                    # echo("$ (", read_buffer, ")", html_stack[high(html_stack)][1])
                                    var classname = html_stack[high(html_stack)][1]
                                    classname = classname.split("\"")[1]
                                    case classname:
                                        of "listname":
                                            name &= read_buffer
                                        of "masc", "fem":
                                            gender &= read_buffer
                                        of "browsename":
                                            desc &= read_buffer
                                        of "listusage", "nn", "mng", "listgender":
                                            #TODO removing mng breaks some meanings, but with it had caused some issues
                                            discard
                                        else:
                                            if not classname.startsWith("namedesc"):
                                                echo("$ (", read_buffer, ")", html_stack[high(html_stack)][1])
                            reached_space = false
                        of '>':
                            bracket_stack -= 1
                            # echo(tag_close, " ", tag_kind, " ", tag_buffer)
                            if tag_kind notin ["i", "b", "a", "br"]: #TODO maybe add mng here
                                if not tag_close:
                                    html_stack &= (tag_kind, tag_buffer)
                                else:
                                    if html_stack[high(html_stack)][0] == tag_kind:
                                        discard html_stack.pop()
                                # echo(html_stack)
                                if len(read_buffer) > 0:
                                    read_buffer = newStringOfCap(100)
                            tag_buffer = newStringOfCap(100)
                            tag_kind = newStringOfCap(5)
                            tag_close = false
                        of '\n':
                            # echo(read_buffer)
                            break # for testing
                        else:
                            if bracket_stack == 0:
                                if c == '"':
                                    read_buffer.add('\\')
                                read_buffer.add(c)
                            else:
                                if (not reached_space):
                                    if c == ' ':
                                        reached_space = true
                                    elif c != '/':
                                        tag_kind.add(c)
                                else:
                                    tag_buffer.add(c)
                html_stream.close()

                write_f.write("count = ")
                write_f.write($count_f)
                write_f.write("\n")

                write_m.write("count = ")
                write_m.write($count_m)
                write_m.write("\n")

                write_f.write("firstnames = Array[String]([")
                write_f.write("\"")
                write_f.write(all_names_f[0])
                write_f.write("\"")
                for i in 1..<len(all_names_f):
                    write_f.write(", \"")
                    write_f.write(all_names_f[i])
                    write_f.write("\"")
                write_f.write("])\n")

                write_m.write("firstnames = Array[String]([")
                write_m.write("\"")
                write_m.write(all_names_m[0])
                write_m.write("\"")
                for i in 1..<len(all_names_m):
                    write_m.write(", \"")
                    write_m.write(all_names_m[i])
                    write_m.write("\"")
                write_m.write("])\n")

                # write_f.write("meanings = Array[String]([")
                # write_f.write("\"")
                # write_f.write(all_descs_f[0])
                # write_f.write("\"")
                # for i in 1..<len(all_descs_f):
                #     write_f.write(", \"")
                #     write_f.write(all_descs_f[i])
                #     write_f.write("\"")
                # write_f.write("])\n")

                # write_m.write("meanings = Array[String]([")
                # write_m.write("\"")
                # write_m.write(all_descs_m[0])
                # write_m.write("\"")
                # for i in 1..<len(all_descs_m):
                #     write_m.write(", \"")
                #     write_m.write(all_descs_m[i])
                #     write_m.write("\"")
                # write_m.write("])\n")

                echo(count)
                count = 0

for r in letter_set.items():
    stdout.write($r)
    stdout.write(" ")
echo()
