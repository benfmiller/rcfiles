#!/usr/bin/env python3

"""Opens given file in Microsoft Edge"""
import argparse
import pprint

# import audio_metadata as am

ap = argparse.ArgumentParser()
ap.add_argument("current_directory", help="output from pwd")
ap.add_argument("input_file", help="path to the input file")
args = ap.parse_args()

pp = pprint.PrettyPrinter()
# test_file = "e:/audio_files/test/test.mp4"
# print(args)
input_file = args.input_file
current_dir = args.current_directory

# print("\n\n")
# pp.pprint(metadata)


# print(current_dir)
if current_dir[:5] == "/mnt/":
    drive_letter = current_dir[5].upper()
    new_location = f"{drive_letter}:{current_dir[6:]}/{input_file}"
    # print(drive_letter)
    # print(input_file)
    print(new_location)
else:
    # This doesn't work
    print(f"\\\\wsl${current_dir}/{input_file}")
# print(current_dir)
