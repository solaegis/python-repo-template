"""Command-line interface."""

import click

from {{PACKAGE_NAME}}.__about__ import __version__


@click.group()
@click.version_option(version=__version__)
def cli():
    """{{PACKAGE_DESCRIPTION}}"""
    pass


@cli.command()
def hello():
    """Say hello."""
    click.echo("Hello from {{PACKAGE_NAME}}!")


def main():
    """Entry point for the CLI."""
    cli()


if __name__ == "__main__":
    main()
