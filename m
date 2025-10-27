Return-Path: <linux-hyperv+bounces-7352-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBEEC11824
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 22:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883B3428243
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093F328639;
	Mon, 27 Oct 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QC/sntyg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6486B321F5E;
	Mon, 27 Oct 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599630; cv=none; b=AWpUC8kLk5+MhpXSma92W9dw9QysCMPHEo9+zunrLtzkM5ZpGdPC+pBgBEPugC3okYhJqPNpYY5MvGSZH0jyatuHHXoWdcXBWVNZ90Rz7USl6KmEsEupZC9rwreic63wkIQfIS2T8ru7tXFUQBYuuzHP+3lTmBWs6zuCMBvaPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599630; c=relaxed/simple;
	bh=tO3FN4fxdhPi+yfIDlAC7iTTiwIEjcGocHaSjgwKCCE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u5ar43ANb0iFLfylwoFnYhgOOppY3KgI1yg8fAOp/xv9BnAVt5Bz3SG78ZzriYKFlBwmAd3dhz8KUcqUkpIFOdL6aXoKpaMdDe4OPmI4okIMb0aJU1w2gk2v8IOHSMEHTXLOhAuzQaLWA+uHDAKowECF4GkpSZdGv2h501jBhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QC/sntyg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE46A200FE45;
	Mon, 27 Oct 2025 14:13:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE46A200FE45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761599627;
	bh=5BEQ+Rdazd68OImD4lrHLz3JOy1h0JL4+nN9aWLZ9sE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QC/sntygHjFiX4MEiMHQDLnyrdoYuR+JLg5jbYoou1XPIi6QpUq/gQ/Vi3zCWsNWx
	 3qmj1Ir/w43y4dbogm9orxqP0W1U5uQyRNoHtKKtcM2ZGJMlU+G3ZRKfRc1+ciHTSn
	 zUU1QIGjRcpKcdY5n39Mk/LCVQ9jjkQL3iewRl08=
Message-ID: <b5c82c21-fef5-4ddb-bc0f-d0d5d89e5a5d@linux.microsoft.com>
Date: Mon, 27 Oct 2025 14:13:36 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: easwar.hariharan@linux.microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com,
 nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v3 0/2] Add support for clean shutdown with MSHV
To: Praveen K Paladugu <prapal@linux.microsoft.com>
References: <20251027202859.72006-1-prapal@linux.microsoft.com>
 <9097e99c-8d80-44c2-9dab-87166760af9b@linux.microsoft.com>
 <a50ef2a9-44da-4154-8a4a-a21a7bf15836@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <a50ef2a9-44da-4154-8a4a-a21a7bf15836@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/2025 2:11 PM, Praveen K Paladugu wrote:
> 
> 
> On 10/27/2025 3:56 PM, Easwar Hariharan wrote:
>> On 10/27/2025 1:28 PM, Praveen K Paladugu wrote:
>>> Add support for clean shutdown of the root partition when running on MSHV
>>> hypervisor.
>>>
>>> v3:
>>>   - Dropped acpi_sleep handlers as they are not used on mshv
>>>   - Applied ordering for hv_reboot_notifier
>>>   - Fixed build issues on i386, arm64 architectures
>>>
>>> v2:
>>>    - Addressed review comments from v1.
>>>    - Moved all sleep state handling methods under CONFIG_ACPI stub
>>>    - - This fixes build issues on non-x86 architectures.
>>>
>>> Praveen K Paladugu (2):
>>>    hyperv: Add definitions for MSHV sleep state configuration
>>>    hyperv: Enable clean shutdown for root partition with MSHV
>>>
>>>   arch/x86/hyperv/hv_init.c       |   8 +++
>>>   arch/x86/include/asm/mshyperv.h |   2 +
>>>   drivers/hv/mshv_common.c        | 103 ++++++++++++++++++++++++++++++++
>>>   include/hyperv/hvgdk_mini.h     |   4 +-
>>>   include/hyperv/hvhdk_mini.h     |  33 ++++++++++
>>>   5 files changed, 149 insertions(+), 1 deletion(-)
>>>
>>
>> This series seems to assume that Mukesh's hypervisor crash series has been merged, but that's not the case.
>> I don't see any code context or logical dependency on that series, but correct me if I'm wrong. If there's no
>> dependency, can you send a v4 based on Linus' tree or hyperv-next to avoid a merge conflict?
>>
> 
> I rebased this patchset on top of hyperv/hyperv-next branch, which has crashdump patches: https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
> 
> Let me know if I missed/misunderstood anything.
>

Nope, a miss on my part. Sorry about the noise.

Thanks,
Easwar (he/him)

