{inputs, ...}: {
  perSystem = _: {
    process-compose.dev = {
      imports = [inputs.services-flake.processComposeModules.default];

      # Uncomment to enable Postgres. See
      # https://community.flake.parts/services-flake/postgres for the full
      # option set (extensions, initialScript, listen_addresses, etc.).
      #
      # services.postgres.pg = {
      #   enable = true;
      #   initialDatabases = [{name = "app_dev";} {name = "app_test";}];
      # };

      settings.processes = {
        # Replace these with the project's actual processes. `depends_on` on
        # `services.postgres.pg` would gate startup on Postgres health.
        #
        # astro.command = "pnpm dev";
        # tailwind.command = "pnpm tailwindcss -i src/styles.css -o dist/styles.css --watch";
        # nrepl = {
        #   command = "op run --account invetica.1password.com -- bin/nrepl";
        #   readiness_probe.exec.command = ''nc -z localhost "$NREPL_PORT"'';
        # };
      };
    };
  };
}
