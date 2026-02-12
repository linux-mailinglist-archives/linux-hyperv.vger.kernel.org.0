Return-Path: <linux-hyperv+bounces-8796-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAFQEVJQjml4BgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8796-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 23:12:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57C131790
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 23:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 292183012217
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F11D35DD19;
	Thu, 12 Feb 2026 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gq8WHvem"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C535B130;
	Thu, 12 Feb 2026 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770934352; cv=none; b=LCT4WapQzDfr3/EXN+WRjZG2CUenZ8PE/HuynhHo4gZ9fxOGqg9ARvd0Xm/QW/Q6+WS8OR1yMiYpbs6ykDdpxdhp4H4Jlno40GmoES435aXWc99IufQB7m3T/YJqlpy9L+q9V/XARvZvJpN0VtHhGVMFTuwQioaErGQBfXqiP58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770934352; c=relaxed/simple;
	bh=TdDlUCAwUTSp8mtHBMlPNvufZ057pZO4PUfaUxDFvww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMzN1XFMGjJeDOUy9HUx4wvgpOeJxNM1Jn625OowJr0s+0paCd2J6SfYlQpygSX4gaoQQB+aMUoLwphjazVbIDjmhHppf/cve0OEikTjWen0Q+bdb1KTb9tkLT4yP+TTHCcsacYfsplxQU4oj9KWoeH6qVMSnFzSP6jxvpdvMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gq8WHvem; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id DCE0220B7167;
	Thu, 12 Feb 2026 14:12:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCE0220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770934350;
	bh=eMu5gM+7OCyBS0hUDhGp2mJQZR4sgj4kzgGvyMhqUdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gq8WHvem2vqIRkO6kZVc5+1qQngR2Hp8hsLZVZh0cl2ETgiI+xBKN/TRhkay36ttB
	 basHTkzMfJAYVGt71D5PGwmh4BStk+ZG70JTPBpa735L5I82AU+ydJQ/T9ZjrNsc97
	 pTmlCtk/nOBsGDNI/0wuTdc352GZfFhPoVDJRSBQ=
Message-ID: <fb651abf-0546-3bef-bf8f-597f35ddc0d6@linux.microsoft.com>
Date: Thu, 12 Feb 2026 14:12:29 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] kexec: Add permission notifier chain for kexec
 operations
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176962212169.85424.4683391728440118017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <176962212169.85424.4683391728440118017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8796-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: DC57C131790
X-Rspamd-Action: no action

On 1/28/26 09:42, Stanislav Kinsburskii wrote:
> Add a blocking notifier chain to allow subsystems to be notified
> before kexec execution. This enables modules to perform necessary
> cleanup or validation before the system transitions to a new kernel or
> block kexec if not possible under current conditions.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   include/linux/kexec.h |    6 ++++++
>   kernel/kexec_core.c   |   24 ++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ff7e231b0485..311037d30f9e 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -35,6 +35,7 @@ extern note_buf_t __percpu *crash_notes;
>   #include <linux/ioport.h>
>   #include <linux/module.h>
>   #include <linux/highmem.h>
> +#include <linux/notifier.h>
>   #include <asm/kexec.h>
>   #include <linux/crash_core.h>
>   
> @@ -532,10 +533,13 @@ extern bool kexec_file_dbg_print;
>   
>   extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
>   extern void kimage_unmap_segment(void *buffer);
> +extern int kexec_block_notifier_register(struct notifier_block *nb);
> +extern int kexec_block_notifier_unregister(struct notifier_block *nb);
>   #else /* !CONFIG_KEXEC_CORE */
>   struct pt_regs;
>   struct task_struct;
>   struct kimage;
> +struct notifier_block;
>   static inline void __crash_kexec(struct pt_regs *regs) { }
>   static inline void crash_kexec(struct pt_regs *regs) { }
>   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
> @@ -543,6 +547,8 @@ static inline int kexec_crash_loaded(void) { return 0; }
>   static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
>   { return NULL; }
>   static inline void kimage_unmap_segment(void *buffer) { }
> +static inline int kexec_block_notifier_register(struct notifier_block *nb) { }
> +static inline int kexec_block_notifier_unregister(struct notifier_block *nb) { }
>   #define kexec_in_progress false
>   #endif /* CONFIG_KEXEC_CORE */
>   
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 0f92acdd354d..1e86a6f175f0 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -57,6 +57,20 @@ bool kexec_in_progress = false;
>   
>   bool kexec_file_dbg_print;
>   
> +static BLOCKING_NOTIFIER_HEAD(kexec_block_list);
> +
> +int kexec_block_notifier_register(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&kexec_block_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(kexec_block_notifier_register);
> +
> +int kexec_block_notifier_unregister(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&kexec_block_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(kexec_block_notifier_unregister);
> +
>   /*
>    * When kexec transitions to the new kernel there is a one-to-one
>    * mapping between physical and virtual addresses.  On processors
> @@ -1124,6 +1138,12 @@ bool kexec_load_permitted(int kexec_image_type)
>   	return true;
>   }
>   
> +static int kexec_check_blockers(void)
> +{
> +	/* Notify subsystems of impending kexec */
> +	return blocking_notifier_call_chain(&kexec_block_list, 0, NULL);
> +}
> +
>   /*
>    * Move into place and start executing a preloaded standalone
>    * executable.  If nothing was preloaded return an error.
> @@ -1139,6 +1159,10 @@ int kernel_kexec(void)
>   		goto Unlock;
>   	}
>   
> +	error = kexec_check_blockers();

This could take a long time, and I am not sure if it's a good idea
to stall kexec with such dependencies.

Thanks,
-Mukesh


> +	if (error)
> +		goto Unlock;
> +
>   	error = liveupdate_reboot();
>   	if (error)
>   		goto Unlock;
> 
> 


