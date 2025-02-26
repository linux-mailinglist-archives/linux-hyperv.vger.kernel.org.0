Return-Path: <linux-hyperv+bounces-4052-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD8DA465A4
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2025 16:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AAFC7ABA87
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2025 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676D621CC56;
	Wed, 26 Feb 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YU7xe1AF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A35021E0AA
	for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584974; cv=none; b=TV6gZ15nwBgWzZoAhQpbR7BuNWahFmf6lxWK+0j4dnjxVyzI4PHQglZdQ9ewE2i3bKgGem/yJqh8PZya2ugHhS+fo2LVk8E8awLzWqdeBu433lP5o73gbuBzxuYx0k46G9QiO1PcWJmhQpTwgv1K0OhtMO1JcYkBVXNpPmoJEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584974; c=relaxed/simple;
	bh=n9sfwMLjqZKr8H/DBdrE0eiQovz4JNiyMotXUT2Uvjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwynbEjfKHJaNIl+7KtwtaYlID9+UcAK+E0CzabajE2Pa1b2BN0PnvFw/2KQUBpp5dBxidyaSyeHFv0DFFUfS5Lt7H4OyvW+Cgnq6q9U/HT2aBpzfzKCZ7BgIWzBDHSUPttowOanzyQRqtFqxr4PtM44ptaqPayCjj+d+Ud1MMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YU7xe1AF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so61410555e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 07:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740584969; x=1741189769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0p0n/HvVMpkGcsOceJadWdw3uKxq8oQ66r+vg7p98B4=;
        b=YU7xe1AF+mIIRE7HEzTv/xqfgG3daQ37STLk0+GSYkYg5cHt4hw5iGQ91J1s+f+/0B
         Bo/RzLGkB5EvQtsml+u54+dLeCStLnhdzvlC8aeQBBQMYdWwNuAXtdU2KItZRtD6IX8Q
         SFVz2bkymusgV+/ggXZxf+8p6Gi4kAnialYcFKMp1YQMnxhPra4gSugoceRexIJZDGGl
         8WX+ThWR32eP+CmdjRDEDDBVlhYPOSpOpmXsG+QwzFQuyInlz5q6+PFLG34iuw7jrGeb
         E4EE3avW1e1Z7wiKOz4cEKtg2CRAYVIjOr4kbgOHBKw3ph/SdOqZS2HMcnuYZ1aK/hZG
         tdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584969; x=1741189769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p0n/HvVMpkGcsOceJadWdw3uKxq8oQ66r+vg7p98B4=;
        b=gZKe/zV3ahLGvatI6g+IbD3LjJ+F1ZoNTyTrpm4xLM2fE1drW947Xv9rPT/vmeJqC6
         GmAq+YbwyXPAPHvuueBTEqXCWFIY6RTCfgIybUDuUEOCGcAO2lSC0roXuyRp28azlW4k
         /cHCFmMOp1R1krq8RuhRZFzndHRlKbmrq912TeZ0MWSPsiVrBWepHs2TK0s2W3b4fkOL
         qj/5aiXXRU+m1lfVKA3Kfz7FpyYAoxaWEr1mmFC4Gybacgqy1zVZtDGMKtNSj6VHYt69
         5UIaT9Que1J0bylyy2U4XQ69suS2IEib1uCW26czfUvqNBHg6tgT28ANCJthGyjispID
         +m0w==
X-Forwarded-Encrypted: i=1; AJvYcCVZRZ8igCuSmEmyrFIpQjfFNG+KGTilNr5k/7i5+DSvUqjtxRaGOjacAB62xx0DlUQqR8eAOQRmmbQXkZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MqJn26lCaiBaKZ/GGnMv6LP8JOv4rsr4QV/osCC7rNgAsRWq
	JILjwsceiXjEyoqbgOgxfQL3qSQL0vNrhUujS6TCqYiKmG+tM1b3amvttHuZDc45+nC/U/egHmt
	b
X-Gm-Gg: ASbGnctCdad5GX7Oi155iV4UA/4Pis1X4ou9aRhqh1M/4U7KVx6qO6WIgP2HwxFbSJ0
	pNtPERYHaqiazaOzdc1hywRH6Lt36+tMXpbZk613Zla/SB1LD/yIxb2uXTKvTonjZQBYJLvAqxE
	oc3VtxEsiBrG9/q4frXnKUVS6GeI3VPXkYoXqxGDgluQIYaYU92I70UH+uUeaHsExESz5ou6pml
	VCbhtCpDaVu1vKSymU5/3cp/D8SkcSFVZze1CMRl5m0+9arnkDOphLQVTlKt+//zIA1kyhjt83g
	jyOUq6DclCFJ5Z361sqmWOjmx3QW
X-Google-Smtp-Source: AGHT+IFrDL1uk86PVoF2mj9jbYVArsum6vONC+I6iG2Yc+eitETSemITRmSloxxMANxWuwoKDv84Ng==
X-Received: by 2002:a05:600c:4506:b0:439:6e12:fdb4 with SMTP id 5b1f17b1804b1-43ab8fe90camr40816605e9.14.1740584969299;
        Wed, 26 Feb 2025 07:49:29 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532d33sm25750165e9.15.2025.02.26.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:49:28 -0800 (PST)
