Return-Path: <linux-hyperv+bounces-7955-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA6CA1C18
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 23:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3779F300418C
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 21:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD14332EB0;
	Wed,  3 Dec 2025 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MOl+nWAB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3F73176F8;
	Wed,  3 Dec 2025 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799090; cv=none; b=XIe8IBOK76LjXX7gKMiUwncZULTuYO2ID+1zFhb7m6aip2r3wBACPA+vpDrjzQCaS7qp6Ug4ufD4TjYGWe/T1zBl05BqT6YbrxsXyZp3r9GOwV4qKYojV4akD9mtiPIx7cXu2obaLINiAD36Ps8ZAuSUQxKAs9fXVwRGUBpr+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799090; c=relaxed/simple;
	bh=wCQyLdeyQH7xBbNWiMugRq1EWfg2OIHrcm4tXXTzCDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIWnsPR4rlVqWESN8Dbt4u3HHIxCfVmU+q2xvh465U7HGwSHoSkscwQSe1QgihAhc2b0Xb5VrgxeYAC9L6DoBXqMTG/GbjU/1tf9kNTb1UMBIb+396TFRDxesSjTLwcHPi7Xku0lD3F8P58f62B3l7lI/ZSNdIGCiUzpLF+tOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MOl+nWAB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.205] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 179C32120E87;
	Wed,  3 Dec 2025 13:58:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 179C32120E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764799086;
	bh=lMn3mqjiHeSXwjUdyptgs6wyhe6SQCKYF+mJUVkwNP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MOl+nWABDMdNmBvTkeduDTW79sa0FgowibjsS69qY60MfkJ1pvpdP7yu68lRIu35v
	 p4HRrpLgRio/oY2lHvqKw78DWDOWWbbB+sYuNM1b18ljPy4BojSLcASoAYWP2agw/+
	 2JEQRB0/hdTO5oTWveGd6XgMEM2fYUg3KIyL61rY=
Message-ID: <c35bb6fd-9b9f-4e56-8124-f9a41f532c68@linux.microsoft.com>
Date: Wed, 3 Dec 2025 13:58:05 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mshv: Add definitions for stats pages
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
 prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
 paekkaladevi@linux.microsoft.com
References: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764784405-4484-3-git-send-email-nunodasneves@linux.microsoft.com>
 <aTCKL1XBxZ8w6kqY@skinsburskii.localdomain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <aTCKL1XBxZ8w6kqY@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/2025 11:06 AM, Stanislav Kinsburskii wrote:
> On Wed, Dec 03, 2025 at 09:53:24AM -0800, Nuno Das Neves wrote:
>> Add the definitions for hypervisor, logical processor, and partition
>> stats pages.
>>
>> Move the definition for the VP stats page to its rightful place in
>> hvhdk.h, and add the missing members.
>>
>> These enum members retain their CamelCase style, since they are imported
>> directly from the hypervisor code They will be stringified when printing
>> the stats out, and retain more readability in this form.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/mshv_root_main.c |  17 --
>>  include/hyperv/hvhdk.h      | 437 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 437 insertions(+), 17 deletions(-)
>>
> 
> <snip>
> 
>> +
>> +enum hv_stats_partition_counters {		/* HV_PROCESS_COUNTER */
>> +	PartitionVirtualProcessors		= 1,
>> +	PartitionTlbSize			= 3,
>> +	PartitionAddressSpaces			= 4,
>> +	PartitionDepositedPages			= 5,
>> +	PartitionGpaPages			= 6,
>> +	PartitionGpaSpaceModifications		= 7,
>> +	PartitionVirtualTlbFlushEntires		= 8,
>> +	PartitionRecommendedTlbSize		= 9,
>> +	PartitionGpaPages4K			= 10,
>> +	PartitionGpaPages2M			= 11,
>> +	PartitionGpaPages1G			= 12,
>> +	PartitionGpaPages512G			= 13,
>> +	PartitionDevicePages4K			= 14,
>> +	PartitionDevicePages2M			= 15,
>> +	PartitionDevicePages1G			= 16,
>> +	PartitionDevicePages512G		= 17,
>> +	PartitionAttachedDevices		= 18,
>> +	PartitionDeviceInterruptMappings	= 19,
>> +	PartitionIoTlbFlushes			= 20,
>> +	PartitionIoTlbFlushCost			= 21,
>> +	PartitionDeviceInterruptErrors		= 22,
>> +	PartitionDeviceDmaErrors		= 23,
>> +	PartitionDeviceInterruptThrottleEvents	= 24,
>> +	PartitionSkippedTimerTicks		= 25,
>> +	PartitionPartitionId			= 26,
>> +#if IS_ENABLED(CONFIG_X86)
> 
> Why isn't this CONFIG_X86_64 instead (here and below)?

An oversight, thanks for catching it.
I'll change it to CONFIG_X86_64

> 
> Thanks,
> Stanislav


