Return-Path: <linux-hyperv+bounces-11064-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNUwGnnzDWry4wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11064-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 19:46:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 176F6594861
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DB8F3230FCD
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99585346E5E;
	Wed, 20 May 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nnvU/TDP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB793E3C62
	for <linux-hyperv@vger.kernel.org>; Wed, 20 May 2026 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298095; cv=none; b=YTa7T2bkA37BE3rlZmNPnIvY7NjwK3jiz8mn91QUjblZy7c25Ib90j5QrQSSa6PuPLSMRyHpGA3ahmM30TsZwibgqL7/X0TJicTaJ670iJ9CmDNXUCslmIEFG5rw30paPA/EjCgiwKm98uYx0Y+73hn2TBJxHfixmPVQP1H/aBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298095; c=relaxed/simple;
	bh=3OBSzmJ9Qs+xIPdG2EQFuYezwwEX7Uj0rcvm6Gm98NI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hIlBtSSw9y1rftEn5TEOE7zaVkMyOpNwH8AXFdcRvE95UDQTpOy/NloHjYMds85G+l3fPeDuawc+1cfNxR1XmcphNlV/UQoDhnvBcnToXBavTkbvqFhcpeZWRKz9Z6hOZpsKqXgXHtn4p28c5ejg0UgmZFW3D3UuBeBydsUuhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nnvU/TDP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 2E82720B7167; Wed, 20 May 2026 10:28:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E82720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779298087;
	bh=eVOL8qzVM9mtXXb7KSyUaA53OdqpWhpTPeEHWX/aFAE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nnvU/TDPKP75lLMEec+JJp78KNQDmXyleg7E3AgMkW5Adr+kvNFTWsu5TFqftMic5
	 Mhn39LOkjqYPUjQx/fFbAJlPlzJSYjzIEEG5vYorMsCewIpEvJRSZp45sZA3J24GWB
	 8pv8DV4icQpTwAOUgFIWzavSbFYpzA9zKEwnCCTg=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 2B94F30705A4;
	Wed, 20 May 2026 10:28:07 -0700 (PDT)
Date: Wed, 20 May 2026 10:28:07 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
cc: linux-hyperv@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
    "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>, 
    Michael Kelley <mhklinux@outlook.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] hyperv: move vmbus_root_device outside of the VMBus
 driver
