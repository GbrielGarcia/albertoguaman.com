#!/usr/bin/env python3
"""Genera web/blog/rss.xml desde lib/src/model/blog_post.dart (fuente única)."""

from __future__ import annotations

import calendar
import re
from datetime import datetime, timezone
from pathlib import Path
from xml.sax.saxutils import escape

ROOT = Path(__file__).resolve().parents[1]
DART = ROOT / "lib" / "src" / "model" / "blog_post.dart"
OUT = ROOT / "web" / "blog" / "rss.xml"

POST_RE = re.compile(
    r'BlogPost\(\s*'
    r'slug:\s*"(?P<slug>[^"]+)",\s*'
    r'title:\s*(?P<title>(?:"(?:\\.|[^"\\])*"|[^,])+?),\s*'
    r'excerpt:\s*(?P<excerpt>(?:"(?:\\.|[^"\\])*"|[^,])+?),\s*',
    re.DOTALL,
)
DATE_RE = re.compile(r'date:\s*"(?P<date>\d{4}-\d{2}-\d{2})"')


def _unquote(raw: str) -> str:
    raw = raw.strip()
    if raw.startswith('"') and raw.endswith('"'):
        return bytes(raw[1:-1], "utf-8").decode("unicode_escape")
    # Multi-line concatenation: "a"\n        "b"
    parts = re.findall(r'"(?:\\.|[^"\\])*"', raw)
    if parts:
        return "".join(bytes(p[1:-1], "utf-8").decode("unicode_escape") for p in parts)
    return raw


def parse_posts(src: str) -> list[dict[str, str]]:
    posts: list[dict[str, str]] = []
    for m in POST_RE.finditer(src):
        block_end = src.find("),", m.end())
        block = src[m.start() : block_end if block_end != -1 else m.end() + 400]
        dm = DATE_RE.search(block)
        if not dm:
            continue
        posts.append(
            {
                "slug": m.group("slug"),
                "title": _unquote(m.group("title")),
                "excerpt": _unquote(m.group("excerpt")),
                "date": dm.group("date"),
            }
        )
    return posts


def rfc822(date_s: str) -> str:
    dt = datetime.strptime(date_s, "%Y-%m-%d").replace(tzinfo=timezone.utc)
    wday = calendar.day_abbr[dt.weekday()]
    mon = calendar.month_abbr[dt.month]
    return f"{wday}, {dt.day:02d} {mon} {dt.year} 00:00:00 +0000"


def main() -> None:
    posts = parse_posts(DART.read_text(encoding="utf-8"))
    if not posts:
        raise SystemExit("No se encontraron posts en blog_post.dart")

    items = []
    for p in posts:
        link = f"https://albertoguaman.com/blog/{p['slug']}"
        items.append(
            "\n".join(
                [
                    "    <item>",
                    f"      <title>{escape(p['title'])}</title>",
                    f"      <link>{link}</link>",
                    f'      <guid isPermaLink="true">{link}</guid>',
                    f"      <pubDate>{rfc822(p['date'])}</pubDate>",
                    f"      <description>{escape(p['excerpt'])}</description>",
                    "    </item>",
                ]
            )
        )

    xml = (
        '<?xml version="1.0" encoding="UTF-8"?>\n'
        '<rss version="2.0">\n'
        "  <channel>\n"
        "    <title>Alberto Guaman · Blog</title>\n"
        "    <link>https://albertoguaman.com/blog</link>\n"
        "    <description>Artículos sobre desarrollo, Flutter, web y tecnología.</description>\n"
        "    <language>es-ec</language>\n"
        + "\n".join(items)
        + "\n  </channel>\n</rss>\n"
    )
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(xml, encoding="utf-8")
    print(f"OK {OUT} ({len(posts)} items)")


if __name__ == "__main__":
    main()
