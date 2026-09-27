# Builds every logo asset in public/ from design/logo.jpg:
#   logo.webp                       the full logo (home page)
#   anim/gate|door|butterfly.webp   layers of the "door opens, butterfly flies in" animation
#                                   (src/components/LogoGate.svelte), cut from the drawing alone:
#                                   no wordmark, no border, no ground line beyond the gate's base
# (The header mark and favicons are the separate vector "gateless gate": GateMark.svelte,
# public/favicon.svg, and PNGs rendered from it.)
#
#   python3 design/build-logo-assets.py        (needs numpy, scipy, Pillow)
#
# The positions it prints (door rectangle, butterfly centre, as fractions of the square)
# are the ones hard-coded in LogoGate.svelte; update them if the logo changes.
import json
import numpy as np
from PIL import Image
from scipy import ndimage as ndi
src = Image.open('design/logo.jpg').convert('RGB')
src.resize((512, 512), Image.LANCZOS).save('public/logo.webp', quality=88, method=6)
full = np.asarray(src).astype(np.uint8).copy()
cream = np.array([243, 236, 221])

# The ground line (rows 747-759) runs from x 137 to 886. Keep the part under the gate
# (x 470-842), which is the gate's own base, and erase what sticks out on either side.
full[745:762, 100:470] = cream
full[745:762, 843:930] = cream

CX0, CY0, CX1, CY1 = 114, 132, 914, 778          # the drawing, padded to a square
side = 820
ox, oy = (side - (CX1 - CX0)) // 2, (side - (CY1 - CY0)) // 2
sq = np.empty((side, side, 3), np.uint8); sq[:] = cream
sq[oy:oy + CY1 - CY0, ox:ox + CX1 - CX0] = full[CY0:CY1, CX0:CX1]
to_sq = lambda x, y: (x - CX0 + ox, y - CY0 + oy)

img = sq.astype(int)
ink = (np.abs(img - cream).sum(-1) > 45) & ~(img.min(-1) > 225)
lab, n = ndi.label(ink)
sizes = ndi.sum(ink, lab, range(1, n + 1))
gate_id, fly_id = np.argsort(sizes)[::-1][:2] + 1
gate = lab == gate_id
fly = ndi.binary_fill_holes(lab == fly_id)

# Butterfly with its white sticker outline and a feathered edge.
halo = ndi.binary_dilation(fly, iterations=9) & (img.min(-1) > 236)
fly_full = ndi.binary_fill_holes(fly | halo)
alpha = ndi.gaussian_filter(ndi.binary_dilation(fly_full, iterations=1).astype(float), 0.8)
fly_rgba = np.dstack([sq, (np.clip(alpha, 0, 1) * 255).astype(np.uint8)])

# Gate without the butterfly: mirror each row about its own centre (beam ≈ 652, pillars ≈ 656).
hole = ndi.binary_dilation(fly_full, iterations=4) | (ndi.binary_dilation(fly_full, iterations=16) & (img.min(-1) > 195))
gate_img = sq.copy()
gate_img[hole] = cream
ys, xs = np.where(hole)
axis = np.where(ys < to_sq(0, 352)[1], to_sq(652, 0)[0], to_sq(656, 0)[0])
mx = (2 * axis - xs).clip(0, side - 1)
take = gate[ys, mx] | ndi.binary_dilation(gate, iterations=1)[ys, mx]
gate_img[ys[take], xs[take]] = sq[ys[take], mx[take]]

# Door panel, and a hole for it in the gate layer.
dx0, dy0 = to_sq(552, 340); dx1, dy1 = to_sq(761, 747)
door = gate_img[dy0:dy1, dx0:dx1].copy()   # from the rebuilt gate: the butterfly overlapped the door
# The outline's soft edge blends into the gold; repaint light pixels near the butterfly with plain gold.
near = ndi.binary_dilation(fly_full, iterations=28)[dy0:dy1, dx0:dx1]
bright = door.astype(int).sum(-1)
gold = np.median(door[bright > 400].reshape(-1, 3), axis=0).astype(np.uint8)
door[near & (bright > np.median(bright) + 25)] = gold
# Transparent background, so the animation blends into whatever box it sits in.
# The gate's shape comes from the rebuilt image (the part the butterfly hid is gate too).
dist = np.abs(gate_img.astype(int) - cream).sum(-1)
g_lab, _ = ndi.label((dist > 45) & ~(gate_img.min(-1) > 225))
g_sizes = np.bincount(g_lab.ravel()); g_sizes[0] = 0
shape = g_lab == g_sizes.argmax()
# Small light specks inside the gate stay solid; the big gaps between the beams stay open.
holes, n_holes = ndi.label(ndi.binary_fill_holes(shape) & ~shape)
hole_sizes = ndi.sum(np.ones_like(holes), holes, range(1, n_holes + 1))
for i, size in enumerate(hole_sizes, 1):
    if size < 400:
        shape |= holes == i
# Solid inside; at the edge, opacity follows how far a pixel is from the cream, and the
# cream is taken back out of its colour so no pale fringe shows on a dark background.
inner = ndi.binary_erosion(shape, iterations=1)
edge = ndi.binary_dilation(shape, iterations=2) & ~inner
a = np.where(inner, 1.0, 0.0)
a[edge] = np.clip((dist[edge] - 10) / 70, 0, 1)
safe = np.maximum(a, 1e-3)[..., None]
unmixed = ((gate_img.astype(float) - (1 - safe) * cream) / safe).clip(0, 255).astype(np.uint8)
gate_img = np.where(edge[..., None], unmixed, gate_img)
gate_alpha = (a * 255).astype(np.uint8)
gate_alpha[dy0:dy1, dx0:dx1] = 0           # the doorway: the light shows through here

fy, fx = np.where(fly)
meta = {
  'door': {k: round(v, 4) for k, v in dict(x=dx0 / side, y=dy0 / side, w=(dx1 - dx0) / side, h=(dy1 - dy0) / side).items()},
  'butterfly': {'x': round(fx.mean() / side, 4), 'y': round(fy.mean() / side, 4)},
}
print(json.dumps(meta))

# 2x the size LogoGate shows them at.
OUT, k = 320, 320 / side
gate_rgba = Image.fromarray(np.dstack([gate_img, gate_alpha]), 'RGBA')
gate_rgba.resize((OUT, OUT), Image.LANCZOS).save('public/anim/gate.webp', quality=90, method=6)
Image.fromarray(fly_rgba, 'RGBA').resize((OUT, OUT), Image.LANCZOS).save('public/anim/butterfly.webp', quality=90, method=6)
door_img = Image.fromarray(door)
door_img.resize((round(door_img.width * k), round(door_img.height * k)), Image.LANCZOS).save('public/anim/door.webp', quality=90, method=6)
