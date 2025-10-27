Return-Path: <linux-hyperv+bounces-7351-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21575C117CA
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 22:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD041A631C0
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43449328622;
	Mon, 27 Oct 2025 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Op/X1Tkr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4030326D45;
	Mon, 27 Oct 2025 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599477; cv=none; b=ulbvCHGihryNX1g4V8uGvfhgQo39sPYHAXX9bDrV774bOhctboALfAtlBBALz2y8L4Q4BfxKUTOLu+BgjfDcpuRJWnYhudcYs/PnDHCHPVySzY5AVPq5PHWx+yvjaUGPQEtf/0RxiSA3HaYBEM1wE6cKMpHyLIxR6nBttR0sRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599477; c=relaxed/simple;
	bh=4n9QIdJQ3ilSVQij+WP1ABTTm2Q8Tv5JdHLCiFPkaO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAdKheZhcWx9i1T+d3+uQOM0ygIDPsPUREV+d4zQQnAl7V/0AbXIC/v/YL3T/wnsZzMsCqlCKIddcu2jMXcvpq9YiQJMxAcQoJhn70aTnyyJao2AJcrKaxNwtNN7q+FmEiSOUXuByxwUu8k8vW/roQkov+EdgM/0BeF6pLuN3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Op/X1Tkr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.76.96.75] (unknown [20.97.10.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 63B17200FE4D;
	Mon, 27 Oct 2025 14:11:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63B17200FE4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761599474;
	bh=emPHTxDsECB1m3bST7rxoZFSUDfKsuIuBI3rEmfSJOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Op/X1Tkr31eLC6+9hJman1GDU3oFw0FxhzgJFqT0ai9xc6oxeQG+luAkboWClfYRX
	 XX1jcGGKQ9g6Gg1VEN+jdRUqbPJqSH+1eGEB4rNMWg83t79lHbPw5ChLmIfDnVZ6c1
	 9rdosqOPabi3A8+1MzZsLb3GGxZgI03Hu3+CNaZo=
Message-ID: <a50ef2a9-44da-4154-8a4a-a21a7bf15836@linux.microsoft.com>
Date: Mon, 27 Oct 2025 16:11:13 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add support for clean shutdown with MSHV
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 anbelski@linux.microsoft.com, nunodasneves@linux.microsoft.com,
 skinsburskii@linux.microsoft.com
References: <20251027202859.72006-1-prapal@linux.microsoft.com>
 <9097e99c-8d80-44c2-9dab-87166760af9b@linux.microsoft.com>
Content-Language: en-US
From: Praveen K Paladugu <prapal@linux.microsoft.com>
In-Reply-To: <9097e99c-8d80-44c2-9dab-87166760af9b@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/2025 3:56 PM, Easwar Hariharan wrote:
> On 10/27/2025 1:28 PM, Praveen K Paladugu wrote:
>> Add support for clean shutdown of the root partition when running on MSHV
>> hypervisor.
>>
>> v3:
>>   - Dropped acpi_sleep handlers as they are not used on mshv
>>   - Applied ordering for hv_reboot_notifier
>>   - Fixed build issues on i386, arm64 architectures
>>
>> v2:
>>    - Addressed review comments from v1.
>>    - Moved all sleep state handling methods under CONFIG_ACPI stub
>>    - - This fixes build issues on non-x86 architectures.
>>
>> Praveen K Paladugu (2):
>>    hyperv: Add definitions for MSHV sleep state configuration
>>    hyperv: Enable clean shutdown for root partition with MSHV
>>
>>   arch/x86/hyperv/hv_init.c       |   8 +++
>>   arch/x86/include/asm/mshyperv.h |   2 +
>>   drivers/hv/mshv_common.c        | 103 ++++++++++++++++++++++++++++++++
>>   include/hyperv/hvgdk_mini.h     |   4 +-
>>   include/hyperv/hvhdk_mini.h     |  33 ++++++++++
>>   5 files changed, 149 insertions(+), 1 deletion(-)
>>
> 
> This series seems to assume that Mukesh's hypervisor crash series has been merged, but that's not the case.
> I don't see any code context or logical dependency on that series, but correct me if I'm wrong. If there's no
> dependency, can you send a v4 based on Linus' tree or hyperv-next to avoid a merge conflict?
> 

I rebased this patchset on top of hyperv/hyperv-next branch, which has 
crashdump patches: 
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next

Let me know if I missed/misunderstood anything.


> Thanks,
> Easwar (he/him)


