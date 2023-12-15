{
  outputs = {self}: {
    defaultTemplate = self.templates.trivial;

    templates = {
      clojure = {
        path = ./clojure;
        description = "Reloadable Clojure for Emacsen.";
      };

      minimal = {
        path = ./minimal;
        description = "Devenv for minimalists.";
      };
    };
  };
}
