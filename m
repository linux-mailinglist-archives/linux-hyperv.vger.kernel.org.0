Return-Path: <linux-hyperv+bounces-3510-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A03A9F8724
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 22:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0807A29A1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 21:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060781D516B;
	Thu, 19 Dec 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCjGswjz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD731C5CB6;
	Thu, 19 Dec 2024 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644107; cv=none; b=ZHzcjMgaO3LfRb6x5qzkdPrgd2vjYi6v1110uFgsocZFdGIHeb/JkPFauvtG6UIN+GZnC0ABtSQ6n1ueMfm+iUcbta/JYr18gGRqHRtJJKsnMrfw3c4fOMivUNjD10+U3+JuBEKq1IYdFrubZSIHFjjcRClhICrr9t4qqrcUkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644107; c=relaxed/simple;
	bh=qbLaOpkLG0uR+lXbmj3sOmz6zbMhelr1oPZqm/zqSVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVERYX0rU0Nss7OfQ3Zfm3UEzQeQvdLZGD19HwUZDsQU25g5AwJvN3cXQ9qEifPatntUkOHXLAPGS5/i6MBcGy1B114vmNvMb+qgsca8B9h4dZFnoQ5iWQliSobV0emMyptAggUBX0QWr1mgZPgTrXNpMr1bQEpbkrmXPe2BUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCjGswjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1704EC4CECE;
	Thu, 19 Dec 2024 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734644106;
	bh=qbLaOpkLG0uR+lXbmj3sOmz6zbMhelr1oPZqm/zqSVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCjGswjzUvzlqPBU0CLGPzDngfxh2nK7mBeNawTtf5yjRSE0Hpno9SYa/wHReOJHx
	 83BJlC/qK7AotX7tlMhkMlKZ6dzRl6Dg0ycDZHwlqNloASQwSBAY+c65QfLq6K1YOd
	 40WPsCwiDELO+ik52d2oc1s44Y6IhNb5Aopso93Mv6OHhzd1H06BCQ5BYi+g/ANNEx
	 uWLd9LU/TJC5WtSSP1YcUAQ46mVZKgZPdgzxpm2eJIN+gVPtJB6xkxmbD5xT5w3hsl
	 YbLpbQ1j6n8TEaf3lTXqiSe82X4Dmq/D+jjjteLfJcktOr7OcCOMbhurEbEdgcnfzj
	 hTUFCq4DGnm+Q==
Date: Thu, 19 Dec 2024 21:35:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, hpa@zytor.com, kys@microsoft.com,
	bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH 2/2] hyperv: Do not overlap the input and output
 hypercall areas in get_vtl(void)
Message-ID: <Z2SRiEW6yU2Nf4hs@liuwe-devbox-debian-v2>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-3-romank@linux.microsoft.com>
 <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
 <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>

On Thu, Dec 19, 2024 at 10:19:07AM -0800, Roman Kisel wrote:
> 
> 
> On 12/18/2024 6:42 PM, Wei Liu wrote:
> > On Wed, Dec 18, 2024 at 12:54:21PM -0800, Roman Kisel wrote:
> > > The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2], disallows
> > > overlapping of the input and output hypercall areas, and get_vtl(void) does
> > > overlap them.
> > > 
> > > To fix this, enable allocation of the output hypercall pages when running in
> > > the VTL mode and use the output hypercall page of the current vCPU for the
> > > hypercall.
> > > 
> > > [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
> > > [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
> > > 
> > > Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
> > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > > ---
> > >   arch/x86/hyperv/hv_init.c | 2 +-
> > >   drivers/hv/hv_common.c    | 6 +++---
> > >   2 files changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > index c7185c6a290b..90c9ea00273e 100644
> > > --- a/arch/x86/hyperv/hv_init.c
> > > +++ b/arch/x86/hyperv/hv_init.c
> > > @@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
> > >   	local_irq_save(flags);
> > >   	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > -	output = (struct hv_get_vp_registers_output *)input;
> > > +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > 
> > You can do
> > 
> > 	output = (char *)input + HV_HYP_PAGE_SIZE / 2;
> > 
> > to avoid the extra allocation.
> > 
> > The input and output structures surely won't take up half of the page.
> Agreed on the both counts! I do think that the attempt to save here
> won't help much: the hypercall output per-CPU pages in the VTL mode are
> needed just as in the dom0/root partition mode because this hypercall
> isn't going to be the only one required.
> 
> In other words, we will have to allocate these pages anyway as we evolve
> the code; we are trying to save here what is going to be spent anyway. Sort
> of, kicking the can down the road as the saying goes :)
> 

If you want this patch to be backported, then the smaller the change the
better.

In this particular case, I don't have a strong opinion. Your original
patch is small enough to be backported easily.

You can keep the patch as-is.

Thanks,
Wei.

