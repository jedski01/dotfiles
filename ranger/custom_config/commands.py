from ranger.api.commands import *

class execute_tat(Command):
    def execute(self):
        current_file = self.fm.thisfile

        print(self.fm.thisfile)
        if current_file.path:
            self.fm.run(['tat', current_file.path])
