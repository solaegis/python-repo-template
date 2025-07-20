"""Test CLI functionality."""

from click.testing import CliRunner

from {{PACKAGE_NAME}}.cli import cli


def test_cli_help():
    """Test CLI help command."""
    runner = CliRunner()
    result = runner.invoke(cli, ['--help'])
    assert result.exit_code == 0
    assert '{{PACKAGE_DESCRIPTION}}' in result.output


def test_hello_command():
    """Test hello command."""
    runner = CliRunner()
    result = runner.invoke(cli, ['hello'])
    assert result.exit_code == 0
    assert 'Hello from {{PACKAGE_NAME}}!' in result.output
