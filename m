Return-Path: <linux-hyperv+bounces-3546-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D292B9FD708
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 19:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB503A2087
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02645005;
	Fri, 27 Dec 2024 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lZm1HRcA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE31F7087;
	Fri, 27 Dec 2024 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735324965; cv=none; b=KZXGDIekmrgc7xb5hRosiZnpU6ixB0U4eQNpajyRNNfnO2T+tInz3gtZolXEcwjxZ7mj8DchghXEXrmGY5EJAI1Pe4wTTWrQ6h+3x6BQSoKXyC0X/auwM1DDWYdX8uEHCjX7lIZzoAHQt4WJTu3gIk8ROAljBv6SY10kIEt5O38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735324965; c=relaxed/simple;
	bh=A+BBvZyO3CfGAvySWJlVZTAxKUeNktWMfo8GT2L9te0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=txjPo0b2hlpG/50jy9sl07QEklSIUuAFz0RL6Y+MoZnIbseU7l7Rkiruvo9R11xysEX37CULMBXT1EKDs8jv8wKxfTz1M1AJuc1sx14w66pv9z8YUy9ZowOSjZo3NroN2Ap0/G4YbUAMQYtcaCWamwKnUCQFL+wDEV7wzQjmipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lZm1HRcA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.65.29] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id C8F22203EC38;
	Fri, 27 Dec 2024 10:42:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8F22203EC38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735324963;
	bh=hJi7mPmyw/Ve1vpTuzabpt9i67A26sg2hP41YYdO/4o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lZm1HRcAYGbnhFqHjHSwxrz1MZugOaZGVK9xZziW2A8m+wTqjIiDNAWtm+R71OSiu
	 48odD2JWAKUSw/TJJOCI0NtNLB7FttePElmZsIygu+GgQ5PLQW5ztxw8TX0e/4E8qS
	 bUNIiYHy21OAHU/mpP9pM5KsAHpCnVGzIpxL138Q=
Message-ID: <9cbdbad3-9ee8-42db-bd0d-b31986a07731@linux.microsoft.com>
Date: Fri, 27 Dec 2024 10:42:43 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, nunodasneves@linux.microsoft.com,
 tglx@linutronix.de, tiala@microsoft.com, wei.liu@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 eahariha@linux.microsoft.com, apais@microsoft.com, benhill@microsoft.com,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v4 0/5] hyperv: Fixes for get_vtl(),
 hv_vtl_apicid_to_vp_id()
To: Roman Kisel <romank@linux.microsoft.com>
References: <20241227183155.122827-1-romank@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20241227183155.122827-1-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/2024 10:31 AM, Roman Kisel wrote:
> The get_vtl(void) function
> 
> * has got one bug when the code started using a wrong pointer type after
>   refactoring, and also
> * the both function in question don't adhere to the requirements of
>   the Hypervisor Top-Level Funactional Specification[1, 2] as the code overlaps
>   the input and output areas for a hypercall.
> 
> The first issue leads to a wrong 100% reproducible computation due to reading
> a byte worth of data at a wrong offset. That in turn leads to using a nonsensical
> value ("fortunately", could catch it easily!) for the current VTL when initiating
> VMBus communications. As a repercussion from that, the system wouldn't boot. The
> fix is straightforward: use the correct pointer type.
> 
> The second issue doesn't seem to lead to any reproducible breakage just yet. It is
> fixed with using the output hypercall pages allocated per-CPU, and that isn't the
> only or the most obvious choice so let me elaborate why that fix appears to be the
> best one in my opinion out of the options I could conceive of.
> 
> The approach chosen for fixing the second issue makes two things shine through:
> 
> * these functions just get a vCPU register, no special treatment needs to be
>   involved,
> * VTLs and dom0 can and should share code as both exist to provide services to
>   a guest(s), be that from within the partition or from outside of it.
> 
> The projected benefits include replacing the functions in question with a future
> `hv_get_vp_registers` one shared between dom0 and VTLs to allow for a better test
> coverage.
> 
> I have validated the fixes by booting the fixed kernel in VTL2 up using OpenVMM and
> OpenHCL[3, 4].
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
> [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
> [3] https://openvmm.dev/guide/user_guide/openhcl.html
> [4] https://github.com/microsoft/OpenVMM
> 
> [v4]
>   - Wrapped DECLARE_FLEX_ARRAY into a struct and added one more
>     member as the documentation requires,
>   - Removed superfluous type coercion,
>   - Fixed tags,
>   - Rebased onto the latest hyperv-next branch.
> 
> [v3]: https://lore.kernel.org/lkml/20241226213110.899497-1-romank@linux.microsoft.com/
>   - Added a fix for hv_vtl_apicid_to_vp_id(),
>   - Split out the patch for enabling the hypercall output page,
>   - Updated the title of the patch series,
> 
> [v2]: https://lore.kernel.org/lkml/20241226203050.800524-1-romank@linux.microsoft.com/
>   - Used the suggestions to define an additional structure to improve code readability,
>   - Split out the patch with that definition.
> 
> [v1]: https://lore.kernel.org/lkml/20241218205421.319969-1-romank@linux.microsoft.com/
> 
> Roman Kisel (5):
>   hyperv: Define struct hv_output_get_vp_registers
>   hyperv: Fix pointer type in get_vtl(void)
>   hyperv: Enable the hypercall output page for the VTL mode
>   hyperv: Do not overlap the hvcall IO areas in get_vtl()
>   hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()
> 
>  arch/x86/hyperv/hv_init.c   |  6 ++--
>  arch/x86/hyperv/hv_vtl.c    |  2 +-
>  drivers/hv/hv_common.c      |  6 ++--
>  include/hyperv/hvgdk_mini.h | 65 +++++++++++++++++++++++++++++++++++--
>  4 files changed, 70 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 26e1b813fcd02984b1cac5f3decdf4b0bb56fe02

Thank you for the persistence!

For the series,

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