In-Reply-To: <20260520154943.898386-1-hamzamahfooz@linux.microsoft.com>
Message-ID: <ca225758-37f-84a-6074-5c6a9d21dbfb@linux.microsoft.com>
References: <20260520154943.898386-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,linux.microsoft.com,anirudhrb.com,outlook.com,arndb.de];
	TAGGED_FROM(0.00)[bounces-11064-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,linux.microsoft.com:mid,linux.microsoft.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 176F6594861
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026, Hamza Mahfooz wrote:

> Conceptually, we shouldn't have to build the VMBus driver to answer the
> question "does VMBus exist?" So, move vmbus_root_device and the
> functions that access it directly to hyperv.h. Also, introduce
> hv_set_vmbus_root_device() to allow vmbus_drv to set the root device.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/r/20260520074044.923728-1-arnd@kernel.org/
> Fixes: f1a9e67c1138 ("mshv: limit SynIC management to MSHV-owned resources")
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> drivers/hv/vmbus_drv.c | 27 ++++++---------------------
> include/linux/hyperv.h | 18 ++++++++++++++++--
> 2 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 71f1b4d52f7f..b26e6b42fa49 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -47,9 +47,6 @@ struct vmbus_dynid {
> 	struct hv_vmbus_device_id id;
> };
>
> -/* VMBus Root Device */
> -static struct device  *vmbus_root_device;
> -
> static int hyperv_cpuhp_online;
>
> static DEFINE_PER_CPU(long, vmbus_evt);
> @@ -95,18 +92,6 @@ static struct resource *fb_mmio;
> static struct resource *hyperv_mmio;
> static DEFINE_MUTEX(hyperv_mmio_lock);
>
> -struct device *hv_get_vmbus_root_device(void)
> -{
> -	return vmbus_root_device;
> -}
> -EXPORT_SYMBOL_GPL(hv_get_vmbus_root_device);
> -
> -bool hv_vmbus_exists(void)
> -{
> -	return vmbus_root_device != NULL;
> -}
> -EXPORT_SYMBOL_GPL(hv_vmbus_exists);
> -
> static u8 channel_monitor_group(const struct vmbus_channel *channel)
> {
> 	return (u8)channel->offermsg.monitorid / 32;
> @@ -903,7 +888,7 @@ static int vmbus_dma_configure(struct device *child_device)
> 	 * On x86/x64 coherence is assumed and these calls have no effect.
> 	 */
> 	hv_setup_dma_ops(child_device,
> -		device_get_dma_attr(vmbus_root_device) == DEV_DMA_COHERENT);
> +		device_get_dma_attr(hv_get_vmbus_root_device()) == DEV_DMA_COHERENT);
> 	return 0;
> }
>
> @@ -2172,7 +2157,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
> 		     &child_device_obj->channel->offermsg.offer.if_instance);
>
> 	child_device_obj->device.bus = &hv_bus;
> -	child_device_obj->device.parent = vmbus_root_device;
> +	child_device_obj->device.parent = hv_get_vmbus_root_device();
> 	child_device_obj->device.release = vmbus_device_release;
>
> 	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
> @@ -2561,7 +2546,7 @@ static int vmbus_acpi_add(struct platform_device *pdev)
> 	struct acpi_device *ancestor;
> 	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>
> -	vmbus_root_device = &device->dev;
> +	hv_set_vmbus_root_device(&device->dev);
>
> 	/*
> 	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2648,7 +2633,7 @@ static int vmbus_device_add(struct platform_device *pdev)
> 	struct device_node *np = pdev->dev.of_node;
> 	int ret;
>
> -	vmbus_root_device = &pdev->dev;
> +	hv_set_vmbus_root_device(&pdev->dev);
>
> 	ret = of_range_parser_init(&parser, np);
> 	if (ret)
> @@ -2969,7 +2954,7 @@ static int __init hv_acpi_init(void)
> 	if (ret)
> 		return ret;
>
> -	if (!vmbus_root_device) {
> +	if (!hv_vmbus_exists()) {
> 		ret = -ENODEV;
> 		goto cleanup;
> 	}
> @@ -3000,7 +2985,7 @@ static int __init hv_acpi_init(void)
>
> cleanup:
> 	platform_driver_unregister(&vmbus_platform_driver);
> -	vmbus_root_device = NULL;
> +	hv_set_vmbus_root_device(NULL);
> 	return ret;
> }
>
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 5459e776ec17..3e8ea7d9653c 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1302,9 +1302,23 @@ static inline void *hv_get_drvdata(struct hv_device *dev)
> 	return dev_get_drvdata(&dev->device);
> }
>
> -struct device *hv_get_vmbus_root_device(void);
> +/* Do *not* use this outside of hyperv.h */
> +static struct device *__vmbus_root_device __read_mostly;
>
> -bool hv_vmbus_exists(void);
> +static inline void hv_set_vmbus_root_device(struct device *dev)
> +{
> +	__vmbus_root_device = dev;
> +}
> +
> +static inline struct device *hv_get_vmbus_root_device(void)
> +{
> +	return __vmbus_root_device;
> +}
> +
> +static inline bool hv_vmbus_exists(void)
> +{
> +	return hv_get_vmbus_root_device();
> +}
>
> struct hv_ring_buffer_debug_info {
> 	u32 current_interrupt_mask;
> -- 
> 2.54.0
>

Thank you Hamza. Yes, one could do this. It still does not solve the 
problem of loading MSHV-root first, then VMBUS. The entire 
hv_vmbus_exists() test is a workaround that mostly works, but shouldn't be 
there in the first place. What really needs to happen is a SYNIC driver so 
components can load in arbitrary orders if compiled as modules. Which in 
turn is outside of my original goal to fix L1VH's kexec. The SYNIC 
abstraction needs to come no later than the root/nested capability.

Best,
Jork

