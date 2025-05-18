// A generated module for Homeserver functions
//
// This module has been generated via dagger init and serves as a reference to
// basic module structure as you get started with Dagger.
//
// Two functions have been pre-created. You can modify, delete, or add to them,
// as needed. They demonstrate usage of arguments and return types using simple
// echo and grep commands. The functions can be called from the dagger CLI or
// from one of the SDKs.
//
// The first line in this comment block is a short description line and the
// rest is a long description with more detail on the module's purpose or usage,
// if appropriate. All modules should have a short description.

package main

import (
	"context"
	"dagger/homeserver/internal/dagger"
)

type Homeserver struct {
	container *dagger.Container
}

func (m *Homeserver) WithPackages(weakDeps bool, packages ...string) *Homeserver {
	// Install packages
	command := []string{"dnf", "-y", "install"}

	// Add the weak deps option if weak deps should be disabled
	if !weakDeps {
		command = append(command, "--setopt=install_weak_deps=0")
	}

	m.container = m.container.WithExec(append(command, packages...))

	return m
}

func (m *Homeserver) WithCoprEnabled(copr string) *Homeserver {
	m.container = m.container.WithExec([]string{"dnf", "-y", "copr", "enable", copr})

	return m
}

func (m *Homeserver) WithCoprDisabled(copr string) *Homeserver {
	m.container = m.container.WithExec([]string{"dnf", "-y", "copr", "disable", copr})

	return m
}

func (m *Homeserver) BaseContainer(version string, digest string) *Homeserver {
	systemFiles := dag.CurrentModule().Source().Directory("system_files")

	// Add the system files to the contain
	m.container = dag.Container().
		From("quay.io/fedora/fedora-bootc:"+version+"@sha256:"+digest).
		WithDirectory("/", systemFiles)

	return m
}

func (m *Homeserver) WithRepoDisabled(repo string) *Homeserver {
	m.container = m.container.WithExec([]string{"dnf", "config-manager", "setopt", repo + ".enabled=0"})

	return m
}

func (m *Homeserver) WithBasePackages() *Homeserver {
	return m.WithPackages(false,
		"dnf5-command(config-manager)",
		"dnf5-command(copr)",
		"audit",
		"clevis-dracut",
		"clevis-pin-tpm2",
		"firewalld",
		"gcc",
		"pciutils",
		"usbutils",
		"wireguard-tools")
}

func (m *Homeserver) WithCockpit() *Homeserver {
	return m.WithPackages(false,
		"cockpit",
		"cockpit-files",
		"cockpit-selinux")
}

func (m *Homeserver) WithIncus() *Homeserver {

	return m.WithCoprEnabled("ganto/umoci").
		WithPackages(true,
			"genisoimage",
			"incus",
			"incus-agent",
			"incus-client",
			"umoci",
			"swtpm").
		WithCoprDisabled("ganto/umoci")

	/* TODO: Fix group IDs */
}

// Build container
func (m *Homeserver) Build() *dagger.Container {
	return m.BaseContainer("42", "d3ee684f0e05edb711afbab4db82687fa6b8dcb7a86746ff99a48d053f7e3643").
		WithBasePackages().
		WithRepoDisabled("fedora-cisco-openh264").
		WithCockpit().
		WithIncus().
		// TODO: Add tailscale
		// TODO: Add Universal Blue stuff
		// TODO: Enable services
		// TODO: Kernel stuff
		// TODO: Cleanup
		// TODO: bootc lint
		container
}

// Build and publish container
func (m *Homeserver) BuildAndPublish(ctx context.Context, directoryArg *dagger.Directory, pattern string) (string, error) {
	return dag.Container().
		From("alpine:latest").
		WithMountedDirectory("/mnt", directoryArg).
		WithWorkdir("/mnt").
		WithExec([]string{"grep", "-R", pattern, "."}).
		Stdout(ctx)
}
