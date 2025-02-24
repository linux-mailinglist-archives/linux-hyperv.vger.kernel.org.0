Return-Path: <linux-hyperv+bounces-4030-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C911BA4249D
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 15:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CCA17B77D
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066ED233720;
	Mon, 24 Feb 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AC6owz5h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DFB1B7F4;
	Mon, 24 Feb 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408519; cv=none; b=mXLZU5QrnT2cfSCyRrlU1IGA4Y+L3rAknV10oroPXyLuXIheAIqcvrCtFlGTu+kkl9DSn9D0xCZ4Mn/sv6oYNkgfhWCSlS9GfcNKaeu3CY21q8eiuyKZ4hT4FUn/+3W9IdtAAVo5w5p/SRUhHPwI+1MPfn0qXdpT+E4Ped+GVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408519; c=relaxed/simple;
	bh=v/i5uNRdv0lKpzjbyVJ/rUwzfVKBkuvu3O1tyNM6WNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNDyMO+z3a7/ftVHNxVbCE6dR48RS6RjXZ6Y8j/L/TWOfRWL8pYy6NKiP4s7PMHqInaFyDn+AzvCYrqhZlbawoyNlAA9jRoHjUhVJhy+S3m9uPhW8eno8bYDmJkn8x3dy6KO7qieOQ8UVY3vzu/8f91p0J2B26ra4P5SYSDlTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AC6owz5h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2 (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id DD8B820DF168;
	Mon, 24 Feb 2025 06:48:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD8B820DF168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740408517;
	bh=B1XHtWIka4rmClyLQc4wAzTbA5a3eeqHQdnViUvy9kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AC6owz5hIgwCPb/60nWWp31kDbFvEMfSDHte5zvyQRfTgZMDJHuNmzUljmeb+nLDA
	 FeQz/TFArAmXS8P0SEHyiUc6Lo6UXsG12TY5ts1QefxVqUTJ39MP20TK0DtehvwNRV
	 MGXB81NfmVdlb15/rzikXrH6f2gJYKgttsm877EY=
Date: Mon, 24 Feb 2025 09:48:31 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jani Nikula <jani.nikula@intel.com>, Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: Re: [PATCH v2] panic: call panic handlers before
 panic_other_cpus_shutdown()
Message-ID: <Z7yGv_ZyeyUueXLz@hm-sls2>
References: <20250221213055.133849-1-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB4157D993CCE04F2D46E2B8A1D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157D993CCE04F2D46E2B8A1D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Feb 21, 2025 at 11:01:09PM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, February 21, 2025 1:31 PM
> > 
> > Since, the panic handlers may require certain cpus to be online to panic
> > gracefully, we should call them before turning off SMP. Without this
> > re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
> > vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
> > is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
> > crash_smp_send_stop() before the vmbus channel can be deconstructed.
> 
> Hamza -- what specifically is the problem with the way vmbus_wait_for_unload()
> works today? That code is aware of the problem that the unload response comes
> only on the VMBUS_CONNECT_CPU, and that cpu may not be able to handle
> the interrupt. So the code polls the message page of each CPU to try to get the
> unload response message. Is there a scenario where that approach isn't working?
> 

It doesn't work on arm64 (if the crashing cpu isn't VMBUS_CONNECT_CPU), it
always ends up at "VMBus UNLOAD did not complete" without fail. It seems
like arm64's crash_smp_send_stop() is more aggressive than x86's.

> Note also that Hyper-V itself can take a long time (10's of seconds) to respond
> to the unload request. See the comments in vmbus_wait_for_unload() about
> flushing the Azure host disk cache. I worked on this code and did the
> measurements, so I have some familiarity with the problems. :-)
> 
> Michael
> 
> > 
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> > v2: keep printk_legacy_allow_panic_sync() after
> >     panic_other_cpus_shutdown().
> > ---
> >  kernel/panic.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index fbc59b3b64d0..433cf651e213 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -372,16 +372,16 @@ void panic(const char *fmt, ...)
> >  	if (!_crash_kexec_post_notifiers)
> >  		__crash_kexec(NULL);
> > 
> > -	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> > -
> > -	printk_legacy_allow_panic_sync();
> > -
> >  	/*
> >  	 * Run any panic handlers, including those that might need to
> >  	 * add information to the kmsg dump output.
> >  	 */
> >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> > 
> > +	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
> > +
> > +	printk_legacy_allow_panic_sync();
> > +
> >  	panic_print_sys_info(false);
> > 
> >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> > --
> > 2.47.1
> > 
> 

