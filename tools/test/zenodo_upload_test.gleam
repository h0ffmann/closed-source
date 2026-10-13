import fabric/json
import fabric/sys
import fabric/zenodo_upload

pub fn deposit_metadata_keeps_listed_keys_test() {
  let meta =
    json.Object([
      #("title", json.String("t")),
      #("x", json.Int(1)),
      #("upload_type", json.String("publication")),
      #("publication_type", json.String("preprint")),
    ])
  // The order is the keep list's, not the file's; the version comes last.
  assert json.encode(zenodo_upload.deposit_metadata(meta, "v0.1.0"), 0, True)
    == "{\"metadata\": {\"title\": \"t\", \"upload_type\": \"publication\", \"publication_type\": \"preprint\", \"version\": \"v0.1.0\"}}"
}

pub fn deposit_metadata_of_the_real_file_test() {
  let assert Ok(text) = sys.read("../.zenodo.json")
  let assert Ok(meta) = json.decode(text)
  let assert Ok(real) =
    zenodo_upload.deposit_metadata(meta, "v0.0.0") |> json.get("metadata")
  assert json.get(real, "upload_type") == Ok(json.String("publication"))
  assert json.get(real, "doi") == Error(Nil)
  assert json.get(real, "version") == Ok(json.String("v0.0.0"))
}

pub fn normalise_prints_as_pathlib_test() {
  assert zenodo_upload.normalise("pdf//./a.pdf") == "pdf/a.pdf"
  assert zenodo_upload.normalise("./a.pdf") == "a.pdf"
  assert zenodo_upload.normalise("/x/../a.pdf") == "/x/../a.pdf"
  assert zenodo_upload.normalise("//a") == "//a"
  assert zenodo_upload.normalise("///a") == "/a"
  assert zenodo_upload.normalise(".") == "."
}

pub fn is_pdf_test() {
  assert !zenodo_upload.is_pdf("../README.md")
  assert !zenodo_upload.is_pdf("missing.pdf")
  assert !zenodo_upload.is_pdf(".pdf")
}
