
link='--link'
mode='' # e.g.: --mode=0770

# Helper
fail() {
	printf '\e[31;1mArgh: %s\e[0m\n'	"$1"	1>&2
	[[ -n "$2" ]] && echo "$2" 1>&2
	exit 1
}

warn() {
	printf '\e[33;1mArgh: %s\e[0m\n'	"$1"	1>&2
	[[ -n "$2" ]] && echo "$2" 1>&2
}

ALLOK=1
X() {
	ALLOK=0
}

# sanity checks
[[ -d '/cluster/project/pangolin/sampleset' ]] || fail 'No sampleset directory:' '/cluster/project/pangolin/sampleset'
[[ -d '/cluster/project/pangolin/data/fgcz_raw ###' ]] || fail 'No download directory:' '/cluster/project/pangolin/data/fgcz_raw ###'


echo -e '\r\e[K[████████████████] done.'
if (( !ALLOK )); then
		echo Some errors
		exit 1
fi;



echo All Ok
exit 0

