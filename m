Return-Path: <linux-hyperv+bounces-11254-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCxrFDtOF2r7AAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11254-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:04:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC5D5E9DDD
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F2CA3073718
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1AC3B19D1;
	Wed, 27 May 2026 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IuZHBjAi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397236164D;
	Wed, 27 May 2026 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911835; cv=none; b=jxpxgAXo/XxhAA6jufnlXFE3Rv7Tuza0L6VZWE8Pfu2O48/L2jrwspn7ojPZB9othxlqp2B0AcByc5s9gjfyOuJ5XuYvIykCMP1/46mneC6Lf3NXa0C5brG5bVCrPsnWRmbuTFzdTNI9oGGgzQahgZ5YtL3D1YBLV4x4ihTC/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911835; c=relaxed/simple;
	bh=V/IZ+dlQw8HbtISOjh0jYowq37bg2bf44XmeV23eMqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1Udshu5LuTTRBOShlc+JwkqRlM7YATM7nIsnGZ+jY5lw236tzqd2qOThgJ6nkgCdjKtp0A4DXLjGAgvKZ2tdsn3gbEnzkrMpi72Odl6T2MKJqCsG2L5k7Y+L5Qv4rvjBgIlEkawEWXGKuAUHAW3mLlfUcxkDVfG9wCrAaK64zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IuZHBjAi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.217.2] (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 847AC20B7169;
	Wed, 27 May 2026 12:57:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 847AC20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779911822;
	bh=gjryDlrN7Gpzw0+ElyfVCmfagySTCO/jGQTXKd+CZtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IuZHBjAiMIsXTd3K8LC1qP4Ga7pbVna8xI1Xhsm8QWqF+9cjXzGmmb4PGg21c/8fU
	 MsFKMXkJ4Ace6KpdMlk0F4KvCNfPu1Y8hJJlUT+nz4kXhk69mHD2rNg8xXQX7xjryr
	 2TUl2P/gPcRjpB71nJxLAe1RgOkdGL8hkyMJnNjc=
Message-ID: <cef8f530-f523-41dd-9e67-99763f623076@linux.microsoft.com>
Date: Wed, 27 May 2026 12:57:12 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mshv: Add conditional VMBus dependency
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 jloeser@linux.microsoft.com, linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de,
 hamzamahfooz@linux.microsoft.com
References: <20260526141304.3924-1-mhklkml@zohomail.com>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <20260526141304.3924-1-mhklkml@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-11254-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hargar@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,arndb.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Queue-Id: 9CC5D5E9DDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/2026 7:13 AM, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When the VMBus driver is not part of the kernel (CONFIG_HYPERV_VMBUS=n),
> the MSHV root driver fails to link:
> 
> ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!
> 
> Fix this while meeting these requirements:
> * It must be possible to include the MSHV root driver without the
>   VMBus driver. In such case, the MSHV root driver can be built-in
>   to the kernel image, or it can be built as a separate module.
> * If both the MSHV root driver and the VMBus driver are present, the
>   MSHV root driver and VMBus driver can both be built-in, or they can
>   both be separate modules. Or the MSHV root driver can be a module
>   while the VMBus driver can be built-in, but the reverse is
>   disallowed. Regardless of the build choices, the VMBus driver must
>   be loaded before the MSHV driver in order for the SynIC to be
>   managed properly (see comments in the MSHV SynIC code).
> 
> The fix has two parts:
> * Add a Kconfig entry for MSHV_ROOT to depend on HYPERV_VMBUS if
>   HYPERV_VMBUS is present. The entry disallows MSHV_ROOT being
>   built-in when HYPERV_VMBUS is a module, but without requiring that
>   HYPERV_VMBUS be built.
> * Add a stub implementation of hv_vmbus_exists() for when the
>   VMBus driver is not present so that the MSHV root driver has
>   no module dependency on VMBus. When the VMBus driver *is*
>   present, the module dependency ensures that the VMBus driver
>   loads first when both are built as modules.
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
>   the two calls to hv_vmbus_exists() in mshv_synic.c, provide a stub
>   for hv_vmbus_exists() when CONFIG_HYPERV_VMBUS is not set. The
>   effect is the same as in v1, but the code is cleaner. [Jork Loeser]
> 
> Arnd: I've kept your Ack even though I changed how hv_vmbus_exists()
> is stubbed out since the effect is the same. Let me know if
> you have any concerns.
> 
>  drivers/hv/Kconfig     | 1 +
>  include/linux/hyperv.h | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 2d0b3fcb0ff8..aa11bcefddf2 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -74,6 +74,7 @@ config MSHV_ROOT
>  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>  	# no particular order, making it impossible to reassemble larger pages
>  	depends on PAGE_SIZE_4KB
> +	depends on HYPERV_VMBUS if HYPERV_VMBUS
>  	select EVENTFD
>  	select VIRT_XFER_TO_GUEST_WORK
>  	select HMM_MIRROR
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 41a3d82f0722..734b7ef98f4d 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1304,7 +1304,11 @@ static inline void *hv_get_drvdata(struct hv_device *dev)
>  
>  struct device *hv_get_vmbus_root_device(void);
>  
> +#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
>  bool hv_vmbus_exists(void);
> +#else
> +static inline bool hv_vmbus_exists(void) { return false; }
> +#endif
>  
>  struct hv_ring_buffer_debug_info {
>  	u32 current_interrupt_mask;

Reviewed-by: Hardik Garg <hargar@linux.microsoft.com>



Thanks,
Hardik

