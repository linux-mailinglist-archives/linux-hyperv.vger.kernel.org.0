Return-Path: <linux-hyperv+bounces-3610-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3733BA054F4
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 09:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D890A18878D1
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D21ACEB6;
	Wed,  8 Jan 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDiFwtVd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E71AA781;
	Wed,  8 Jan 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323497; cv=none; b=pW0NmOiHCAaU3glXhCiAFbKVCbrp1X+pjxztWWWDCv4HqAWSr0UxnCTiHyP9uWu15kQ3F8AmfQ3dKwCttHognX92k7yI+uOSqjMKZJ8uHHoyx47j4DU0SvpmbI14Ge/WPC4KlL2gn0l2n8ZdQYhx478M54q7BsvmPPD4RP0fm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323497; c=relaxed/simple;
	bh=acF9LMMKbzu69UPIwIq7zDl1Bv0e2Kb/qDci76XFe1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAVNafkA0iHS2JgFYoTQdGI3wCvZgPZUR/xdC45VENbIYUjldh1fuh7KE8FDoOR8qbXsaGXEj7zZJZXCe9g4WrjgaI7ZpuJJ9S+/a28xlJrsogVTUd0MXMfYA/rU5ADujvt1iV5PnS8eUUBDebSMEOd47C1EMNNcj4IIXlAJzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDiFwtVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCA5C4CEE0;
	Wed,  8 Jan 2025 08:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736323497;
	bh=acF9LMMKbzu69UPIwIq7zDl1Bv0e2Kb/qDci76XFe1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDiFwtVddR6zWaFLODRRVKawOU+W4G9uGO5wIH2adAmHcypyGAV186GEoJGzZtxhT
	 iM0V8pBr48IpkF7jp12pI9ChabmwquwT3YCIsThUhUo2nJSVWyzcemaevNYU29dxS9
	 QyAmfF4k1tf+lSnbSDHyjLIC3xw2u5v6eoXMc/WOhKFJG6cL0A+EtPxkEFmt7iXpb7
	 JobBNUK1lAHzEHwiQKMr3RpIw/A7d/5MpyB1KxNMLBDhCFpfHjtIkOFG4BS+BCGMMd
	 6g0snbFujq/6+W3Ti8G1BzhnalC8orQB0javxI1pGfOVexqCONhHJ7p0Nb5MuXeVvj
	 +rxWJq0qMGZVA==
Date: Wed, 8 Jan 2025 08:04:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, hpa@zytor.com,
	kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, eahariha@linux.microsoft.com,
	haiyangz@microsoft.com, mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Message-ID: <Z34xp0ret-5Zcgo9@liuwe-devbox-debian-v2>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>
 <20250106171114.GA18270@skinsburskii.>
 <a1577153-95c0-4791-8f6a-0ec00fae48f7@linux.microsoft.com>
 <20250106193248.GB18346@skinsburskii.>
 <3c90bc0f-be28-4f10-8057-be5e780c5a24@linux.microsoft.com>
 <20250107191848.GA24369@skinsburskii.>
 <17dfb71a-119c-4906-bc22-4f65fb28676b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17dfb71a-119c-4906-bc22-4f65fb28676b@linux.microsoft.com>

On Tue, Jan 07, 2025 at 03:11:15PM -0800, Roman Kisel wrote:
> 
> 
> On 1/7/2025 11:18 AM, Stanislav Kinsburskii wrote:
> > On Mon, Jan 06, 2025 at 01:07:25PM -0800, Roman Kisel wrote:
> > 
> 
> [...]
> 
> > My point is that the proposed fix looks more like an Underhill-tailored
> > bandage and doesn't take the needs of other stake holders into
> > consideration.
> The patch takes as much into consideration as present in the hyperv-next
> tree. Working on the open-source project seems to be harder otherwise.
> A bandage, or not, that's a matter of opinion. There's a been a break,
> here's the bandage.
> 
> > 
> > What is the urgency in merging of this particular change?
> 
> The get_vtl function is broken thus blocking any further work on
> upstreaming VTL mode patches, ARM64 and more. That's not an urgent
> urgency where customers are in pain, more like the urgency of needing
> to take the trash out, and until that happens, continuing inhaling the
> fumes.
> 
> The urgency of unblocking is to continue work on proposing VTL mode
> patches not to carry lots of out-of-tree code in the fork.
> 
> There might be a future where the Hyper-V code offers an API surface
> covering needs of consumers like dom0 and VTLs whereby they maybe can
> be built as an out-of-tree modules so the opinions wouldn't clash as
> much.
> 
> Avoiding using the output hypercall page leads to something like[1]
> and it looks quite complicated although that's the bare bones, lots
> of notes.
> 
> [1]
> 
> /*
>  * Fast extended hypercall with 20 bytes of input and 16 bytes of
>  * output for getting a VP register.
>  *
>  * NOTES:
>  *  1. The function is __init only atm, so the XMM context isn't
>  *     used by the user mode.
>  *  2. X86_64 only.
>  *  3. Fast extended hypercalls may use XMM0..XMM6, and XMM is
>  *     architerctural on X86_64 yet the support should be enabled
>  *     in the CR's. Here, need RDX, R8 and XMM0 for input and RDX,
>  *     R8 for output
>  *  4. No provisions for TDX and SEV-SNP for the sake of simplicity
>  *     (the hypervisor cannot see the guest registers in the
>  *     confidential VM), would need to fallback.

I am not worried about this point. There are architectural defined ways
to handle this.

>  *  5. The robust implementation would need to check if fast extended
>  *     hypercalls are available by checking the synthehtic CPUID leaves.
>  *     A separate leaf indicates fast output support.
>  *     It _almost_ certainly has to be, unless somehow disabled, hard
>  *     to see why that would be needed.
>  */

The rest I agree. Not worth the effort just to add that support here for
a single user.

I've been thinking about adding the extended hypercall support for a
while, but I'm not sure if it's worth the effort overall.

An aspiring developer who's interested in this area is building a
prototype to see if extended fast hypercall can give a boost to some of
the frequent hypercalls.

In any case, I think this patch is fine.

Thanks,
Wei.

