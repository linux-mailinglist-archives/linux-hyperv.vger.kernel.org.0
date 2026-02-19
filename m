Return-Path: <linux-hyperv+bounces-8920-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TYa8DRiLl2n/0AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8920-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 23:13:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B188F1630C6
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 23:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E12F63007B8C
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98BE2DB79E;
	Thu, 19 Feb 2026 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VUYs7JSP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEAB1DE3B5;
	Thu, 19 Feb 2026 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539221; cv=none; b=QXyRzu3i6/2s08yo4qLFTxzkFlpQm4yQyXiK6JRXiE//k4+OqllBC7ztNHKOK2Q0waitlKDhCQEcAVTUtWvkQKaHfhB9kOThcWWSGd7LdSf4bfsinKJfkAsFtTXdWv4lqPDJxasD0QFdw77/sVHeQeDJRZQHx5vVrOOUViuOXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539221; c=relaxed/simple;
	bh=nRYEQTF5vOMcDcP+/k8TMMaUvzFxWiLcQmmzlYDa3Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbYg3aFDgaXYqtdeSsH0cA8LKdQSSOjrTsNLZ0mvIwRA5EqoskiIeRvzqorrxKIBSgpxsdZcJO5tfaBicMuhNtnObQHNkIkw94opC8QVtGRANYjs24LZJBlCLF2WreW4r1r7/M6ejk5vmfxV1lrTY5Vk3cPAujqEeQRgsK312KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VUYs7JSP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id A537B20B6F00;
	Thu, 19 Feb 2026 14:13:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A537B20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771539220;
	bh=alc86/6tZez+jJ4pB8akwxTAsV8UqLXdKg2TaieKjWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUYs7JSPF4TPiElOtjdBVx6EpHxPNorxgQOJUCDSAN94GWrSaf7YiiIrXSlG15BPU
	 3Ikn6YUKufJsRrwYGAZvbVAVTwHjSMgglU+b8AVsCbqOYL1iy4QU0NpAF2wH7FDZtP
	 3AjLaHQIXa0/vmmbAEm80MycYWhs0MVn7Fmi7kak=
Date: Thu, 19 Feb 2026 14:13:37 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kexec: Add permission notifier chain for kexec
 operations
Message-ID: <aZeLEZ3SlLmf9aS-@skinsburskii.localdomain>
References: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176962212169.85424.4683391728440118017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <fb651abf-0546-3bef-bf8f-597f35ddc0d6@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb651abf-0546-3bef-bf8f-597f35ddc0d6@linux.microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-8920-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B188F1630C6
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 02:12:29PM -0800, Mukesh R wrote:
> On 1/28/26 09:42, Stanislav Kinsburskii wrote:
> > Add a blocking notifier chain to allow subsystems to be notified
> > before kexec execution. This enables modules to perform necessary
> > cleanup or validation before the system transitions to a new kernel or
> > block kexec if not possible under current conditions.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >   include/linux/kexec.h |    6 ++++++
> >   kernel/kexec_core.c   |   24 ++++++++++++++++++++++++
> >   2 files changed, 30 insertions(+)
> > 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index ff7e231b0485..311037d30f9e 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -35,6 +35,7 @@ extern note_buf_t __percpu *crash_notes;
> >   #include <linux/ioport.h>
> >   #include <linux/module.h>
> >   #include <linux/highmem.h>
> > +#include <linux/notifier.h>
> >   #include <asm/kexec.h>
> >   #include <linux/crash_core.h>
> > @@ -532,10 +533,13 @@ extern bool kexec_file_dbg_print;
> >   extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> >   extern void kimage_unmap_segment(void *buffer);
> > +extern int kexec_block_notifier_register(struct notifier_block *nb);
> > +extern int kexec_block_notifier_unregister(struct notifier_block *nb);
> >   #else /* !CONFIG_KEXEC_CORE */
> >   struct pt_regs;
> >   struct task_struct;
> >   struct kimage;
> > +struct notifier_block;
> >   static inline void __crash_kexec(struct pt_regs *regs) { }
> >   static inline void crash_kexec(struct pt_regs *regs) { }
> >   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
> > @@ -543,6 +547,8 @@ static inline int kexec_crash_loaded(void) { return 0; }
> >   static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> >   { return NULL; }
> >   static inline void kimage_unmap_segment(void *buffer) { }
> > +static inline int kexec_block_notifier_register(struct notifier_block *nb) { }
> > +static inline int kexec_block_notifier_unregister(struct notifier_block *nb) { }
> >   #define kexec_in_progress false
> >   #endif /* CONFIG_KEXEC_CORE */
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 0f92acdd354d..1e86a6f175f0 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -57,6 +57,20 @@ bool kexec_in_progress = false;
> >   bool kexec_file_dbg_print;
> > +static BLOCKING_NOTIFIER_HEAD(kexec_block_list);
> > +
> > +int kexec_block_notifier_register(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&kexec_block_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(kexec_block_notifier_register);
> > +
> > +int kexec_block_notifier_unregister(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_unregister(&kexec_block_list, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(kexec_block_notifier_unregister);
> > +
> >   /*
> >    * When kexec transitions to the new kernel there is a one-to-one
> >    * mapping between physical and virtual addresses.  On processors
> > @@ -1124,6 +1138,12 @@ bool kexec_load_permitted(int kexec_image_type)
> >   	return true;
> >   }
> > +static int kexec_check_blockers(void)
> > +{
> > +	/* Notify subsystems of impending kexec */
> > +	return blocking_notifier_call_chain(&kexec_block_list, 0, NULL);
> > +}
> > +
> >   /*
> >    * Move into place and start executing a preloaded standalone
> >    * executable.  If nothing was preloaded return an error.
> > @@ -1139,6 +1159,10 @@ int kernel_kexec(void)
> >   		goto Unlock;
> >   	}
> > +	error = kexec_check_blockers();
> 
> This could take a long time, and I am not sure if it's a good idea
> to stall kexec with such dependencies.
> 

Whether the call takes time should not matter. liveudpate_reboot()
already introduced the same semantics below.

Thanks,
Stanislav

> Thanks,
> -Mukesh
> 
> 
> > +	if (error)
> > +		goto Unlock;
> > +
> >   	error = liveupdate_reboot();
> >   	if (error)
> >   		goto Unlock;
> > 
> > 
> 

