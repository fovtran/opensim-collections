import subprocess


subprocess.call(r'"C:\\Program Files\\7-Zip\\7z.exe" l -r ' + "e:\\449a\\arch_opensim\\iars\\avatars.iar" + ' -o' + "d:\\temp")
subprocess.call(r'"C:\\Program Files\\7-Zip\\7z.exe" l -sltr ' + "e:\\449a\\arch_opensim\\oars2\\large_structures_01.oar" + ' -o' + "d:\\temp")