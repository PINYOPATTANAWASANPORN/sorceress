import pytest
import os
from src.tools.echo import echo
from src import settings

@pytest.mark.asyncio
async def test_echo_tool():
    test_text = "sorceress-mcp-verification"
    result = await echo(test_text)
    assert result == test_text

def test_settings_constants():
    assert settings.VERSION is not None
    assert isinstance(settings.ENVIRONMENT, str)
