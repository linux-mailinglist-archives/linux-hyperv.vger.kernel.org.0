Return-Path: <linux-hyperv+bounces-8491-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOKnLFrGc2lZygAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8491-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 20:04:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B0779F47
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 20:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C7693003D10
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31E1F181F;
	Fri, 23 Jan 2026 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jm7o/QO4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972C62AD3D;
	Fri, 23 Jan 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195096; cv=none; b=bFEY7pE9pRBeO/YF13exW0usXpwinQZW5CUiBN3vogMkTd+WjfEDZXBZmyXGJt1CAVn4k6rS62QLj5/2aLPnocHc+1kLdvjlimJOSnHpq5CVUMlZy6ssWedyDBzKAw2Je1kg8h2AtQYZFa2vj9stcpNm22EV4tO34MIiEh03KBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195096; c=relaxed/simple;
	bh=r2o+aO0wipbJWW54GKb06lDZIt1g0/yJ+y7EEErVEYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2nFYLfjOJUT0eT0qlDWIBQK42gWduIpsyLM+PwA8jB0vFl/lQonCwEC2I7wkm57xSdwzTLzBjAhvL8wiRRb+nvXp+F1PclGy6cbpMhMAFBQUTIBNHVXOfvhB2v5+ubkQ72La71oO2JF7y2iQgsa+LQh+2mUQB1t8PRM8yiT4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jm7o/QO4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.200.94] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D20820B7167;
	Fri, 23 Jan 2026 11:04:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D20820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769195093;
	bh=fIqKkFf6ReHD1wiRblTzxnzkeYJI/kaiXLJVZFKq36E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jm7o/QO4CoqbKmM7b2fX0OP4IPh2NDrQ8rb8hdX8tkvYeJlRvJyJIV5hx6b9jTexm
	 2G4wezZgNhKmZYmPA+xife8Opky0Z9PcWObkmsoJ+i9jzGw6eNp3Ank/k6mlAQhY2g
	 cDgYVKVY+oCGrfCbyaBt1ov9g6zT5IZvEj9huhQw=
Message-ID: <2ea6f13f-ac2e-4ed7-9f2c-6c079cb25b85@linux.microsoft.com>
Date: Fri, 23 Jan 2026 11:04:52 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] mshv: Add data for printing stats page counters
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "paekkaladevi@linux.microsoft.com" <paekkaladevi@linux.microsoft.com>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
 <20260121214623.76374-7-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41572B2CC3494BE6BC737424D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41572B2CC3494BE6BC737424D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8491-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,vger.kernel.org,linux.microsoft.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nunodasneves@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 23B0779F47
X-Rspamd-Action: no action

On 1/23/2026 9:09 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, January 21, 2026 1:46 PM
>>
>> Introduce hv_counters.c, containing static data corresponding to
>> HV_*_COUNTER enums in the hypervisor source. Defining the enum
>> members as an array instead makes more sense, since it will be
>> iterated over to print counter information to debugfs.
> 
> I would have expected the filename to be mshv_counters.c, so that the association
> with the MS hypervisor is clear. And the file is inextricably linked to mshv_debugfs.c,
> which of course has the "mshv_" prefix. Or is there some thinking I'm not aware of
> for using the "hv_" prefix?
> 
Good question - I originally thought of using hv_ because the definitions inside are
part of the hypervisor ABI, and hence also have the hv_ prefix.

However you have a good point, and I'm not opposed to changing it.

Maybe to just be super explicit: "mshv_debugfs_counters.c" ?

> Also, I see in Patch 7 of this series that hv_counters.c is #included as a .c file
> in mshv_debugfs.c. Is there a reason for doing the #include instead of adding
> hv_counters.c to the Makefile and building it on its own? You would need to
> add a handful of extern statements to mshv_root.h so that the tables are
> referenceable from mshv_debugfs.c. But that would seem to be the more
> normal way of doing things.  #including a .c file is unusual.
> 

Yes...I thought I could avoid noise in mshv_root.h and the Makefile, since it's
only relevant for mshv_debugfs.c. However I could see this file (whether as .c or
.h) being misused and included elsewhere inadvertantly, which would duplicate the
tables, so maybe doing it the normal way is a better idea, even if mshv_debugfs.c
is likely the only user.

