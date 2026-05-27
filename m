Return-Path: <linux-hyperv+bounces-11218-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GwZOznuFmruvgcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11218-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:14:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 622245E4BAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8B0C3051A76
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 13:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEDF409100;
	Wed, 27 May 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K2Fa+hLz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2E440803B;
	Wed, 27 May 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887087; cv=none; b=t6qOXY3pwB/10tmA+/aIdDy1e3e78DNwN5ifs1xeVuqiR+ydurKvnapuq2U6sdlfROTl0G0QTMvIMOW+ujU2e3jKNwMf96vXmxOIaL0lgyU7NtGvT51EuCml2bBxl3lx/hr8/enCN/xHe0756aFm9RNDRy2N5FEg8NBBIqnJvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887087; c=relaxed/simple;
	bh=j+c97PZZCGAp2+t5jJNZJy9fRscBG/1wlw4i4xpXxA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pnl1FjYKwzLQD7ua2HcfO7bdv8+k59i2TMAwlxnEQGtIMhReJ58wfualMgFzuCchPOc2nJrjgNnotVyXluIfT6jnWWiKx+BiLMcBbh1TVP1o5+p4g2sKkBPjV5lqt+7y1rg5zYt6b5wt+ru+kSLGNXyrKv7PHemyQtK0AZ4ubUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K2Fa+hLz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 1974020B7169; Wed, 27 May 2026 06:04:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1974020B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779887069;
	bh=8qaddr1QwCmLcHe+5KMvGQ4/pciu1ZT8ioZClU9ZOOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2Fa+hLzbIuuU0VQXM0PCLVz5U/rv+ZnQv6yrYa2I/hc4cFKOpmVRP2+EAOHD8bhL
	 0ETLTrhqWgQu7z+95sIOvA/XIdgkLIqMe4FtPRM7T66OEvPVHQzexqsk9Cb5G+MCLi
	 3Aipu7J9rUQuCSEYfbSB8hIePIi61y4JzwJBIN5k=
Date: Wed, 27 May 2026 09:04:29 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	decui@microsoft.com, longli@microsoft.com,
	ssengar@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/hyperv: Replace "hyperv_" with "hvdrm_" as
 symbol name prefix
Message-ID: <ahbr3aepFUuJ45Zg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260526205239.1509-1-mhklkml@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526205239.1509-1-mhklkml@zohomail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11218-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,lists.freedesktop.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hyperv_driver.name:url,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,outlook.com:email,linux.microsoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ptr_shape.data:url]
X-Rspamd-Queue-Id: 622245E4BAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:52:39PM -0700, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Function and structure names in the Hyper-V DRM driver currently
> use "hyperv_" as the prefix. This conflicts with usage in core Hyper-V
> and VMBus code, and incorrectly implies that functions and structures
> in this driver apply generically to Hyper-V. A specific conflict arises
> for "hyperv_init", which is an initcall for generic Hyper-V
> initialization on arm64. The conflict prevents the use of
> initcall_blacklist on the kernel boot line to skip loading this driver.
> 
> Fix this by substituting "hvdrm_" as the prefix for all functions and

I would personally prefer "hv_drm_", since it seems clearer.

