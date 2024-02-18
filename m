Return-Path: <linux-hyperv+bounces-1562-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3A885953A
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB2E1F21A52
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132936FC6;
	Sun, 18 Feb 2024 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tw/WcLpO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D49C6AB6;
	Sun, 18 Feb 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708240649; cv=none; b=m+JwSNPiYsJpmSd0Kw1YGcPQrcloBtfJKcUvegU/BTYa75jFZHl6DLUP+mfct8UX4EuotYodbFxV7+j6ETUMFNMRbaGibJKUP5/hj8EMm7kiqBWu+Hj3E7bidGurfmQqfjkE2fk9UdZg7LY8ZwhqsmIb4WN3eYj3Lu5+IGLY9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708240649; c=relaxed/simple;
	bh=L8J8eACUalCEgWfWQBJioE9GrIGkLHOWAjSReQo7yno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDmUa5VAJ18D+J9FoaJJtlhrKMpaGJABh6JPljn8vwWzOQswKd6EddcssjSbCfiNaHpjlLY+vC5nqaRv7/fFyCuNoSZwXBkCkGLlNV4JXdOgRNpgVdmwK1+STeoBwlEAJmIo2xMDgakGQLXR9U/v/3jlQ/SQC35CqgfR6X9Cqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tw/WcLpO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 14DBD207FD52; Sat, 17 Feb 2024 23:17:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14DBD207FD52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708240647;
	bh=LdaRdWmbMEnotmV1b8TIw7ZbnOCT9R2Ck+eYzZcx9yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tw/WcLpOgOgsqKMYW8B9Z0rVL+yc6O9z4tzrAYZ0O+wLfRB2vItaUYprFVAMGq7GZ
	 T05UzsXYQyQc43pnh4S8BTryrfLu672uh1Lx+V2N3xFJObaxePy8vGhBKPv23rGCpE
	 T4XacBWdPs4Re/ly3hJzabQC0Stch9p7ckEsUrkw=
Date: Sat, 17 Feb 2024 23:17:27 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: Kconfig: select CPUMASK_OFFSTACK for Hyper-V
Message-ID: <20240218071727.GA19702@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1708092603-14504-1-git-send-email-ssengar@linux.microsoft.com>
 <SN6PR02MB415758508A7BE89E0CFBD976D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415758508A7BE89E0CFBD976D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Feb 17, 2024 at 04:46:04PM +0000, Michael Kelley wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, February 16, 2024 6:10 AM
> > To: kys@microsoft.com; haiyangz@microsoft.com; wei.liu@kernel.org;
> > decui@microsoft.com; linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: ssengar@microsoft.com
> > Subject: [PATCH] Drivers: hv: Kconfig: select CPUMASK_OFFSTACK for Hyper-V
> > 
> > CPUMASK_OFFSTACK must be set to have NR_CPUS_RANGE_END value greater than
> > 512, which eventually allows NR_CPUS > 512.
> > 
> > CPUMASK_OFFSTACK can also be enabled by setting MAXSMP=y, but that will
> > set NR_CPUS=8192. This is not accurate for Hyper-V, because maximum number
> > of vCPU supported by Hyper-V today is 2048. Thus, enabling MAXSMP increase
> > the vmlinux size unnecessary.
> 
> Note that these statements apply only to x86.  arm64 doesn't have MAXSMP
> or NR_CPUS_RANGE_END.
> 
> > 
> > This option allows NR_CPUS=2048 which saves around 1MB of vmlinux size
> > for Hyper-V.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 0024210..bc3f496 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -9,6 +9,7 @@ config HYPERV
> >  	select PARAVIRT
> >  	select X86_HV_CALLBACK_VECTOR if X86
> >  	select OF_EARLY_FLATTREE if OF
> > +	select CPUMASK_OFFSTACK
> >  	help
> >  	  Select this option to run Linux as a Hyper-V client operating
> >  	  system.
> > --
> > 1.8.3.1
> > 
> 
> I'm not sure that enabling CPUMASK_OFFSTACK for Hyper-V
> guests is the right thing to do, as there's additional runtime
> cost when CPUMASK_OFFSTACK is enabled.  I agree that for
> the most general case, you want NR_CPUS to be 2048, which
> requires CPUMASK_OFFSTACK.  But it would be legitimate to
> build a kernel with NR_CPUS set to something like 64 or 256
> for a more limited Hyper-V guest use case, and to not want to
> incur the cost of CPUMASK_OFFSTACK.
> 
> You could consider doing something like this:
> 
> 	select CPUMASK_OFFSTACK if NR_CPUS > 512

Thanks for your review.

This was my first thought as well, but for x86, NR_CPUS itself depends
on CPUMASK_OFFSTACK and this creates some kind of circular dependency
and doesn't work effectively.

Here are few key points to note:

1. In ARM64 as well for enabling CPUMASK_OFFSTACK we need to enable
   DEBUG_PER_CPU_MAPS and that will have additional overhead.
   This dependency is for all the archs. There was an earlier attempt
   to decouple it: https://lore.kernel.org/lkml/20220412231508.32629-2-libo.chen@oracle.com/
   
2. However, for ARM64, NR_CPUS doesn't have dependency on CPUMASK_OFFSTACK.
   In ARM64 NR_CPUS is quite independent from any policy, we can choose any
   value for NR_CPUS freely, things are simple. This problem specificaly
   to be solved for x86.

3. If we have to select more then 512 CPUs on x86, CPUMASK_OFFSTACK
   needto be enabled, so this additional runtime cost is unavoidable
   for NR_CPUS > 512. There is no way today to enable CPUMASK_OFFSTACK
   apart from enabling MAXSMP or DEBUG_PER_CPU_MAPS. Both of these
   options we don't want to use.
   
I agree that we possibly don't want to enable this option for HyperV VMs
where NR_CPUS < 512. I have two thoughts here:

1. Enable it only for VTL platforms, as current requirement for minimal kernel
   is only for VTL platforms only.

2. Fix this for all of x86. I couldn't find any reson why CPUMASK_OFFSTACK
   dependency is there on x86 for having more than 512 CPUs. What is special
   in x86 to have this restriction ? If there is no reason we should relax
   the restriction of CPUMASK_OFFSTACK for NR_CPUs similar to ARM and other
   archs.

- Saurabh

> 
> But kernel builders always have the option of explicitly
> enabling CPUMASK_OFFSTACK.  That's what I see in the distro
> vendor arm64 images in Azure, since there's currently nothing
> that automatically selects CPUMASK_OFFSTACK for arm64.
> So I'm wondering if selecting CPUMASK_OFFSTACK under
> HYPERV should be added at all.  The two aren't really related.
> 
> There are recent LKML threads on enabling CPUMASK_OFFSTACK
> for arm64 -- see links below for some useful discussion of the
> topic in general.
> 
> Michael
> 
> [1] https://lore.kernel.org/lkml/794a1211-630b-3ee5-55a3-c06f10df1490@linux.com/
> [2] https://lore.kernel.org/lkml/7ab6660e-e69f-a64b-0de3-b8dde14f79fa@linux.com/
> [3] https://lore.kernel.org/lkml/e0d41efb-a74e-6bb5-f325-63d42358c802@gentwo.org/

