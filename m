Return-Path: <linux-hyperv+bounces-3581-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE62A02EC9
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 18:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CBB3A439D
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983421DDC15;
	Mon,  6 Jan 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EtPLjQWN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADDE149C42;
	Mon,  6 Jan 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184036; cv=none; b=IY0s37qEDBAVjks5RxPh1L8f0ib0bcJVJ5A3i9se3aSjQ12320dsD5q30l8WU/rx2O8HaH9jFQD4xHe/Rhkum+qJllhoYXSeiYrL6lmJ/x1rpDA0mATE9nl1maYsHzaLQRQaE5iQ5lmrn4NGLx4Pd8nvxBWUhZN3B+tcIW0c+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184036; c=relaxed/simple;
	bh=DwH1GE59+U6pMom6U8m9Tyok+6KdzxBNDfcjINhGpKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7bHcDuvZFkDeb3rEi15SAoy6e7eZQnASah40wGxIO9QocmRebvgAU2EAAuY4bYRm9aPBr8kP3Wet8n9pS8CsKBVIR85AVkG5RjlciUKbdn/ApaXoexs0l0o/pA3KbgVyMtmaxl9pwsKc/jhcnt6EsF/hRtqUEAMUh0rXrDxFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EtPLjQWN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 76C43206AB8F;
	Mon,  6 Jan 2025 09:11:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76C43206AB8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736183475;
	bh=M76S3xTNCr0JXsIHhPtgxDhOTAD6iFMubyEkKmdcqD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtPLjQWNIYXevz/N/1CemqLHiXsCoPjfaQYsPdQVIUhaYJiH9+dU+ERnH5JYGvXea
	 NfXivtSPK3mIIjFtpV/2tq+YtV+kRfQmdPRZru/C0j/CgFGTEAvelOnqHUtFvCWfow
	 WkAaNIIi/0OpSRdcir7oRbdew/22zLKf+4+4bIZY=
Date: Mon, 6 Jan 2025 09:11:14 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Message-ID: <20250106171114.GA18270@skinsburskii.>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>

On Fri, Jan 03, 2025 at 01:39:29PM -0800, Roman Kisel wrote:
> 
> 
> On 1/3/2025 11:20 AM, Stanislav Kinsburskii wrote:
> > On Mon, Dec 30, 2024 at 10:09:39AM -0800, Roman Kisel wrote:
> > > Due to the hypercall page not being allocated in the VTL mode,
> > > the code resorts to using a part of the input page.
> > > 
> > > Allocate the hypercall output page in the VTL mode thus enabling
> > > it to use it for output and share code with dom0.
> > > 
> > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > > ---
> > >   drivers/hv/hv_common.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > > index c6ed3ba4bf61..c983cfd4d6c0 100644
> > > --- a/drivers/hv/hv_common.c
> > > +++ b/drivers/hv/hv_common.c
> > > @@ -340,7 +340,7 @@ int __init hv_common_init(void)
> > >   	BUG_ON(!hyperv_pcpu_input_arg);
> > >   	/* Allocate the per-CPU state for output arg for root */
> > > -	if (hv_root_partition) {
> > > +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
> > 
> > This check doesn't look nice.
> I read that as you don't like it. Neither do I (see below), the change
> enables what's needed for the rest, and poses no harm imo.
> 
> > First of all, IS_ENABLED(CONFIG_HYPERV_VTL_MODE) doesn't mean that this
> > particular kernel is being booted in VTL other that VTL0. > Second,
> > current approach is that a VTL1+ kernel is a different build
> from VTL0
> > kernel and thus relying on the config option looks reasonable. However,
> > this is not true in general case.
> "First" and "Second" appear to be saying that the approach is good in
> your opinion. What is that general case you're alluding to which is
> going to be broken by adding IS_ENABLED() here, how do I repro the
> possible borkage?
> 
> > 
> > I'd suggest one of the following three options:
> > 
> > 1. Always allocate per-cpu output pages. This is wasteful for the VTL0
> > guest case, but it might worth it for overall simplification.
> As outlined above, the justification for the changes you're requesting
> isn't clear. Yet, if no objections from others, I'd happily weed out
> these if's and #ifdef's, on that we're in agreement.
> 
> > 
> > 2. Don't touch this code and keep the cnage in the Underhill tree.
> So, leave get_vtl() broken iiuc? Please suggest what would be the fix
> you prefer more. The patch set regularizes the common case and makes
> get_vtl() look as hv_get_vp_register which it is so get_vtl() can be
> replaced with it once it appears in the tree.
> 
> All in all, strong disagree. I cannot seem to see how "don't touch"
> and "keep" is going to work with upstreaming the VTL mode patches.
> 
> > 
> > 3. Introduce a configuration option (command line or device tree or
> > both) and use it instead of the kernel config option.
> That looks to me as messy and complicated compared to adding
> IS_ENABLED(). Why defer the decision to runtime, what are the benefits
> in your opinion?
> 

The issue is that when you boot the same kernel in both VTL0 and VTL1+,
the pages will be allocated in any case (root or guest, VTL0 or VTL1+).

Also, there are other places in the code, where braching needs to be done
differently depending in on which VTL the execution is happening in.

I think, there are two possible paths we can take here.

The first one is when the checks are done during compilation. In this case
the kernel should explicitly fail to boot in VTL0 if compiled for VTL1+
and vice versa.

The second one if to make checks in runtime and let the same kernel boot
differently in different VTLs.

Thoughts?

Stas

> > 
> > Thanks,
> > Stas
> > 
> > >   		hyperv_pcpu_output_arg = alloc_percpu(void *);
> > >   		BUG_ON(!hyperv_pcpu_output_arg);
> > >   	}
> > > @@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
> > >   	void **inputarg, **outputarg;
> > >   	u64 msr_vp_index;
> > >   	gfp_t flags;
> > > -	int pgcount = hv_root_partition ? 2 : 1;
> > > +	const int pgcount = (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
> > >   	void *mem;
> > >   	int ret;
> > > @@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
> > >   		if (!mem)
> > >   			return -ENOMEM;
> > > -		if (hv_root_partition) {
> > > +		if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
> > >   			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> > >   			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
> > >   		}
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> Thank you,
> Roman
> 