> structures in this driver. This prefix marries the existing "hv" prefix
> for Hyper-V related code with "drm" to indicate this driver.
> 
> The changes are all mechanical text substitution in symbol names.
> There are no other code or functional changes.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> This patch is built against linux-next20260526.
> 
>  drivers/gpu/drm/hyperv/hyperv_drm.h         |  20 ++--
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  88 ++++++++--------
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 110 ++++++++++----------
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c   |  70 ++++++-------
>  4 files changed, 144 insertions(+), 144 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
> index 9e776112c03e..66bd8730aad2 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm.h
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
> @@ -8,7 +8,7 @@
>  
>  #define VMBUS_MAX_PACKET_SIZE 0x4000
>  
> -struct hyperv_drm_device {
> +struct hvdrm_drm_device {

"hvdrm_drm_device" looks kinda redundant, perhaps
s/hyperv_drm_device/hv_drm_device would be more sensible.

Hamza

>  	/* drm */
>  	struct drm_device dev;
>  	struct drm_plane plane;
> @@ -39,17 +39,17 @@ struct hyperv_drm_device {
>  	struct hv_device *hdev;
>  };
>  
> -#define to_hv(_dev) container_of(_dev, struct hyperv_drm_device, dev)
> +#define to_hv(_dev) container_of(_dev, struct hvdrm_drm_device, dev)
>  
> -/* hyperv_drm_modeset */
> -int hyperv_mode_config_init(struct hyperv_drm_device *hv);
> +/* hvdrm_drm_modeset */
> +int hvdrm_mode_config_init(struct hvdrm_drm_device *hv);
>  
> -/* hyperv_drm_proto */
> -int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp);
> -int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
> +/* hvdrm_drm_proto */
> +int hvdrm_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp);
> +int hvdrm_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
>  			    u32 w, u32 h, u32 pitch);
> -int hyperv_hide_hw_ptr(struct hv_device *hdev);
> -int hyperv_update_dirt(struct hv_device *hdev, struct drm_rect *rect);
> -int hyperv_connect_vsp(struct hv_device *hdev);
> +int hvdrm_hide_hw_ptr(struct hv_device *hdev);
> +int hvdrm_update_dirt(struct hv_device *hdev, struct drm_rect *rect);
> +int hvdrm_connect_vsp(struct hv_device *hdev);
>  
>  #endif
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index b6bf6412ae34..a4456ccf340e 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -26,7 +26,7 @@
>  
>  DEFINE_DRM_GEM_FOPS(hv_fops);
>  
> -static struct drm_driver hyperv_driver = {
> +static struct drm_driver hvdrm_driver = {
>  	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
>  
>  	.name		 = DRIVER_NAME,
> @@ -39,17 +39,17 @@ static struct drm_driver hyperv_driver = {
>  	DRM_FBDEV_SHMEM_DRIVER_OPS,
>  };
>  
> -static int hyperv_pci_probe(struct pci_dev *pdev,
> +static int hvdrm_pci_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *ent)
>  {
>  	return 0;
>  }
>  
> -static void hyperv_pci_remove(struct pci_dev *pdev)
> +static void hvdrm_pci_remove(struct pci_dev *pdev)
>  {
>  }
>  
> -static const struct pci_device_id hyperv_pci_tbl[] = {
> +static const struct pci_device_id hvdrm_pci_tbl[] = {
>  	{
>  		.vendor = PCI_VENDOR_ID_MICROSOFT,
>  		.device = PCI_DEVICE_ID_HYPERV_VIDEO,
> @@ -60,14 +60,14 @@ static const struct pci_device_id hyperv_pci_tbl[] = {
>  /*
>   * PCI stub to support gen1 VM.
>   */
> -static struct pci_driver hyperv_pci_driver = {
> +static struct pci_driver hvdrm_pci_driver = {
>  	.name =		KBUILD_MODNAME,
> -	.id_table =	hyperv_pci_tbl,
> -	.probe =	hyperv_pci_probe,
> -	.remove =	hyperv_pci_remove,
> +	.id_table =	hvdrm_pci_tbl,
> +	.probe =	hvdrm_pci_probe,
> +	.remove =	hvdrm_pci_remove,
>  };
>  
> -static int hyperv_setup_vram(struct hyperv_drm_device *hv,
> +static int hvdrm_setup_vram(struct hvdrm_drm_device *hv,
>  			     struct hv_device *hdev)
>  {
>  	struct drm_device *dev = &hv->dev;
> @@ -102,15 +102,15 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
>  	return ret;
>  }
>  
> -static int hyperv_vmbus_probe(struct hv_device *hdev,
> +static int hvdrm_vmbus_probe(struct hv_device *hdev,
>  			      const struct hv_vmbus_device_id *dev_id)
>  {
> -	struct hyperv_drm_device *hv;
> +	struct hvdrm_drm_device *hv;
>  	struct drm_device *dev;
>  	int ret;
>  
> -	hv = devm_drm_dev_alloc(&hdev->device, &hyperv_driver,
> -				struct hyperv_drm_device, dev);
> +	hv = devm_drm_dev_alloc(&hdev->device, &hvdrm_driver,
> +				struct hvdrm_drm_device, dev);
>  	if (IS_ERR(hv))
>  		return PTR_ERR(hv);
>  
> @@ -119,15 +119,15 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>  	hv_set_drvdata(hdev, hv);
>  	hv->hdev = hdev;
>  
> -	ret = hyperv_connect_vsp(hdev);
> +	ret = hvdrm_connect_vsp(hdev);
>  	if (ret) {
>  		drm_err(dev, "Failed to connect to vmbus.\n");
>  		goto err_hv_set_drv_data;
>  	}
>  
> -	aperture_remove_all_conflicting_devices(hyperv_driver.name);
> +	aperture_remove_all_conflicting_devices(hvdrm_driver.name);
>  
> -	ret = hyperv_setup_vram(hv, hdev);
> +	ret = hvdrm_setup_vram(hv, hdev);
>  	if (ret)
>  		goto err_vmbus_close;
>  
> @@ -136,11 +136,11 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>  	 * vram location is not fatal. Device will update dirty area till
>  	 * preferred resolution only.
>  	 */
> -	ret = hyperv_update_vram_location(hdev, hv->fb_base);
> +	ret = hvdrm_update_vram_location(hdev, hv->fb_base);
>  	if (ret)
>  		drm_warn(dev, "Failed to update vram location.\n");
>  
> -	ret = hyperv_mode_config_init(hv);
> +	ret = hvdrm_mode_config_init(hv);
>  	if (ret)
>  		goto err_free_mmio;
>  
> @@ -168,10 +168,10 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>  	return ret;
>  }
>  
> -static void hyperv_vmbus_remove(struct hv_device *hdev)
> +static void hvdrm_vmbus_remove(struct hv_device *hdev)
>  {
>  	struct drm_device *dev = hv_get_drvdata(hdev);
> -	struct hyperv_drm_device *hv = to_hv(dev);
> +	struct hvdrm_drm_device *hv = to_hv(dev);
>  
>  	vmbus_set_skip_unload(false);
>  	drm_dev_unplug(dev);
> @@ -183,12 +183,12 @@ static void hyperv_vmbus_remove(struct hv_device *hdev)
>  	vmbus_free_mmio(hv->mem->start, hv->fb_size);
>  }
>  
> -static void hyperv_vmbus_shutdown(struct hv_device *hdev)
> +static void hvdrm_vmbus_shutdown(struct hv_device *hdev)
>  {
>  	drm_atomic_helper_shutdown(hv_get_drvdata(hdev));
>  }
>  
> -static int hyperv_vmbus_suspend(struct hv_device *hdev)
> +static int hvdrm_vmbus_suspend(struct hv_device *hdev)
>  {
>  	struct drm_device *dev = hv_get_drvdata(hdev);
>  	int ret;
> @@ -202,67 +202,67 @@ static int hyperv_vmbus_suspend(struct hv_device *hdev)
>  	return 0;
>  }
>  
> -static int hyperv_vmbus_resume(struct hv_device *hdev)
> +static int hvdrm_vmbus_resume(struct hv_device *hdev)
>  {
>  	struct drm_device *dev = hv_get_drvdata(hdev);
> -	struct hyperv_drm_device *hv = to_hv(dev);
> +	struct hvdrm_drm_device *hv = to_hv(dev);
>  	int ret;
>  
> -	ret = hyperv_connect_vsp(hdev);
> +	ret = hvdrm_connect_vsp(hdev);
>  	if (ret)
>  		return ret;
>  
> -	ret = hyperv_update_vram_location(hdev, hv->fb_base);
> +	ret = hvdrm_update_vram_location(hdev, hv->fb_base);
>  	if (ret)
>  		return ret;
>  
>  	return drm_mode_config_helper_resume(dev);
>  }
>  
> -static const struct hv_vmbus_device_id hyperv_vmbus_tbl[] = {
> +static const struct hv_vmbus_device_id hvdrm_vmbus_tbl[] = {
>  	/* Synthetic Video Device GUID */
>  	{HV_SYNTHVID_GUID},
>  	{}
>  };
>  
> -static struct hv_driver hyperv_hv_driver = {
> +static struct hv_driver hvdrm_hv_driver = {
>  	.name = KBUILD_MODNAME,
> -	.id_table = hyperv_vmbus_tbl,
> -	.probe = hyperv_vmbus_probe,
> -	.remove = hyperv_vmbus_remove,
> -	.shutdown = hyperv_vmbus_shutdown,
> -	.suspend = hyperv_vmbus_suspend,
> -	.resume = hyperv_vmbus_resume,
> +	.id_table = hvdrm_vmbus_tbl,
> +	.probe = hvdrm_vmbus_probe,
> +	.remove = hvdrm_vmbus_remove,
> +	.shutdown = hvdrm_vmbus_shutdown,
> +	.suspend = hvdrm_vmbus_suspend,
> +	.resume = hvdrm_vmbus_resume,
>  	.driver = {
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  
> -static int __init hyperv_init(void)
> +static int __init hvdrm_init(void)
>  {
>  	int ret;
>  
>  	if (drm_firmware_drivers_only())
>  		return -ENODEV;
>  
> -	ret = pci_register_driver(&hyperv_pci_driver);
> +	ret = pci_register_driver(&hvdrm_pci_driver);
>  	if (ret != 0)
>  		return ret;
>  
> -	return vmbus_driver_register(&hyperv_hv_driver);
> +	return vmbus_driver_register(&hvdrm_hv_driver);
>  }
>  
> -static void __exit hyperv_exit(void)
> +static void __exit hvdrm_exit(void)
>  {
> -	vmbus_driver_unregister(&hyperv_hv_driver);
> -	pci_unregister_driver(&hyperv_pci_driver);
> +	vmbus_driver_unregister(&hvdrm_hv_driver);
> +	pci_unregister_driver(&hvdrm_pci_driver);
>  }
>  
> -module_init(hyperv_init);
> -module_exit(hyperv_exit);
> +module_init(hvdrm_init);
> +module_exit(hvdrm_exit);
>  
> -MODULE_DEVICE_TABLE(pci, hyperv_pci_tbl);
> -MODULE_DEVICE_TABLE(vmbus, hyperv_vmbus_tbl);
> +MODULE_DEVICE_TABLE(pci, hvdrm_pci_tbl);
> +MODULE_DEVICE_TABLE(vmbus, hvdrm_vmbus_tbl);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Deepak Rawat <drawat.floss@gmail.com>");
>  MODULE_DESCRIPTION("DRM driver for Hyper-V synthetic video device");
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 793dbbf61893..6844d085e709 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -25,11 +25,11 @@
>  
>  #include "hyperv_drm.h"
>  
> -static int hyperv_blit_to_vram_rect(struct drm_framebuffer *fb,
> +static int hvdrm_blit_to_vram_rect(struct drm_framebuffer *fb,
>  				    const struct iosys_map *vmap,
>  				    struct drm_rect *rect)
>  {
> -	struct hyperv_drm_device *hv = to_hv(fb->dev);
> +	struct hvdrm_drm_device *hv = to_hv(fb->dev);
>  	struct iosys_map dst = IOSYS_MAP_INIT_VADDR_IOMEM(hv->vram);
>  	int idx;
>  
> @@ -44,9 +44,9 @@ static int hyperv_blit_to_vram_rect(struct drm_framebuffer *fb,
>  	return 0;
>  }
>  
> -static int hyperv_connector_get_modes(struct drm_connector *connector)
> +static int hvdrm_connector_get_modes(struct drm_connector *connector)
>  {
> -	struct hyperv_drm_device *hv = to_hv(connector->dev);
> +	struct hvdrm_drm_device *hv = to_hv(connector->dev);
>  	int count;
>  
>  	count = drm_add_modes_noedid(connector,
> @@ -58,11 +58,11 @@ static int hyperv_connector_get_modes(struct drm_connector *connector)
>  	return count;
>  }
>  
> -static const struct drm_connector_helper_funcs hyperv_connector_helper_funcs = {
> -	.get_modes = hyperv_connector_get_modes,
> +static const struct drm_connector_helper_funcs hvdrm_connector_helper_funcs = {
> +	.get_modes = hvdrm_connector_get_modes,
>  };
>  
> -static const struct drm_connector_funcs hyperv_connector_funcs = {
> +static const struct drm_connector_funcs hvdrm_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
>  	.reset = drm_atomic_helper_connector_reset,
> @@ -70,15 +70,15 @@ static const struct drm_connector_funcs hyperv_connector_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
> -static inline int hyperv_conn_init(struct hyperv_drm_device *hv)
> +static inline int hvdrm_conn_init(struct hvdrm_drm_device *hv)
>  {
> -	drm_connector_helper_add(&hv->connector, &hyperv_connector_helper_funcs);
> +	drm_connector_helper_add(&hv->connector, &hvdrm_connector_helper_funcs);
>  	return drm_connector_init(&hv->dev, &hv->connector,
> -				  &hyperv_connector_funcs,
> +				  &hvdrm_connector_funcs,
>  				  DRM_MODE_CONNECTOR_VIRTUAL);
>  }
>  
> -static int hyperv_check_size(struct hyperv_drm_device *hv, int w, int h,
> +static int hvdrm_check_size(struct hvdrm_drm_device *hv, int w, int h,
>  			     struct drm_framebuffer *fb)
>  {
>  	u32 pitch = w * (hv->screen_depth / 8);
> @@ -92,25 +92,25 @@ static int hyperv_check_size(struct hyperv_drm_device *hv, int w, int h,
>  	return 0;
>  }
>  
> -static const uint32_t hyperv_formats[] = {
> +static const uint32_t hvdrm_formats[] = {
>  	DRM_FORMAT_XRGB8888,
>  };
>  
> -static const uint64_t hyperv_modifiers[] = {
> +static const uint64_t hvdrm_modifiers[] = {
>  	DRM_FORMAT_MOD_LINEAR,
>  	DRM_FORMAT_MOD_INVALID
>  };
>  
> -static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +static void hvdrm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>  					     struct drm_atomic_commit *state)
>  {
> -	struct hyperv_drm_device *hv = to_hv(crtc->dev);
> +	struct hvdrm_drm_device *hv = to_hv(crtc->dev);
>  	struct drm_plane *plane = &hv->plane;
>  	struct drm_plane_state *plane_state = plane->state;
>  	struct drm_crtc_state *crtc_state = crtc->state;
>  
> -	hyperv_hide_hw_ptr(hv->hdev);
> -	hyperv_update_situation(hv->hdev, 1,  hv->screen_depth,
> +	hvdrm_hide_hw_ptr(hv->hdev);
> +	hvdrm_update_situation(hv->hdev, 1,  hv->screen_depth,
>  				crtc_state->mode.hdisplay,
>  				crtc_state->mode.vdisplay,
>  				plane_state->fb->pitches[0]);
> @@ -118,14 +118,14 @@ static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>  	drm_crtc_vblank_on(crtc);
>  }
>  
> -static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
> +static const struct drm_crtc_helper_funcs hvdrm_crtc_helper_funcs = {
>  	.atomic_check = drm_crtc_helper_atomic_check,
>  	.atomic_flush = drm_crtc_vblank_atomic_flush,
> -	.atomic_enable = hyperv_crtc_helper_atomic_enable,
> +	.atomic_enable = hvdrm_crtc_helper_atomic_enable,
>  	.atomic_disable = drm_crtc_vblank_atomic_disable,
>  };
>  
> -static const struct drm_crtc_funcs hyperv_crtc_funcs = {
> +static const struct drm_crtc_funcs hvdrm_crtc_funcs = {
>  	.reset = drm_atomic_helper_crtc_reset,
>  	.destroy = drm_crtc_cleanup,
>  	.set_config = drm_atomic_helper_set_config,
> @@ -135,11 +135,11 @@ static const struct drm_crtc_funcs hyperv_crtc_funcs = {
>  	DRM_CRTC_VBLANK_TIMER_FUNCS,
>  };
>  
> -static int hyperv_plane_atomic_check(struct drm_plane *plane,
> +static int hvdrm_plane_atomic_check(struct drm_plane *plane,
>  				     struct drm_atomic_commit *state)
>  {
>  	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
> -	struct hyperv_drm_device *hv = to_hv(plane->dev);
> +	struct hvdrm_drm_device *hv = to_hv(plane->dev);
>  	struct drm_framebuffer *fb = plane_state->fb;
>  	struct drm_crtc *crtc = plane_state->crtc;
>  	struct drm_crtc_state *crtc_state = NULL;
> @@ -167,10 +167,10 @@ static int hyperv_plane_atomic_check(struct drm_plane *plane,
>  	return 0;
>  }
>  
> -static void hyperv_plane_atomic_update(struct drm_plane *plane,
> +static void hvdrm_plane_atomic_update(struct drm_plane *plane,
>  				       struct drm_atomic_commit *state)
>  {
> -	struct hyperv_drm_device *hv = to_hv(plane->dev);
> +	struct hvdrm_drm_device *hv = to_hv(plane->dev);
>  	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>  	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>  	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
> @@ -185,15 +185,15 @@ static void hyperv_plane_atomic_update(struct drm_plane *plane,
>  		if (!drm_rect_intersect(&dst_clip, &damage))
>  			continue;
>  
> -		hyperv_blit_to_vram_rect(new_state->fb, &shadow_plane_state->data[0], &damage);
> -		hyperv_update_dirt(hv->hdev, &damage);
> +		hvdrm_blit_to_vram_rect(new_state->fb, &shadow_plane_state->data[0], &damage);
> +		hvdrm_update_dirt(hv->hdev, &damage);
>  	}
>  }
>  
> -static int hyperv_plane_get_scanout_buffer(struct drm_plane *plane,
> +static int hvdrm_plane_get_scanout_buffer(struct drm_plane *plane,
>  					   struct drm_scanout_buffer *sb)
>  {
> -	struct hyperv_drm_device *hv = to_hv(plane->dev);
> +	struct hvdrm_drm_device *hv = to_hv(plane->dev);
>  	struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(hv->vram);
>  
>  	if (plane->state && plane->state->fb) {
> @@ -207,9 +207,9 @@ static int hyperv_plane_get_scanout_buffer(struct drm_plane *plane,
>  	return -ENODEV;
>  }
>  
> -static void hyperv_plane_panic_flush(struct drm_plane *plane)
> +static void hvdrm_plane_panic_flush(struct drm_plane *plane)
>  {
> -	struct hyperv_drm_device *hv = to_hv(plane->dev);
> +	struct hvdrm_drm_device *hv = to_hv(plane->dev);
>  	struct drm_rect rect;
>  
>  	if (plane->state && plane->state->fb) {
> @@ -218,32 +218,32 @@ static void hyperv_plane_panic_flush(struct drm_plane *plane)
>  		rect.x2 = plane->state->fb->width;
>  		rect.y2 = plane->state->fb->height;
>  
> -		hyperv_update_dirt(hv->hdev, &rect);
> +		hvdrm_update_dirt(hv->hdev, &rect);
>  	}
>  
>  	vmbus_initiate_unload(true);
>  }
>  
> -static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {
> +static const struct drm_plane_helper_funcs hvdrm_plane_helper_funcs = {
>  	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> -	.atomic_check = hyperv_plane_atomic_check,
> -	.atomic_update = hyperv_plane_atomic_update,
> -	.get_scanout_buffer = hyperv_plane_get_scanout_buffer,
> -	.panic_flush = hyperv_plane_panic_flush,
> +	.atomic_check = hvdrm_plane_atomic_check,
> +	.atomic_update = hvdrm_plane_atomic_update,
> +	.get_scanout_buffer = hvdrm_plane_get_scanout_buffer,
> +	.panic_flush = hvdrm_plane_panic_flush,
>  };
>  
> -static const struct drm_plane_funcs hyperv_plane_funcs = {
> +static const struct drm_plane_funcs hvdrm_plane_funcs = {
>  	.update_plane		= drm_atomic_helper_update_plane,
>  	.disable_plane		= drm_atomic_helper_disable_plane,
>  	.destroy		= drm_plane_cleanup,
>  	DRM_GEM_SHADOW_PLANE_FUNCS,
>  };
>  
> -static const struct drm_encoder_funcs hyperv_drm_simple_encoder_funcs_cleanup = {
> +static const struct drm_encoder_funcs hvdrm_drm_simple_encoder_funcs_cleanup = {
>  	.destroy = drm_encoder_cleanup,
>  };
>  
> -static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
> +static inline int hvdrm_pipe_init(struct hvdrm_drm_device *hv)
>  {
>  	struct drm_device *dev = &hv->dev;
>  	struct drm_encoder *encoder = &hv->encoder;
> @@ -253,29 +253,29 @@ static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
>  	int ret;
>  
>  	ret = drm_universal_plane_init(dev, plane, 0,
> -				       &hyperv_plane_funcs,
> -				       hyperv_formats, ARRAY_SIZE(hyperv_formats),
> -				       hyperv_modifiers,
> +				       &hvdrm_plane_funcs,
> +				       hvdrm_formats, ARRAY_SIZE(hvdrm_formats),
> +				       hvdrm_modifiers,
>  				       DRM_PLANE_TYPE_PRIMARY, NULL);
>  	if (ret)
>  		return ret;
> -	drm_plane_helper_add(plane, &hyperv_plane_helper_funcs);
> +	drm_plane_helper_add(plane, &hvdrm_plane_helper_funcs);
>  	drm_plane_enable_fb_damage_clips(plane);
>  
>  	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
> -					&hyperv_crtc_funcs, NULL);
> +					&hvdrm_crtc_funcs, NULL);
>  	if (ret)
>  		return ret;
> -	drm_crtc_helper_add(crtc, &hyperv_crtc_helper_funcs);
> +	drm_crtc_helper_add(crtc, &hvdrm_crtc_helper_funcs);
>  
>  	encoder->possible_crtcs = drm_crtc_mask(crtc);
>  	ret = drm_encoder_init(dev, encoder,
> -			       &hyperv_drm_simple_encoder_funcs_cleanup,
> +			       &hvdrm_drm_simple_encoder_funcs_cleanup,
>  			       DRM_MODE_ENCODER_NONE, NULL);
>  	if (ret)
>  		return ret;
>  
> -	ret = hyperv_conn_init(hv);
> +	ret = hvdrm_conn_init(hv);
>  	if (ret) {
>  		drm_err(dev, "Failed to initialized connector.\n");
>  		return ret;
> @@ -285,25 +285,25 @@ static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
>  }
>  
>  static enum drm_mode_status
> -hyperv_mode_valid(struct drm_device *dev,
> +hvdrm_mode_valid(struct drm_device *dev,
>  		  const struct drm_display_mode *mode)
>  {
> -	struct hyperv_drm_device *hv = to_hv(dev);
> +	struct hvdrm_drm_device *hv = to_hv(dev);
>  
> -	if (hyperv_check_size(hv, mode->hdisplay, mode->vdisplay, NULL))
> +	if (hvdrm_check_size(hv, mode->hdisplay, mode->vdisplay, NULL))
>  		return MODE_BAD;
>  
>  	return MODE_OK;
>  }
>  
> -static const struct drm_mode_config_funcs hyperv_mode_config_funcs = {
> +static const struct drm_mode_config_funcs hvdrm_mode_config_funcs = {
>  	.fb_create = drm_gem_fb_create_with_dirty,
> -	.mode_valid = hyperv_mode_valid,
> +	.mode_valid = hvdrm_mode_valid,
>  	.atomic_check = drm_atomic_helper_check,
>  	.atomic_commit = drm_atomic_helper_commit,
>  };
>  
> -int hyperv_mode_config_init(struct hyperv_drm_device *hv)
> +int hvdrm_mode_config_init(struct hvdrm_drm_device *hv)
>  {
>  	struct drm_device *dev = &hv->dev;
>  	int ret;
> @@ -322,9 +322,9 @@ int hyperv_mode_config_init(struct hyperv_drm_device *hv)
>  	dev->mode_config.preferred_depth = hv->screen_depth;
>  	dev->mode_config.prefer_shadow = 0;
>  
> -	dev->mode_config.funcs = &hyperv_mode_config_funcs;
> +	dev->mode_config.funcs = &hvdrm_mode_config_funcs;
>  
> -	ret = hyperv_pipe_init(hv);
> +	ret = hvdrm_pipe_init(hv);
>  	if (ret) {
>  		drm_err(dev, "Failed to initialized pipe.\n");
>  		return ret;
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index 6e09b0218df4..7c11b20a9124 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -181,7 +181,7 @@ struct synthvid_msg {
>  	};
>  } __packed;
>  
> -static inline bool hyperv_version_ge(u32 ver1, u32 ver2)
> +static inline bool hvdrm_version_ge(u32 ver1, u32 ver2)
>  {
>  	if (SYNTHVID_VER_GET_MAJOR(ver1) > SYNTHVID_VER_GET_MAJOR(ver2) ||
>  	    (SYNTHVID_VER_GET_MAJOR(ver1) == SYNTHVID_VER_GET_MAJOR(ver2) &&
> @@ -191,10 +191,10 @@ static inline bool hyperv_version_ge(u32 ver1, u32 ver2)
>  	return false;
>  }
>  
> -static inline int hyperv_sendpacket(struct hv_device *hdev, struct synthvid_msg *msg)
> +static inline int hvdrm_sendpacket(struct hv_device *hdev, struct synthvid_msg *msg)
>  {
>  	static atomic64_t request_id = ATOMIC64_INIT(0);
> -	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
> +	struct hvdrm_drm_device *hv = hv_get_drvdata(hdev);
>  	int ret;
>  
>  	msg->pipe_hdr.type = PIPE_MSG_DATA;
> @@ -211,9 +211,9 @@ static inline int hyperv_sendpacket(struct hv_device *hdev, struct synthvid_msg
>  	return ret;
>  }
>  
> -static int hyperv_negotiate_version(struct hv_device *hdev, u32 ver)
> +static int hvdrm_negotiate_version(struct hv_device *hdev, u32 ver)
>  {
> -	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
> +	struct hvdrm_drm_device *hv = hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg = (struct synthvid_msg *)hv->init_buf;
>  	struct drm_device *dev = &hv->dev;
>  	unsigned long t;
> @@ -223,7 +223,7 @@ static int hyperv_negotiate_version(struct hv_device *hdev, u32 ver)
>  	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_version_req);
>  	msg->ver_req.version = ver;
> -	hyperv_sendpacket(hdev, msg);
> +	hvdrm_sendpacket(hdev, msg);
>  
>  	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
>  	if (!t) {
> @@ -243,9 +243,9 @@ static int hyperv_negotiate_version(struct hv_device *hdev, u32 ver)
>  	return 0;
>  }
>  
> -int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
> +int hvdrm_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
>  {
> -	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
> +	struct hvdrm_drm_device *hv = hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg = (struct synthvid_msg *)hv->init_buf;
>  	struct drm_device *dev = &hv->dev;
>  	unsigned long t;
> @@ -257,7 +257,7 @@ int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
>  	msg->vram.user_ctx = vram_pp;
>  	msg->vram.vram_gpa = vram_pp;
>  	msg->vram.is_vram_gpa_specified = 1;
> -	hyperv_sendpacket(hdev, msg);
> +	hvdrm_sendpacket(hdev, msg);
>  
>  	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
>  	if (!t) {
> @@ -272,7 +272,7 @@ int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
>  	return 0;
>  }
>  
> -int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
> +int hvdrm_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
>  			    u32 w, u32 h, u32 pitch)
>  {
>  	struct synthvid_msg msg;
> @@ -292,7 +292,7 @@ int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
>  	msg.situ.video_output[0].height_pixels = h;
>  	msg.situ.video_output[0].pitch_bytes = pitch;
>  
> -	hyperv_sendpacket(hdev, &msg);
> +	hvdrm_sendpacket(hdev, &msg);
>  
>  	return 0;
>  }
> @@ -306,11 +306,11 @@ int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
>   * the msg.ptr_shape.data. Note: setting msg.ptr_pos.is_visible to 0 doesn't
>   * work in tests.
>   *
> - * The hyperv_hide_hw_ptr() is also called in the handler of the
> + * The hvdrm_hide_hw_ptr() is also called in the handler of the
>   * SYNTHVID_FEATURE_CHANGE event, otherwise the host still draws an extra
>   * unwanted mouse pointer after the VM Connection window is closed and reopened.
>   */
> -int hyperv_hide_hw_ptr(struct hv_device *hdev)
> +int hvdrm_hide_hw_ptr(struct hv_device *hdev)
>  {
>  	struct synthvid_msg msg;
>  
> @@ -322,7 +322,7 @@ int hyperv_hide_hw_ptr(struct hv_device *hdev)
>  	msg.ptr_pos.video_output = 0;
>  	msg.ptr_pos.image_x = 0;
>  	msg.ptr_pos.image_y = 0;
> -	hyperv_sendpacket(hdev, &msg);
> +	hvdrm_sendpacket(hdev, &msg);
>  
>  	memset(&msg, 0, sizeof(struct synthvid_msg));
>  	msg.vid_hdr.type = SYNTHVID_POINTER_SHAPE;
> @@ -338,14 +338,14 @@ int hyperv_hide_hw_ptr(struct hv_device *hdev)
>  	msg.ptr_shape.data[1] = 1;
>  	msg.ptr_shape.data[2] = 1;
>  	msg.ptr_shape.data[3] = 1;
> -	hyperv_sendpacket(hdev, &msg);
> +	hvdrm_sendpacket(hdev, &msg);
>  
>  	return 0;
>  }
>  
> -int hyperv_update_dirt(struct hv_device *hdev, struct drm_rect *rect)
> +int hvdrm_update_dirt(struct hv_device *hdev, struct drm_rect *rect)
>  {
> -	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
> +	struct hvdrm_drm_device *hv = hv_get_drvdata(hdev);
>  	struct synthvid_msg msg;
>  
>  	if (!hv->dirt_needed)
> @@ -363,14 +363,14 @@ int hyperv_update_dirt(struct hv_device *hdev, struct drm_rect *rect)
>  	msg.dirt.rect[0].x2 = rect->x2;
>  	msg.dirt.rect[0].y2 = rect->y2;
>  
> -	hyperv_sendpacket(hdev, &msg);
> +	hvdrm_sendpacket(hdev, &msg);
>  
>  	return 0;
>  }
>  
> -static int hyperv_get_supported_resolution(struct hv_device *hdev)
> +static int hvdrm_get_supported_resolution(struct hv_device *hdev)
>  {
> -	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
> +	struct hvdrm_drm_device *hv = hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg = (struct synthvid_msg *)hv->init_buf;
>  	struct drm_device *dev = &hv->dev;
>  	unsigned long t;
> @@ -383,7 +383,7 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
>  		sizeof(struct synthvid_supported_resolution_req);
>  	msg->resolution_req.maximum_resolution_count =
>  		SYNTHVID_MAX_RESOLUTION_COUNT;
> -	hyperv_sendpacket(hdev, msg);
> +	hvdrm_sendpacket(hdev, msg);
>  
>  	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
>  	if (!t) {
> @@ -420,9 +420,9 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
>  	return 0;
>  }
>  
> -static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
> +static void hvdrm_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  {
> -	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
> +	struct hvdrm_drm_device *hv = hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg;
>  	size_t hdr_size;
>  	size_t need;
> @@ -486,7 +486,7 @@ static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  		}
>  		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
>  		if (hv->dirt_needed)
> -			hyperv_hide_hw_ptr(hv->hdev);
> +			hvdrm_hide_hw_ptr(hv->hdev);
>  		return;
>  	default:
>  		return;
> @@ -508,10 +508,10 @@ static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
>  	complete(&hv->wait);
>  }
>  
> -static void hyperv_receive(void *ctx)
> +static void hvdrm_receive(void *ctx)
>  {
>  	struct hv_device *hdev = ctx;
> -	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
> +	struct hvdrm_drm_device *hv = hv_get_drvdata(hdev);
>  	struct synthvid_msg *recv_buf;
>  	u32 bytes_recvd;
>  	u64 req_id;
> @@ -539,19 +539,19 @@ static void hyperv_receive(void *ctx)
>  					    ret, bytes_recvd);
>  		} else if (bytes_recvd > 0 &&
>  			   recv_buf->pipe_hdr.type == PIPE_MSG_DATA) {
> -			hyperv_receive_sub(hdev, bytes_recvd);
> +			hvdrm_receive_sub(hdev, bytes_recvd);
>  		}
>  	} while (bytes_recvd > 0 && ret == 0);
>  }
>  
> -int hyperv_connect_vsp(struct hv_device *hdev)
> +int hvdrm_connect_vsp(struct hv_device *hdev)
>  {
> -	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
> +	struct hvdrm_drm_device *hv = hv_get_drvdata(hdev);
>  	struct drm_device *dev = &hv->dev;
>  	int ret;
>  
>  	ret = vmbus_open(hdev->channel, VMBUS_RING_BUFSIZE, VMBUS_RING_BUFSIZE,
> -			 NULL, 0, hyperv_receive, hdev);
> +			 NULL, 0, hvdrm_receive, hdev);
>  	if (ret) {
>  		drm_err(dev, "Unable to open vmbus channel\n");
>  		return ret;
> @@ -561,16 +561,16 @@ int hyperv_connect_vsp(struct hv_device *hdev)
>  	switch (vmbus_proto_version) {
>  	case VERSION_WIN10:
>  	case VERSION_WIN10_V5:
> -		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
> +		ret = hvdrm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
>  		if (!ret)
>  			break;
>  		fallthrough;
>  	case VERSION_WIN8:
>  	case VERSION_WIN8_1:
> -		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
> +		ret = hvdrm_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
>  		break;
>  	default:
> -		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
> +		ret = hvdrm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
>  		break;
>  	}
>  
> @@ -581,8 +581,8 @@ int hyperv_connect_vsp(struct hv_device *hdev)
>  
>  	hv->screen_depth = SYNTHVID_DEPTH_WIN8;
>  
> -	if (hyperv_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
> -		ret = hyperv_get_supported_resolution(hdev);
> +	if (hvdrm_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
> +		ret = hvdrm_get_supported_resolution(hdev);
>  		if (ret)
>  			drm_err(dev, "Failed to get supported resolution from host, use default\n");
>  	}
> -- 
> 2.25.1
> 

