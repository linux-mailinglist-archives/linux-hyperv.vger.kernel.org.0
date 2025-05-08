Return-Path: <linux-hyperv+bounces-5437-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D689EAB0303
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 20:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02807BA5B0
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 18:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A57286D6E;
	Thu,  8 May 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDAbB5eE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214C286D68;
	Thu,  8 May 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729561; cv=none; b=QeaU8O96S/1ynALkxZarBjAqI+kJ3aDzZG7G2HVQk15fPi/FN60AbJMP0gMSp4Kpu9/hu9V4uahoqfasC0Io72A4YgWSwniUG5tpaoUdih7CLAl0lVr94n60yYPTRqewTS6SWOodHKAJZRxJceV66XH1TQklThGD5qV6NCl4RGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729561; c=relaxed/simple;
	bh=aSLCvMPJiFtdHctPooEDdmXbWiWznln96hcDJ8bZEhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2vhewlj0Wef16GPulNYXqRotoNhN2cGIlBdSyPeSpHedzQxi3CEXt8efK5XcbhNEyhoLP+WwHJZgGD3RNVsOQ2Y1mz/6zAZAQDOJD6RHSqUL8BmPHI2pqb7YfOvWFbsV4PpJYYvXjzKZNfGeXdFWl6Xos90DrOrfafGwHURDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDAbB5eE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3E0C4CEE7;
	Thu,  8 May 2025 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746729560;
	bh=aSLCvMPJiFtdHctPooEDdmXbWiWznln96hcDJ8bZEhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDAbB5eEujHm6EsEQZ9Z2k6629vZYnNcpL9OF3ut5SmCuCYYISa3Y5t+XSFz29nCN
	 kvIWRQin3ExBhrCgC9dsYnwFTRdaNIWUJIeWEaxhhxq8Mk6h1gxKCnaAsG2bbkU/qD
	 HOtK2L3xeCDILApkH+n0wO3TRIUDct4pcW4ZeTCpS8BEYnNEGwPf31obEANEhf1JiQ
	 YYMezgKwpRMzKMbv4uCEhukggb58k/Zkf6mqHMT4iq0qo0F+g8brAZC3Dlt4MDpBqD
	 KhEu9C4/CzFYc/NiMKXTAYpUW8VHA51KkvKDl1WOkaG5qH5rO2maQVoYwptapRwDn2
	 V6KBCR1Y5vI7w==
Date: Thu, 8 May 2025 18:39:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: ardb@kernel.org, bp@alien8.de, brgerst@gmail.com,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	dimitri.sivanich@hpe.com, gautham.shenoy@amd.com,
	haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com, jpoimboe@kernel.org,
	justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
	kys@microsoft.com, lenb@kernel.org, mhklinux@outlook.com,
	mingo@redhat.com, nikunj@amd.com, papaluri@amd.com,
	patryk.wlazlyn@linux.intel.com, peterz@infradead.org,
	rafael@kernel.org, russ.anderson@hpe.com, sohil.mehta@intel.com,
	steve.wahl@hpe.com, tglx@linutronix.de, thomas.lendacky@amd.com,
	tiala@microsoft.com, wei.liu@kernel.org, yuehaibing@huawei.com,
	linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next 0/2] arch/x86, x86/hyperv: Few fixes for the
 AP startup
Message-ID: <aBz6Vuv9w4uRjaG_@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250507182227.7421-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507182227.7421-1-romank@linux.microsoft.com>

On Wed, May 07, 2025 at 11:22:24AM -0700, Roman Kisel wrote:
> This patchset combines two patches that depend on each other and were not applying
> cleanly:
>   1. Fix APIC ID and VP index confusion in hv_snp_boot_ap():
>     https://lore.kernel.org/linux-hyperv/20250430204720.108962-1-romank@linux.microsoft.com/
>   2. Provide the CPU number in the wakeup AP callback:
>     https://lore.kernel.org/linux-hyperv/20250430204720.108962-1-romank@linux.microsoft.com/
> 
> I rebased the patches on top of the latest hyperv-next tree and updated the second patch
> that broke the linux-next build. That fix that, I made one non-functional change:
> updated the signature of numachip_wakeup_secondary() to match the parameter list of
> wakeup_secondary_cpu().
> 
> Roman Kisel (2):
>   x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()
>   arch/x86: Provide the CPU number in the wakeup AP callback

I queue these up.

Just so you know I'm experimenting a new setup. These have been applied
to hyperv-next-staging. It will take some time for them to propagate to
hyperv-next.

Thanks,
Wei.

> 
>  arch/x86/coco/sev/core.c             | 13 ++-----
>  arch/x86/hyperv/hv_init.c            | 33 +++++++++++++++++
>  arch/x86/hyperv/hv_vtl.c             | 54 ++++------------------------
>  arch/x86/hyperv/ivm.c                | 11 ++++--
>  arch/x86/include/asm/apic.h          |  8 ++---
>  arch/x86/include/asm/mshyperv.h      |  7 ++--
>  arch/x86/kernel/acpi/madt_wakeup.c   |  2 +-
>  arch/x86/kernel/apic/apic_noop.c     |  8 ++++-
>  arch/x86/kernel/apic/apic_numachip.c |  2 +-
>  arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
>  arch/x86/kernel/smpboot.c            | 10 +++---
>  include/hyperv/hvgdk_mini.h          |  2 +-
>  12 files changed, 76 insertions(+), 76 deletions(-)
> 
> 
> base-commit: 9b0844d87b1407681b78130429f798beb366f43f
> -- 
> 2.43.0
> 

