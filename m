Return-Path: <linux-hyperv+bounces-3459-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB339ED44C
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2024 19:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11879188A935
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2024 18:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164BF1DE4C8;
	Wed, 11 Dec 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cZpOFeet"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DE31DE2DF;
	Wed, 11 Dec 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940040; cv=none; b=iEn1g2ciTSxI3NfeW9FLOaGARKTUqUzIZBsyPrtR20wID53IDCqJa6fnBVh9J98b9ZOZ3a8nQSehA9Ewlq36JkuOvzaDpZUwO2E7UGG4CRILsUCAbR9OZYC9miAi4tbiPaA4aywA3HWjnlHNooM+9RPJ5GpH07/ze61oEkRpYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940040; c=relaxed/simple;
	bh=NNbOsGSC//EdeMszMnVRP4wtv265fEiLNJXCoy30Qi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k64zuWHTcqsfr2n1fVSHt0+Y6aTx1bq6XnCCe/XIjnCfwSp4DdU3e/Afu/SGm73dSInZjf/d90hkqaErcdTpEsGNe1wFKM9cwROFU+EsHwMGYDkuz1U5c2XpZMwn+5VIO/esdFLW+bhtLM4+0VB2r5WP1qb3NLVkmQ0yHTRcvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cZpOFeet; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id A17C1204721C;
	Wed, 11 Dec 2024 10:00:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A17C1204721C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733940037;
	bh=b895POQEkPicrgi43bLCfxOD1pFPcie/UcJzv4HRE9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZpOFeetZdSphtj0i+JUmDvk+/LOvQYuHwNjeiF1G1dWb7L9gkvtN/+4GpvucyKVQ
	 MA7gJRr+Z33URkZ4a/aHst+J6S0U3RbWiP+EB/c4r9WU1ID8jHnx4La7DEkjYZTxSz
	 kQ+17XKTcP5gVkr6YOZNdYm8BacasCAzK3L+/D+Y=
Date: Wed, 11 Dec 2024 10:00:35 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
Message-ID: <20241211180035.GA20385@skinsburskii.>
References: <173143547242.3415.16207372030310222687.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB41575A98314B82C498A3D312D4592@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241120005106.GA18115@skinsburskii.>
 <SN6PR02MB4157121B6CD9F5CAAFB39637D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241125222457.GA28630@skinsburskii.>
 <SN6PR02MB4157344DE32DF479543CC2CED42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157344DE32DF479543CC2CED42F2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Nov 26, 2024 at 06:11:10AM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, November 25, 2024 2:25 PM
> > 
> > On Fri, Nov 22, 2024 at 06:33:12PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday,
> > November 19, 2024 4:51 PM
> > > >
> > > > On Tue, Nov 12, 2024 at 07:48:06PM +0000, Michael Kelley wrote:
> > > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday,
> > > > November 12, 2024 10:18 AM
> > > > > >
> > > > > > Enable X86_FEATURE_TSC_RELIABLE by default as X86_FEATURE_TSC_RELIABLE
> > is
> > > > > > independent from invariant TSC and should have never been gated by the
> > > > > > HV_ACCESS_TSC_INVARIANT privilege.
> > > > >
> > > > > I think originally X86_FEATURE_TSC_RELIABLE was gated by the Hyper-V
> > > > > TSC Invariant feature because otherwise VM live migration may cause
> > > > > the TSC value reported by the RDTSC/RDTSCP instruction in the guest
> > > > > to abruptly change frequency and value. In such cases, the TSC isn't
> > > > > useable by the kernel or user space.
> > > > >
> > > > > Enabling the Hyper-V TSC Invariant feature fixes that by using the
> > > > > hardware scaling available in more recent processors to automatically
> > > > > fixup the TSC value returned by RDTSC/RDTSCP in the guest.
> > > > >
> > > > > Is there a practical problem that is fixed by always enabling
> > > > > X86_FEATURE_TSC_RELIABLE?
> > > > >
> > > >
> > > > The particular problem is that HV_ACCESS_TSC_INVARIANT is not set for the
> > > > nested root, which in turn leads to keeping tsc clocksource watchdog
> > > > thread and TSC sycn check timer around.
> > >
> > > I have trouble keeping all the different TSC "features" conceptually
> > > separate. :-( The TSC frequency not changing (and the value not
> > > abruptly jumping?) should already be represented by
> > > X86_FEATURE_TSC_CONSTANT.  In the kernel, X86_FEATURE_TSC_RELIABLE
> > > effectively only controls whether the TSC clocksource watchdog is
> > > enabled, and in spite of the live migration foibles, I don't see a need
> > > for that watchdog in a Hyper-V VM. So maybe it's OK to always set
> > > X86_FEATURE_TSC_RELIABLE in a Hyper-V VM, as you have
> > > proposed.
> > >
> > > The "tsc_reliable" flag is also exposed to user space as part of the
> > > /proc/cpuinfo "flags" output, so theoretically some user space
> > > program could change behavior based on that flag. But that seems
> > > a bit far-fetched. I know there are user space programs that check
> > > the CPUID INVARIANT_TSC flag to know whether they can use
> > > the raw RDTSC instruction output to do start/stop timing. The
> > > Hyper-V TSC Invariant feature makes that work correctly, even
> > > across live migrations.
> > >
> > 
> > It sounds to me that if X86_FEATURE_TSC_CONSTANT is available
> > on Hyper-V, then we can set X86_FEATURE_TSC_RELIABLE.
> > Is it what you are saying?
> > 
> 
> No. Sorry I wasn't clear. X86_FEATURE_TSC_CONSTANT will
> be set only when the Hyper-V TSC Invariant feature is enabled, so
> tying X86_FEATURE_TSC_RELIABLE to that is what happens now.
> 
> What I'm suggesting is to take your patch "as is". In other words,
> always enable X86_FEATURE_TSC_RELIABLE. From what I can tell,
> TSC_RELIABLE is only used to disable the TSC watchdog. Since I
> can't see a use for the TSC watchdog in a VM, always setting
> TSC_RELIABLE probably makes sense. TSC_RELIABLE doesn't
> say anything about whether the TSC frequency might change, such
> as across a VM live migration. TSC_CONSTANT is what tells you that
> the frequency won't change.
> 
> My caveat is that I don't know the history of TSC_RELIABLE. I
> don't see any documentation on the details of what it is supposed
> to convey, especially in a VM. Maybe someone on the "To:" list
> who knows for sure can confirm what I'm thinking.
> 
> Michael

We had a long ionternal discussion with hypervisor folks and it looks
like we will propose a more robust solution to go forward.
The hypervisor will provide an additional CPUID bit, which guarantees
TSC reliability (including across live migration).

I'll prepare an updated version.

Thanks,
Stanislav

> 
> 
> 
> 

