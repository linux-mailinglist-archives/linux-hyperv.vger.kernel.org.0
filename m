Return-Path: <linux-hyperv+bounces-3918-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E56FA31BCC
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 03:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D213A7AAF
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 02:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971072AE69;
	Wed, 12 Feb 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKeV1YZ0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AC271805;
	Wed, 12 Feb 2025 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326651; cv=none; b=qKRJSS/81+4gBdFXWRk8aTIw3ZH7HHFzOHUGRN473I59RluNr54u6UCjwe1AOJTsRpBjhSRWqBScqzk+8Fu3q9c6Er9D5/8GPcooa0HfjLkjNvAqt7LnYGBT8Zc0MYW94Dud5lMSSeRAXxHIiId/tebhHDmDcmUxGeun6wcgA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326651; c=relaxed/simple;
	bh=IfNzFSoFebDHVFD6C3un0hfHjr9AseBn27h5i77Vq+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp/kVGDPY1AuAR0Ln9/hWzO/+83xKbJZlvVn2KHGJyp/czzw6Jq18znjh8zdn5ylcAgAEHujDrB91x0F7Ir1K3LjMkSA5BXhsjMAw51sDcpuCYl177R51NlVhH7y+f/+LH4Kxjz5D0K5kVR+oaJuvJ0NFN6FVekkzdB421MX1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKeV1YZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D68C4CEDD;
	Wed, 12 Feb 2025 02:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739326650;
	bh=IfNzFSoFebDHVFD6C3un0hfHjr9AseBn27h5i77Vq+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKeV1YZ0Ve18A8Hic9PwaGOUW1qk6t7uDfTSjB62RfdLSvh0qBLZxHSJhB8h451l5
	 L+yVT0YG4EQTBjNfJqAj6U+K2OswjMnSDo6nXInbmLdvWIxEh9Jhbd72aHwpNpzU2i
	 J96wlYe5lZUVyg2Vghq+EbHtjLI0r0mzG/QyE8SJLgF6IjykkaX1VqEnyeaPDmfc+V
	 SrPVSI4F4lq0xA/XPFZae/tvBskaHyy3YJMNRErnmfJT5o/+GeRQ0U5ysS74pBlMvG
	 qmGuuJZvKPNQ/b4R5L9q8wAkJRQATfh4DGz7kU1Geuj6tPikcodhsUekLimUVxB5IT
	 wc4MRIx4h+baA==
Date: Wed, 12 Feb 2025 02:17:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: namjain@linux.microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, ssengar@linux.microsoft.com, tglx@linutronix.de,
	wei.liu@kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/hyperv/vtl: Stop kernel from probing VTL0 low memory
Message-ID: <Z6wEuas8LbRVoBP_@liuwe-devbox-debian-v2>
References: <20250116061224.1701-1-namjain@linux.microsoft.com>
 <20250117170141.1351283-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117170141.1351283-1-romank@linux.microsoft.com>

On Fri, Jan 17, 2025 at 09:01:41AM -0800, Roman Kisel wrote:
> > For Linux, running in Hyper-V VTL (Virtual Trust Level), kernel in VTL2
> > tries to access VTL0 low memory in probe_roms. This memory is not
> > described in the e820 map. Initialize probe_roms call to no-ops
> > during boot for VTL2 kernel to avoid this. The issue got identified
> > in OpenVMM which detects invalid accesses initiated from kernel running
> > in VTL2.
> > 
> > Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_vtl.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > index 4e1b1e3b5658..3f4e20d7b724 100644
> > --- a/arch/x86/hyperv/hv_vtl.c
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -30,6 +30,7 @@ void __init hv_vtl_init_platform(void)
> >	x86_platform.realmode_init = x86_init_noop;
> >	x86_init.irqs.pre_vector_init = x86_init_noop;
> >	x86_init.timers.timer_init = x86_init_noop;
> > +	x86_init.resources.probe_roms = x86_init_noop;
> >  
> >	/* Avoid searching for BIOS MP tables */
> >	x86_init.mpparse.find_mptable = x86_init_noop;
> > 
> > base-commit: 37136bf5c3a6f6b686d74f41837a6406bec6b7bc
> > -- 
> > 2.43.0
> 
> Thanks, Naman!
> 
> Tested-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.

