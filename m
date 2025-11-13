Return-Path: <linux-hyperv+bounces-7552-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7054FC59BF1
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9857B4E13A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AAE317708;
	Thu, 13 Nov 2025 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gbOT4UAV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76302C158F;
	Thu, 13 Nov 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062001; cv=none; b=Z3gfZqkwplJv9g9xg+R/2/g8zEGnzxd0bGKUvJDoIj4cwEwqySWw0NWtLZlqCare2lS1UG2iDcLRGoAPmR1H0kjzGhqOS4gbw7rOtuKE13MidhT/tGbZDi6kjMdst17J5lvMCqCdwfnlagKAPWw3/5Kjjs7jTuPdnS5B8g/OKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062001; c=relaxed/simple;
	bh=H+s+wXGlr05QZhtTdjxgkqOu/GHIlsKEGeIHF1ooc+M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LV6XjGsWhKmgq8k/5VL5NF46dDkELtdsgTYRhSgVAQo8iIbJLb7SDFFVFlqg/Cpup1u/WPNur1yHsXxHufiqI/bftXbPWpHpoWwKU2RFPOsZZcdYNJpYlPRgmLECRftEBIrWCh6GHyiG9sAjANtR6Rc6229jPthTXnB6HasfHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gbOT4UAV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 22E40201AE45;
	Thu, 13 Nov 2025 11:26:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22E40201AE45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763061998;
	bh=XP6qBn4xE2iY48r2TtR3Vn9u/QUliY3xJU8NscRXz/0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gbOT4UAVV0sdgmFbDAvfIkNxbGJbG6250u+duwdtjDhJb/v3qo5oPct7n9zytGfzh
	 o/7Ay+ePzKGeHQRony98QNEQdou1xX1Ag+yx6tI7Hu/zp7tvQ9e8I1ak9bArw5bRIa
	 bVSi/M0SwSXUtCdsZFmh36tnk2JpB7LeuZmm6YTM=
Message-ID: <8a8a7118-233b-468d-b8e9-43312cb11483@linux.microsoft.com>
Date: Thu, 13 Nov 2025 11:26:31 -0800
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
 nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com,
 mhklinux@outlook.com
Subject: Re: [PATCH v4 0/3] Add support for clean shutdown with MSHV
To: Praveen K Paladugu <prapal@linux.microsoft.com>
References: <20251107221700.45957-1-prapal@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20251107221700.45957-1-prapal@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2025 2:16 PM, Praveen K Paladugu wrote:
> Add support for clean shutdown of the root partition when running on
> MSHV Hypervisor.
> 
> v4:
>  - Adopted machine_ops to order invoking HV_ENTER_SLEEP_STATE as the
>    last step in shutdown sequence.
>  - This ensures rest of the cleanups are done before powering off
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
> Praveen K Paladugu (3):
>   hyperv: Add definitions for MSHV sleep state configuration
>   hyperv: Use reboot notifier to configure sleep state
>   hyperv: Cleanly shutdown root partition with MSHV
> 
>  arch/x86/hyperv/hv_init.c       |  9 +++
>  arch/x86/include/asm/mshyperv.h |  4 ++
>  drivers/hv/mshv_common.c        | 99 +++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h     |  4 +-
>  include/hyperv/hvhdk_mini.h     | 33 +++++++++++
>  5 files changed, 148 insertions(+), 1 deletion(-)
> 
For the series, modulo the lkp complaint about unused status in hv_machine_power_off()

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

