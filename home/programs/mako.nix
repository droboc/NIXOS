{
  pkgs, ...
}: {
  # Habilitar el servicio de notificaciones Mako
  services.mako.enable = true;

  # Paquetes para notificaciones
  home.packages = with pkgs; [
    libnotify # Para enviar notificaciones
    mako # Demonio de notificaciones
  ];
}
