#!/usr/bin/env python3
"""
Transfers files for starting dnsmasq
"""
from __future__ import print_function
from __future__ import division
from __future__ import unicode_literals
from __future__ import absolute_import

import os
import os.path as p
import subprocess
import sys
import shutil
# import glob


if os.geteuid()==0:
    print("Running as root.")
else:
    print("User is not root.")
    sys.exit()


version = sys.version_info[ 0 : 3 ]
if version < ( 3, 6, 0 ):
    sys.exit( 'YouCompleteMe requires Python >= 3.6.0; '
            'your version of Python is ' + sys.version )

DIR_OF_THIS_SCRIPT = p.dirname( p.abspath( __file__ ) )
HOME_DIR = "/".join(DIR_OF_THIS_SCRIPT.split("/")[:3])
# DIR_OF_OLD_LIBS = p.join( DIR_OF_THIS_SCRIPT, 'python' )


def check_call( args, **kwargs ):
    """
    calls to python process
    """
    try:
        subprocess.check_call( args, **kwargs )
    except subprocess.CalledProcessError as error:
        sys.exit( error.returncode )


def main():
    """
    Kabaam!!!
    """
    old_conf_dir = HOME_DIR + "/.config/last_wslvpn"
    if not os.path.exists(old_conf_dir):
        os.mkdir(old_conf_dir)
        print(f"{old_conf_dir} created")
    print("moving conf files")
    if os.path.exists("/etc/resolv.conf"):
        os.rename("/etc/resolv.conf", old_conf_dir + "/resolv.conf")
    if os.path.exists("/etc/dnsmasq.conf"):
        os.rename("/etc/dnsmasq.conf", old_conf_dir + "/dnsmasq.conf")

    print("copying rcfiles versions to etc")
    shutil.copy(HOME_DIR + "/rcfiles/texts/wslvpn/resolv.conf", "/etc/resolv.conf")
    shutil.copy(HOME_DIR + "/rcfiles/texts/wslvpn/dnsmasq.conf", "/etc/dnsmasq.conf")
    os.system('dnsmasq')

#     build_file = p.join( DIR_OF_THIS_SCRIPT, 'third_party', 'ycmd', 'build.py' )

#     if not p.isfile( build_file ):
#         sys.exit(
#           'File {0} does not exist; you probably forgot to run:\n'
#           '\tgit submodule update --init --recursive\n'.format( build_file ) )

#     check_call( [ sys.executable, build_file ] + sys.argv[ 1: ] )

#     # Remove old YCM libs if present so that YCM can start.
#     # old_libs = (
#     #     glob.glob( p.join( DIR_OF_OLD_LIBS, '*ycm_core.*' ) ) +
#     #     glob.glob( p.join( DIR_OF_OLD_LIBS, '*ycm_client_support.*' ) ) +
    #     glob.glob( p.join( DIR_OF_OLD_LIBS, '*clang*.*' ) ) )
    # for lib in old_libs:
    #     os.remove( lib )


if __name__ == "__main__":
    # print(HOME_DIR)
    main()
