Return-Path: <linux-hyperv+bounces-9350-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHbBInpFsmk5KwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9350-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 05:47:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E968226D35C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 05:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47B6F3104406
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 04:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F193451AB;
	Thu, 12 Mar 2026 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZMr0c7d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE20282F12;
	Thu, 12 Mar 2026 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773290778; cv=none; b=TQvj5cfEWUglnh2U23IMoDSXCkN9JdmsZX5egfi9nOzJ2DNyCzVk71vEBmMCuAmtxbe5kfZMN5Cf3qGr+gFLO7J06ZI3yFu0ly1TNJ25zwpnWrMYC0lqpyNOA0/l9ypUkplfzGt6donZ/mWb3RgInT13m5wBueOO3D5NTWfe3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773290778; c=relaxed/simple;
	bh=Y8sYqXr6CpMwHt6m1Bersm2ioQl2Rd4JvM6VRDgUawM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJLF55dQQ9eR7tF2s2g03T6Y4ld80p8q8EZuYMApPUSH5t07froNd0/4nS3LDBduoNbziuMXRilOgs06B3yfihCI9uveFtLQFFm3ZYPj9Ku/tPt/ZE6DlkBoLFahitwaKqntA5h0wRAyMjzpuVGhAaxmJZtpeqPzvN5JIK64vMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZMr0c7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B8AC4CEF7;
	Thu, 12 Mar 2026 04:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773290778;
	bh=Y8sYqXr6CpMwHt6m1Bersm2ioQl2Rd4JvM6VRDgUawM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZMr0c7dPCrNqrSuGTTE09iOKEStVLZbd3Nv9VUwXj3K0Gw4DzZy3gjZg7av7NWXg
	 ulUgwVU53aodD7a2eom7rPWo9+mwRsmlT1w8hyqshZh/7mvArGXcuE5AfN56g+eThx
	 6kYaFrsbcxsyr/LhJX928PVr3TtgxDEZL0GJkv9fb2g6E8KiclU+6wT6hdMWotGvjO
	 1OYOi9VK90pNb7UUl7Pr8E0hP7KHa19P4rx6jj7kYx7S6H77DLntbE3XvS1bVXGwEJ
	 xxmFUYiiptWSIGwhzzUfwF5SU10hhX5LUtjh4Q03CVLjhO3HMazRkiqOsx7nkw0Xn1
	 F25el4w66jaEA==
Date: Thu, 12 Mar 2026 04:46:16 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: drawat.floss@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	ryasuoka@redhat.com, jfalempe@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: Provide option to skip VMBus
 unload on panic
Message-ID: <20260312044616.GC3771304@liuwe-devbox-debian-v2.local>
References: <20260217182335.265585-1-mhklkml@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217182335.265585-1-mhklkml@zohomail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9350-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com,lists.freedesktop.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: E968226D35C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dexuan and Long, can you share your thoughts on this patch?

On Tue, Feb 17, 2026 at 10:23:34AM -0800, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Currently, VMBus code initiates a VMBus unload in the panic path so
> that if a kdump kernel is loaded, it can start fresh in setting up its
> own VMBus connection. However, a driver for the VMBus virtual frame
> buffer may need to flush dirty portions of the frame buffer back to
> the Hyper-V host so that panic information is visible in the graphics
> console. To support such flushing, provide exported functions for the
> frame buffer driver to specify that the VMBus unload should not be
> done by the VMBus driver, and to initiate the VMBus unload itself.
> Together these allow a frame buffer driver to delay the VMBus unload
> until after it has completed the flush.
> 
> Ideally, the VMBus driver could use its own panic-path callback to do
> the unload after all frame buffer drivers have finished. But DRM frame
> buffer drivers use the kmsg dump callback, and there are no callbacks
> after that in the panic path. Hence this somewhat messy approach to
> properly sequencing the frame buffer flush and the VMBus unload.
> 
> Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v2: None
> 
>  drivers/hv/channel_mgmt.c |  1 +
>  drivers/hv/hyperv_vmbus.h |  1 -
>  drivers/hv/vmbus_drv.c    | 25 ++++++++++++++++++-------
>  include/linux/hyperv.h    |  3 +++
>  4 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 74fed2c073d4..5de83676dbad 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -944,6 +944,7 @@ void vmbus_initiate_unload(bool crash)
>  	else
>  		vmbus_wait_for_unload();
>  }
> +EXPORT_SYMBOL_GPL(vmbus_initiate_unload);
>  
>  static void vmbus_setup_channel_state(struct vmbus_channel *channel,
>  				      struct vmbus_channel_offer_channel *offer)
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index cdbc5f5c3215..5d3944fc93ae 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -440,7 +440,6 @@ void hv_vss_deinit(void);
>  int hv_vss_pre_suspend(void);
>  int hv_vss_pre_resume(void);
>  void hv_vss_onchannelcallback(void *context);
> -void vmbus_initiate_unload(bool crash);
>  
>  static inline void hv_poll_channel(struct vmbus_channel *channel,
>  				   void (*cb)(void *))
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 6785ad63a9cb..97dfa529d250 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -69,19 +69,29 @@ bool vmbus_is_confidential(void)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_is_confidential);
>  
> +static bool skip_vmbus_unload;
> +
> +/*
> + * Allow a VMBus framebuffer driver to specify that in the case of a panic,
> + * it will do the VMbus unload operation once it has flushed any dirty
> + * portions of the framebuffer to the Hyper-V host.
> + */
> +void vmbus_set_skip_unload(bool skip)
> +{
> +	skip_vmbus_unload = skip;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_set_skip_unload);
> +
>  /*
>   * The panic notifier below is responsible solely for unloading the
>   * vmbus connection, which is necessary in a panic event.
> - *
> - * Notice an intrincate relation of this notifier with Hyper-V
> - * framebuffer panic notifier exists - we need vmbus connection alive
> - * there in order to succeed, so we need to order both with each other
> - * [see hvfb_on_panic()] - this is done using notifiers' priorities.
>   */
>  static int hv_panic_vmbus_unload(struct notifier_block *nb, unsigned long val,
>  			      void *args)
>  {
> -	vmbus_initiate_unload(true);
> +	if (!skip_vmbus_unload)
> +		vmbus_initiate_unload(true);
> +
>  	return NOTIFY_DONE;
>  }
>  static struct notifier_block hyperv_panic_vmbus_unload_block = {
> @@ -2848,7 +2858,8 @@ static void hv_crash_handler(struct pt_regs *regs)
>  {
>  	int cpu;
>  
> -	vmbus_initiate_unload(true);
> +	if (!skip_vmbus_unload)
> +		vmbus_initiate_unload(true);
>  	/*
>  	 * In crash handler we can't schedule synic cleanup for all CPUs,
>  	 * doing the cleanup for current CPU only. This should be sufficient
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index dfc516c1c719..b0502a336eb3 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1334,6 +1334,9 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
>  			bool fb_overlap_ok);
>  void vmbus_free_mmio(resource_size_t start, resource_size_t size);
>  
> +void vmbus_initiate_unload(bool crash);
> +void vmbus_set_skip_unload(bool skip);
> +
>  /*
>   * GUID definitions of various offer types - services offered to the guest.
>   */
> -- 
> 2.25.1
> 

