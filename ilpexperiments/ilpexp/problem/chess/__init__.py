from .chess import ChessProblem
from .chessmapfilter1.mapfilter1 import MapFilter1Problem
from .chessmapfilteruntil1.mapfilteruntil1 import MapFilterUntil1Problem
from .chessmapuntil1.mapuntil1 import MapUntil1Problem
from .chessoriginal.chessoriginal import ChessOriginal


MAPFILTER1 = MapFilter1Problem()
MAPFILTERUNTIL1 = MapFilterUntil1Problem()
MAPUNTIL1 = MapUntil1Problem()
CHESSORIGINAL = ChessOriginal()

CHESS_TRANSFER = [
    MAPFILTER1,
    MAPFILTERUNTIL1,
    MAPUNTIL1,
    CHESSORIGINAL,
    ]
