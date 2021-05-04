--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15
-- Dumped by pg_dump version 10.15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO "user";

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO "user";

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO "user";

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO "user";

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO "user";

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO "user";

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO "user";

--
-- Name: client; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO "user";

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO "user";

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO "user";

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO "user";

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO "user";

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO "user";

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO "user";

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO "user";

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO "user";

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO "user";

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO "user";

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO "user";

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO "user";

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO "user";

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO "user";

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO "user";

--
-- Name: component; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO "user";

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO "user";

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO "user";

--
-- Name: credential; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO "user";

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO "user";

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO "user";

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO "user";

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO "user";

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO "user";

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO "user";

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO "user";

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO "user";

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO "user";

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO "user";

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO "user";

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO "user";

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO "user";

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO "user";

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO "user";

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO "user";

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO "user";

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO "user";

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO "user";

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO "user";

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO "user";

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO "user";

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO "user";

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO "user";

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO "user";

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO "user";

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO "user";

--
-- Name: realm; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.realm OWNER TO "user";

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO "user";

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO "user";

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO "user";

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO "user";

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO "user";

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO "user";

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO "user";

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO "user";

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO "user";

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO "user";

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO "user";

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO "user";

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO "user";

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO "user";

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO "user";

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO "user";

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO "user";

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO "user";

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO "user";

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO "user";

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO "user";

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO "user";

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO "user";

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO "user";

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO "user";

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO "user";

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO "user";

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO "user";

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO "user";

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO "user";

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO "user";

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO "user";

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO "user";

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO "user";

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO "user";

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO "user";

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO "user";

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO "user";

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
b5d314f2-a3f4-4ec7-8ccd-879950546d1d	\N	auth-cookie	master	41340f93-d183-4355-8b25-835c34e03f04	2	10	f	\N	\N
06cf4699-2193-4a24-93df-a172d9b787bf	\N	auth-spnego	master	41340f93-d183-4355-8b25-835c34e03f04	3	20	f	\N	\N
446e8d43-2842-49db-bdcc-1c6c8f3d2e5c	\N	identity-provider-redirector	master	41340f93-d183-4355-8b25-835c34e03f04	2	25	f	\N	\N
42dd98b6-d3f8-4f8f-a3fb-246018254fb7	\N	\N	master	41340f93-d183-4355-8b25-835c34e03f04	2	30	t	76526d9a-2b79-4deb-8518-fb2eb249cade	\N
621d23af-5a62-4b70-b8fa-5688ef6889d6	\N	auth-username-password-form	master	76526d9a-2b79-4deb-8518-fb2eb249cade	0	10	f	\N	\N
d24210bd-c5fa-4686-a9be-075b9414258a	\N	\N	master	76526d9a-2b79-4deb-8518-fb2eb249cade	1	20	t	7e554beb-a1c4-4774-9289-b240434eca5c	\N
9a17673d-3f1e-4ef8-91ce-d47bd8db1f96	\N	conditional-user-configured	master	7e554beb-a1c4-4774-9289-b240434eca5c	0	10	f	\N	\N
923cab01-baa1-45f0-8850-c46dbd55901e	\N	auth-otp-form	master	7e554beb-a1c4-4774-9289-b240434eca5c	0	20	f	\N	\N
5eb45d5a-f560-421d-84ae-ca509161fbc7	\N	direct-grant-validate-username	master	f3bcfdda-7b41-4be1-9e7a-ec5f1cf210fd	0	10	f	\N	\N
1e56161f-b7e7-419f-bc45-8582a6690b8c	\N	direct-grant-validate-password	master	f3bcfdda-7b41-4be1-9e7a-ec5f1cf210fd	0	20	f	\N	\N
eefad059-592c-4cbe-8253-ac3b2807f910	\N	\N	master	f3bcfdda-7b41-4be1-9e7a-ec5f1cf210fd	1	30	t	f916af6f-6fe5-420e-a280-caf34a544ae3	\N
226022c2-38f1-400f-bf32-318678667aa2	\N	conditional-user-configured	master	f916af6f-6fe5-420e-a280-caf34a544ae3	0	10	f	\N	\N
26dc643c-df11-4d9a-8de2-947e2c23c7e0	\N	direct-grant-validate-otp	master	f916af6f-6fe5-420e-a280-caf34a544ae3	0	20	f	\N	\N
53a65230-e6eb-4e5d-87df-cac2975c1824	\N	registration-page-form	master	76b0af4a-2697-4cfd-9c5b-c34bd04de77d	0	10	t	161522c7-c7f2-4b57-9853-421197f2af83	\N
1a14de95-3384-484c-b6d2-6f47ef996c57	\N	registration-user-creation	master	161522c7-c7f2-4b57-9853-421197f2af83	0	20	f	\N	\N
8f828e21-d2e8-473a-82a2-ae10f4863f74	\N	registration-profile-action	master	161522c7-c7f2-4b57-9853-421197f2af83	0	40	f	\N	\N
28486f35-edf1-4ae5-a52d-ffde5eaebd0b	\N	registration-password-action	master	161522c7-c7f2-4b57-9853-421197f2af83	0	50	f	\N	\N
58e0b8d5-e4f6-4c78-9cd4-f453613aa10c	\N	registration-recaptcha-action	master	161522c7-c7f2-4b57-9853-421197f2af83	3	60	f	\N	\N
fc08b3c1-7384-4eba-8d85-ae02bc6cc1d6	\N	reset-credentials-choose-user	master	202309df-43aa-4a01-8ab3-d2e273153c21	0	10	f	\N	\N
76cc2734-1201-44c1-a046-38ce81f5a406	\N	reset-credential-email	master	202309df-43aa-4a01-8ab3-d2e273153c21	0	20	f	\N	\N
81b6c28b-c91e-4ca1-9f45-583405418649	\N	reset-password	master	202309df-43aa-4a01-8ab3-d2e273153c21	0	30	f	\N	\N
bfd6164b-e988-4aaa-b8fb-9a742e79bd8a	\N	\N	master	202309df-43aa-4a01-8ab3-d2e273153c21	1	40	t	4aec02be-4af8-4b0e-8e95-cce6ef65b2a0	\N
1e83bc31-cdd0-4fc7-a164-bfc9da8119fd	\N	conditional-user-configured	master	4aec02be-4af8-4b0e-8e95-cce6ef65b2a0	0	10	f	\N	\N
5db516dc-2fbb-46a7-bc82-321a74142eae	\N	reset-otp	master	4aec02be-4af8-4b0e-8e95-cce6ef65b2a0	0	20	f	\N	\N
584a52b6-6284-4256-9378-3da01c573e0b	\N	client-secret	master	d28597e5-9749-4a17-b237-dd3d6ec23ca3	2	10	f	\N	\N
a0826614-d0d2-49e9-9c98-488a3953913e	\N	client-jwt	master	d28597e5-9749-4a17-b237-dd3d6ec23ca3	2	20	f	\N	\N
164a9e2e-3290-40d2-9ee2-6df4071982b8	\N	client-secret-jwt	master	d28597e5-9749-4a17-b237-dd3d6ec23ca3	2	30	f	\N	\N
f46823da-1a40-4af7-aef6-0156e6c56206	\N	client-x509	master	d28597e5-9749-4a17-b237-dd3d6ec23ca3	2	40	f	\N	\N
b36af6f5-9700-44d8-a7a9-96855cdd0fd8	\N	idp-review-profile	master	7e254e7f-740c-4366-8976-03123b86438b	0	10	f	\N	fda5806c-b056-4339-88f7-1b82e37e1f75
a1fd3ff5-7b31-4c02-a6d0-303295639842	\N	\N	master	7e254e7f-740c-4366-8976-03123b86438b	0	20	t	2c2ae017-fd8a-49ce-a0bc-a06b52d2e32e	\N
779df80e-cbf4-4f66-a0db-efb17c63ef17	\N	idp-create-user-if-unique	master	2c2ae017-fd8a-49ce-a0bc-a06b52d2e32e	2	10	f	\N	d1de2c2e-a3a0-4815-8088-1fa61c5cc703
a0fd2518-17b8-4904-a5e6-e9bc209839a0	\N	\N	master	2c2ae017-fd8a-49ce-a0bc-a06b52d2e32e	2	20	t	611858e6-72b1-4359-a41c-960d04739224	\N
5915f453-c5e5-4f1d-a72c-b851e74cb37e	\N	idp-confirm-link	master	611858e6-72b1-4359-a41c-960d04739224	0	10	f	\N	\N
f243f8a3-fc36-4c6f-9864-cd97231530ac	\N	\N	master	611858e6-72b1-4359-a41c-960d04739224	0	20	t	0550864f-2c7e-4fd0-acd6-4ea88041563d	\N
36f9eca4-2ec2-4ada-9711-70c876dacf63	\N	idp-email-verification	master	0550864f-2c7e-4fd0-acd6-4ea88041563d	2	10	f	\N	\N
fa2351dd-c908-43b1-a1b1-59e16a48a4f2	\N	\N	master	0550864f-2c7e-4fd0-acd6-4ea88041563d	2	20	t	b975f4af-711a-4b08-99c3-5d637c4a79db	\N
da2595f9-3c56-41fe-b4c1-2019af7eb5c6	\N	idp-username-password-form	master	b975f4af-711a-4b08-99c3-5d637c4a79db	0	10	f	\N	\N
9b4de524-c099-457f-85e1-192047b714ea	\N	\N	master	b975f4af-711a-4b08-99c3-5d637c4a79db	1	20	t	d61e5599-1a6e-4875-a7fa-265446636ffd	\N
0a14388d-e28a-4b75-b692-151ade6cf91d	\N	conditional-user-configured	master	d61e5599-1a6e-4875-a7fa-265446636ffd	0	10	f	\N	\N
f840f2ac-bc62-43b6-b7c4-d5a47433c6ad	\N	auth-otp-form	master	d61e5599-1a6e-4875-a7fa-265446636ffd	0	20	f	\N	\N
26f9ddab-8843-4338-bb74-05e513744201	\N	http-basic-authenticator	master	3349e23c-1d02-44e6-ba68-d4fcc397df0b	0	10	f	\N	\N
8b7f8d70-1bf3-42a1-a9c3-62f311fe9f52	\N	docker-http-basic-authenticator	master	e0525862-c5cb-4f7b-ac4b-3fb6c4ff4a1c	0	10	f	\N	\N
f61f539e-a4e3-4817-9f35-2c142dd21239	\N	no-cookie-redirect	master	1948b634-c7cd-4cb0-b63e-e4e47b3f5c4d	0	10	f	\N	\N
9e15413d-935f-4a86-a12e-7838fba8f4d0	\N	\N	master	1948b634-c7cd-4cb0-b63e-e4e47b3f5c4d	0	20	t	ad2aebbb-f585-4530-9e15-0134719ee19a	\N
9e49c157-c1d5-4a5c-885e-991e3dab900c	\N	basic-auth	master	ad2aebbb-f585-4530-9e15-0134719ee19a	0	10	f	\N	\N
0c1f4751-853c-4563-a279-ac41e6e1ddc1	\N	basic-auth-otp	master	ad2aebbb-f585-4530-9e15-0134719ee19a	3	20	f	\N	\N
42bff9e1-c387-4205-8e42-d5207a7d1c3b	\N	auth-spnego	master	ad2aebbb-f585-4530-9e15-0134719ee19a	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
41340f93-d183-4355-8b25-835c34e03f04	browser	browser based authentication	master	basic-flow	t	t
76526d9a-2b79-4deb-8518-fb2eb249cade	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
7e554beb-a1c4-4774-9289-b240434eca5c	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
f3bcfdda-7b41-4be1-9e7a-ec5f1cf210fd	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
f916af6f-6fe5-420e-a280-caf34a544ae3	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
76b0af4a-2697-4cfd-9c5b-c34bd04de77d	registration	registration flow	master	basic-flow	t	t
161522c7-c7f2-4b57-9853-421197f2af83	registration form	registration form	master	form-flow	f	t
202309df-43aa-4a01-8ab3-d2e273153c21	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
4aec02be-4af8-4b0e-8e95-cce6ef65b2a0	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
d28597e5-9749-4a17-b237-dd3d6ec23ca3	clients	Base authentication for clients	master	client-flow	t	t
7e254e7f-740c-4366-8976-03123b86438b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
2c2ae017-fd8a-49ce-a0bc-a06b52d2e32e	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
611858e6-72b1-4359-a41c-960d04739224	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
0550864f-2c7e-4fd0-acd6-4ea88041563d	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
b975f4af-711a-4b08-99c3-5d637c4a79db	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
d61e5599-1a6e-4875-a7fa-265446636ffd	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
3349e23c-1d02-44e6-ba68-d4fcc397df0b	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
e0525862-c5cb-4f7b-ac4b-3fb6c4ff4a1c	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
1948b634-c7cd-4cb0-b63e-e4e47b3f5c4d	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
ad2aebbb-f585-4530-9e15-0134719ee19a	Authentication Options	Authentication options.	master	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
fda5806c-b056-4339-88f7-1b82e37e1f75	review profile config	master
d1de2c2e-a3a0-4815-8088-1fa61c5cc703	create unique user config	master
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
fda5806c-b056-4339-88f7-1b82e37e1f75	missing	update.profile.on.first.login
d1de2c2e-a3a0-4815-8088-1fa61c5cc703	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
4a769675-b438-4f6c-bba3-01099c2bba35	t	t	master-realm	0	f	81441125-24cb-44a8-90c1-7093663420bf	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
f583e151-9c5b-4b04-a063-fac67125a01c	t	f	account	0	f	4ddc1874-08a4-46d0-962b-2bf54c259b95	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	t	f	account-console	0	t	12bca951-2435-435d-ab2b-dcff9dd1e17c	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ef262a64-56ae-4103-bb4a-e007bb682b82	t	f	broker	0	f	675c7fa4-1e23-4117-86b0-0050ed6f0ec8	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
7e54002c-d307-41bd-9601-fddb5ddcfefb	t	f	security-admin-console	0	t	3d0be31f-511e-4a33-94e1-62d86c7c50a3	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
60bdbe03-1554-4523-8785-0ed38bd91b07	t	f	admin-cli	0	t	96b9f178-f6be-464b-9c55-eed5ebee6688	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	S256	pkce.code.challenge.method
7e54002c-d307-41bd-9601-fddb5ddcfefb	S256	pkce.code.challenge.method
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_default_roles (client_id, role_id) FROM stdin;
f583e151-9c5b-4b04-a063-fac67125a01c	fd7d7f75-312e-4f92-8683-8b1d9bd70ca4
f583e151-9c5b-4b04-a063-fac67125a01c	842ffd65-7c4d-42f1-baac-5c875284e2e1
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
1703cd3e-3d0e-4881-b723-4dd1c4fedd21	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
3d35613f-342b-4fa9-9967-5c37597883a4	role_list	master	SAML role list	saml
d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	profile	master	OpenID Connect built-in scope: profile	openid-connect
a801e1f9-ced3-4644-8fd2-acb93cf24904	email	master	OpenID Connect built-in scope: email	openid-connect
bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	address	master	OpenID Connect built-in scope: address	openid-connect
f550e41e-2f17-4998-a828-83578ebe871e	phone	master	OpenID Connect built-in scope: phone	openid-connect
7e43eb45-d446-4d98-a175-c1fe4acfbbdb	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
d30e6093-1bd4-4e7c-abec-50720909a75f	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
aa24096f-9de2-4369-bb12-824bc6259158	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
1703cd3e-3d0e-4881-b723-4dd1c4fedd21	true	display.on.consent.screen
1703cd3e-3d0e-4881-b723-4dd1c4fedd21	${offlineAccessScopeConsentText}	consent.screen.text
3d35613f-342b-4fa9-9967-5c37597883a4	true	display.on.consent.screen
3d35613f-342b-4fa9-9967-5c37597883a4	${samlRoleListScopeConsentText}	consent.screen.text
d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	true	display.on.consent.screen
d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	${profileScopeConsentText}	consent.screen.text
d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	true	include.in.token.scope
a801e1f9-ced3-4644-8fd2-acb93cf24904	true	display.on.consent.screen
a801e1f9-ced3-4644-8fd2-acb93cf24904	${emailScopeConsentText}	consent.screen.text
a801e1f9-ced3-4644-8fd2-acb93cf24904	true	include.in.token.scope
bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	true	display.on.consent.screen
bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	${addressScopeConsentText}	consent.screen.text
bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	true	include.in.token.scope
f550e41e-2f17-4998-a828-83578ebe871e	true	display.on.consent.screen
f550e41e-2f17-4998-a828-83578ebe871e	${phoneScopeConsentText}	consent.screen.text
f550e41e-2f17-4998-a828-83578ebe871e	true	include.in.token.scope
7e43eb45-d446-4d98-a175-c1fe4acfbbdb	true	display.on.consent.screen
7e43eb45-d446-4d98-a175-c1fe4acfbbdb	${rolesScopeConsentText}	consent.screen.text
7e43eb45-d446-4d98-a175-c1fe4acfbbdb	false	include.in.token.scope
d30e6093-1bd4-4e7c-abec-50720909a75f	false	display.on.consent.screen
d30e6093-1bd4-4e7c-abec-50720909a75f		consent.screen.text
d30e6093-1bd4-4e7c-abec-50720909a75f	false	include.in.token.scope
aa24096f-9de2-4369-bb12-824bc6259158	false	display.on.consent.screen
aa24096f-9de2-4369-bb12-824bc6259158	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
f583e151-9c5b-4b04-a063-fac67125a01c	3d35613f-342b-4fa9-9967-5c37597883a4	t
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	3d35613f-342b-4fa9-9967-5c37597883a4	t
60bdbe03-1554-4523-8785-0ed38bd91b07	3d35613f-342b-4fa9-9967-5c37597883a4	t
ef262a64-56ae-4103-bb4a-e007bb682b82	3d35613f-342b-4fa9-9967-5c37597883a4	t
4a769675-b438-4f6c-bba3-01099c2bba35	3d35613f-342b-4fa9-9967-5c37597883a4	t
7e54002c-d307-41bd-9601-fddb5ddcfefb	3d35613f-342b-4fa9-9967-5c37597883a4	t
f583e151-9c5b-4b04-a063-fac67125a01c	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	t
f583e151-9c5b-4b04-a063-fac67125a01c	a801e1f9-ced3-4644-8fd2-acb93cf24904	t
f583e151-9c5b-4b04-a063-fac67125a01c	7e43eb45-d446-4d98-a175-c1fe4acfbbdb	t
f583e151-9c5b-4b04-a063-fac67125a01c	d30e6093-1bd4-4e7c-abec-50720909a75f	t
f583e151-9c5b-4b04-a063-fac67125a01c	1703cd3e-3d0e-4881-b723-4dd1c4fedd21	f
f583e151-9c5b-4b04-a063-fac67125a01c	bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	f
f583e151-9c5b-4b04-a063-fac67125a01c	f550e41e-2f17-4998-a828-83578ebe871e	f
f583e151-9c5b-4b04-a063-fac67125a01c	aa24096f-9de2-4369-bb12-824bc6259158	f
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	t
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	a801e1f9-ced3-4644-8fd2-acb93cf24904	t
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	7e43eb45-d446-4d98-a175-c1fe4acfbbdb	t
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	d30e6093-1bd4-4e7c-abec-50720909a75f	t
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	1703cd3e-3d0e-4881-b723-4dd1c4fedd21	f
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	f
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	f550e41e-2f17-4998-a828-83578ebe871e	f
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	aa24096f-9de2-4369-bb12-824bc6259158	f
60bdbe03-1554-4523-8785-0ed38bd91b07	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	t
60bdbe03-1554-4523-8785-0ed38bd91b07	a801e1f9-ced3-4644-8fd2-acb93cf24904	t
60bdbe03-1554-4523-8785-0ed38bd91b07	7e43eb45-d446-4d98-a175-c1fe4acfbbdb	t
60bdbe03-1554-4523-8785-0ed38bd91b07	d30e6093-1bd4-4e7c-abec-50720909a75f	t
60bdbe03-1554-4523-8785-0ed38bd91b07	1703cd3e-3d0e-4881-b723-4dd1c4fedd21	f
60bdbe03-1554-4523-8785-0ed38bd91b07	bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	f
60bdbe03-1554-4523-8785-0ed38bd91b07	f550e41e-2f17-4998-a828-83578ebe871e	f
60bdbe03-1554-4523-8785-0ed38bd91b07	aa24096f-9de2-4369-bb12-824bc6259158	f
ef262a64-56ae-4103-bb4a-e007bb682b82	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	t
ef262a64-56ae-4103-bb4a-e007bb682b82	a801e1f9-ced3-4644-8fd2-acb93cf24904	t
ef262a64-56ae-4103-bb4a-e007bb682b82	7e43eb45-d446-4d98-a175-c1fe4acfbbdb	t
ef262a64-56ae-4103-bb4a-e007bb682b82	d30e6093-1bd4-4e7c-abec-50720909a75f	t
ef262a64-56ae-4103-bb4a-e007bb682b82	1703cd3e-3d0e-4881-b723-4dd1c4fedd21	f
ef262a64-56ae-4103-bb4a-e007bb682b82	bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	f
ef262a64-56ae-4103-bb4a-e007bb682b82	f550e41e-2f17-4998-a828-83578ebe871e	f
ef262a64-56ae-4103-bb4a-e007bb682b82	aa24096f-9de2-4369-bb12-824bc6259158	f
4a769675-b438-4f6c-bba3-01099c2bba35	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	t
4a769675-b438-4f6c-bba3-01099c2bba35	a801e1f9-ced3-4644-8fd2-acb93cf24904	t
4a769675-b438-4f6c-bba3-01099c2bba35	7e43eb45-d446-4d98-a175-c1fe4acfbbdb	t
4a769675-b438-4f6c-bba3-01099c2bba35	d30e6093-1bd4-4e7c-abec-50720909a75f	t
4a769675-b438-4f6c-bba3-01099c2bba35	1703cd3e-3d0e-4881-b723-4dd1c4fedd21	f
4a769675-b438-4f6c-bba3-01099c2bba35	bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	f
4a769675-b438-4f6c-bba3-01099c2bba35	f550e41e-2f17-4998-a828-83578ebe871e	f
4a769675-b438-4f6c-bba3-01099c2bba35	aa24096f-9de2-4369-bb12-824bc6259158	f
7e54002c-d307-41bd-9601-fddb5ddcfefb	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	t
7e54002c-d307-41bd-9601-fddb5ddcfefb	a801e1f9-ced3-4644-8fd2-acb93cf24904	t
7e54002c-d307-41bd-9601-fddb5ddcfefb	7e43eb45-d446-4d98-a175-c1fe4acfbbdb	t
7e54002c-d307-41bd-9601-fddb5ddcfefb	d30e6093-1bd4-4e7c-abec-50720909a75f	t
7e54002c-d307-41bd-9601-fddb5ddcfefb	1703cd3e-3d0e-4881-b723-4dd1c4fedd21	f
7e54002c-d307-41bd-9601-fddb5ddcfefb	bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	f
7e54002c-d307-41bd-9601-fddb5ddcfefb	f550e41e-2f17-4998-a828-83578ebe871e	f
7e54002c-d307-41bd-9601-fddb5ddcfefb	aa24096f-9de2-4369-bb12-824bc6259158	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
1703cd3e-3d0e-4881-b723-4dd1c4fedd21	e1aba0d2-34de-4845-9641-5c04fe6fed43
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
9f56b89b-0c44-47a0-84cc-fd9c7d53c433	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
fab81f13-bd0a-4218-ad2b-4ac55316f286	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
05c00a39-54c8-4c50-91a3-cdfc1a97becb	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a122c6a4-9969-45ab-b7c9-fe17cd3d69d9	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
974b6df3-2de1-4636-a3f0-eb9f3e5d376f	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
e8ac5dc9-d6d6-4aa8-9447-6a7abeff393d	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
5e29ec13-c0b5-43c0-a586-8797f616e8c8	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
30cbf793-1024-49e2-b11c-3f8fb93502d5	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
72724183-96b3-4386-ad06-0b3453579176	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
b75f281f-878e-48a4-a3bd-2c6040d1ef7b	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
adeb5d05-5a80-493a-9c0f-ff11419a4201	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
e7b306b6-aa5b-4216-95f8-d57d953d6b09	e8ac5dc9-d6d6-4aa8-9447-6a7abeff393d	allow-default-scopes	true
78f21adb-6361-409a-9e55-ee58710a33a8	30cbf793-1024-49e2-b11c-3f8fb93502d5	allow-default-scopes	true
aaf324ae-ec38-40b6-8a87-cca6b9218341	9f56b89b-0c44-47a0-84cc-fd9c7d53c433	client-uris-must-match	true
788f938e-b45f-4e41-8e7d-39427d8b5d87	9f56b89b-0c44-47a0-84cc-fd9c7d53c433	host-sending-registration-request-must-match	true
7a37f443-0749-486a-a00e-f561f835efb0	a122c6a4-9969-45ab-b7c9-fe17cd3d69d9	max-clients	200
d3a39f0d-d2b2-4050-bb24-7aeffe1a4c5a	5e29ec13-c0b5-43c0-a586-8797f616e8c8	allowed-protocol-mapper-types	oidc-full-name-mapper
4c63c7b5-9086-4820-836f-837632478ceb	5e29ec13-c0b5-43c0-a586-8797f616e8c8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d2fd39d4-8e39-47e3-ae3a-266ea0efabc8	5e29ec13-c0b5-43c0-a586-8797f616e8c8	allowed-protocol-mapper-types	saml-user-property-mapper
f02172ea-0381-4b69-85d1-22b5cef6facb	5e29ec13-c0b5-43c0-a586-8797f616e8c8	allowed-protocol-mapper-types	oidc-address-mapper
16488807-6ad6-42df-8cc5-8dde209c3005	5e29ec13-c0b5-43c0-a586-8797f616e8c8	allowed-protocol-mapper-types	saml-user-attribute-mapper
b47d2659-ca5b-4a5f-9b08-378465d9a1f1	5e29ec13-c0b5-43c0-a586-8797f616e8c8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8f094bae-aa19-4cca-a230-d348302c3bae	5e29ec13-c0b5-43c0-a586-8797f616e8c8	allowed-protocol-mapper-types	saml-role-list-mapper
6dbf2f36-46b7-42e0-80c7-4561e3bf190d	5e29ec13-c0b5-43c0-a586-8797f616e8c8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7738a65c-d2d3-40f7-b630-3d86a6367368	974b6df3-2de1-4636-a3f0-eb9f3e5d376f	allowed-protocol-mapper-types	oidc-full-name-mapper
f9698b17-327f-4fda-8725-60c848cd256e	974b6df3-2de1-4636-a3f0-eb9f3e5d376f	allowed-protocol-mapper-types	saml-user-attribute-mapper
245f591d-421a-40d8-a2a8-25d92d060089	974b6df3-2de1-4636-a3f0-eb9f3e5d376f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5c679f78-db2d-453a-ab37-a5f0114bb646	974b6df3-2de1-4636-a3f0-eb9f3e5d376f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ed2d2d78-b087-4790-b45a-ccbc41d8a0d4	974b6df3-2de1-4636-a3f0-eb9f3e5d376f	allowed-protocol-mapper-types	oidc-address-mapper
2290dd89-8120-4b2e-9284-c181a556f359	974b6df3-2de1-4636-a3f0-eb9f3e5d376f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
926020a3-49cc-4f4e-87e9-cb67400c4886	974b6df3-2de1-4636-a3f0-eb9f3e5d376f	allowed-protocol-mapper-types	saml-user-property-mapper
aed1a224-4ce5-472d-91d9-2e8df07f3b48	974b6df3-2de1-4636-a3f0-eb9f3e5d376f	allowed-protocol-mapper-types	saml-role-list-mapper
e43f7309-e36d-41d3-963d-1f442f30c54c	adeb5d05-5a80-493a-9c0f-ff11419a4201	priority	100
f8528000-0d50-4577-a2cc-bc23de5e7f26	adeb5d05-5a80-493a-9c0f-ff11419a4201	secret	lhm8ldM5acISpkqZWl5Qzw
6a43c005-7802-4e2c-8720-879aa6347c3c	adeb5d05-5a80-493a-9c0f-ff11419a4201	kid	ab0bc435-8064-447d-b5f1-2d9784e9f0a8
d5173dc3-6988-4c11-b247-12401d624b28	b75f281f-878e-48a4-a3bd-2c6040d1ef7b	kid	017ea585-5bc5-4de3-9fe0-4755a929579c
e8e88742-d44b-469d-a6e9-50cc311cc342	b75f281f-878e-48a4-a3bd-2c6040d1ef7b	secret	xn6fgItV4QRd4pJqtVBEju5YAyG3BDgHJue1CtjEr2gAv_RMmCiQohNhai94GM9qiHsad8vm61WeLNvvvl3L0g
5b08c60b-f448-4f68-836b-e517067f7d2c	b75f281f-878e-48a4-a3bd-2c6040d1ef7b	priority	100
530853cd-1b1e-4077-9f83-a1a44b70bf5e	b75f281f-878e-48a4-a3bd-2c6040d1ef7b	algorithm	HS256
1f46923d-4d7d-498a-8be3-2b17b0cf0f36	72724183-96b3-4386-ad06-0b3453579176	certificate	MIICmzCCAYMCBgF5N7xwhDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwNTA0MTQxNDI3WhcNMzEwNTA0MTQxNjA3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCn5Ss6Dvs9w2pKgQgzxsFcggs20EifKaOea5I5gYHP0WSAyGBxY0vrSUijeO5Rxjc1hqvIm6uHhnDerX4BDXbZeVD64OwXUE7b3Ci9zLQNUlLmsNUcimIWLpg4wsosEkfzXCey/l9y8VgGfFMaeQtAFgpDzggTFQIwf5KZJ+9Mu+I5wmF2X5YAdGO2/lizrie3pMi1r7ekmjIzcvU7Js95p2VlT/N5szoLH1uL1vlFGYh1AgnT6kyz7Xs2IYz6RRfakHm9/stMEkx0KzbUJ9Pu5fL4qxwZvIIDDpG0Qbdd1thONvs6d7jwfTM7UVTbkxfw88ZNFr5sQNHF9zOklLU/AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIx5xL3nUZmfHqvvurespeRvHsQfvzJmx9R1HX2ocNVatF9V9EZFfDTJD75MO6nkXiZGnj81Un3kPFuSV40FJFggytGqt5EUtwi3+SvOl9F2J5t/Kolr1MmM+zbPVKGEJDq9W7FW2xLz9Krhdp0JqglTSECqfndllAu8PTy2f2DqETRhIMSrhWl9/NS0McSbqWlUxwjg8xGqhoq6rE+DQ+W5sDgBzudFiV/z22eD0K3k00tq+Cy8LTMBHZI7XC9A5Gq6Ey3dHLM10Xk/vVqeD8H16H5YVvxOLKZRmvhFjtaX5RkMGap+yy+Ytv/mh2mVEqtRreFjqfxth+wyZTj4Cxc=
8c9fe948-fb53-45a2-8563-e8d90c707a3b	72724183-96b3-4386-ad06-0b3453579176	priority	100
1d5b2c2f-370b-41a3-a2d3-6952502a4446	72724183-96b3-4386-ad06-0b3453579176	privateKey	MIIEpAIBAAKCAQEAp+UrOg77PcNqSoEIM8bBXIILNtBInymjnmuSOYGBz9FkgMhgcWNL60lIo3juUcY3NYaryJurh4Zw3q1+AQ122XlQ+uDsF1BO29wovcy0DVJS5rDVHIpiFi6YOMLKLBJH81wnsv5fcvFYBnxTGnkLQBYKQ84IExUCMH+SmSfvTLviOcJhdl+WAHRjtv5Ys64nt6TIta+3pJoyM3L1OybPeadlZU/zebM6Cx9bi9b5RRmIdQIJ0+pMs+17NiGM+kUX2pB5vf7LTBJMdCs21CfT7uXy+KscGbyCAw6RtEG3XdbYTjb7One48H0zO1FU25MX8PPGTRa+bEDRxfczpJS1PwIDAQABAoIBAQCSjhmgkWlALa8/n8iAIbOxw5Z0X3W08YzwgWffqKues2IuhDqjX5Dqrkqo36vwV7zjjU2wTCp7n6Aw0HKYCp+/EAXfKK0NYL2lb1Vk8CYPJthUpPEx+53JTRz1FxuRQtfpl3zT4vWAiSlUZ/vGtPhcFaEaNOOZfJIvsXxPEqvxZvg/0bKnPpgPok/FZogFZIpD0hLf15XOcxBZkOxamvruNvA+SwpwoBeFGvc1YCHse1QbHjjv6encbRlRFzAB7WfhSakimKk7AXCItuxaWOJST7hLeLOtE6Cyu04vEus3E4dvhKRS0HmmCWk1e/TMzN/u4zuITV96zks/r78m9WsJAoGBAOUZH5CJ7YWtZxBeMs7t7/MsN4Tg3BQNvPVpW+O2QkK3J/kKtMSS8lHWkspRbgBLaPLhtoCT1rMAafwnVrrO0q/2WQ8xz9GpqxU7WCgMcFiMDtmN7QFROFFlKxVg7ACkzq9RNhmPeNUr82XmaIP/wpQ4WWuss8Tw/uN07rPnp6pNAoGBALucPC9T9s7gekDvAVkO5JayeVSz0BCpiM3zS2LAQZ42F2nukxI+wGe7dobRXg1iCmdELQ6Luy9PxWVe3YDpnj5aBI+IOVuca+80mj0YTjbPiGLeTe4B9K/2yv+7RSn8Gp36NxZuLDSrJaISklcSwDMww6f6g1j1cqLmW9Us8gu7AoGBAORpuQPF0K/v5Ar4sBWKOysq0avE+Qdxbw0LX5dYNxYHQG5Xk0VN8RVRJwdaSp82kEtgaTIms+/CIOlLW3hjDsJrjf3NPxMd47oGce10AWr3MTMNAtjGXq0gfeURvhsiNgOrp5GybtmyuTjGkTvR+vEGgXkONinL0YV8JyXteEgdAoGAXa74xtFwz4F8yuwOikBLmYzp1YgtAAUIkX9KR7eljLGKI5XEzzmSrroHx+7IvnoUo9iBf1/7SvbUpXgnt/Xw1UXyPRJTQhHsO/jShGucsvYTLvu/gnhrjWr5l5YWRY7kY7rMw2CkpnBITJRliyGL5IQXT8xixotagUny1ZKqE30CgYAyQZi4Jyj5TlTcPBHfFAO7/cmN3+2c1mrJ9neoz3eh1p3Jiyu2zNulkqPWS7Ahe6n8isCN/l9UT1mdCuC8kmtcMB0E8+PUt/ikQXiqwXK1ZWv5J/MogVTVl8QmtqXMXO2a5h9QXHMw1+rU+jzyFiwSeFn4UqK3kdvasslxabGqUA==
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.composite_role (composite, child_role) FROM stdin;
3b093ac2-840f-4d01-869f-e438b3d913be	23afcbd2-1953-4d51-a446-859735fe0d47
3b093ac2-840f-4d01-869f-e438b3d913be	838d623c-62bb-4f84-b034-5e638c0bac55
3b093ac2-840f-4d01-869f-e438b3d913be	145f789f-15a3-4afb-9fb1-95f5a28d61f9
3b093ac2-840f-4d01-869f-e438b3d913be	e0561b41-20fc-4559-8c85-dd21adf0cb0b
3b093ac2-840f-4d01-869f-e438b3d913be	215be23e-6a8c-4d1f-8155-89fd8270f34e
3b093ac2-840f-4d01-869f-e438b3d913be	0e2b47a4-b364-4137-9d1f-9a29b181f1ac
3b093ac2-840f-4d01-869f-e438b3d913be	6d317551-76c4-43a9-86bd-3804251ac674
3b093ac2-840f-4d01-869f-e438b3d913be	15dc7982-d457-4af7-a190-b6ff5d9c27ee
3b093ac2-840f-4d01-869f-e438b3d913be	a6a66e1a-1a05-4cc1-bc27-d5e6e4e6c365
3b093ac2-840f-4d01-869f-e438b3d913be	1da74a49-00cd-4658-91d5-a3353b92af26
3b093ac2-840f-4d01-869f-e438b3d913be	8014a25c-825b-4baf-ba75-decdafb2edf7
3b093ac2-840f-4d01-869f-e438b3d913be	cfd4364c-63b6-4c94-90f3-67d2ef03b784
3b093ac2-840f-4d01-869f-e438b3d913be	b6633f7d-6107-4870-9bc0-c2e9d4de878c
3b093ac2-840f-4d01-869f-e438b3d913be	8e1365e9-e5a2-42eb-9bc1-1ab1953422c8
3b093ac2-840f-4d01-869f-e438b3d913be	8ae95230-4f42-4084-a0cd-d416c4857a7c
3b093ac2-840f-4d01-869f-e438b3d913be	f82f56b6-9098-4f8d-81cb-40a559480ef1
3b093ac2-840f-4d01-869f-e438b3d913be	3b988cd8-f4f5-45a4-8ed9-f966480b15dd
3b093ac2-840f-4d01-869f-e438b3d913be	e03a4b23-0001-4a0f-9576-df28f93c8fde
e0561b41-20fc-4559-8c85-dd21adf0cb0b	8ae95230-4f42-4084-a0cd-d416c4857a7c
e0561b41-20fc-4559-8c85-dd21adf0cb0b	e03a4b23-0001-4a0f-9576-df28f93c8fde
215be23e-6a8c-4d1f-8155-89fd8270f34e	f82f56b6-9098-4f8d-81cb-40a559480ef1
842ffd65-7c4d-42f1-baac-5c875284e2e1	b4ffb02b-97b2-4366-a446-99aacece202f
48ad7ede-7107-4660-9727-9e09b3245916	9e042df2-89eb-4891-9163-bbe59282c4f2
3b093ac2-840f-4d01-869f-e438b3d913be	8b04ceda-bdc3-486d-995b-8d431bcb6520
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
28ac3fb4-4329-4ec9-88e6-f365e7cd3d06	\N	password	930df47e-2483-48ac-877e-aea8708f074c	1620137768650	\N	{"value":"U03fa80i9XqcLTyqNi9Xe4PWivx5M40kUCwEQ2pKEsGxyp9nKhiS/1YZi4Ciih/SrzhXRCXgVerWUnOnCeRitg==","salt":"VtJetL8W/IfmXCYl9R1G0A=="}	{"hashIterations":100000,"algorithm":"pbkdf2-sha256"}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-05-04 14:14:09.972376	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	0137649456
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-05-04 14:14:10.038441	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	0137649456
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-05-04 14:14:10.073051	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	0137649456
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-05-04 14:14:10.0758	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	0137649456
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-05-04 14:14:10.213472	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	0137649456
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-05-04 14:14:10.216544	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	0137649456
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-05-04 14:14:10.295248	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	0137649456
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-05-04 14:14:10.298593	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	0137649456
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-05-04 14:14:10.337286	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	0137649456
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-05-04 14:14:10.443919	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	0137649456
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-05-04 14:14:10.550192	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	0137649456
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-05-04 14:14:10.552593	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	0137649456
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-05-04 14:14:10.735287	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	0137649456
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-04 14:14:10.773343	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	0137649456
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-04 14:14:10.774935	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	0137649456
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-04 14:14:10.835459	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	0137649456
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-05-04 14:14:10.836979	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	0137649456
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-05-04 14:14:10.964597	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	0137649456
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-05-04 14:14:11.05608	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	0137649456
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-05-04 14:14:11.05987	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	0137649456
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-04 14:14:11.836935	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	0137649456
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-05-04 14:14:11.06146	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	0137649456
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-05-04 14:14:11.063622	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	0137649456
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-05-04 14:14:11.143469	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	0137649456
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-05-04 14:14:11.146692	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	0137649456
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-05-04 14:14:11.148151	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	0137649456
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-05-04 14:14:11.175335	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	0137649456
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-05-04 14:14:11.267553	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	0137649456
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-05-04 14:14:11.270183	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	0137649456
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-05-04 14:14:11.377018	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	0137649456
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-05-04 14:14:11.446861	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	0137649456
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-05-04 14:14:11.459776	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	0137649456
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-05-04 14:14:11.462705	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	0137649456
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-04 14:14:11.466548	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	0137649456
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-04 14:14:11.468171	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	0137649456
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-04 14:14:11.551625	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	0137649456
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-05-04 14:14:11.570559	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	0137649456
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-05-04 14:14:11.575342	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	0137649456
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-05-04 14:14:11.577704	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	0137649456
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-05-04 14:14:11.587304	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	0137649456
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-05-04 14:14:11.588705	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	0137649456
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-05-04 14:14:11.636549	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	0137649456
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-05-04 14:14:11.640014	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	0137649456
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-05-04 14:14:11.761269	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	0137649456
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-05-04 14:14:11.777083	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	0137649456
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-04 14:14:11.84024	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	0137649456
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-04 14:14:11.841716	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	0137649456
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-04 14:14:11.947157	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	0137649456
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-05-04 14:14:12.035311	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	0137649456
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-05-04 14:14:12.070166	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	0137649456
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-05-04 14:14:12.146241	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	0137649456
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-05-04 14:14:12.149076	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	0137649456
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-05-04 14:14:12.151264	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	0137649456
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-05-04 14:14:12.153149	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	0137649456
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-04 14:14:12.158545	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	0137649456
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-04 14:14:12.161545	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	0137649456
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-04 14:14:12.247666	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	0137649456
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-05-04 14:14:12.436889	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	0137649456
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-05-04 14:14:12.535632	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	0137649456
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-05-04 14:14:12.540021	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	0137649456
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-05-04 14:14:12.546056	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	0137649456
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-05-04 14:14:12.551293	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	0137649456
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-05-04 14:14:12.553658	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	0137649456
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-05-04 14:14:12.555782	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	0137649456
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-05-04 14:14:12.635773	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	0137649456
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-05-04 14:14:12.740862	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	0137649456
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-05-04 14:14:12.745624	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	0137649456
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-05-04 14:14:12.846982	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	0137649456
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-05-04 14:14:12.947079	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	0137649456
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-05-04 14:14:12.950747	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	0137649456
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-05-04 14:14:13.040987	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	0137649456
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-04 14:14:13.045587	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	0137649456
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-04 14:14:13.049382	73	EXECUTED	7:03b3f4b264c3c68ba082250a80b74216	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	0137649456
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-04 14:14:13.050834	74	MARK_RAN	7:64c5728f5ca1f5aa4392217701c4fe23	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	0137649456
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-04 14:14:13.145233	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	0137649456
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-05-04 14:14:13.244633	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	0137649456
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-04 14:14:13.255178	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	0137649456
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-04 14:14:13.33555	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	0137649456
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-04 14:14:13.350066	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	0137649456
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-05-04 14:14:13.435717	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	0137649456
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-04 14:14:13.441195	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	0137649456
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-04 14:14:13.442579	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	0137649456
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-04 14:14:13.535456	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	0137649456
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-04 14:14:13.537243	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	0137649456
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-05-04 14:14:13.541744	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	0137649456
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	1703cd3e-3d0e-4881-b723-4dd1c4fedd21	f
master	3d35613f-342b-4fa9-9967-5c37597883a4	t
master	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee	t
master	a801e1f9-ced3-4644-8fd2-acb93cf24904	t
master	bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373	f
master	f550e41e-2f17-4998-a828-83578ebe871e	f
master	7e43eb45-d446-4d98-a175-c1fe4acfbbdb	t
master	d30e6093-1bd4-4e7c-abec-50720909a75f	t
master	aa24096f-9de2-4369-bb12-824bc6259158	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
3b093ac2-840f-4d01-869f-e438b3d913be	master	f	${role_admin}	admin	master	\N	master
23afcbd2-1953-4d51-a446-859735fe0d47	master	f	${role_create-realm}	create-realm	master	\N	master
838d623c-62bb-4f84-b034-5e638c0bac55	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_create-client}	create-client	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
145f789f-15a3-4afb-9fb1-95f5a28d61f9	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_view-realm}	view-realm	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
e0561b41-20fc-4559-8c85-dd21adf0cb0b	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_view-users}	view-users	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
215be23e-6a8c-4d1f-8155-89fd8270f34e	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_view-clients}	view-clients	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
0e2b47a4-b364-4137-9d1f-9a29b181f1ac	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_view-events}	view-events	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
6d317551-76c4-43a9-86bd-3804251ac674	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_view-identity-providers}	view-identity-providers	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
15dc7982-d457-4af7-a190-b6ff5d9c27ee	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_view-authorization}	view-authorization	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
a6a66e1a-1a05-4cc1-bc27-d5e6e4e6c365	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_manage-realm}	manage-realm	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
1da74a49-00cd-4658-91d5-a3353b92af26	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_manage-users}	manage-users	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
8014a25c-825b-4baf-ba75-decdafb2edf7	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_manage-clients}	manage-clients	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
cfd4364c-63b6-4c94-90f3-67d2ef03b784	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_manage-events}	manage-events	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
b6633f7d-6107-4870-9bc0-c2e9d4de878c	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_manage-identity-providers}	manage-identity-providers	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
8e1365e9-e5a2-42eb-9bc1-1ab1953422c8	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_manage-authorization}	manage-authorization	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
8ae95230-4f42-4084-a0cd-d416c4857a7c	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_query-users}	query-users	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
f82f56b6-9098-4f8d-81cb-40a559480ef1	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_query-clients}	query-clients	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
3b988cd8-f4f5-45a4-8ed9-f966480b15dd	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_query-realms}	query-realms	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
e03a4b23-0001-4a0f-9576-df28f93c8fde	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_query-groups}	query-groups	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
fd7d7f75-312e-4f92-8683-8b1d9bd70ca4	f583e151-9c5b-4b04-a063-fac67125a01c	t	${role_view-profile}	view-profile	master	f583e151-9c5b-4b04-a063-fac67125a01c	\N
842ffd65-7c4d-42f1-baac-5c875284e2e1	f583e151-9c5b-4b04-a063-fac67125a01c	t	${role_manage-account}	manage-account	master	f583e151-9c5b-4b04-a063-fac67125a01c	\N
b4ffb02b-97b2-4366-a446-99aacece202f	f583e151-9c5b-4b04-a063-fac67125a01c	t	${role_manage-account-links}	manage-account-links	master	f583e151-9c5b-4b04-a063-fac67125a01c	\N
699a9530-f67d-4a17-8877-2a059d08875e	f583e151-9c5b-4b04-a063-fac67125a01c	t	${role_view-applications}	view-applications	master	f583e151-9c5b-4b04-a063-fac67125a01c	\N
9e042df2-89eb-4891-9163-bbe59282c4f2	f583e151-9c5b-4b04-a063-fac67125a01c	t	${role_view-consent}	view-consent	master	f583e151-9c5b-4b04-a063-fac67125a01c	\N
48ad7ede-7107-4660-9727-9e09b3245916	f583e151-9c5b-4b04-a063-fac67125a01c	t	${role_manage-consent}	manage-consent	master	f583e151-9c5b-4b04-a063-fac67125a01c	\N
8002bc67-90f3-44d9-a91d-88f9da3fc7fa	ef262a64-56ae-4103-bb4a-e007bb682b82	t	${role_read-token}	read-token	master	ef262a64-56ae-4103-bb4a-e007bb682b82	\N
8b04ceda-bdc3-486d-995b-8d431bcb6520	4a769675-b438-4f6c-bba3-01099c2bba35	t	${role_impersonation}	impersonation	master	4a769675-b438-4f6c-bba3-01099c2bba35	\N
e1aba0d2-34de-4845-9641-5c04fe6fed43	master	f	${role_offline-access}	offline_access	master	\N	master
af499575-a4e8-4735-8dc5-9b87987170e0	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.migration_model (id, version, update_time) FROM stdin;
h5ptp	9.0.12	1620137760
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
f05ac6c5-4cc9-48dc-b198-e0b6cc2ccf88	audience resolve	openid-connect	oidc-audience-resolve-mapper	7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	\N
be7b825c-6e68-430e-a19a-0b3854ee4768	locale	openid-connect	oidc-usermodel-attribute-mapper	7e54002c-d307-41bd-9601-fddb5ddcfefb	\N
875f122d-826c-4497-8c71-1f9c1b094e73	role list	saml	saml-role-list-mapper	\N	3d35613f-342b-4fa9-9967-5c37597883a4
d6b1989d-7119-4cbd-ae4f-876dd1b3f5f3	full name	openid-connect	oidc-full-name-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
65ba1a76-88e5-4ecd-84bd-b83b20701730	family name	openid-connect	oidc-usermodel-property-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
e9abf886-4b91-4fa0-89e1-d63ea8f758ce	given name	openid-connect	oidc-usermodel-property-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
37ace034-f044-4bd1-87d2-64141008add4	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
9f3bd1cd-9544-47f2-8903-a3bc7bc89276	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
15632075-a138-46d6-adfd-bdb447462376	username	openid-connect	oidc-usermodel-property-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
a31152d2-e92f-4885-8619-850b4c1ff2f0	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
f69f4bad-e5e6-4fd4-98fd-00c7e77f06d2	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
64db8841-31a0-440c-b21a-d897e56cd616	website	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
468be16b-ec7d-4f6a-ab64-0110cb2c63dc	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
904d98e2-9100-478d-8327-7cee3e5e415f	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
8e58fed5-9fdb-4499-b0f0-7fdd5186b1d4	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
d054a698-0b51-4928-aa77-a42bf42b6002	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
b499daae-980d-4786-bc86-4eb9ca170bdf	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	d0fcbdcd-9790-4bb7-8e43-7576d416f9ee
4a9fb80e-21fa-498a-97d9-00e467d9dd7c	email	openid-connect	oidc-usermodel-property-mapper	\N	a801e1f9-ced3-4644-8fd2-acb93cf24904
eef23e02-b106-45f5-9c91-2d45b279d20d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	a801e1f9-ced3-4644-8fd2-acb93cf24904
d96eead4-134c-43ea-ab1f-3a2fc6944e69	address	openid-connect	oidc-address-mapper	\N	bf9e65f9-6dcb-454e-b0ba-8dbe1d8e7373
38e36e91-4e66-4686-8ff9-032cd284438b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f550e41e-2f17-4998-a828-83578ebe871e
b8779c30-3fc0-44c1-b71a-9aab723026bf	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f550e41e-2f17-4998-a828-83578ebe871e
f7525039-c62b-47b2-8ee2-9bcacf8cde31	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	7e43eb45-d446-4d98-a175-c1fe4acfbbdb
cd6c40ba-bdac-4fbc-91ff-dc71e7fd3c97	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	7e43eb45-d446-4d98-a175-c1fe4acfbbdb
0e9a7b0b-36d2-4858-9aa2-b1efa57f99b9	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	7e43eb45-d446-4d98-a175-c1fe4acfbbdb
8bf23508-9f7c-46f7-bf84-1e366516b0fb	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	d30e6093-1bd4-4e7c-abec-50720909a75f
a3151d1f-5e6f-4aab-8209-caa275125a2c	upn	openid-connect	oidc-usermodel-property-mapper	\N	aa24096f-9de2-4369-bb12-824bc6259158
e41bd677-b04f-41a7-81d5-1d4f9d5e4695	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	aa24096f-9de2-4369-bb12-824bc6259158
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
be7b825c-6e68-430e-a19a-0b3854ee4768	true	userinfo.token.claim
be7b825c-6e68-430e-a19a-0b3854ee4768	locale	user.attribute
be7b825c-6e68-430e-a19a-0b3854ee4768	true	id.token.claim
be7b825c-6e68-430e-a19a-0b3854ee4768	true	access.token.claim
be7b825c-6e68-430e-a19a-0b3854ee4768	locale	claim.name
be7b825c-6e68-430e-a19a-0b3854ee4768	String	jsonType.label
875f122d-826c-4497-8c71-1f9c1b094e73	false	single
875f122d-826c-4497-8c71-1f9c1b094e73	Basic	attribute.nameformat
875f122d-826c-4497-8c71-1f9c1b094e73	Role	attribute.name
d6b1989d-7119-4cbd-ae4f-876dd1b3f5f3	true	userinfo.token.claim
d6b1989d-7119-4cbd-ae4f-876dd1b3f5f3	true	id.token.claim
d6b1989d-7119-4cbd-ae4f-876dd1b3f5f3	true	access.token.claim
65ba1a76-88e5-4ecd-84bd-b83b20701730	true	userinfo.token.claim
65ba1a76-88e5-4ecd-84bd-b83b20701730	lastName	user.attribute
65ba1a76-88e5-4ecd-84bd-b83b20701730	true	id.token.claim
65ba1a76-88e5-4ecd-84bd-b83b20701730	true	access.token.claim
65ba1a76-88e5-4ecd-84bd-b83b20701730	family_name	claim.name
65ba1a76-88e5-4ecd-84bd-b83b20701730	String	jsonType.label
e9abf886-4b91-4fa0-89e1-d63ea8f758ce	true	userinfo.token.claim
e9abf886-4b91-4fa0-89e1-d63ea8f758ce	firstName	user.attribute
e9abf886-4b91-4fa0-89e1-d63ea8f758ce	true	id.token.claim
e9abf886-4b91-4fa0-89e1-d63ea8f758ce	true	access.token.claim
e9abf886-4b91-4fa0-89e1-d63ea8f758ce	given_name	claim.name
e9abf886-4b91-4fa0-89e1-d63ea8f758ce	String	jsonType.label
37ace034-f044-4bd1-87d2-64141008add4	true	userinfo.token.claim
37ace034-f044-4bd1-87d2-64141008add4	middleName	user.attribute
37ace034-f044-4bd1-87d2-64141008add4	true	id.token.claim
37ace034-f044-4bd1-87d2-64141008add4	true	access.token.claim
37ace034-f044-4bd1-87d2-64141008add4	middle_name	claim.name
37ace034-f044-4bd1-87d2-64141008add4	String	jsonType.label
9f3bd1cd-9544-47f2-8903-a3bc7bc89276	true	userinfo.token.claim
9f3bd1cd-9544-47f2-8903-a3bc7bc89276	nickname	user.attribute
9f3bd1cd-9544-47f2-8903-a3bc7bc89276	true	id.token.claim
9f3bd1cd-9544-47f2-8903-a3bc7bc89276	true	access.token.claim
9f3bd1cd-9544-47f2-8903-a3bc7bc89276	nickname	claim.name
9f3bd1cd-9544-47f2-8903-a3bc7bc89276	String	jsonType.label
15632075-a138-46d6-adfd-bdb447462376	true	userinfo.token.claim
15632075-a138-46d6-adfd-bdb447462376	username	user.attribute
15632075-a138-46d6-adfd-bdb447462376	true	id.token.claim
15632075-a138-46d6-adfd-bdb447462376	true	access.token.claim
15632075-a138-46d6-adfd-bdb447462376	preferred_username	claim.name
15632075-a138-46d6-adfd-bdb447462376	String	jsonType.label
a31152d2-e92f-4885-8619-850b4c1ff2f0	true	userinfo.token.claim
a31152d2-e92f-4885-8619-850b4c1ff2f0	profile	user.attribute
a31152d2-e92f-4885-8619-850b4c1ff2f0	true	id.token.claim
a31152d2-e92f-4885-8619-850b4c1ff2f0	true	access.token.claim
a31152d2-e92f-4885-8619-850b4c1ff2f0	profile	claim.name
a31152d2-e92f-4885-8619-850b4c1ff2f0	String	jsonType.label
f69f4bad-e5e6-4fd4-98fd-00c7e77f06d2	true	userinfo.token.claim
f69f4bad-e5e6-4fd4-98fd-00c7e77f06d2	picture	user.attribute
f69f4bad-e5e6-4fd4-98fd-00c7e77f06d2	true	id.token.claim
f69f4bad-e5e6-4fd4-98fd-00c7e77f06d2	true	access.token.claim
f69f4bad-e5e6-4fd4-98fd-00c7e77f06d2	picture	claim.name
f69f4bad-e5e6-4fd4-98fd-00c7e77f06d2	String	jsonType.label
64db8841-31a0-440c-b21a-d897e56cd616	true	userinfo.token.claim
64db8841-31a0-440c-b21a-d897e56cd616	website	user.attribute
64db8841-31a0-440c-b21a-d897e56cd616	true	id.token.claim
64db8841-31a0-440c-b21a-d897e56cd616	true	access.token.claim
64db8841-31a0-440c-b21a-d897e56cd616	website	claim.name
64db8841-31a0-440c-b21a-d897e56cd616	String	jsonType.label
468be16b-ec7d-4f6a-ab64-0110cb2c63dc	true	userinfo.token.claim
468be16b-ec7d-4f6a-ab64-0110cb2c63dc	gender	user.attribute
468be16b-ec7d-4f6a-ab64-0110cb2c63dc	true	id.token.claim
468be16b-ec7d-4f6a-ab64-0110cb2c63dc	true	access.token.claim
468be16b-ec7d-4f6a-ab64-0110cb2c63dc	gender	claim.name
468be16b-ec7d-4f6a-ab64-0110cb2c63dc	String	jsonType.label
904d98e2-9100-478d-8327-7cee3e5e415f	true	userinfo.token.claim
904d98e2-9100-478d-8327-7cee3e5e415f	birthdate	user.attribute
904d98e2-9100-478d-8327-7cee3e5e415f	true	id.token.claim
904d98e2-9100-478d-8327-7cee3e5e415f	true	access.token.claim
904d98e2-9100-478d-8327-7cee3e5e415f	birthdate	claim.name
904d98e2-9100-478d-8327-7cee3e5e415f	String	jsonType.label
8e58fed5-9fdb-4499-b0f0-7fdd5186b1d4	true	userinfo.token.claim
8e58fed5-9fdb-4499-b0f0-7fdd5186b1d4	zoneinfo	user.attribute
8e58fed5-9fdb-4499-b0f0-7fdd5186b1d4	true	id.token.claim
8e58fed5-9fdb-4499-b0f0-7fdd5186b1d4	true	access.token.claim
8e58fed5-9fdb-4499-b0f0-7fdd5186b1d4	zoneinfo	claim.name
8e58fed5-9fdb-4499-b0f0-7fdd5186b1d4	String	jsonType.label
d054a698-0b51-4928-aa77-a42bf42b6002	true	userinfo.token.claim
d054a698-0b51-4928-aa77-a42bf42b6002	locale	user.attribute
d054a698-0b51-4928-aa77-a42bf42b6002	true	id.token.claim
d054a698-0b51-4928-aa77-a42bf42b6002	true	access.token.claim
d054a698-0b51-4928-aa77-a42bf42b6002	locale	claim.name
d054a698-0b51-4928-aa77-a42bf42b6002	String	jsonType.label
b499daae-980d-4786-bc86-4eb9ca170bdf	true	userinfo.token.claim
b499daae-980d-4786-bc86-4eb9ca170bdf	updatedAt	user.attribute
b499daae-980d-4786-bc86-4eb9ca170bdf	true	id.token.claim
b499daae-980d-4786-bc86-4eb9ca170bdf	true	access.token.claim
b499daae-980d-4786-bc86-4eb9ca170bdf	updated_at	claim.name
b499daae-980d-4786-bc86-4eb9ca170bdf	String	jsonType.label
4a9fb80e-21fa-498a-97d9-00e467d9dd7c	true	userinfo.token.claim
4a9fb80e-21fa-498a-97d9-00e467d9dd7c	email	user.attribute
4a9fb80e-21fa-498a-97d9-00e467d9dd7c	true	id.token.claim
4a9fb80e-21fa-498a-97d9-00e467d9dd7c	true	access.token.claim
4a9fb80e-21fa-498a-97d9-00e467d9dd7c	email	claim.name
4a9fb80e-21fa-498a-97d9-00e467d9dd7c	String	jsonType.label
eef23e02-b106-45f5-9c91-2d45b279d20d	true	userinfo.token.claim
eef23e02-b106-45f5-9c91-2d45b279d20d	emailVerified	user.attribute
eef23e02-b106-45f5-9c91-2d45b279d20d	true	id.token.claim
eef23e02-b106-45f5-9c91-2d45b279d20d	true	access.token.claim
eef23e02-b106-45f5-9c91-2d45b279d20d	email_verified	claim.name
eef23e02-b106-45f5-9c91-2d45b279d20d	boolean	jsonType.label
d96eead4-134c-43ea-ab1f-3a2fc6944e69	formatted	user.attribute.formatted
d96eead4-134c-43ea-ab1f-3a2fc6944e69	country	user.attribute.country
d96eead4-134c-43ea-ab1f-3a2fc6944e69	postal_code	user.attribute.postal_code
d96eead4-134c-43ea-ab1f-3a2fc6944e69	true	userinfo.token.claim
d96eead4-134c-43ea-ab1f-3a2fc6944e69	street	user.attribute.street
d96eead4-134c-43ea-ab1f-3a2fc6944e69	true	id.token.claim
d96eead4-134c-43ea-ab1f-3a2fc6944e69	region	user.attribute.region
d96eead4-134c-43ea-ab1f-3a2fc6944e69	true	access.token.claim
d96eead4-134c-43ea-ab1f-3a2fc6944e69	locality	user.attribute.locality
38e36e91-4e66-4686-8ff9-032cd284438b	true	userinfo.token.claim
38e36e91-4e66-4686-8ff9-032cd284438b	phoneNumber	user.attribute
38e36e91-4e66-4686-8ff9-032cd284438b	true	id.token.claim
38e36e91-4e66-4686-8ff9-032cd284438b	true	access.token.claim
38e36e91-4e66-4686-8ff9-032cd284438b	phone_number	claim.name
38e36e91-4e66-4686-8ff9-032cd284438b	String	jsonType.label
b8779c30-3fc0-44c1-b71a-9aab723026bf	true	userinfo.token.claim
b8779c30-3fc0-44c1-b71a-9aab723026bf	phoneNumberVerified	user.attribute
b8779c30-3fc0-44c1-b71a-9aab723026bf	true	id.token.claim
b8779c30-3fc0-44c1-b71a-9aab723026bf	true	access.token.claim
b8779c30-3fc0-44c1-b71a-9aab723026bf	phone_number_verified	claim.name
b8779c30-3fc0-44c1-b71a-9aab723026bf	boolean	jsonType.label
f7525039-c62b-47b2-8ee2-9bcacf8cde31	true	multivalued
f7525039-c62b-47b2-8ee2-9bcacf8cde31	foo	user.attribute
f7525039-c62b-47b2-8ee2-9bcacf8cde31	true	access.token.claim
f7525039-c62b-47b2-8ee2-9bcacf8cde31	realm_access.roles	claim.name
f7525039-c62b-47b2-8ee2-9bcacf8cde31	String	jsonType.label
cd6c40ba-bdac-4fbc-91ff-dc71e7fd3c97	true	multivalued
cd6c40ba-bdac-4fbc-91ff-dc71e7fd3c97	foo	user.attribute
cd6c40ba-bdac-4fbc-91ff-dc71e7fd3c97	true	access.token.claim
cd6c40ba-bdac-4fbc-91ff-dc71e7fd3c97	resource_access.${client_id}.roles	claim.name
cd6c40ba-bdac-4fbc-91ff-dc71e7fd3c97	String	jsonType.label
a3151d1f-5e6f-4aab-8209-caa275125a2c	true	userinfo.token.claim
a3151d1f-5e6f-4aab-8209-caa275125a2c	username	user.attribute
a3151d1f-5e6f-4aab-8209-caa275125a2c	true	id.token.claim
a3151d1f-5e6f-4aab-8209-caa275125a2c	true	access.token.claim
a3151d1f-5e6f-4aab-8209-caa275125a2c	upn	claim.name
a3151d1f-5e6f-4aab-8209-caa275125a2c	String	jsonType.label
e41bd677-b04f-41a7-81d5-1d4f9d5e4695	true	multivalued
e41bd677-b04f-41a7-81d5-1d4f9d5e4695	foo	user.attribute
e41bd677-b04f-41a7-81d5-1d4f9d5e4695	true	id.token.claim
e41bd677-b04f-41a7-81d5-1d4f9d5e4695	true	access.token.claim
e41bd677-b04f-41a7-81d5-1d4f9d5e4695	groups	claim.name
e41bd677-b04f-41a7-81d5-1d4f9d5e4695	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	4a769675-b438-4f6c-bba3-01099c2bba35	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	41340f93-d183-4355-8b25-835c34e03f04	76b0af4a-2697-4cfd-9c5b-c34bd04de77d	f3bcfdda-7b41-4be1-9e7a-ec5f1cf210fd	202309df-43aa-4a01-8ab3-d2e273153c21	d28597e5-9749-4a17-b237-dd3d6ec23ca3	2592000	f	900	t	f	e0525862-c5cb-4f7b-ac4b-3fb6c4ff4a1c	0	f	0	0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	rh-sso	master
displayNameHtml	<strong>Red Hat</strong><sup>®</sup> Single Sign On	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_default_roles (realm_id, role_id) FROM stdin;
master	e1aba0d2-34de-4845-9641-5c04fe6fed43
master	af499575-a4e8-4735-8dc5-9b87987170e0
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.redirect_uris (client_id, value) FROM stdin;
f583e151-9c5b-4b04-a063-fac67125a01c	/realms/master/account/*
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	/realms/master/account/*
7e54002c-d307-41bd-9601-fddb5ddcfefb	/admin/master/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
d64aa474-04f6-4255-840f-08e99da216d0	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
a6e5ba47-16a5-4437-b4b9-f46bb3993122	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
3e9c6161-c6f0-4494-8391-d2174ec77f9c	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
c7ff206c-97bd-445d-8e31-6df647d1a14a	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
1f9f9334-b871-4c46-82a0-4af02fd47707	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
30887748-261c-40fa-814c-a8dc16b7e862	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
7d9948ee-13af-4c7f-a2a7-6a67d9b6b665	842ffd65-7c4d-42f1-baac-5c875284e2e1
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
930df47e-2483-48ac-877e-aea8708f074c	\N	3769f5ed-48f6-422b-9463-76e90cf16ee4	f	t	\N	\N	\N	master	bcf8ipdw	1620137768152	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
842ffd65-7c4d-42f1-baac-5c875284e2e1	930df47e-2483-48ac-877e-aea8708f074c
af499575-a4e8-4735-8dc5-9b87987170e0	930df47e-2483-48ac-877e-aea8708f074c
e1aba0d2-34de-4845-9641-5c04fe6fed43	930df47e-2483-48ac-877e-aea8708f074c
fd7d7f75-312e-4f92-8683-8b1d9bd70ca4	930df47e-2483-48ac-877e-aea8708f074c
3b093ac2-840f-4d01-869f-e438b3d913be	930df47e-2483-48ac-877e-aea8708f074c
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.web_origins (client_id, value) FROM stdin;
7e54002c-d307-41bd-9601-fddb5ddcfefb	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES public.client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES public.client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