> See one more comment on the last line of this patch ...
> 
>>
>> Include hypervisor, logical processor, partition, and virtual
>> processor counters.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/hv_counters.c | 488 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 488 insertions(+)
>>  create mode 100644 drivers/hv/hv_counters.c
>>
>> diff --git a/drivers/hv/hv_counters.c b/drivers/hv/hv_counters.c
>> new file mode 100644
>> index 000000000000..a8e07e72cc29
>> --- /dev/null
>> +++ b/drivers/hv/hv_counters.c
>> @@ -0,0 +1,488 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2026, Microsoft Corporation.
>> + *
>> + * Data for printing stats page counters via debugfs.
>> + *
>> + * Authors: Microsoft Linux virtualization team
>> + */
>> +
>> +struct hv_counter_entry {
>> +	char *name;
>> +	int idx;
>> +};
>> +
>> +/* HV_HYPERVISOR_COUNTER */
>> +static struct hv_counter_entry hv_hypervisor_counters[] = {
>> +	{ "HvLogicalProcessors", 1 },
>> +	{ "HvPartitions", 2 },
>> +	{ "HvTotalPages", 3 },
>> +	{ "HvVirtualProcessors", 4 },
>> +	{ "HvMonitoredNotifications", 5 },
>> +	{ "HvModernStandbyEntries", 6 },
>> +	{ "HvPlatformIdleTransitions", 7 },
>> +	{ "HvHypervisorStartupCost", 8 },
>> +
>> +	{ "HvIOSpacePages", 10 },
>> +	{ "HvNonEssentialPagesForDump", 11 },
>> +	{ "HvSubsumedPages", 12 },
>> +};
>> +
>> +/* HV_CPU_COUNTER */
>> +static struct hv_counter_entry hv_lp_counters[] = {
>> +	{ "LpGlobalTime", 1 },
>> +	{ "LpTotalRunTime", 2 },
>> +	{ "LpHypervisorRunTime", 3 },
>> +	{ "LpHardwareInterrupts", 4 },
>> +	{ "LpContextSwitches", 5 },
>> +	{ "LpInterProcessorInterrupts", 6 },
>> +	{ "LpSchedulerInterrupts", 7 },
>> +	{ "LpTimerInterrupts", 8 },
>> +	{ "LpInterProcessorInterruptsSent", 9 },
>> +	{ "LpProcessorHalts", 10 },
>> +	{ "LpMonitorTransitionCost", 11 },
>> +	{ "LpContextSwitchTime", 12 },
>> +	{ "LpC1TransitionsCount", 13 },
>> +	{ "LpC1RunTime", 14 },
>> +	{ "LpC2TransitionsCount", 15 },
>> +	{ "LpC2RunTime", 16 },
>> +	{ "LpC3TransitionsCount", 17 },
>> +	{ "LpC3RunTime", 18 },
>> +	{ "LpRootVpIndex", 19 },
>> +	{ "LpIdleSequenceNumber", 20 },
>> +	{ "LpGlobalTscCount", 21 },
>> +	{ "LpActiveTscCount", 22 },
>> +	{ "LpIdleAccumulation", 23 },
>> +	{ "LpReferenceCycleCount0", 24 },
>> +	{ "LpActualCycleCount0", 25 },
>> +	{ "LpReferenceCycleCount1", 26 },
>> +	{ "LpActualCycleCount1", 27 },
>> +	{ "LpProximityDomainId", 28 },
>> +	{ "LpPostedInterruptNotifications", 29 },
>> +	{ "LpBranchPredictorFlushes", 30 },
>> +#if IS_ENABLED(CONFIG_X86_64)
>> +	{ "LpL1DataCacheFlushes", 31 },
>> +	{ "LpImmediateL1DataCacheFlushes", 32 },
>> +	{ "LpMbFlushes", 33 },
>> +	{ "LpCounterRefreshSequenceNumber", 34 },
>> +	{ "LpCounterRefreshReferenceTime", 35 },
>> +	{ "LpIdleAccumulationSnapshot", 36 },
>> +	{ "LpActiveTscCountSnapshot", 37 },
>> +	{ "LpHwpRequestContextSwitches", 38 },
>> +	{ "LpPlaceholder1", 39 },
>> +	{ "LpPlaceholder2", 40 },
>> +	{ "LpPlaceholder3", 41 },
>> +	{ "LpPlaceholder4", 42 },
>> +	{ "LpPlaceholder5", 43 },
>> +	{ "LpPlaceholder6", 44 },
>> +	{ "LpPlaceholder7", 45 },
>> +	{ "LpPlaceholder8", 46 },
>> +	{ "LpPlaceholder9", 47 },
>> +	{ "LpSchLocalRunListSize", 48 },
>> +	{ "LpReserveGroupId", 49 },
>> +	{ "LpRunningPriority", 50 },
>> +	{ "LpPerfmonInterruptCount", 51 },
>> +#elif IS_ENABLED(CONFIG_ARM64)
>> +	{ "LpCounterRefreshSequenceNumber", 31 },
>> +	{ "LpCounterRefreshReferenceTime", 32 },
>> +	{ "LpIdleAccumulationSnapshot", 33 },
>> +	{ "LpActiveTscCountSnapshot", 34 },
>> +	{ "LpHwpRequestContextSwitches", 35 },
>> +	{ "LpPlaceholder2", 36 },
>> +	{ "LpPlaceholder3", 37 },
>> +	{ "LpPlaceholder4", 38 },
>> +	{ "LpPlaceholder5", 39 },
>> +	{ "LpPlaceholder6", 40 },
>> +	{ "LpPlaceholder7", 41 },
>> +	{ "LpPlaceholder8", 42 },
>> +	{ "LpPlaceholder9", 43 },
>> +	{ "LpSchLocalRunListSize", 44 },
>> +	{ "LpReserveGroupId", 45 },
>> +	{ "LpRunningPriority", 46 },
>> +#endif
>> +};
>> +
>> +/* HV_PROCESS_COUNTER */
>> +static struct hv_counter_entry hv_partition_counters[] = {
>> +	{ "PtVirtualProcessors", 1 },
>> +
>> +	{ "PtTlbSize", 3 },
>> +	{ "PtAddressSpaces", 4 },
>> +	{ "PtDepositedPages", 5 },
>> +	{ "PtGpaPages", 6 },
>> +	{ "PtGpaSpaceModifications", 7 },
>> +	{ "PtVirtualTlbFlushEntires", 8 },
>> +	{ "PtRecommendedTlbSize", 9 },
>> +	{ "PtGpaPages4K", 10 },
>> +	{ "PtGpaPages2M", 11 },
>> +	{ "PtGpaPages1G", 12 },
>> +	{ "PtGpaPages512G", 13 },
>> +	{ "PtDevicePages4K", 14 },
>> +	{ "PtDevicePages2M", 15 },
>> +	{ "PtDevicePages1G", 16 },
>> +	{ "PtDevicePages512G", 17 },
>> +	{ "PtAttachedDevices", 18 },
>> +	{ "PtDeviceInterruptMappings", 19 },
>> +	{ "PtIoTlbFlushes", 20 },
>> +	{ "PtIoTlbFlushCost", 21 },
>> +	{ "PtDeviceInterruptErrors", 22 },
>> +	{ "PtDeviceDmaErrors", 23 },
>> +	{ "PtDeviceInterruptThrottleEvents", 24 },
>> +	{ "PtSkippedTimerTicks", 25 },
>> +	{ "PtPartitionId", 26 },
>> +#if IS_ENABLED(CONFIG_X86_64)
>> +	{ "PtNestedTlbSize", 27 },
>> +	{ "PtRecommendedNestedTlbSize", 28 },
>> +	{ "PtNestedTlbFreeListSize", 29 },
>> +	{ "PtNestedTlbTrimmedPages", 30 },
>> +	{ "PtPagesShattered", 31 },
>> +	{ "PtPagesRecombined", 32 },
>> +	{ "PtHwpRequestValue", 33 },
>> +	{ "PtAutoSuspendEnableTime", 34 },
>> +	{ "PtAutoSuspendTriggerTime", 35 },
>> +	{ "PtAutoSuspendDisableTime", 36 },
>> +	{ "PtPlaceholder1", 37 },
>> +	{ "PtPlaceholder2", 38 },
>> +	{ "PtPlaceholder3", 39 },
>> +	{ "PtPlaceholder4", 40 },
>> +	{ "PtPlaceholder5", 41 },
>> +	{ "PtPlaceholder6", 42 },
>> +	{ "PtPlaceholder7", 43 },
>> +	{ "PtPlaceholder8", 44 },
>> +	{ "PtHypervisorStateTransferGeneration", 45 },
>> +	{ "PtNumberofActiveChildPartitions", 46 },
>> +#elif IS_ENABLED(CONFIG_ARM64)
>> +	{ "PtHwpRequestValue", 27 },
>> +	{ "PtAutoSuspendEnableTime", 28 },
>> +	{ "PtAutoSuspendTriggerTime", 29 },
>> +	{ "PtAutoSuspendDisableTime", 30 },
>> +	{ "PtPlaceholder1", 31 },
>> +	{ "PtPlaceholder2", 32 },
>> +	{ "PtPlaceholder3", 33 },
>> +	{ "PtPlaceholder4", 34 },
>> +	{ "PtPlaceholder5", 35 },
>> +	{ "PtPlaceholder6", 36 },
>> +	{ "PtPlaceholder7", 37 },
>> +	{ "PtPlaceholder8", 38 },
>> +	{ "PtHypervisorStateTransferGeneration", 39 },
>> +	{ "PtNumberofActiveChildPartitions", 40 },
>> +#endif
>> +};
>> +
>> +/* HV_THREAD_COUNTER */
>> +static struct hv_counter_entry hv_vp_counters[] = {
>> +	{ "VpTotalRunTime", 1 },
>> +	{ "VpHypervisorRunTime", 2 },
>> +	{ "VpRemoteNodeRunTime", 3 },
>> +	{ "VpNormalizedRunTime", 4 },
>> +	{ "VpIdealCpu", 5 },
>> +
>> +	{ "VpHypercallsCount", 7 },
>> +	{ "VpHypercallsTime", 8 },
>> +#if IS_ENABLED(CONFIG_X86_64)
>> +	{ "VpPageInvalidationsCount", 9 },
>> +	{ "VpPageInvalidationsTime", 10 },
>> +	{ "VpControlRegisterAccessesCount", 11 },
>> +	{ "VpControlRegisterAccessesTime", 12 },
>> +	{ "VpIoInstructionsCount", 13 },
>> +	{ "VpIoInstructionsTime", 14 },
>> +	{ "VpHltInstructionsCount", 15 },
>> +	{ "VpHltInstructionsTime", 16 },
>> +	{ "VpMwaitInstructionsCount", 17 },
>> +	{ "VpMwaitInstructionsTime", 18 },
>> +	{ "VpCpuidInstructionsCount", 19 },
>> +	{ "VpCpuidInstructionsTime", 20 },
>> +	{ "VpMsrAccessesCount", 21 },
>> +	{ "VpMsrAccessesTime", 22 },
>> +	{ "VpOtherInterceptsCount", 23 },
>> +	{ "VpOtherInterceptsTime", 24 },
>> +	{ "VpExternalInterruptsCount", 25 },
>> +	{ "VpExternalInterruptsTime", 26 },
>> +	{ "VpPendingInterruptsCount", 27 },
>> +	{ "VpPendingInterruptsTime", 28 },
>> +	{ "VpEmulatedInstructionsCount", 29 },
>> +	{ "VpEmulatedInstructionsTime", 30 },
>> +	{ "VpDebugRegisterAccessesCount", 31 },
>> +	{ "VpDebugRegisterAccessesTime", 32 },
>> +	{ "VpPageFaultInterceptsCount", 33 },
>> +	{ "VpPageFaultInterceptsTime", 34 },
>> +	{ "VpGuestPageTableMaps", 35 },
>> +	{ "VpLargePageTlbFills", 36 },
>> +	{ "VpSmallPageTlbFills", 37 },
>> +	{ "VpReflectedGuestPageFaults", 38 },
>> +	{ "VpApicMmioAccesses", 39 },
>> +	{ "VpIoInterceptMessages", 40 },
>> +	{ "VpMemoryInterceptMessages", 41 },
>> +	{ "VpApicEoiAccesses", 42 },
>> +	{ "VpOtherMessages", 43 },
>> +	{ "VpPageTableAllocations", 44 },
>> +	{ "VpLogicalProcessorMigrations", 45 },
>> +	{ "VpAddressSpaceEvictions", 46 },
>> +	{ "VpAddressSpaceSwitches", 47 },
>> +	{ "VpAddressDomainFlushes", 48 },
>> +	{ "VpAddressSpaceFlushes", 49 },
>> +	{ "VpGlobalGvaRangeFlushes", 50 },
>> +	{ "VpLocalGvaRangeFlushes", 51 },
>> +	{ "VpPageTableEvictions", 52 },
>> +	{ "VpPageTableReclamations", 53 },
>> +	{ "VpPageTableResets", 54 },
>> +	{ "VpPageTableValidations", 55 },
>> +	{ "VpApicTprAccesses", 56 },
>> +	{ "VpPageTableWriteIntercepts", 57 },
>> +	{ "VpSyntheticInterrupts", 58 },
>> +	{ "VpVirtualInterrupts", 59 },
>> +	{ "VpApicIpisSent", 60 },
>> +	{ "VpApicSelfIpisSent", 61 },
>> +	{ "VpGpaSpaceHypercalls", 62 },
>> +	{ "VpLogicalProcessorHypercalls", 63 },
>> +	{ "VpLongSpinWaitHypercalls", 64 },
>> +	{ "VpOtherHypercalls", 65 },
>> +	{ "VpSyntheticInterruptHypercalls", 66 },
>> +	{ "VpVirtualInterruptHypercalls", 67 },
>> +	{ "VpVirtualMmuHypercalls", 68 },
>> +	{ "VpVirtualProcessorHypercalls", 69 },
>> +	{ "VpHardwareInterrupts", 70 },
>> +	{ "VpNestedPageFaultInterceptsCount", 71 },
>> +	{ "VpNestedPageFaultInterceptsTime", 72 },
>> +	{ "VpPageScans", 73 },
>> +	{ "VpLogicalProcessorDispatches", 74 },
>> +	{ "VpWaitingForCpuTime", 75 },
>> +	{ "VpExtendedHypercalls", 76 },
>> +	{ "VpExtendedHypercallInterceptMessages", 77 },
>> +	{ "VpMbecNestedPageTableSwitches", 78 },
>> +	{ "VpOtherReflectedGuestExceptions", 79 },
>> +	{ "VpGlobalIoTlbFlushes", 80 },
>> +	{ "VpGlobalIoTlbFlushCost", 81 },
>> +	{ "VpLocalIoTlbFlushes", 82 },
>> +	{ "VpLocalIoTlbFlushCost", 83 },
>> +	{ "VpHypercallsForwardedCount", 84 },
>> +	{ "VpHypercallsForwardingTime", 85 },
>> +	{ "VpPageInvalidationsForwardedCount", 86 },
>> +	{ "VpPageInvalidationsForwardingTime", 87 },
>> +	{ "VpControlRegisterAccessesForwardedCount", 88 },
>> +	{ "VpControlRegisterAccessesForwardingTime", 89 },
>> +	{ "VpIoInstructionsForwardedCount", 90 },
>> +	{ "VpIoInstructionsForwardingTime", 91 },
>> +	{ "VpHltInstructionsForwardedCount", 92 },
>> +	{ "VpHltInstructionsForwardingTime", 93 },
>> +	{ "VpMwaitInstructionsForwardedCount", 94 },
>> +	{ "VpMwaitInstructionsForwardingTime", 95 },
>> +	{ "VpCpuidInstructionsForwardedCount", 96 },
>> +	{ "VpCpuidInstructionsForwardingTime", 97 },
>> +	{ "VpMsrAccessesForwardedCount", 98 },
>> +	{ "VpMsrAccessesForwardingTime", 99 },
>> +	{ "VpOtherInterceptsForwardedCount", 100 },
>> +	{ "VpOtherInterceptsForwardingTime", 101 },
>> +	{ "VpExternalInterruptsForwardedCount", 102 },
>> +	{ "VpExternalInterruptsForwardingTime", 103 },
>> +	{ "VpPendingInterruptsForwardedCount", 104 },
>> +	{ "VpPendingInterruptsForwardingTime", 105 },
>> +	{ "VpEmulatedInstructionsForwardedCount", 106 },
>> +	{ "VpEmulatedInstructionsForwardingTime", 107 },
>> +	{ "VpDebugRegisterAccessesForwardedCount", 108 },
>> +	{ "VpDebugRegisterAccessesForwardingTime", 109 },
>> +	{ "VpPageFaultInterceptsForwardedCount", 110 },
>> +	{ "VpPageFaultInterceptsForwardingTime", 111 },
>> +	{ "VpVmclearEmulationCount", 112 },
>> +	{ "VpVmclearEmulationTime", 113 },
>> +	{ "VpVmptrldEmulationCount", 114 },
>> +	{ "VpVmptrldEmulationTime", 115 },
>> +	{ "VpVmptrstEmulationCount", 116 },
>> +	{ "VpVmptrstEmulationTime", 117 },
>> +	{ "VpVmreadEmulationCount", 118 },
>> +	{ "VpVmreadEmulationTime", 119 },
>> +	{ "VpVmwriteEmulationCount", 120 },
>> +	{ "VpVmwriteEmulationTime", 121 },
>> +	{ "VpVmxoffEmulationCount", 122 },
>> +	{ "VpVmxoffEmulationTime", 123 },
>> +	{ "VpVmxonEmulationCount", 124 },
>> +	{ "VpVmxonEmulationTime", 125 },
>> +	{ "VpNestedVMEntriesCount", 126 },
>> +	{ "VpNestedVMEntriesTime", 127 },
>> +	{ "VpNestedSLATSoftPageFaultsCount", 128 },
>> +	{ "VpNestedSLATSoftPageFaultsTime", 129 },
>> +	{ "VpNestedSLATHardPageFaultsCount", 130 },
>> +	{ "VpNestedSLATHardPageFaultsTime", 131 },
>> +	{ "VpInvEptAllContextEmulationCount", 132 },
>> +	{ "VpInvEptAllContextEmulationTime", 133 },
>> +	{ "VpInvEptSingleContextEmulationCount", 134 },
>> +	{ "VpInvEptSingleContextEmulationTime", 135 },
>> +	{ "VpInvVpidAllContextEmulationCount", 136 },
>> +	{ "VpInvVpidAllContextEmulationTime", 137 },
>> +	{ "VpInvVpidSingleContextEmulationCount", 138 },
>> +	{ "VpInvVpidSingleContextEmulationTime", 139 },
>> +	{ "VpInvVpidSingleAddressEmulationCount", 140 },
>> +	{ "VpInvVpidSingleAddressEmulationTime", 141 },
>> +	{ "VpNestedTlbPageTableReclamations", 142 },
>> +	{ "VpNestedTlbPageTableEvictions", 143 },
>> +	{ "VpFlushGuestPhysicalAddressSpaceHypercalls", 144 },
>> +	{ "VpFlushGuestPhysicalAddressListHypercalls", 145 },
>> +	{ "VpPostedInterruptNotifications", 146 },
>> +	{ "VpPostedInterruptScans", 147 },
>> +	{ "VpTotalCoreRunTime", 148 },
>> +	{ "VpMaximumRunTime", 149 },
>> +	{ "VpHwpRequestContextSwitches", 150 },
>> +	{ "VpWaitingForCpuTimeBucket0", 151 },
>> +	{ "VpWaitingForCpuTimeBucket1", 152 },
>> +	{ "VpWaitingForCpuTimeBucket2", 153 },
>> +	{ "VpWaitingForCpuTimeBucket3", 154 },
>> +	{ "VpWaitingForCpuTimeBucket4", 155 },
>> +	{ "VpWaitingForCpuTimeBucket5", 156 },
>> +	{ "VpWaitingForCpuTimeBucket6", 157 },
>> +	{ "VpVmloadEmulationCount", 158 },
>> +	{ "VpVmloadEmulationTime", 159 },
>> +	{ "VpVmsaveEmulationCount", 160 },
>> +	{ "VpVmsaveEmulationTime", 161 },
>> +	{ "VpGifInstructionEmulationCount", 162 },
>> +	{ "VpGifInstructionEmulationTime", 163 },
>> +	{ "VpEmulatedErrataSvmInstructions", 164 },
>> +	{ "VpPlaceholder1", 165 },
>> +	{ "VpPlaceholder2", 166 },
>> +	{ "VpPlaceholder3", 167 },
>> +	{ "VpPlaceholder4", 168 },
>> +	{ "VpPlaceholder5", 169 },
>> +	{ "VpPlaceholder6", 170 },
>> +	{ "VpPlaceholder7", 171 },
>> +	{ "VpPlaceholder8", 172 },
>> +	{ "VpContentionTime", 173 },
>> +	{ "VpWakeUpTime", 174 },
>> +	{ "VpSchedulingPriority", 175 },
>> +	{ "VpRdpmcInstructionsCount", 176 },
>> +	{ "VpRdpmcInstructionsTime", 177 },
>> +	{ "VpPerfmonPmuMsrAccessesCount", 178 },
>> +	{ "VpPerfmonLbrMsrAccessesCount", 179 },
>> +	{ "VpPerfmonIptMsrAccessesCount", 180 },
>> +	{ "VpPerfmonInterruptCount", 181 },
>> +	{ "VpVtl1DispatchCount", 182 },
>> +	{ "VpVtl2DispatchCount", 183 },
>> +	{ "VpVtl2DispatchBucket0", 184 },
>> +	{ "VpVtl2DispatchBucket1", 185 },
>> +	{ "VpVtl2DispatchBucket2", 186 },
>> +	{ "VpVtl2DispatchBucket3", 187 },
>> +	{ "VpVtl2DispatchBucket4", 188 },
>> +	{ "VpVtl2DispatchBucket5", 189 },
>> +	{ "VpVtl2DispatchBucket6", 190 },
>> +	{ "VpVtl1RunTime", 191 },
>> +	{ "VpVtl2RunTime", 192 },
>> +	{ "VpIommuHypercalls", 193 },
>> +	{ "VpCpuGroupHypercalls", 194 },
>> +	{ "VpVsmHypercalls", 195 },
>> +	{ "VpEventLogHypercalls", 196 },
>> +	{ "VpDeviceDomainHypercalls", 197 },
>> +	{ "VpDepositHypercalls", 198 },
>> +	{ "VpSvmHypercalls", 199 },
>> +	{ "VpBusLockAcquisitionCount", 200 },
>> +	{ "VpLoadAvg", 201 },
>> +	{ "VpRootDispatchThreadBlocked", 202 },
>> +	{ "VpIdleCpuTime", 203 },
>> +	{ "VpWaitingForCpuTimeBucket7", 204 },
>> +	{ "VpWaitingForCpuTimeBucket8", 205 },
>> +	{ "VpWaitingForCpuTimeBucket9", 206 },
>> +	{ "VpWaitingForCpuTimeBucket10", 207 },
>> +	{ "VpWaitingForCpuTimeBucket11", 208 },
>> +	{ "VpWaitingForCpuTimeBucket12", 209 },
>> +	{ "VpHierarchicalSuspendTime", 210 },
>> +	{ "VpExpressSchedulingAttempts", 211 },
>> +	{ "VpExpressSchedulingCount", 212 },
>> +	{ "VpBusLockAcquisitionTime", 213 },
>> +#elif IS_ENABLED(CONFIG_ARM64)
>> +	{ "VpSysRegAccessesCount", 9 },
>> +	{ "VpSysRegAccessesTime", 10 },
>> +	{ "VpSmcInstructionsCount", 11 },
>> +	{ "VpSmcInstructionsTime", 12 },
>> +	{ "VpOtherInterceptsCount", 13 },
>> +	{ "VpOtherInterceptsTime", 14 },
>> +	{ "VpExternalInterruptsCount", 15 },
>> +	{ "VpExternalInterruptsTime", 16 },
>> +	{ "VpPendingInterruptsCount", 17 },
>> +	{ "VpPendingInterruptsTime", 18 },
>> +	{ "VpGuestPageTableMaps", 19 },
>> +	{ "VpLargePageTlbFills", 20 },
>> +	{ "VpSmallPageTlbFills", 21 },
>> +	{ "VpReflectedGuestPageFaults", 22 },
>> +	{ "VpMemoryInterceptMessages", 23 },
>> +	{ "VpOtherMessages", 24 },
>> +	{ "VpLogicalProcessorMigrations", 25 },
>> +	{ "VpAddressDomainFlushes", 26 },
>> +	{ "VpAddressSpaceFlushes", 27 },
>> +	{ "VpSyntheticInterrupts", 28 },
>> +	{ "VpVirtualInterrupts", 29 },
>> +	{ "VpApicSelfIpisSent", 30 },
>> +	{ "VpGpaSpaceHypercalls", 31 },
>> +	{ "VpLogicalProcessorHypercalls", 32 },
>> +	{ "VpLongSpinWaitHypercalls", 33 },
>> +	{ "VpOtherHypercalls", 34 },
>> +	{ "VpSyntheticInterruptHypercalls", 35 },
>> +	{ "VpVirtualInterruptHypercalls", 36 },
>> +	{ "VpVirtualMmuHypercalls", 37 },
>> +	{ "VpVirtualProcessorHypercalls", 38 },
>> +	{ "VpHardwareInterrupts", 39 },
>> +	{ "VpNestedPageFaultInterceptsCount", 40 },
>> +	{ "VpNestedPageFaultInterceptsTime", 41 },
>> +	{ "VpLogicalProcessorDispatches", 42 },
>> +	{ "VpWaitingForCpuTime", 43 },
>> +	{ "VpExtendedHypercalls", 44 },
>> +	{ "VpExtendedHypercallInterceptMessages", 45 },
>> +	{ "VpMbecNestedPageTableSwitches", 46 },
>> +	{ "VpOtherReflectedGuestExceptions", 47 },
>> +	{ "VpGlobalIoTlbFlushes", 48 },
>> +	{ "VpGlobalIoTlbFlushCost", 49 },
>> +	{ "VpLocalIoTlbFlushes", 50 },
>> +	{ "VpLocalIoTlbFlushCost", 51 },
>> +	{ "VpFlushGuestPhysicalAddressSpaceHypercalls", 52 },
>> +	{ "VpFlushGuestPhysicalAddressListHypercalls", 53 },
>> +	{ "VpPostedInterruptNotifications", 54 },
>> +	{ "VpPostedInterruptScans", 55 },
>> +	{ "VpTotalCoreRunTime", 56 },
>> +	{ "VpMaximumRunTime", 57 },
>> +	{ "VpWaitingForCpuTimeBucket0", 58 },
>> +	{ "VpWaitingForCpuTimeBucket1", 59 },
>> +	{ "VpWaitingForCpuTimeBucket2", 60 },
>> +	{ "VpWaitingForCpuTimeBucket3", 61 },
>> +	{ "VpWaitingForCpuTimeBucket4", 62 },
>> +	{ "VpWaitingForCpuTimeBucket5", 63 },
>> +	{ "VpWaitingForCpuTimeBucket6", 64 },
>> +	{ "VpHwpRequestContextSwitches", 65 },
>> +	{ "VpPlaceholder2", 66 },
>> +	{ "VpPlaceholder3", 67 },
>> +	{ "VpPlaceholder4", 68 },
>> +	{ "VpPlaceholder5", 69 },
>> +	{ "VpPlaceholder6", 70 },
>> +	{ "VpPlaceholder7", 71 },
>> +	{ "VpPlaceholder8", 72 },
>> +	{ "VpContentionTime", 73 },
>> +	{ "VpWakeUpTime", 74 },
>> +	{ "VpSchedulingPriority", 75 },
>> +	{ "VpVtl1DispatchCount", 76 },
>> +	{ "VpVtl2DispatchCount", 77 },
>> +	{ "VpVtl2DispatchBucket0", 78 },
>> +	{ "VpVtl2DispatchBucket1", 79 },
>> +	{ "VpVtl2DispatchBucket2", 80 },
>> +	{ "VpVtl2DispatchBucket3", 81 },
>> +	{ "VpVtl2DispatchBucket4", 82 },
>> +	{ "VpVtl2DispatchBucket5", 83 },
>> +	{ "VpVtl2DispatchBucket6", 84 },
>> +	{ "VpVtl1RunTime", 85 },
>> +	{ "VpVtl2RunTime", 86 },
>> +	{ "VpIommuHypercalls", 87 },
>> +	{ "VpCpuGroupHypercalls", 88 },
>> +	{ "VpVsmHypercalls", 89 },
>> +	{ "VpEventLogHypercalls", 90 },
>> +	{ "VpDeviceDomainHypercalls", 91 },
>> +	{ "VpDepositHypercalls", 92 },
>> +	{ "VpSvmHypercalls", 93 },
>> +	{ "VpLoadAvg", 94 },
>> +	{ "VpRootDispatchThreadBlocked", 95 },
>> +	{ "VpIdleCpuTime", 96 },
>> +	{ "VpWaitingForCpuTimeBucket7", 97 },
>> +	{ "VpWaitingForCpuTimeBucket8", 98 },
>> +	{ "VpWaitingForCpuTimeBucket9", 99 },
>> +	{ "VpWaitingForCpuTimeBucket10", 100 },
>> +	{ "VpWaitingForCpuTimeBucket11", 101 },
>> +	{ "VpWaitingForCpuTimeBucket12", 102 },
>> +	{ "VpHierarchicalSuspendTime", 103 },
>> +	{ "VpExpressSchedulingAttempts", 104 },
>> +	{ "VpExpressSchedulingCount", 105 },
>> +#endif
>> +};
>> +
> 
> The patch puts a blank line at the end of the new hv_counters.c file. When using
> "git am" to apply this patch, I get this warning:
> 
> .git/rebase-apply/patch:499: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> 
> Line 499 is that blank line at the end of the new file. If I modify the patch to remove
> the adding of the blank line, "git am" will apply the patch with no warning. This
> should probably be fixed.
> 
Thanks for pointing that out, I'll fix it!

> Michael


