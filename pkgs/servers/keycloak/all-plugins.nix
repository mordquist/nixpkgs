{ callPackage }:

{
  scim-for-keycloak = callPackage ./scim-for-keycloak {};
  keycloak-discord = callPackage ./keycloak-discord {};
  keycloak-has-logged-in = callPackage ./keycloak-has-logged-in {};
  keycloak-metrics-spi = callPackage ./keycloak-metrics-spi {};
}
