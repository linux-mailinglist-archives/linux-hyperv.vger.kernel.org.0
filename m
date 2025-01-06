Return-Path: <linux-hyperv+bounces-3586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A10A0305D
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 20:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4623D1885423
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 19:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C254206B;
	Mon,  6 Jan 2025 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bd3rssaM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A681CBA34;
	Mon,  6 Jan 2025 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191158; cv=none; b=X5iQ5D9/T1PD2rviL4LhzjG8VhwZHHky6uKbST+MHWKfKzWpevn958mFNuzQn35iXcx07M7xTG8H0Tq3qb0dV1tg1j8/ACU4BynRvxR/COjnD4dHDZMMHN/yOeYg2InvW7m/GN9ftksXhwLuUFScmbN4xzszI1g95uQFT9rpPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191158; c=relaxed/simple;
	bh=AbfHzP5X1QRZKSKaCHI87g20THFIIXLe54x65h2AHVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXh2HvUQab03CoKuQA5wfSQfNr/EbRdn8jkm9dWycUU1wgv2v6ivIbMnHUDoGNILtJL8Cmz8lFPX4N/ZPI10V7P+TddeSBcU/03sMHDGIyrMLjee5cBGkoCJV0iCWH0y48Hel8h8MmtnHFvm5JSXodpPG+6AJmdQ+dQ7km3SFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bd3rssaM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id BA020204674E;
	Mon,  6 Jan 2025 11:19:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA020204674E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736191156;
	bh=U/tTpLzTcMYGmBt7apXnrgn/W+eaiJzASIfk4nIMBnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bd3rssaMCuucqw6lmtQkMvM4I0pC/IHOsJr5XZRe2niSZbsMcjO2hSJLWZvTPn+5Y
	 9Nha3aQewxdgjqMhug1ZXsvErHQSoz4cziNpev0jto+2MFAApyC814PsyfpbWQtX27
	 BvizObgH/po9LEzCnkrVngrSkkmpVEstD/lN9yTo=
Date: Mon, 6 Jan 2025 11:19:14 -0800
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
Message-ID: <20250106191914.GA18346@skinsburskii.>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <SN6PR02MB41573C71F0BD479FA24A30E2D4152@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250106172312.GA18291@skinsburskii.>
 <SN6PR02MB41576D6210E0270610F55DB3D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41576D6210E0270610F55DB3D4102@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Jan 06, 2025 at 06:18:51PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, January 6, 2025 9:23 AM
> > 
> > On Fri, Jan 03, 2025 at 10:08:05PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday, January
> > 3, 2025 11:20 AM
> > > >
> > > > On Mon, Dec 30, 2024 at 10:09:39AM -0800, Roman Kisel wrote:
> > > > > Due to the hypercall page not being allocated in the VTL mode,
> > > > > the code resorts to using a part of the input page.
> > > > >
> > > > > Allocate the hypercall output page in the VTL mode thus enabling
> > > > > it to use it for output and share code with dom0.
> > > > >
> > > > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > > > > ---
> > > > >  drivers/hv/hv_common.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > > > > index c6ed3ba4bf61..c983cfd4d6c0 100644
> > > > > --- a/drivers/hv/hv_common.c
> > > > > +++ b/drivers/hv/hv_common.c
> > > > > @@ -340,7 +340,7 @@ int __init hv_common_init(void)
> > > > >  	BUG_ON(!hyperv_pcpu_input_arg);
> > > > >
> > > > >  	/* Allocate the per-CPU state for output arg for root */
> > > > > -	if (hv_root_partition) {
> > > > > +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
> > > >
> > > > This check doesn't look nice.
> > > > First of all, IS_ENABLED(CONFIG_HYPERV_VTL_MODE) doesn't mean that this
> > > > particular kernel is being booted in VTL other that VTL0.
> > >
> > > Actually, it does mean that. Kernels built with CONFIG_HYPERV_VTL_MODE=y
> > > will not run as a normal guest in VTL 0. See the third paragraph of the
> > > "help" section for HYPERV_VTL_MODE in drivers/hv/Kconfig.
> > >
> > 
> > Thanks for pointing to this piece.
> > 
> > This limitation looks aritificial to me and as VTL support in Linux is
> > currently being extended beyond Underhill support, keeping this
> > restriction makes some further development in scope of LVBS support
> > complicated and error prone due to potential ABI mismatches between
> > Linux kernels in different VTLs.
> > 
> > IOW, making the same kernel properly bootable (or - worse - explicitly
> > un-bootable) in different VTLs is a more robust way in the long run.
> 
> The reason for the limitation is the sequencing of early Hyper-V-related
> initialization steps. Knowing at runtime whether you are running at
> VTL0 or some other VTL requires making a hypercall in get_vtl().
> Unfortunately, the machinery for making a hypercall (setting the guest
> OS ID, and allocating the x86 hypercall page) is established relatively late
> during initialization, in hyperv_init(). But running in other than VTL0
> requires the initializations that are done in hv_vtl_init_platform(), which
> must be done much earlier. There's no clear way out of this conundrum
> purely on the Linux guest side.
> 
> To solve the conundrum on x86, one possibility to consider is having
> Hyper-V make HV_REGISTER_VSM_VP_STATUS available as a synthetic
> MSR, which can be read without making a hypercall. This register could be
> read in ms_hyperv_init_platform() to know if running at VTL0 or not.
> Using synthetic MSRs is how other aspects of early Hyper-V-related
> initialization is done in Linux on x86.
> 
> I think there's some discussion on the x86 sequencing issues on LKML
> from when the VTL code was first added. I was part of that discussion, but
> don't remember all the details. There might additional issues raised in
> that discussion.
> 
> The sequencing issues would also need to be sorted out on the arm64
> side, as they are different from x86. We don't have an early Hyper-V
> specific hook like ms_hyperv_init_platform() on the arm64 side, so
> that might be problem. But on the flip side, we also don't have the
> x86-specific messiness that hv_vtl_init_platform() handles. Also,
> there are no synthetic MSRs on arm64, so register accesses always
> use hypercalls, but there's no hypercall page needed. On balance, I
> think getting VTL stuff initialized on arm64 will be easier, but I'm not sure.
> 
> Michael

Thank you for summarizing this up. This aligns with my understanding.

Since VTL1 firmware is a payload for VTL0 kernel, one of my proposals to
the original message was to explicitly notify the kernel it's running in
VTL1 via command line argument and/or DT.

Thanks,
Stas

