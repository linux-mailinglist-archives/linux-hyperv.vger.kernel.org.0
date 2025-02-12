Return-Path: <linux-hyperv+bounces-3919-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD6CA31BE5
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 03:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4B1889EA5
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 02:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F42AE69;
	Wed, 12 Feb 2025 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTMWDyOA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A71CD1F;
	Wed, 12 Feb 2025 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326880; cv=none; b=jZTphlKtnQmQncCrTdVtiHJKasLrNRiCgoE3k2a6wdB61qUzjkjHGi2xfeLBcu4QU78WUS5/04bDcIcdjJhRMw8mhEmZBpZoDIPcBjxGEMFk8WCrU9nM0KO4FCpnvseWHLWfGz090yPam/yExhQNqxJvRHcyBsgbegIHctbF8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326880; c=relaxed/simple;
	bh=IyLvP91pfGYRHCXqlRx/ClwzflNIe5Yh0J8AVLNN12Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uqg55o8KK9teSGjuOh3/9TIWD11Rp/Mjw6iBw5jeo/0TGOFC+4R4cDmTCKbtejEVzESdhWUHc+hGub4sgHnFCKjTGs0zNndw5OyVOLI3luk0v2BE0zvNRGqjcxtWr4LKCLJp0GAqu7gRWUZd10FH/h21AnZCUsIU/iln7x+fIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTMWDyOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ABEC4CEE4;
	Wed, 12 Feb 2025 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739326879;
	bh=IyLvP91pfGYRHCXqlRx/ClwzflNIe5Yh0J8AVLNN12Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTMWDyOAyrZVTk0RkOOT1gPJt1AI4FCh107H0lJJ+YKfe9DYu7MtgZZMFdIs8ESso
	 Rkv66JTBZOZc6fxrTFn5GOSJAWT8ebdmxqQhvjoHRi2m8K0KoRrqLdpzsBYgK6avmY
	 8v16oFX0lxzGEL+7Ix0lOtJQgdiSo7XU7DWJn15evfvurFOjyiBJgbbW12pLJMzJid
	 AiKoCNVZ9qtXAm5CVFefyRPCUIIwAmCLE+GKL7oyPMxLvlVY25yPJIpdUwarc1GZXJ
	 6WML7Tij8w4ZZ/m5qU8gTjIRw9z14NXwCnLtf86vBBLfPLIMTLas43Yvev16eA0fKU
	 NWPH++9FGpjoA==
Date: Wed, 12 Feb 2025 02:21:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mingo@redhat.com, ssengar@linux.microsoft.com, tglx@linutronix.de,
	wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH hyperv-next 0/2] x86/hyperv: VTL mode reboot fixes
Message-ID: <Z6wFnoK-X7i1bd9x@liuwe-devbox-debian-v2>
References: <20250117210702.1529580-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117210702.1529580-1-romank@linux.microsoft.com>

On Fri, Jan 17, 2025 at 01:07:00PM -0800, Roman Kisel wrote:
> The first patch defines a specialized machine emergency restart
> callback not to write to the physical address of 0x472 which is
> what the native_machine_emergency_restart() does unconditionally.
> 
> I first wanted to tweak that function[1], and in the course of
> the discussion it looked as the risks of doing that would
> outweigh the benefit: the bare-metal systems have likely adopted
> that behavior as a standard although I could not find any mentions
> of that magic address in the UEFI+ACPI specification.
> 
> The second patch removes the need to always supply "reboot=t"
> to the kernel command line in the OpenHCL bootloader [2]. There is
> no other option at the moment; when/if it appears the newly added
> callback's code can be adjusted as required.
> 
> It would be great to apply this to the stable tree if no concerns,
> should apply cleanly.
> 
> [1] https://lore.kernel.org/all/20250109204352.1720337-1-romank@linux.microsoft.com/
> [2] https://github.com/microsoft/openvmm/blob/7a9d0e0a00461be6e5f3267af9ea54cc7157c900/openhcl/openhcl_boot/src/main.rs#L139
> 
> Roman Kisel (2):
>   x86/hyperv: VTL mode emergency restart callback
>   x86/hyperv: VTL mode callback for restarting the system

Saurabh please review these patches. Thanks.

I don't have a strong opinion on them.

> 
>  arch/x86/hyperv/hv_vtl.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> 
> base-commit: 2e03358be78b65d28b66e17aca9e0c8700b0df78
> -- 
> 2.34.1
> 

