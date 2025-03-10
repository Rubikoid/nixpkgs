{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  cairocffi,
  cffi,
  strenum,
  psutil,
  xcffib,
  pdm-backend,
  pyside6,
  pyvirtualdisplay,
  pytestCheckHook,
  qtile,
}:

buildPythonPackage rec {
  pname = "qtile-bonsai";
  version = "0.5.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "aravinda0";
    repo = "qtile-bonsai";
    tag = "v${version}";
    hash = "sha256-1wiBrLQDdQGsoZAT5XUzmuloVo90y+GZu1bqPrbQl48=";
  };

  build-system = [
    pdm-backend
  ];

  dependencies = [
    strenum
    psutil
  ];

  nativeCheckInputs = [
    pyside6
    pyvirtualdisplay
    (cairocffi.override { withXcffib = true; })
    cffi
    xcffib
    qtile
    pytestCheckHook
  ];

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  disabledTestPaths = [
    # Needs a running DBUS
    "tests/integration/test_layout.py"
    "tests/integration/test_widget.py"
  ];

  pythonImportsCheck = [ "qtile_bonsai" ];

  meta = {
    changelog = "https://github.com/aravinda0/qtile-bonsai/releases/tag/${version}";
    homepage = "https://github.com/aravinda0/qtile-bonsai";
    description = "Flexible layout for the qtile tiling window manager";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      gurjaka
      sigmanificient
    ];
  };
}
