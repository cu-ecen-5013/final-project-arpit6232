#include <linux/build-salt.h>
#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(.gnu.linkonce.this_module) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

static const struct modversion_info ____versions[]
__used __section(__versions) = {
	{ 0xc79d2779, "module_layout" },
	{ 0x1ff06dbb, "unregister_netdev" },
	{ 0x3c12dfe, "cancel_work_sync" },
	{ 0x37a0cba, "kfree" },
	{ 0x8585a3ba, "wiphy_free" },
	{ 0xa4d3c898, "wiphy_unregister" },
	{ 0x66ce1691, "free_netdev" },
	{ 0x1b16447e, "register_netdev" },
	{ 0xb4b5022a, "alloc_netdev_mqs" },
	{ 0x75ed7c93, "ether_setup" },
	{ 0x81faee8e, "wiphy_register" },
	{ 0x7dffd8c1, "wiphy_new_nm" },
	{ 0x26c2e0b5, "kmem_cache_alloc_trace" },
	{ 0x8537dfba, "kmalloc_caches" },
	{ 0xc5850110, "printk" },
	{ 0xd06b6499, "cfg80211_connect_done" },
	{ 0xc5b6f236, "queue_work_on" },
	{ 0x2d3385d3, "system_wq" },
	{ 0x848af2d3, "cfg80211_scan_done" },
	{ 0xf9a482f9, "msleep" },
	{ 0xdecd0b29, "__stack_chk_fail" },
	{ 0xd0ce971f, "cfg80211_put_bss" },
	{ 0xfb4741c5, "cfg80211_inform_bss_data" },
	{ 0xce58ba8, "kfree_skb" },
	{ 0xcf2a6966, "up" },
	{ 0xbcaef45f, "cfg80211_disconnected" },
	{ 0x81b395b3, "down_interruptible" },
	{ 0xbdfb6dbb, "__fentry__" },
};

MODULE_INFO(depends, "cfg80211");


MODULE_INFO(srcversion, "CFAC3495C6704A051172C45");
