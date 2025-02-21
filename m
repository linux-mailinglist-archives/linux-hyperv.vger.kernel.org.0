Return-Path: <linux-hyperv+bounces-4019-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90280A401FD
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 22:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B5E422AD2
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 21:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FA20124F;
	Fri, 21 Feb 2025 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LHOk3ztX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFA36AF5;
	Fri, 21 Feb 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173002; cv=none; b=m8dM5N1amzINXTRq5wOviZPt3RQqbFYlIXyXwcSgnS0vh57EtUosqAZ9wr3BGvHLML7fiYtsfkGYOtL+atnrVGo+UYZpr/i7G1MveqnrO/K+8CWbhO18duXctB3kVZsjhIwwZWtCFjFHG+mbcitpNXDCVR6CO8ZZqMqB7PoiKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173002; c=relaxed/simple;
	bh=ZTSuJI4NpA2G+Uhgn5aDFK0ZVKGllwLkSTgD4pjOJ3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzTesjXrOMua/DkXsHL2zUnyFl8aaBQuf9z0IJO8w27K+5dbE22dv0F0itpnLu47qdGOhc36INCa34cmeXM518k/DlA+pFQhBQnp9+QF5FXGwWykaP6zWtNklvV4/iEdOmMmEWXjf38wwgoOl5bBKXHlO2E4Mn6CU1/uvzWvtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LHOk3ztX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2 (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B98F204E5BD;
	Fri, 21 Feb 2025 13:23:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B98F204E5BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740172999;
	bh=cqnvgwsa9KsqqXm7ZC1c0BQtDHXhaxp07maFvW8SBZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHOk3ztXYb8BSdV6NZytHCKh1X23+/yRWSuV7zA6UQ6c4z+LRBYknD0EDMRLdM1bb
	 Xh+o1rO9c5eK2mnHaeTSlIxhh3CzCIDJRaQUOToWaGRMf1eeJjekuP6zn+zBVdEV+J
	 MZCwk922GFjdDndYAB/QaMgaI/iBFcA2zA3OKddw=
Date: Fri, 21 Feb 2025 16:23:07 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, decui@microsoft.com,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com,
	jani.nikula@intel.com, jfalempe@redhat.com,
	joel.granados@kernel.org, john.ogness@linutronix.de,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	pmladek@suse.com, takakura@valinux.co.jp, wei.liu@kernel.org
Subject: Re: [PATCH RFC] panic: call panic handlers before
 panic_other_cpus_shutdown()
Message-ID: <Z7juu2YMiVfYm7ZM@hm-sls2>
References: <20250220225302.195282-1-hamzamahfooz@linux.microsoft.com>
 <20250221022328.47078-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221022328.47078-1-ryotkkr98@gmail.com>

Hey Ryo,

On Fri, Feb 21, 2025 at 11:23:28AM +0900, Ryo Takakura wrote:
> Hi Hamza!
> 
> On Thu, 20 Feb 2025 17:53:00 -0500, Hamza Mahfooz wrote:
> >Since, the panic handlers may require certain cpus to be online to panic
> >gracefully, we should call them before turning off SMP. Without this
> >re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
> >vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
> >is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
> >crash_smp_send_stop() before the vmbus channel can be deconstructed.
> >
> >Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> >---
> > kernel/panic.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/kernel/panic.c b/kernel/panic.c
> >index fbc59b3b64d0..9712a46dfe27 100644
> >--- a/kernel/panic.c
> >+++ b/kernel/panic.c
> >@@ -372,8 +372,6 @@ void panic(const char *fmt, ...)
> > 	if (!_crash_kexec_post_notifiers)
> > 		__crash_kexec(NULL);
> > 
> >-	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> >-
> > 	printk_legacy_allow_panic_sync();
> 
> I think printk_legacy_allow_panic_sync() is placed after 
> panic_other_cpus_shutdown() so that it flushes the stored 
> cpus backtraces as described [0].
> 
> > 	/*
> >@@ -382,6 +380,8 @@ void panic(const char *fmt, ...)
> > 	 */
> > 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> > 
> >+	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> >+
> 
> So maybe panic_other_cpus_shutdown() should be palced after 
> atomic_notifier_call_chain() along with printk_legacy_allow_panic_sync()
> like below?
> 
> ----- BEGIN -----
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d8635d5cecb2..7ac40e85ee27 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -372,16 +372,16 @@ void panic(const char *fmt, ...)
>         if (!_crash_kexec_post_notifiers)
>                 __crash_kexec(NULL);
> 
> -       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> -
> -       printk_legacy_allow_panic_sync();
> -
>         /*
>          * Run any panic handlers, including those that might need to
>          * add information to the kmsg dump output.
>          */
>         atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> 
> +       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> +
> +       printk_legacy_allow_panic_sync();
> +
>         panic_print_sys_info(false);
> 
>         kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> ----- END -----

Ya, that looks fine to me, that's actually how I had it initally, but I
wasn't sure if it had to go before the panic handlers. So, I erred on
the side of caution.

BR,
Hamza

> 
> Sincerely,
> Ryo Takakura
> 
> [0] https://lore.kernel.org/all/20240820063001.36405-30-john.ogness@linutronix.de/

