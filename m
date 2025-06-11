Return-Path: <linux-hyperv+bounces-5877-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBA9AD5D8B
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 19:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866B216995E
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F472686B9;
	Wed, 11 Jun 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cjF2ILhl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCFB25EF94;
	Wed, 11 Jun 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664538; cv=none; b=OwxCKs9X9nvsoxiw3uSIBkAVI66PQ0urS6sRARFRZKfthR36qzvE0n911l2tDoipTUINedYjr8eKVOic+c3t9JjSuYDHXRTn5xhQQ+HtRDv2XOPlP8Q5Tqeu2w6LXgWHdlc9uSkJ78NY/aIihzbnUfq8au1y3Uecrn5msbhlQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664538; c=relaxed/simple;
	bh=BVVzexcYLJkxpQIX3fIaNYt0G1r4djbiE0jciYNbgLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwGoAez5sR02WhennGMvfz5yId8TAyvxJ4iH0WumVMqWGO5Asi/MNBLqWZkdd1EXPpIAhCSy1e+g9OvIllPTr82hjlRB1rHES3ArfcibGwjQbaoOoRGrvrNpR8X4MjMvEe7F+bkHsTp8463ZiocIIm1QiavVr931nGLVTQSruKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cjF2ILhl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6008C2115196;
	Wed, 11 Jun 2025 10:55:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6008C2115196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749664535;
	bh=dotjx06SWmrVjPB7Z2CaqcDqgv/mNIYEKk1xOmc6KOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cjF2ILhlABGfqzXOL8i/Inel2VXBacL66m3r5jCIXFlyPhYhWrN4VVsqd2tFGUKXI
	 jF88qXNWtH88d9gPYf5vtHAfDc8PWhbKIkRSclxSRH4KTwZW3vugN2D2HTBAYneopq
	 ycI7z13UXKktCQ5PwqqxhVnX1vZskifni4JlDQaY=
Message-ID: <2c8d534b-02c5-4149-882b-40eb27671614@linux.microsoft.com>
Date: Wed, 11 Jun 2025 10:55:35 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Nested virtualization fixes for root partition
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, lpieralisi@kernel.org,
 kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, jinankjain@linux.microsoft.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/10/2025 4:52 PM, Nuno Das Neves wrote:
> Fixes for running as nested root partition on the Microsoft Hypervisor.
> 
> The first patch prevents the vmbus driver being registered on baremetal, since
> there's no vmbus in this scenario.
> 
> The second patch changes vmbus to make hypercalls to the L0 hypervisor instead
> of the L1. This is needed because L0 hypervisor, not the L1, is the one hosting
> the Windows root partition with the VMM that provides vmbus.
> 
> The 3rd and 4th patches fix interrupt unmasking on nested. In this scenario,
> the L1 (nested) hypervisor does the interrupt mapping to root partition cores.
> The vectors just need to be mapped with MAP_DEVICE_INTERRUPT instead of
> affinitized with RETARGET_INTERRUPT.
> 
> Mukesh Rathor (1):
>    PCI: hv: Do not do vmbus initialization on baremetal
> 
> Nuno Das Neves (1):
>    Drivers: hv: Use nested hypercall for post message and signal event
> 
> Stanislav Kinsburskii (2):
>    x86: hyperv: Expose hv_map_msi_interrupt function
>    PCI: hv: Use the correct hypercall for unmasking interrupts on nested
> 
>   arch/arm64/include/asm/mshyperv.h   | 10 ++++++
>   arch/x86/hyperv/irqdomain.c         | 47 +++++++++++++++++++++--------
>   arch/x86/include/asm/mshyperv.h     |  2 ++
>   drivers/hv/connection.c             |  3 ++
>   drivers/hv/hv.c                     |  3 ++
>   drivers/pci/controller/pci-hyperv.c | 21 +++++++++++--
>   6 files changed, 71 insertions(+), 15 deletions(-)
> 

Very cool stuff :) LGTM.

For the patch series:
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

-- 
Thank you,
Roman


