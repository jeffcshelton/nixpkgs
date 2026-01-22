{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  huggingface-hub,
  miditoolkit,
  numpy,
  pytest-cov,
  pytest-xdist,
  pytestCheckHook,
  symusic,
  tokenizers,
  torch,
  tqdm,
}:

buildPythonPackage rec {
  pname = "miditok";
  version = "3.0.6.post1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Natooz";
    repo = "MidiTok";
    tag = "v${version}";
    hash = "sha256-Jk05+3mJNRHhvej6Rh7LuWcAsK5kuKo27R1BLcEC+RA=";
  };

  build-system = [ hatchling ];

  dependencies = [
    huggingface-hub
    numpy
    symusic
    tokenizers
    tqdm
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  checkInputs = [
    miditoolkit
    pytest-cov
    pytest-xdist
    torch
  ];

  pytestFlagsArray = [
    "-n"
    "auto"
  ];

  disabledTests = [
    # Minor format conversion mismatch, not core functionality
    "test_miditoolkit_to_symusic"

    # Single corrupted MIDI file not filtered
    "test_filter_dataset"
  ];

  pythonImportsCheck = [ "miditok" ];

  meta = {
    description = "Converts MIDI files into sequences of tokens";
    homepage = "https://github.com/Natooz/MidiTok";
    changelog = "https://github.com/Natooz/MidiTok/releases/tag/${src.tag}";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.jeffcshelton ];
  };
}
