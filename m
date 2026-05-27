Return-Path: <linux-hyperv+bounces-11251-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLiGDkEqF2qn7gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11251-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 19:30:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB435E8527
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 19:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D22303CF8D
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57044A725;
	Wed, 27 May 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NfaohJ2w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D237175A77;
	Wed, 27 May 2026 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902572; cv=none; b=aBKzCTHlJOcj+RgF24/5PWeyMNa7zvLw1gxrYoTvVj0XTT3p6MIyNvBRmcsiGKgtv+fpp125CD8L0ph6HzD3PZ7spIDwuBK9p34Apu2R+k3nOjV7R+0iIpOkltkm9ZeY46tVdTTI16QDVNI2RqDSnO6IkRZB3OMOL7ER7u9A33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902572; c=relaxed/simple;
	bh=eqUl/efWl34vrEk1hFacy4xsMZOJc6O9Vovh5iCzRmA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oFWHrMYkQi0UN99+Y1qV9XsBSMoq49T+1cJ0z1ZDwuL9gnsjEZ3ELELV6Bx76a+3TVMJk5r+kvSiYlzWnK7JIKCxWqe29JUYrc3jfedV9JLTJbZKGhpUvIXapYZ+0I4RIRQQWI1VGG+r9+joR8XTVwbmuDC42KsQC9VIVRR1L50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NfaohJ2w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id BC35720B7167; Wed, 27 May 2026 10:22:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC35720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779902560;
	bh=BGcDBH66U1fc1FtXNRxQ9HfWayW6/IprxmpCA8LC1MM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NfaohJ2wc0j3DON6F6meNkrNKzbV9Z6rLZdlupPm46T+TxzXpTyHF7iaV0WNVllbX
	 SkxZDKCUusGQ1JDzUnT1hxED+bLUMUa+bxXukQxEbmV+4Jwv8MswOwl+ViyjuUkOCz
	 Ws8XM0g/+4rjjP7LbFFF13ncDv6ttG5jnRluvACE=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id B9F4430705A4;
	Wed, 27 May 2026 10:22:40 -0700 (PDT)
Date: Wed, 27 May 2026 10:22:40 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: mhklinux@outlook.com
cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
    decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
    linux-kernel@vger.kernel.org, arnd@arndb.de, 
    hamzamahfooz@linux.microsoft.com
Subject: Re: [PATCH v2 1/1] mshv: Add conditional VMBus dependency
In-Reply-To: <20260526141304.3924-1-mhklkml@zohomail.com>
Message-ID: <b91cfe81-13a8-88-d75-addc63ddffa9@linux.microsoft.com>
References: <20260526141304.3924-1-mhklkml@zohomail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-11251-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:email,arndb.de:email,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 7AB435E8527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026, Michael Kelley wrote:

> From: Michael Kelley <mhklinux@outlook.com>
>
> When the VMBus driver is not part of the kernel (CONFIG_HYPERV_VMBUS=n),
> the MSHV root driver fails to link:
>
> ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!
>
> Fix this while meeting these requirements:
> * It must be possible to include the MSHV root driver without the
>  VMBus driver. In such case, the MSHV root driver can be built-in
>  to the kernel image, or it can be built as a separate module.
> * If both the MSHV root driver and the VMBus driver are present, the
>  MSHV root driver and VMBus driver can both be built-in, or they can
>  both be separate modules. Or the MSHV root driver can be a module
>  while the VMBus driver can be built-in, but the reverse is
>  disallowed. Regardless of the build choices, the VMBus driver must
>  be loaded before the MSHV driver in order for the SynIC to be
>  managed properly (see comments in the MSHV SynIC code).
>
> The fix has two parts:
> * Add a Kconfig entry for MSHV_ROOT to depend on HYPERV_VMBUS if
>  HYPERV_VMBUS is present. The entry disallows MSHV_ROOT being
>  built-in when HYPERV_VMBUS is a module, but without requiring that
>  HYPERV_VMBUS be built.
> * Add a stub implementation of hv_vmbus_exists() for when the
>  VMBus driver is not present so that the MSHV root driver has
>  no module dependency on VMBus. When the VMBus driver *is*
>  present, the module dependency ensures that the VMBus driver
>  loads first when both are built as modules.
>
> Existing code ensures that the VMBus driver loads first if it is
> built-in. The VMBus driver uses subsys_initcall(), which is
> initcall level 4. The MSHV root driver uses module_init(), which
> becomes device_init() when built-in, and device_init() is
> initcall level 6.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/all/20260520074044.923728-1-arnd@kernel.org/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
> Changes in v2:
> * Instead of putting IS_ENABLED(CONFIG_HYPERV_VMBUS) around each of
>  the two calls to hv_vmbus_exists() in mshv_synic.c, provide a stub
>  for hv_vmbus_exists() when CONFIG_HYPERV_VMBUS is not set. The
>  effect is the same as in v1, but the code is cleaner. [Jork Loeser]
>
> Arnd: I've kept your Ack even though I changed how hv_vmbus_exists()
> is stubbed out since the effect is the same. Let me know if
> you have any concerns.
>
> drivers/hv/Kconfig     | 1 +
> include/linux/hyperv.h | 4 ++++
> 2 files changed, 5 insertions(+)
>
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 2d0b3fcb0ff8..aa11bcefddf2 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -74,6 +74,7 @@ config MSHV_ROOT
> 	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> 	# no particular order, making it impossible to reassemble larger pages
> 	depends on PAGE_SIZE_4KB
> +	depends on HYPERV_VMBUS if HYPERV_VMBUS
> 	select EVENTFD
> 	select VIRT_XFER_TO_GUEST_WORK
> 	select HMM_MIRROR
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 41a3d82f0722..734b7ef98f4d 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1304,7 +1304,11 @@ static inline void *hv_get_drvdata(struct hv_device *dev)
>
> struct device *hv_get_vmbus_root_device(void);
>
> +#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
> bool hv_vmbus_exists(void);
> +#else
> +static inline bool hv_vmbus_exists(void) { return false; }
> +#endif
>
> struct hv_ring_buffer_debug_info {
> 	u32 current_interrupt_mask;
> -- 
> 2.25.1
>

Thank you!

Reviewed-by: Jork Loeser <jloeser@linux.microsoft.com>


