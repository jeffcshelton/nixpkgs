{
  lib,
  buildPythonPackage,
  cmake,
  fetchFromGitHub,
  ninja,
  numpy,
  platformdirs,
  pysmartdl,
  pytestCheckHook,
  scikit-build-core,
  scikit-build,
  setuptools,
}:

buildPythonPackage rec {
  pname = "symusic";
  version = "0.5.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Yikai-Liao";
    repo = "symusic";
    tag = "v${version}";
    hash = "sha256-BEGnvUcAbk4cucvWpB6Be6yG5UWkY0FJJVXpwNEi/5U=";
    fetchSubmodules = true;
  };

  build-system = [
    cmake
    ninja
    scikit-build-core
    scikit-build
    setuptools
  ];

  dependencies = [
    numpy
    platformdirs
    pysmartdl
  ];

  dontUseCmakeConfigure = true;

  # Bug in symusic upstream that causes obfuscated failures for dump_abc calls.
  postPatch = ''
    substituteInPlace py_src/core.cpp \
      --replace 'R"("{} "{}" -o "{}")"' 'R"("{}" "{}" -o "{}")"'
  '';

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "symusic" ];

  meta = {
    description = "Lightning-fast MIDI decoding library for Python";
    homepage = "https://github.com/Yikai-Liao/symusic";
    changelog = "https://github.com/Yikai-Liao/symusic/releases/tag/${src.tag}";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.jeffcshelton ];
  };
}
