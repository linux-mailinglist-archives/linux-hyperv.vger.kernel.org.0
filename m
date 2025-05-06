Return-Path: <linux-hyperv+bounces-5362-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578ECAAB985
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED5E1C41B24
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07953289832;
	Tue,  6 May 2025 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA5LbBft"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767612DA55A;
	Tue,  6 May 2025 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746499977; cv=none; b=bFALrlaILc3MGgpb576KfZTQoL3lPCMHJCaRh8b4tNEtYtXzGCP22Vv69NMH/qj7vv/r1OVx5fSAjfml3SVO+WEUWse5tx+merJTtfKjcxFWuU/OgJuI1K/V8ne4K32ZpWEqN0FEO/QbZoHbUYO4O8383MqGV3+o7553pIAzOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746499977; c=relaxed/simple;
	bh=g721KZVwDDf0MWx8XpiBIQt/dzLSk+8KPYowtAoYXEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp64WCRpC1Cgh45VkUizMRzoJQWsvWIHufW+PscsQ5S+Nhgv436/RreJDoML5DRam3uMPG+PhH/EVM35fu0wyEQTRJxi2q7048gufHtsPYoT1UlcvAJu/MNpOjwd+cPISo5p5v3IO86PBrmG8Ia+mL/sCJlVt6CrSN9O+qkk/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA5LbBft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49824C4CEE4;
	Tue,  6 May 2025 02:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746499975;
	bh=g721KZVwDDf0MWx8XpiBIQt/dzLSk+8KPYowtAoYXEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iA5LbBftXo/8CV2D2Kqhl18Mq18yORC8ariR0vlUGrgf5Ofukfj7k60/t+ebxCZXU
	 qEhDBSKjJQwc0uSM6QwcG8k0hpxlKwA7v6nPpYEyYdwNZ8EMRtOitnytOrsv0CZFdc
	 8WAg1Cohdo4TzwdpczrhacKWugq77kZCiPtJVoyXt0hb71jSOtOThJRix5ViYdY6Qm
	 3tkS/qO3D/ddxYC0XZgIcGc1G8CRXgSLJxiGQKV8jCtuXxGReaQIvONv4+VGIygPOV
	 wKpBI9Y1f6t5OvzNLQl0lc0iix0D/PYcWAF4+Ka4s4gtm2knAzTw7oMtatOiWMaF+k
	 ukE/01Ru7Br9w==
Date: Tue, 6 May 2025 02:52:54 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Wei Liu <wei.liu@kernel.org>, Roman Kisel <romank@linux.microsoft.com>,
	ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, dimitri.sivanich@hpe.com,
	haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com, jgross@suse.com,
	justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
	kys@microsoft.com, lenb@kernel.org, mingo@redhat.com,
	nikunj@amd.com, papaluri@amd.com, perry.yuan@amd.com,
	peterz@infradead.org, rafael@kernel.org, russ.anderson@hpe.com,
	steve.wahl@hpe.com, tglx@linutronix.de, thomas.lendacky@amd.com,
	tim.c.chen@linux.intel.com, tony.luck@intel.com, xin@zytor.com,
	yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
Message-ID: <aBl5hhE2mY5ygq8l@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250430204720.108962-1-romank@linux.microsoft.com>
 <aBUByjvfjLsPU_5f@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <41778d44-19dc-4212-a981-d5a82eaf9577@linux.microsoft.com>
 <aBj895aOnhgsIiwO@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <8bb6418f-0131-4a75-aabe-c753841d116a@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb6418f-0131-4a75-aabe-c753841d116a@intel.com>

On Mon, May 05, 2025 at 11:12:10AM -0700, Dave Hansen wrote:
> On 5/5/25 11:01, Wei Liu wrote:
> > You don't need to do that for this patch. Please point me to Thomas'
> > reply to the previous version and I can add the missing tag to patch
> > while I queue it.
> 
> It's right here:
> 
> 	https://lore.kernel.org/all/8734dnouq6.ffs@tglx/

Thanks for the pointer. This is appreciated.

> 
> It's pretty darn trivial to find if you do any of the following:
> 
> 1. Read this thread in your mail reader that understands threads, or
> 2. Look at this thread on lore, or
> 3. Run "b4 am" on the thread
> 
> Sure, it can be kinda hard to do #1/#2 on gigantic threads if there are
> a ton of replies from the maintainer. But there were 5 messages in this
> thread and only one from Thomas.
> 
> I'd highly suggest adding one or more of those tools to your maintainer
> toolbox! b4, especially, does all the work for you.

I use b4, too.

I wished I had more time to go over every things in my inbox. That's why
I asked Roman (and other contributors) to include whatever tags were
given during the review process while they submit new versions of their
patches.

Thanks,
Wei.

