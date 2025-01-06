Return-Path: <linux-hyperv+bounces-3582-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E71A02ED2
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 18:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B5E18871CA
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9507A1DE4FE;
	Mon,  6 Jan 2025 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aAKvnAsD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6A14AD2B;
	Mon,  6 Jan 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184196; cv=none; b=irYhLaX4AydOk5j4LgaauewUANGlMhkFd+ISygvhpQuQ8Igh8ukM924BlyWevTtibp4vmp9yuuJKYaD6/aiwnINXDfpftFxWrAdxZ84cTOXIUC3sYK1QWRs3EGElsNEz4s+YZStMvTU1LIwF5YQ6U/P3VDncUrtSIvxNmibeHAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184196; c=relaxed/simple;
	bh=0Vgr5SaNIpbK5GODhJvjYukrHkFTwQnk4/XepMdl97A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ/7GHmKFx+rQNlNaiamLWSPhSQV9e1Lgef4zGI6GlhjQmenecqMCfZSIqRU4FC1HGGLyOSQqvEvbrBcD8wdAvSwYx6UDnoHjxNNBVU+S3ansZyOB9hE9aHmS7XP6C5WONQZSUxM2kGQuPw3g65A52y8cEb8e5/FW1dasDvE0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aAKvnAsD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3ADED206AB8F;
	Mon,  6 Jan 2025 09:23:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3ADED206AB8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736184194;
	bh=+y352pOJ31fw2Ll+FAP8IoQ2SVzkeZOfoXYQd9VwztI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAKvnAsDAx4DHtceDeWpNG2fYz8HJUduhD1B7YXIG4O1xbC2DHY5yjeBZZwVFbF1O
	 9HXwymtp7cLmhFuPNbUHg2OexLzZXAGHqu2ojbWcXYwS62TrNxTsLV6alRmXpH47cI
	 gd4rGTJbGNTd4FBLkhs4WFOYx4bY918WcG3f0h2Y=
Date: Mon, 6 Jan 2025 09:23:12 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"tiala@microsoft.com" <tiala@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"apais@microsoft.com" <apais@microsoft.com>,
	"benhill@microsoft.com" <benhill@microsoft.com>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>,
	"vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Message-ID: <20250106172312.GA18291@skinsburskii.>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <SN6PR02MB41573C71F0BD479FA24A30E2D4152@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573C71F0BD479FA24A30E2D4152@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Jan 03, 2025 at 10:08:05PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, January 3, 2025 11:20 AM
> > 
> > On Mon, Dec 30, 2024 at 10:09:39AM -0800, Roman Kisel wrote:
> > > Due to the hypercall page not being allocated in the VTL mode,
> > > the code resorts to using a part of the input page.
> > >
> > > Allocate the hypercall output page in the VTL mode thus enabling
> > > it to use it for output and share code with dom0.
> > >
> > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > > ---
> > >  drivers/hv/hv_common.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > > index c6ed3ba4bf61..c983cfd4d6c0 100644
> > > --- a/drivers/hv/hv_common.c
> > > +++ b/drivers/hv/hv_common.c
> > > @@ -340,7 +340,7 @@ int __init hv_common_init(void)
> > >  	BUG_ON(!hyperv_pcpu_input_arg);
> > >
> > >  	/* Allocate the per-CPU state for output arg for root */
> > > -	if (hv_root_partition) {
> > > +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
> > 
> > This check doesn't look nice.
> > First of all, IS_ENABLED(CONFIG_HYPERV_VTL_MODE) doesn't mean that this
> > particular kernel is being booted in VTL other that VTL0.
> 
> Actually, it does mean that. Kernels built with CONFIG_HYPERV_VTL_MODE=y
> will not run as a normal guest in VTL 0. See the third paragraph of the
> "help" section for HYPERV_VTL_MODE in drivers/hv/Kconfig.
> 

Thanks for pointing to this piece.

This limitation looks aritificial to me and as VTL support in Linux is
currently being extended beyond Underhill support, keeping this
restriction makes some further development in scope of LVBS support
complicated and error prone due to potential ABI mismatches between
Linux kernels in different VTLs.

IOW, making the same kernel properly bootable (or - worse - explicitly
un-bootable) in different VTLs is a more robust way in the long run.

Thanks,
Stas

> Michael
> 
> > 
> > Second, current approach is that a VTL1+ kernel is a different build from VTL0
> > kernel and thus relying on the config option looks reasonable. However,
> > this is not true in general case.
> > 
> > I'd suggest one of the following three options:
> > 
> > 1. Always allocate per-cpu output pages. This is wasteful for the VTL0
> > guest case, but it might worth it for overall simplification.
> > 
> > 2. Don't touch this code and keep the cnage in the Underhill tree.
> > 
> > 3. Introduce a configuration option (command line or device tree or
> > both) and use it instead of the kernel config option.
> > 
> > Thanks,
> > Stas
> > 
> > >  		hyperv_pcpu_output_arg = alloc_percpu(void *);
> > >  		BUG_ON(!hyperv_pcpu_output_arg);
> > >  	}
> > > @@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
> > >  	void **inputarg, **outputarg;
> > >  	u64 msr_vp_index;
> > >  	gfp_t flags;
> > > -	int pgcount = hv_root_partition ? 2 : 1;
> > > +	const int pgcount = (hv_root_partition ||
> > IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
> > >  	void *mem;
> > >  	int ret;
> > >
> > > @@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
> > >  		if (!mem)
> > >  			return -ENOMEM;
> > >
> > > -		if (hv_root_partition) {
> > > +		if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
> > >  			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> > >  			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
> > >  		}
> > > --
> > > 2.34.1
> > >

