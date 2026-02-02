import yaml
import argparse

argparser = argparse.ArgumentParser(prog="config_parser", description="Parse YAML files")
subparser = argparser.add_subparsers(dest="subcommand")

list_parser = subparser.add_parser("list", help="List file's nodes")
list_parser.add_argument("file",
                       help="YAML file to parse")

get_parser = subparser.add_parser("get", help="Get value at node's key")
get_parser.add_argument("file",
                       help="YAML file to parse")
get_parser.add_argument("-n", "--node", required=True,
                        help="Node to get value from")
get_parser.add_argument("-k", "--key", required=True,
                        help="Key to get value from")

if __name__ == "__main__":
    args = argparser.parse_args()
    with open(args.file, "r") as f:
        config = yaml.load(f, Loader=yaml.SafeLoader)
    if args.subcommand == "list":
        print('\n'.join(config.keys()))
    elif args.subcommand == "get":
        print(config[args.node][args.key])
    else:
        raise Exception("Unknown subcommand")