Return-Path: <linux-hyperv+bounces-2607-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C0493E447
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Jul 2024 11:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7D228180A
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Jul 2024 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707518641;
	Sun, 28 Jul 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OdNwxsji"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D4125C1;
	Sun, 28 Jul 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722158299; cv=none; b=bpEqu9TRp6ZNQKzcEIHCixC6LouYf3fKIiK2nAbwXqeE5owjXWmCOhfMWXXPu1c/7Mh+6j6LqtcrtFWxJfEYK2xwHpfxCju3qEivhzTwdQuSHx2QPUaQu2JEgyVP/2N58TNmpHefRbzLv+H0eSHONriScEG72JBm4ynZKd3PYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722158299; c=relaxed/simple;
	bh=xQHXWrQxuY3LLnbKY2nGQiIQD2o8IM4vB/yw7wpQvjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnLnzrlW9+m+lo1IoPawbHiXmbml68vMaKh3SKRSp9dXVU01mp3ZEiTM5ka+EgHKFrHWd9+EBTi2/pjmb2fgTuLNYNyRcWbFfst2KZRpn969RcQ4p6ufjcf3pMHf/psMgW0iPpI4Y/0ENDH2IHF9CFPmIQYHLSezVLCzmbTsF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OdNwxsji; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 4756520B7165; Sun, 28 Jul 2024 02:18:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4756520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722158291;
	bh=a75jyu3AoxlHbEWm2Z2MjA3HM3NBgZ+DcSO645DH89Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdNwxsjimgsOwLg0hhwzx+fVIx/x3sMMpByOE1qam9Qk0EmVQKA+gEYPHiz+nZ2kN
	 B8NRyRgMoRLcyXP5hWSJzA0j6QqUZ9HNVqwzcIIttIKYTFBRcnS+YIwuEgy8cxNd0Q
	 wvbk8lc7NaeHJ79oQZn8IzRdrIZbM4zoIQ2cZxCM=
Date: Sun, 28 Jul 2024 02:18:11 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>,
	"srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Message-ID: <20240728091811.GA32127@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
 <SN6PR02MB4157BB3FF96D869D87B0A5D2D4B62@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157BB3FF96D869D87B0A5D2D4B62@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Jul 28, 2024 at 04:32:23AM +0000, Michael Kelley wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, July 24, 2024 10:26 PM
> > 
> > Currently on a very large system with 1780 CPUs, hv_acpi_init takes
> > around 3 seconds to complete for all the CPUs. This is because of
> > sequential synic initialization for each CPU.
> > 
> > Defer these tasks so that each CPU executes hv_acpi_init in parallel
> > to take full advantage of multiple CPUs.
> > 
> > This solution saves around 2 seconds of boot time on a 1780 CPU system,
> > that around 66% improvement in the existing logic.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 33 ++++++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index c857dc3975be..3395526ad0d0 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1306,6 +1306,13 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> > 
> > +static void vmbus_percpu_work(struct work_struct *work)
> > +{
> > +	unsigned int cpu = smp_processor_id();
> > +
> > +	hv_synic_init(cpu);
> > +}
> > +
> >  /*
> >   * vmbus_bus_init -Main vmbus driver initialization routine.
> >   *
> > @@ -1316,7 +1323,8 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
> >   */
> >  static int vmbus_bus_init(void)
> >  {
> > -	int ret;
> > +	int ret, cpu;
> > +	struct work_struct __percpu *works;
> > 
> >  	ret = hv_init();
> >  	if (ret != 0) {
> > @@ -1355,12 +1363,31 @@ static int vmbus_bus_init(void)
> >  	if (ret)
> >  		goto err_alloc;
> > 
> > +	works = alloc_percpu(struct work_struct);
> > +	if (!works) {
> > +		ret = -ENOMEM;
> > +		goto err_alloc;
> > +	}
> > +
> >  	/*
> >  	 * Initialize the per-cpu interrupt state and stimer state.
> >  	 * Then connect to the host.
> >  	 */
> > -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
> > -				hv_synic_init, hv_synic_cleanup);
> > +	cpus_read_lock();
> > +	for_each_online_cpu(cpu) {
> > +		struct work_struct *work = per_cpu_ptr(works, cpu);
> > +
> > +		INIT_WORK(work, vmbus_percpu_work);
> > +		schedule_work_on(cpu, work);
> > +	}
> > +
> > +	for_each_online_cpu(cpu)
> > +		flush_work(per_cpu_ptr(works, cpu));
> > +
> > +	ret = __cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online", false,
> > +					     hv_synic_init, hv_synic_cleanup, false);
> 
> I'd suggest using cpuhp_setup_state_nocalls_cpuslocked().  It appears to be
> the interface intended for users outside the cpuhotplug code, whereas
> __cpuhp_setup_state_cpuslocked() should be private to the cpuhotplug code.
>

Thanks for your review.
 
The function cpuhp_setup_state_nocalls_cpuslocked() is commonly used across the kernel
drivers hence it was a first choice for me as well. However, it includes a
cpus_read_lock that we already introduced separately in above code. To avoid recursive
locking, I opted for __cpuhp_setup_state_cpuslocked.

One might argue that unlocking and then calling cpuhp_setup_state_nocalls_cpuslocked
could be a solution, but I am concerned about potential race conditions, as CPUs could
come online during this interval and in such case synic initialization for those CPUs
would be missed.

- Saurabh

