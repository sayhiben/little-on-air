"""Run a CAD job with a deterministic exit after all work and assertions.

The installed Windows OpenCascade/CadQuery combination faults during Python
interpreter teardown, including after a bare import. Immediate process exit
avoids that teardown; exceptions still print their traceback and fail the job.
No validation result is inferred from a crash or from partially written files.
"""
from pathlib import Path
import os,runpy,sys,traceback

if __name__=='__main__':
    allowed={'build','validate_fit'}
    if len(sys.argv)!=2 or sys.argv[1] not in allowed:
        raise SystemExit('Usage: python run_cad.py build|validate_fit')
    status=0
    try:
        runpy.run_path(str(Path(__file__).with_name(sys.argv[1]+'.py')),run_name='__main__')
    except BaseException:
        traceback.print_exc()
        status=1
    sys.stdout.flush();sys.stderr.flush()
    if os.name=='nt':os._exit(status)
    raise SystemExit(status)
