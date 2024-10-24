include $(TOPDIR)/rules.mk

PKG_NAME:=kmod-drm-ms912x
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_CHECK_FORMAT_SECURITY:=0

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/drm-ms912x
	SUBMENU:=Video Support
	TITLE:=Macro Silicon MS9122/MS9132 DRM support
	DEPENDS:=@DISPLAY_SUPPORT +kmod-drm +kmod-drm-kms-helper +kmod-usb-core
	FILES:=$(PKG_BUILD_DIR)/ms912x.ko
	AUTOLOAD:=$(call AutoLoad,35,ms912x)
endef

define KernelPackage/drm-ms912x/description
Kernel modules for Macro Silicon MS9122/MS9132 USB video adapters.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

MAKE_OPTS:= \
	ARCH="$(LINUX_KARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	M="$(PKG_BUILD_DIR)"

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		$(MAKE_OPTS) \
		modules
endef

$(eval $(call KernelPackage,drm-ms912x))

