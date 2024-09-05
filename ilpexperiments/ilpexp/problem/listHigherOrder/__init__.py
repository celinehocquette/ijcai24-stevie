from .list import ListProblem

from .alleven.alleven import Alleven
from .addN.addN import AddN
from .allseqN.allseqN import AllSeqN
from .depth.depth import Depth
from .dropk.dropk import DropK
from .droplast.droplast import DropLast
from .droplastk.droplastk import DropLastK
from .encryption.encryption import Encryption
from .finddup.finddup import FindDup
from .firstHalf.firstHalf import FirstHalf
from .isBranch.isBranch import IsBranch
from .isPalindrome.isPalindrome import IsPalindrome
from .isSubTree.isSubTree import IsSubTree
from .lastHalf.lastHalf import LastHalf
from .mylength.mylength import Len
from .member.member import Member
from .multFromSuc.multFromSuc import MultFromSuc
from .of1And2.of1And2 import Of1And2
from .repeatN.repeatN import RepeatN
from .reverse.reverse import Reverse
from .rotateN.rotateN import RotateN
from .sorted.sorted import Sorted

ALLEVEN = Alleven()
ADDN = AddN()
ALLSEQN = AllSeqN()
DEPTH = Depth()
DROPK = DropK()
DROPLAST = DropLast()
DROPLASTK = DropLastK()
ENCRYPTION = Encryption()
FINDDUP = FindDup()
FIRSTHALF = FirstHalf()
ISBRANCH = IsBranch()
ISPALINDROME = IsPalindrome()
ISSUBTREE = IsSubTree()
LASTHALF = LastHalf()
LEN = Len()
MEMBER = Member()
MULTFROMSUC = MultFromSuc()
OF1AND2 = Of1And2()
REPEATN = RepeatN()
REVERSE = Reverse()
ROTATEN = RotateN()
SORTED = Sorted()



DEFAULT_LIST_HO_PROBLEMS = [
    DROPK,
    ALLEVEN,
    FINDDUP,
    LEN,
    MEMBER,
    SORTED,
    REVERSE,
    DROPLAST,
    ENCRYPTION,
    REPEATN,
    ROTATEN,
    ALLSEQN,
    DROPLASTK,
    FIRSTHALF,
    LASTHALF,
    OF1AND2,
    ISPALINDROME,
    DEPTH,
    ISBRANCH,
    ISSUBTREE,
    ADDN,
    MULTFROMSUC,
    ]

