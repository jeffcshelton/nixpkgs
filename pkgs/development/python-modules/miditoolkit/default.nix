{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  matplotlib,
  mido,
  numpy,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "miditoolkit";
  version = "1.0.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "YatingMusic";
    repo = "miditoolkit";
    tag = "v${version}";
    hash = "sha256-2snBO/SzVaqDqL8ziZXvRPPdd7IFjPjLzIfi0OgL7mg=";
  };

  build-system = [ hatchling ];

  dependencies = [
    matplotlib
    mido
    numpy
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "miditoolkit" ];

  meta = {
    description = "A toolkit for loading and writing MIDI files";
    homepage = "https://github.com/YatingMusic/miditoolkit";
    changelog = "https://github.com/YatingMusic/miditoolkit/releases/tag/${src.tag}";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.jeffcshelton ];
  };
}
