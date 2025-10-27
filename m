Return-Path: <linux-hyperv+bounces-7350-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC66C1172A
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 881304E8320
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 20:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE531C580;
	Mon, 27 Oct 2025 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KMCwNNrL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C21328313D;
	Mon, 27 Oct 2025 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598575; cv=none; b=ZX4Nbp1b6cByEiBSsmQSkOZkHeWKDIlUl0owICYLokxOdX2TS/c9/NfhjDk529wneGLjJul9TrM2A18i+QDTW6Do5Gydh0fOkMy8R+K8SKdjOMoGWMC6JGhK6aZs9EjFZ7ChD2rEpZcrw3VRiGHygwitLoTnq3M33xh86QgKfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598575; c=relaxed/simple;
	bh=lmVe/Iqjej0fsxeH7RKHZm4Wv3RimwimtNNRfmJViqU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OfkqxwwmIBAHMQgGeojp8tbGft3Ys1P1f9/yBPFTOBTxwLECBBAZOk4UsjK7ZplXW3WcPzFOl6JWBNo7TK8BhfFvURjLRKvNd9d0i24xN9Zl986hTivBnHetXIUtvElK2UpjlXkc02O80hRxjLHZJyi/T3HithYswPJ6KE86iVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KMCwNNrL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5CED4200FE48;
	Mon, 27 Oct 2025 13:56:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CED4200FE48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761598573;
	bh=/Tuphiv5XiGHszvroQP4N8AV1kSi3JyfaJmLaudRG3U=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KMCwNNrL9jXmyJ/Iz7kPEjZSOl69Sqr6g1llji2BPGVEhKfDb6jfXtsqmb7ixJ9PK
	 U1sYeI239XUqCdrz5QULPbWqlRS5XmoP+1+ORxUdwstzU6Owv4GR56TCmWEigoMoQG
	 +sBsnQpabQ1XbP7FYrFajA2a45on5WZmHUX1AwU4=
Message-ID: <9097e99c-8d80-44c2-9dab-87166760af9b@linux.microsoft.com>
Date: Mon, 27 Oct 2025 13:56:02 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 easwar.hariharan@linux.microsoft.com, anbelski@linux.microsoft.com,
 nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v3 0/2] Add support for clean shutdown with MSHV
To: Praveen K Paladugu <prapal@linux.microsoft.com>
References: <20251027202859.72006-1-prapal@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20251027202859.72006-1-prapal@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/2025 1:28 PM, Praveen K Paladugu wrote:
> Add support for clean shutdown of the root partition when running on MSHV
> hypervisor.
> 
> v3:
>  - Dropped acpi_sleep handlers as they are not used on mshv
>  - Applied ordering for hv_reboot_notifier
>  - Fixed build issues on i386, arm64 architectures
> 
> v2:
>   - Addressed review comments from v1.
>   - Moved all sleep state handling methods under CONFIG_ACPI stub
>   - - This fixes build issues on non-x86 architectures.
> 
> Praveen K Paladugu (2):
>   hyperv: Add definitions for MSHV sleep state configuration
>   hyperv: Enable clean shutdown for root partition with MSHV
> 
>  arch/x86/hyperv/hv_init.c       |   8 +++
>  arch/x86/include/asm/mshyperv.h |   2 +
>  drivers/hv/mshv_common.c        | 103 ++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h     |   4 +-
>  include/hyperv/hvhdk_mini.h     |  33 ++++++++++
>  5 files changed, 149 insertions(+), 1 deletion(-)
> 

This series seems to assume that Mukesh's hypervisor crash series has been merged, but that's not the case.
I don't see any code context or logical dependency on that series, but correct me if I'm wrong. If there's no
dependency, can you send a v4 based on Linus' tree or hyperv-next to avoid a merge conflict?

Thanks,
Easwar (he/him)

