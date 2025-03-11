Return-Path: <linux-hyperv+bounces-4411-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45731A5D221
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 22:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955207AB1A7
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 21:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69811264A94;
	Tue, 11 Mar 2025 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sro4ArFT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C056264A7D;
	Tue, 11 Mar 2025 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730234; cv=none; b=XTclWJHUp18blpl+tDVw1YW568RpGMFRE9HJiS1Kfdox+eOaTLQBXDqKWI66HvcrkiYCYQKhdvApkFOR9VQ9fkoScAV0bxFB7fvPPeG7b5MoftpfXYDZiuRJgMvwHxsBJOm2rQyf03kbMotYoStH6rGhNPnScmybMVi4OvSdBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730234; c=relaxed/simple;
	bh=H2cT8jcME2fJEAJn4Ke0eNz2D+tUy8b8WcBs+Bbfsuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1J2IvA5YoY+tfJ72VoCj8DnGGM7VCKzYh7vpzjFKLY9W3GQPJH8gwRaDwsbmFPQsO00RJdPuIrQNN1j41uzuMzc8XJpQl7YbE1Ay+BVbKRnA+xUS8U3C2nXa5BAStwnKhLwN2uoIUjUQkQ4ylrbddMgHyvVGWzo2OyskDF982o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sro4ArFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F5FC4CEE9;
	Tue, 11 Mar 2025 21:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741730233;
	bh=H2cT8jcME2fJEAJn4Ke0eNz2D+tUy8b8WcBs+Bbfsuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sro4ArFTyzNrsasLlaVdFZzq7b0KJ1DAoiovYEp7Wq7mbsOdr4mLK2RYZiBxXzMfe
	 L7hE3Sn/ynMDh2AJCR71DgZKV8jBdHmp5GUsIIgu6B0f/juC8sWum5x0ReIsI7ZB2m
	 oxX27mZLpcUoBObCXJh6GNwEHdVZ7fnYBJ1ne9cYPUDwHYXuKkiFdgjZ5o2aiHV1O7
	 w9Bd0v4OylJCKqM0EFGbcD2LwXZDR5WwKuINmVG1+UxmGplJ/KOxqDjVeidmcoso5h
	 rsq9OzOmsnNHX2dGanKcUrD7mQvx1Pdi2EL3aTLCueZ95vMbEBG0eLIneC2lEAc168
	 9FNFT/8j8HwTQ==
Date: Tue, 11 Mar 2025 21:57:12 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mingo@redhat.com, ssengar@linux.microsoft.com, tglx@linutronix.de,
	wei.liu@kernel.org, x86@kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, apais@microsoft.com,
	benhill@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3 0/2] x86/hyperv: VTL mode reboot fixes
Message-ID: <Z9CxuMk8RYLLKOsq@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250227214728.15672-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227214728.15672-1-romank@linux.microsoft.com>

On Thu, Feb 27, 2025 at 01:47:26PM -0800, Roman Kisel wrote:
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
> to the kernel command line in the OpenHCL bootloader[2]. There is
> no other option at the moment; when/if it appears the newly added
> callback's code can be adjusted as required.
> 
> [1] https://lore.kernel.org/all/20250109204352.1720337-1-romank@linux.microsoft.com/
> [2] https://github.com/microsoft/openvmm/blob/7a9d0e0a00461be6e5f3267af9ea54cc7157c900/openhcl/openhcl_boot/src/main.rs#L139
> 
> [V3]:
>     - Added verbs to the patch titles.
>       ** Thank you, Ingo!**
> 
> [V2]: https://lore.kernel.org/linux-hyperv/97010881-4b5e-4fb7-b8b3-b6c9e440e692@linux.microsoft.com/
>     - Fixed the warning from the kernel robot about using C23.
>       ** Thank you, kernel robot!**
> 
>     - Tightened up wording in the comments and the commit
>       descriptions.
>       ** Thank you, Saurabh!**
> 
>     - Dropped the CC: stable tag as there is no specific commit
>       this patch series fixes.
>       ** Thank you, Saurabh!**
> 
> [V1]: https://lore.kernel.org/linux-hyperv/20250117210702.1529580-1-romank@linux.microsoft.com/
> 
> Roman Kisel (2):
>   x86/hyperv: Add VTL mode emergency restart callback
>   x86/hyperv: Add VTL mode callback for restarting the system
> 

Applied to hyperv-next. Thanks.

