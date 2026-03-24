{ lib
, stdenv
, meson
, ninja
, pkg-config
, vala
, gtk4
, libadwaita
, glib
, libsoup_3
, json-glib
, libsecret
, libportal
, libportal-gtk4
, libglycin
, libglycin-gtk4
, src
, desktop-file-utils
, appstream
, wrapGAppsHook3
}:

stdenv.mkDerivation {
  pname = "turntable";
  version = "0.5.1";

  inherit src;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
    desktop-file-utils
    appstream
    glib
    wrapGAppsHook3
  ];

  buildInputs = [
    gtk4
    libadwaita
    glib
    libsoup_3
    json-glib
    libportal-gtk4
    libsecret
    libportal
    libglycin
    libglycin-gtk4
  ];
  postInstall = ''
    glib-compile-schemas $out/share/glib-2.0/schemas/
  '';
  preFixup = ''
    gappsWrapperArgs+=(
      --prefix XDG_DATA_DIRS : "$out/share/gsettings-schemas/turntable-0.5.1"
    )
  '';

  meta = {
    description = "Turntable music player";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