Date: Wed, 26 Feb 2025 16:49:26 +0100
From: Petr Mladek <pmladek@suse.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: hamzamahfooz@linux.microsoft.com, akpm@linux-foundation.org,
	bhe@redhat.com, decui@microsoft.com, gregkh@linuxfoundation.org,
	haiyangz@microsoft.com, jani.nikula@intel.com, jfalempe@redhat.com,
	joel.granados@kernel.org, john.ogness@linutronix.de,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org
Subject: Re: [PATCH RFC] panic: call panic handlers before
 panic_other_cpus_shutdown()
Message-ID: <Z784BiUZohADyoOW@pathway.suse.cz>
References: <Z7juu2YMiVfYm7ZM@hm-sls2>
 <20250222054405.298294-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222054405.298294-1-ryotkkr98@gmail.com>

On Sat 2025-02-22 14:44:05, Ryo Takakura wrote:
> On Fri, 21 Feb 2025 16:23:07 -0500, Hamza Mahfooz wrote:
> >On Fri, Feb 21, 2025 at 11:23:28AM +0900, Ryo Takakura wrote:
> >> On Thu, 20 Feb 2025 17:53:00 -0500, Hamza Mahfooz wrote:
> >> >Since, the panic handlers may require certain cpus to be online to panic
> >> >gracefully, we should call them before turning off SMP. Without this
> >> >re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
> >> >vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
> >> >is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
> >> >crash_smp_send_stop() before the vmbus channel can be deconstructed.
> >> >
> >> So maybe panic_other_cpus_shutdown() should be palced after 
> >> atomic_notifier_call_chain() along with printk_legacy_allow_panic_sync()
> >> like below?
> >> 
> >> ----- BEGIN -----
> >> diff --git a/kernel/panic.c b/kernel/panic.c
> >> index d8635d5cecb2..7ac40e85ee27 100644
> >> --- a/kernel/panic.c
> >> +++ b/kernel/panic.c
> >> @@ -372,16 +372,16 @@ void panic(const char *fmt, ...)
> >>         if (!_crash_kexec_post_notifiers)
> >>                 __crash_kexec(NULL);
> >> 
> >> -       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> >> -
> >> -       printk_legacy_allow_panic_sync();
> >> -
> >>         /*
> >>          * Run any panic handlers, including those that might need to
> >>          * add information to the kmsg dump output.
> >>          */
> >>         atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >> 
> >> +       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> >> +
> >> +       printk_legacy_allow_panic_sync();
> >> 
> >>         panic_print_sys_info(false);
> >> 
> >>         kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> >> ----- END -----
> >
> >Ya, that looks fine to me, that's actually how I had it initally, but I
> >wasn't sure if it had to go before the panic handlers. So, I erred on
> >the side of caution.

The ordering (stopping CPUs before allowing printk_legacy loop)
is important from the printk POV. So, keep it, please.


> I see, sorry that I was only speaking in relation to stored backtraces.
> It seems that printk_legacy_allow_panic_sync() is placed before 
> atomic_notifier_call_chain() so that it can handle flushing before calling
> any panic handlers as described [0].

> [0] https://lore.kernel.org/lkml/ZeHSgZs9I3Ihvpye@alley/

> I'm not really familar with the problems associated with panic handlers
> so I hope maybe John and Petr can help on this matter...

Honestly, I do not have much experience with failures of the panic
notifiers. But I saw a patchset which tried to add filtering of
some problematic ones, see
https://lore.kernel.org/lkml/20220108153451.195121-1-gpiccoli@igalia.com/

I did not like the way of ad-hoc filtering. The right solution was to
fix the problematic notifiers.

Anyway, it went out that the situation was not that easy. The notifiers
do various things. Some of them just printing extra information. Others
stopped or suspended some devices or services. Some should be called
before and some after crash_dump.

The outcome was a monster-patchset which tried to fix some problematic
notifiers and split them into more notifier chains, see
https://lore.kernel.org/all/20220427224924.592546-1-gpiccoli@igalia.com/

Some of the fixes were accepted but the split has never been done.


My opinion:

1. The best solution would be to make the problematic notifier working
   with stopped CPUs. The discussion around [v2] suggests that the author
   made it working at least for x86_64, see
   https://lore.kernel.org/r/20250221213055.133849-1-hamzamahfooz@linux.microsoft.com


2. Another good solution might be to do the split of the notifier
   chain, for an example, see
   https://lore.kernel.org/lkml/Yn0TnsWVxCcdB2yO@alley/

   The problematic notifier can be then added into a chain which
   is called before stopping CPUs.


3. In the worst case, you could change the ordering as proposed above.
   I am just afraid that it might bring in new problems. There might
   be notifiers which were not tested with more running CPUs...


In general, the system is in an unpredictable state when panic() is
called. Notifiers should not expect that non-panic CPUs will be
able to handle any requests.

Also it looks like a good idea to stop non-panic CPUs as soon as possible.
Otherwise, they might create more harm than good.

Best Regards,
Petr

