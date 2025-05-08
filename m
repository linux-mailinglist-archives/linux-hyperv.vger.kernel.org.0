Return-Path: <linux-hyperv+bounces-5435-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F93AB0219
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 20:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8CD461909
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B839281523;
	Thu,  8 May 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZN6x7GW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC3207DEE;
	Thu,  8 May 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727410; cv=none; b=rE5WIr74PF9VghaYNgukHSGKwu55ilXN4TPkbLgl1xZPB1AeEfpYdxUpNvsQQRqWgk+w+t7D2ah5hd2uTm4RPOIApC3tkSDeCSS52z24jZBarAINCuJtqT5XWu6FSVJO269wPA3BWipDYYsIl0ANsRaSdcvnSAl4ZfXXXKYJM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727410; c=relaxed/simple;
	bh=keNapksh6o7sIDke7Z7TY0yJwQBMCFVXVOlG6PCsX8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg5S5UHdPNa68V5sjgvUTLSAh79eEV5EuoAOkOJZE2d+BpSAZj9TYGtsLG6hP1psunIqjEGkTqbS7OreXUwfXiVfyWg78SPiilpmCWvuPF4x1l2si7SWN8jZL5jOsXZJJz1p/nr6gQMAk2b8eUyA12eKPhGuEUlqC/HC3CtjnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZN6x7GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C632C4CEE7;
	Thu,  8 May 2025 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746727409;
	bh=keNapksh6o7sIDke7Z7TY0yJwQBMCFVXVOlG6PCsX8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZN6x7GWWTzQbQCFq27jKoBQEr5dYYcaOwLq8Faw33FpF4uA0vwXo/hzu+h9CNfWF
	 XIGZD3oEPOjE21RmipQuoZ2aCKvwuXyX+SLeVKvBGe4oyVB3m+HtfD9LI2R1VSG9kz
	 s86ZnChSIdG6c4XMJhjv6phGHTxELsMiWMbNvHO2RZ076ujIvJ5pRX8RZMRCmqa4ZY
	 8xN+UXImo4E6aQ2dDpLFzyg1n2K6XAWG/1+/YCl8RUaMHuaDy5dyvQFgF50V2fG79Y
	 SSn1XzwFrBmG05N9KdgDqdMacTINtBnWO1SeUlJU4fuGW3tKxNFswwrWbU5k7D+wTv
	 IBXKfObQioO9w==
Date: Thu, 8 May 2025 18:03:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Message-ID: <aBzx8HDwKakGG1tR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>

On Wed, May 07, 2025 at 12:20:36PM -0700, Roman Kisel wrote:
> 
> 
> On 5/7/2025 6:02 AM, Saurabh Singh Sengar wrote:
> > 
> [..]
> 
> > > +	}
> > > +
> > > +	local_irq_save(flags);
> > > +	in = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > +	out = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > > +
> > > +	if (copy_from_user(in, (void __user *)hvcall.input_ptr,
> > > hvcall.input_size)) {
> > 
> > Here is an issue related to usage of user copy functions when interrupt are disabled.
> > It was reported by Michael K here:
> > https://github.com/microsoft/OHCL-Linux-Kernel/issues/33
> 
> From the practical point of view, that memory will be touched by the
> user mode by virtue of Rust requiring initialization so the a possible
> page fault would be resolved before the IOCTL. OpenHCL runs without swap
> so the the memory will not be paged out to require page faults to be
> brought in back.
> 
> I do agree that might be turned into a footgun by the user land if
> they malloc a page w/o prefaulting (so it's just a VA range, not backed
> with the physical page), and then send its address straight over here
> right after w/o writing any data to it. Perhaps likelier with the output
> data. Anyway, yes, relying on the user land doing sane things isn't
> the best approach to the kernel programming.

Yep. We don't rely on user land software doing sane things to maintain
correctness in kernel, so this needs to be fixed.

Thanks,
Wei.

> 
> If we're inclined to fix this, I'd encourage to take an approach that
> works for the confidential VMs as well so we don't have to fix that
> again when start upstreaming what we have for SNP and TDX. The
> allocation *must* be visible to the hypervisor in the confidential
> scenarios.
> 
> Or, maybe we could avoid the allocations by reading the first byte
> of the user land buffer to "pre-fault" the page outside of the
> scope that disables interrupts. Why allocate if we can avoid that?
> Could set up also the SMP remote calls to run this on the desired
> CPU.
> 
> Summarizing for the case you want to change this:
> 
> 1. Keep interrupts disabled when reading/writing to/from the Hyper-V
>    driver allocated input and output pages.
> 2. If you decide to allocate separate pages, make sure they are
>    visible to the hypervisor in the confidential scenarios. I know
>    we're not talking SNP and TDX here just yet but it would be
>    a waste of time imho to build something here and scrape that
>    later. The issues with allocations are:
>        a) If allocating on-demand, we might fail the hypercall
>           because of OOM. That's certainly bad as the whole VM
>           will break down.
>        b) If allocating for the whole lifetime of the VM,
>           let us remember that we avoid using hypercalls
>           due to their runtime cost. We'll be keeping around
>           2 pages per CPU for the few times we need them.
> 3. Consider reading a byte from the user land buffers to make the page
>    fault happen outside of disabling interrupts. There is no
>    outswap (maybe could have disabling swap in Kconfig) so the page
>    will stay in the memory.
> 
> If you're not changing this, feel free to keep my "Reviewed-by".
> 
> > 
> > - Saurabh
> 
> -- 
> Thank you,
> Roman
> 

