from __future__ import annotations

from collections import deque
from pathlib import Path

from PIL import Image

INPUT_SHEET = Path("image – Kopi.png")
OUTPUT_ROOT = Path("assets/animations/companion")
ROW_NAMES = ["idle", "happy", "sleep"]
MIN_COMPONENT_AREA = 7000
BLACK_THRESHOLD = 12
PADDING = 6


def is_foreground(pixel: tuple[int, int, int, int]) -> bool:
    r, g, b, a = pixel
    return a >= 10 and not (r < BLACK_THRESHOLD and g < BLACK_THRESHOLD and b < BLACK_THRESHOLD)


def connected_components(image: Image.Image) -> list[tuple[int, int, int, int, int]]:
    width, height = image.size
    pixels = image.load()
    visited = [[False] * width for _ in range(height)]
    components: list[tuple[int, int, int, int, int]] = []

    for y in range(height):
        for x in range(width):
            if visited[y][x]:
                continue

            if not is_foreground(pixels[x, y]):
                visited[y][x] = True
                continue

            queue: deque[tuple[int, int]] = deque([(x, y)])
            visited[y][x] = True
            min_x = max_x = x
            min_y = max_y = y
            area = 0

            while queue:
                cx, cy = queue.popleft()
                area += 1
                min_x = min(min_x, cx)
                max_x = max(max_x, cx)
                min_y = min(min_y, cy)
                max_y = max(max_y, cy)

                for nx, ny in ((cx + 1, cy), (cx - 1, cy), (cx, cy + 1), (cx, cy - 1)):
                    if not (0 <= nx < width and 0 <= ny < height):
                        continue
                    if visited[ny][nx]:
                        continue

                    visited[ny][nx] = True
                    if is_foreground(pixels[nx, ny]):
                        queue.append((nx, ny))

            components.append((area, min_x, min_y, max_x, max_y))

    return components


def remove_dark_background(frame: Image.Image) -> Image.Image:
    frame = frame.convert("RGBA")
    px = frame.load()
    width, height = frame.size
    for y in range(height):
        for x in range(width):
            r, g, b, a = px[x, y]
            if a < 10 or (
                r < BLACK_THRESHOLD and g < BLACK_THRESHOLD and b < BLACK_THRESHOLD
            ):
                px[x, y] = (0, 0, 0, 0)
    return frame


def group_rows(components: list[tuple[int, int, int, int, int]]) -> list[list[tuple[int, int, int, int, int]]]:
    comps = sorted(components, key=lambda c: (c[2], c[1]))
    rows: list[list[tuple[int, int, int, int, int]]] = []
    for comp in comps:
        _, _, min_y, _, max_y = comp
        center_y = (min_y + max_y) / 2
        if not rows:
            rows.append([comp])
            continue

        last_row = rows[-1]
        last_center = sum((r[2] + r[4]) / 2 for r in last_row) / len(last_row)
        if abs(center_y - last_center) <= 120:
            last_row.append(comp)
        else:
            rows.append([comp])

    for row in rows:
        row.sort(key=lambda c: c[1])
    return rows


def save_row_frames(
    image: Image.Image,
    row_name: str,
    components: list[tuple[int, int, int, int, int]],
) -> None:
    width, height = image.size
    out_dir = OUTPUT_ROOT / row_name
    out_dir.mkdir(parents=True, exist_ok=True)

    boxes = []
    for _, min_x, min_y, max_x, max_y in components:
        x1 = max(0, min_x - PADDING)
        y1 = max(0, min_y - PADDING)
        x2 = min(width, max_x + PADDING + 1)
        y2 = min(height, max_y + PADDING + 1)
        boxes.append((x1, y1, x2, y2))

    max_w = max(x2 - x1 for x1, y1, x2, y2 in boxes)
    max_h = max(y2 - y1 for x1, y1, x2, y2 in boxes)

    for index, (x1, y1, x2, y2) in enumerate(boxes, start=1):
        cropped = image.crop((x1, y1, x2, y2))
        cleaned = remove_dark_background(cropped)

        canvas = Image.new("RGBA", (max_w, max_h), (0, 0, 0, 0))
        offset_x = (max_w - cleaned.width) // 2
        offset_y = (max_h - cleaned.height) // 2
        canvas.alpha_composite(cleaned, dest=(offset_x, offset_y))

        out_path = out_dir / f"frame_{index:02d}.png"
        canvas.save(out_path)


def main() -> None:
    if not INPUT_SHEET.exists():
        raise FileNotFoundError(f"Animation sheet not found: {INPUT_SHEET}")

    sheet = Image.open(INPUT_SHEET).convert("RGBA")
    components = [
        component
        for component in connected_components(sheet)
        if component[0] >= MIN_COMPONENT_AREA
    ]

    rows = group_rows(components)
    if len(rows) != len(ROW_NAMES):
        raise RuntimeError(
            f"Expected {len(ROW_NAMES)} animation rows, found {len(rows)}. "
            "Check thresholds or source sheet."
        )

    for row_name, row_components in zip(ROW_NAMES, rows, strict=True):
        save_row_frames(sheet, row_name, row_components)

    print("Generated frames:")
    for row_name, row_components in zip(ROW_NAMES, rows, strict=True):
        print(f"- {row_name}: {len(row_components)}")


if __name__ == "__main__":
    main()
