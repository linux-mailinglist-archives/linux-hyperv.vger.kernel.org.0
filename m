Return-Path: <linux-hyperv+bounces-8319-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77074D25B5D
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 17:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5BF030617DF
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D163B8BA6;
	Thu, 15 Jan 2026 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="he7uKFXo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C54258EC2;
	Thu, 15 Jan 2026 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493949; cv=none; b=r+0kyKNZI/Qq8eMjmjCgD8kGdFB+2/aHxkv7UrDQQKmsMkiqt+w6sBYVawDSxkLTwvAjwzT+xiTCUKCkJv13antL0IzDlUpWikTddI/RdSqwKofniqwd02cEWPtMtm6v4K1PimCWlSVXiGUM3FnCzINpQB1IVHUmJJ47Oo8U7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493949; c=relaxed/simple;
	bh=Ls0e6TnxvWno1CERwBPoovF05PeQQ5yec26VdeTgnzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS9EL9+xL77N6iLk2QLQC+DyZypU+DOMeQ8jshJly5wrkIvQ5RKOR8/eAVr1J1Fgl6T+AY93FNi3GL+xcWR8TYzfcjCeEhZEtuJ/xDN07iXYsaJDSOlAUAi4ddWscEA1JGWGfreK4bdDcQrSCUZo5F33SAMLprIJcGVifkpRh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=he7uKFXo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6ABF620B7165;
	Thu, 15 Jan 2026 08:19:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6ABF620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768493946;
	bh=0aT3kz+uZ6vKeH7TrJpQENsDi8nyh8VclhWcCwPJABY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=he7uKFXoCIhI9fNRCi697SRS0e7A67OcqKcSQ6XcHmxAFzP8Siu4YWZvJrE8e69IF
	 eeeYWHDPvb0KoLU1+DMAuFzo78YJ+b54hsp0v9sWN+B163eq5FoE2QHJU/aMxV3nvY
	 R3314TD1NBYjXZWbehOKu3nTIlitsJtQtTgufyv4=
Date: Thu, 15 Jan 2026 08:19:03 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH v3 5/6] mshv: Add definitions for stats pages
Message-ID: <aWkTd2zkbVQqePVa@skinsburskii.localdomain>
References: <20260114213803.143486-1-nunodasneves@linux.microsoft.com>
 <20260114213803.143486-6-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114213803.143486-6-nunodasneves@linux.microsoft.com>

On Wed, Jan 14, 2026 at 01:38:02PM -0800, Nuno Das Neves wrote:
> Add the definitions for hypervisor, logical processor, and partition
> stats pages.
> 

The definitions in for partition and virtual processor are outdated.
Now is the good time to sync the new values in.

Thanks,
Stanislav

> Move the definition for the VP stats page to its rightful place in
> hvhdk.h, and add the missing members.
> 
> While at it, correct the ARM64 value of VpRootDispatchThreadBlocked,
> (which is not yet used, so there is no impact).
> 
> These enum members retain their CamelCase style, since they are imported
> directly from the hypervisor code. They will be stringified when
> printing the stats out, and retain more readability in this form.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |  17 --
>  include/hyperv/hvhdk.h      | 437 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 437 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index fbfc9e7d9fa4..724bbaa0b08c 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -39,23 +39,6 @@ MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
>  
> -/* TODO move this to another file when debugfs code is added */
> -enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
> -#if defined(CONFIG_X86)
> -	VpRootDispatchThreadBlocked			= 202,
> -#elif defined(CONFIG_ARM64)
> -	VpRootDispatchThreadBlocked			= 94,
> -#endif
> -	VpStatsMaxCounter
> -};
> -
> -struct hv_stats_page {
> -	union {
> -		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
> -		u8 data[HV_HYP_PAGE_SIZE];
> -	};
> -} __packed;
> -
>  struct mshv_root mshv_root;
>  
>  enum hv_scheduler_type hv_scheduler_type;
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 469186df7826..8bddd11feeba 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -10,6 +10,443 @@
>  #include "hvhdk_mini.h"
>  #include "hvgdk.h"
>  
> +enum hv_stats_hypervisor_counters {		/* HV_HYPERVISOR_COUNTER */
> +	HvLogicalProcessors			= 1,
> +	HvPartitions				= 2,
> +	HvTotalPages				= 3,
> +	HvVirtualProcessors			= 4,
> +	HvMonitoredNotifications		= 5,
> +	HvModernStandbyEntries			= 6,
> +	HvPlatformIdleTransitions		= 7,
> +	HvHypervisorStartupCost			= 8,
> +	HvIOSpacePages				= 10,
> +	HvNonEssentialPagesForDump		= 11,
> +	HvSubsumedPages				= 12,
> +	HvStatsMaxCounter
> +};
> +
> +enum hv_stats_partition_counters {		/* HV_PROCESS_COUNTER */
> +	PartitionVirtualProcessors		= 1,
> +	PartitionTlbSize			= 3,
> +	PartitionAddressSpaces			= 4,
> +	PartitionDepositedPages			= 5,
> +	PartitionGpaPages			= 6,
> +	PartitionGpaSpaceModifications		= 7,
> +	PartitionVirtualTlbFlushEntires		= 8,
> +	PartitionRecommendedTlbSize		= 9,
> +	PartitionGpaPages4K			= 10,
> +	PartitionGpaPages2M			= 11,
> +	PartitionGpaPages1G			= 12,
> +	PartitionGpaPages512G			= 13,
> +	PartitionDevicePages4K			= 14,
> +	PartitionDevicePages2M			= 15,
> +	PartitionDevicePages1G			= 16,
> +	PartitionDevicePages512G		= 17,
> +	PartitionAttachedDevices		= 18,
> +	PartitionDeviceInterruptMappings	= 19,
> +	PartitionIoTlbFlushes			= 20,
> +	PartitionIoTlbFlushCost			= 21,
> +	PartitionDeviceInterruptErrors		= 22,
> +	PartitionDeviceDmaErrors		= 23,
> +	PartitionDeviceInterruptThrottleEvents	= 24,
> +	PartitionSkippedTimerTicks		= 25,
> +	PartitionPartitionId			= 26,
> +#if IS_ENABLED(CONFIG_X86_64)
> +	PartitionNestedTlbSize			= 27,
> +	PartitionRecommendedNestedTlbSize	= 28,
> +	PartitionNestedTlbFreeListSize		= 29,
> +	PartitionNestedTlbTrimmedPages		= 30,
> +	PartitionPagesShattered			= 31,
> +	PartitionPagesRecombined		= 32,
> +	PartitionHwpRequestValue		= 33,
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	PartitionHwpRequestValue		= 27,
> +#endif
> +	PartitionStatsMaxCounter
> +};
> +
> +enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
> +	VpTotalRunTime					= 1,
> +	VpHypervisorRunTime				= 2,
> +	VpRemoteNodeRunTime				= 3,
> +	VpNormalizedRunTime				= 4,
> +	VpIdealCpu					= 5,
> +	VpHypercallsCount				= 7,
> +	VpHypercallsTime				= 8,
> +#if IS_ENABLED(CONFIG_X86_64)
> +	VpPageInvalidationsCount			= 9,
> +	VpPageInvalidationsTime				= 10,
> +	VpControlRegisterAccessesCount			= 11,
> +	VpControlRegisterAccessesTime			= 12,
> +	VpIoInstructionsCount				= 13,
> +	VpIoInstructionsTime				= 14,
> +	VpHltInstructionsCount				= 15,
> +	VpHltInstructionsTime				= 16,
> +	VpMwaitInstructionsCount			= 17,
> +	VpMwaitInstructionsTime				= 18,
> +	VpCpuidInstructionsCount			= 19,
> +	VpCpuidInstructionsTime				= 20,
> +	VpMsrAccessesCount				= 21,
> +	VpMsrAccessesTime				= 22,
> +	VpOtherInterceptsCount				= 23,
> +	VpOtherInterceptsTime				= 24,
> +	VpExternalInterruptsCount			= 25,
> +	VpExternalInterruptsTime			= 26,
> +	VpPendingInterruptsCount			= 27,
> +	VpPendingInterruptsTime				= 28,
> +	VpEmulatedInstructionsCount			= 29,
> +	VpEmulatedInstructionsTime			= 30,
> +	VpDebugRegisterAccessesCount			= 31,
> +	VpDebugRegisterAccessesTime			= 32,
> +	VpPageFaultInterceptsCount			= 33,
> +	VpPageFaultInterceptsTime			= 34,
> +	VpGuestPageTableMaps				= 35,
> +	VpLargePageTlbFills				= 36,
> +	VpSmallPageTlbFills				= 37,
> +	VpReflectedGuestPageFaults			= 38,
> +	VpApicMmioAccesses				= 39,
> +	VpIoInterceptMessages				= 40,
> +	VpMemoryInterceptMessages			= 41,
> +	VpApicEoiAccesses				= 42,
> +	VpOtherMessages					= 43,
> +	VpPageTableAllocations				= 44,
> +	VpLogicalProcessorMigrations			= 45,
> +	VpAddressSpaceEvictions				= 46,
> +	VpAddressSpaceSwitches				= 47,
> +	VpAddressDomainFlushes				= 48,
> +	VpAddressSpaceFlushes				= 49,
> +	VpGlobalGvaRangeFlushes				= 50,
> +	VpLocalGvaRangeFlushes				= 51,
> +	VpPageTableEvictions				= 52,
> +	VpPageTableReclamations				= 53,
> +	VpPageTableResets				= 54,
> +	VpPageTableValidations				= 55,
> +	VpApicTprAccesses				= 56,
> +	VpPageTableWriteIntercepts			= 57,
> +	VpSyntheticInterrupts				= 58,
> +	VpVirtualInterrupts				= 59,
> +	VpApicIpisSent					= 60,
> +	VpApicSelfIpisSent				= 61,
> +	VpGpaSpaceHypercalls				= 62,
> +	VpLogicalProcessorHypercalls			= 63,
> +	VpLongSpinWaitHypercalls			= 64,
> +	VpOtherHypercalls				= 65,
> +	VpSyntheticInterruptHypercalls			= 66,
> +	VpVirtualInterruptHypercalls			= 67,
> +	VpVirtualMmuHypercalls				= 68,
> +	VpVirtualProcessorHypercalls			= 69,
> +	VpHardwareInterrupts				= 70,
> +	VpNestedPageFaultInterceptsCount		= 71,
> +	VpNestedPageFaultInterceptsTime			= 72,
> +	VpPageScans					= 73,
> +	VpLogicalProcessorDispatches			= 74,
> +	VpWaitingForCpuTime				= 75,
> +	VpExtendedHypercalls				= 76,
> +	VpExtendedHypercallInterceptMessages		= 77,
> +	VpMbecNestedPageTableSwitches			= 78,
> +	VpOtherReflectedGuestExceptions			= 79,
> +	VpGlobalIoTlbFlushes				= 80,
> +	VpGlobalIoTlbFlushCost				= 81,
> +	VpLocalIoTlbFlushes				= 82,
> +	VpLocalIoTlbFlushCost				= 83,
> +	VpHypercallsForwardedCount			= 84,
> +	VpHypercallsForwardingTime			= 85,
> +	VpPageInvalidationsForwardedCount		= 86,
> +	VpPageInvalidationsForwardingTime		= 87,
> +	VpControlRegisterAccessesForwardedCount		= 88,
> +	VpControlRegisterAccessesForwardingTime		= 89,
> +	VpIoInstructionsForwardedCount			= 90,
> +	VpIoInstructionsForwardingTime			= 91,
> +	VpHltInstructionsForwardedCount			= 92,
> +	VpHltInstructionsForwardingTime			= 93,
> +	VpMwaitInstructionsForwardedCount		= 94,
> +	VpMwaitInstructionsForwardingTime		= 95,
> +	VpCpuidInstructionsForwardedCount		= 96,
> +	VpCpuidInstructionsForwardingTime		= 97,
> +	VpMsrAccessesForwardedCount			= 98,
> +	VpMsrAccessesForwardingTime			= 99,
> +	VpOtherInterceptsForwardedCount			= 100,
> +	VpOtherInterceptsForwardingTime			= 101,
> +	VpExternalInterruptsForwardedCount		= 102,
> +	VpExternalInterruptsForwardingTime		= 103,
> +	VpPendingInterruptsForwardedCount		= 104,
> +	VpPendingInterruptsForwardingTime		= 105,
> +	VpEmulatedInstructionsForwardedCount		= 106,
> +	VpEmulatedInstructionsForwardingTime		= 107,
> +	VpDebugRegisterAccessesForwardedCount		= 108,
> +	VpDebugRegisterAccessesForwardingTime		= 109,
> +	VpPageFaultInterceptsForwardedCount		= 110,
> +	VpPageFaultInterceptsForwardingTime		= 111,
> +	VpVmclearEmulationCount				= 112,
> +	VpVmclearEmulationTime				= 113,
> +	VpVmptrldEmulationCount				= 114,
> +	VpVmptrldEmulationTime				= 115,
> +	VpVmptrstEmulationCount				= 116,
> +	VpVmptrstEmulationTime				= 117,
> +	VpVmreadEmulationCount				= 118,
> +	VpVmreadEmulationTime				= 119,
> +	VpVmwriteEmulationCount				= 120,
> +	VpVmwriteEmulationTime				= 121,
> +	VpVmxoffEmulationCount				= 122,
> +	VpVmxoffEmulationTime				= 123,
> +	VpVmxonEmulationCount				= 124,
> +	VpVmxonEmulationTime				= 125,
> +	VpNestedVMEntriesCount				= 126,
> +	VpNestedVMEntriesTime				= 127,
> +	VpNestedSLATSoftPageFaultsCount			= 128,
> +	VpNestedSLATSoftPageFaultsTime			= 129,
> +	VpNestedSLATHardPageFaultsCount			= 130,
> +	VpNestedSLATHardPageFaultsTime			= 131,
> +	VpInvEptAllContextEmulationCount		= 132,
> +	VpInvEptAllContextEmulationTime			= 133,
> +	VpInvEptSingleContextEmulationCount		= 134,
> +	VpInvEptSingleContextEmulationTime		= 135,
> +	VpInvVpidAllContextEmulationCount		= 136,
> +	VpInvVpidAllContextEmulationTime		= 137,
> +	VpInvVpidSingleContextEmulationCount		= 138,
> +	VpInvVpidSingleContextEmulationTime		= 139,
> +	VpInvVpidSingleAddressEmulationCount		= 140,
> +	VpInvVpidSingleAddressEmulationTime		= 141,
> +	VpNestedTlbPageTableReclamations		= 142,
> +	VpNestedTlbPageTableEvictions			= 143,
> +	VpFlushGuestPhysicalAddressSpaceHypercalls	= 144,
> +	VpFlushGuestPhysicalAddressListHypercalls	= 145,
> +	VpPostedInterruptNotifications			= 146,
> +	VpPostedInterruptScans				= 147,
> +	VpTotalCoreRunTime				= 148,
> +	VpMaximumRunTime				= 149,
> +	VpHwpRequestContextSwitches			= 150,
> +	VpWaitingForCpuTimeBucket0			= 151,
> +	VpWaitingForCpuTimeBucket1			= 152,
> +	VpWaitingForCpuTimeBucket2			= 153,
> +	VpWaitingForCpuTimeBucket3			= 154,
> +	VpWaitingForCpuTimeBucket4			= 155,
> +	VpWaitingForCpuTimeBucket5			= 156,
> +	VpWaitingForCpuTimeBucket6			= 157,
> +	VpVmloadEmulationCount				= 158,
> +	VpVmloadEmulationTime				= 159,
> +	VpVmsaveEmulationCount				= 160,
> +	VpVmsaveEmulationTime				= 161,
> +	VpGifInstructionEmulationCount			= 162,
> +	VpGifInstructionEmulationTime			= 163,
> +	VpEmulatedErrataSvmInstructions			= 164,
> +	VpPlaceholder1					= 165,
> +	VpPlaceholder2					= 166,
> +	VpPlaceholder3					= 167,
> +	VpPlaceholder4					= 168,
> +	VpPlaceholder5					= 169,
> +	VpPlaceholder6					= 170,
> +	VpPlaceholder7					= 171,
> +	VpPlaceholder8					= 172,
> +	VpPlaceholder9					= 173,
> +	VpPlaceholder10					= 174,
> +	VpSchedulingPriority				= 175,
> +	VpRdpmcInstructionsCount			= 176,
> +	VpRdpmcInstructionsTime				= 177,
> +	VpPerfmonPmuMsrAccessesCount			= 178,
> +	VpPerfmonLbrMsrAccessesCount			= 179,
> +	VpPerfmonIptMsrAccessesCount			= 180,
> +	VpPerfmonInterruptCount				= 181,
> +	VpVtl1DispatchCount				= 182,
> +	VpVtl2DispatchCount				= 183,
> +	VpVtl2DispatchBucket0				= 184,
> +	VpVtl2DispatchBucket1				= 185,
> +	VpVtl2DispatchBucket2				= 186,
> +	VpVtl2DispatchBucket3				= 187,
> +	VpVtl2DispatchBucket4				= 188,
> +	VpVtl2DispatchBucket5				= 189,
> +	VpVtl2DispatchBucket6				= 190,
> +	VpVtl1RunTime					= 191,
> +	VpVtl2RunTime					= 192,
> +	VpIommuHypercalls				= 193,
> +	VpCpuGroupHypercalls				= 194,
> +	VpVsmHypercalls					= 195,
> +	VpEventLogHypercalls				= 196,
> +	VpDeviceDomainHypercalls			= 197,
> +	VpDepositHypercalls				= 198,
> +	VpSvmHypercalls					= 199,
> +	VpBusLockAcquisitionCount			= 200,
> +	VpLoadAvg					= 201,
> +	VpRootDispatchThreadBlocked			= 202,
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	VpSysRegAccessesCount				= 9,
> +	VpSysRegAccessesTime				= 10,
> +	VpSmcInstructionsCount				= 11,
> +	VpSmcInstructionsTime				= 12,
> +	VpOtherInterceptsCount				= 13,
> +	VpOtherInterceptsTime				= 14,
> +	VpExternalInterruptsCount			= 15,
> +	VpExternalInterruptsTime			= 16,
> +	VpPendingInterruptsCount			= 17,
> +	VpPendingInterruptsTime				= 18,
> +	VpGuestPageTableMaps				= 19,
> +	VpLargePageTlbFills				= 20,
> +	VpSmallPageTlbFills				= 21,
> +	VpReflectedGuestPageFaults			= 22,
> +	VpMemoryInterceptMessages			= 23,
> +	VpOtherMessages					= 24,
> +	VpLogicalProcessorMigrations			= 25,
> +	VpAddressDomainFlushes				= 26,
> +	VpAddressSpaceFlushes				= 27,
> +	VpSyntheticInterrupts				= 28,
> +	VpVirtualInterrupts				= 29,
> +	VpApicSelfIpisSent				= 30,
> +	VpGpaSpaceHypercalls				= 31,
> +	VpLogicalProcessorHypercalls			= 32,
> +	VpLongSpinWaitHypercalls			= 33,
> +	VpOtherHypercalls				= 34,
> +	VpSyntheticInterruptHypercalls			= 35,
> +	VpVirtualInterruptHypercalls			= 36,
> +	VpVirtualMmuHypercalls				= 37,
> +	VpVirtualProcessorHypercalls			= 38,
> +	VpHardwareInterrupts				= 39,
> +	VpNestedPageFaultInterceptsCount		= 40,
> +	VpNestedPageFaultInterceptsTime			= 41,
> +	VpLogicalProcessorDispatches			= 42,
> +	VpWaitingForCpuTime				= 43,
> +	VpExtendedHypercalls				= 44,
> +	VpExtendedHypercallInterceptMessages		= 45,
> +	VpMbecNestedPageTableSwitches			= 46,
> +	VpOtherReflectedGuestExceptions			= 47,
> +	VpGlobalIoTlbFlushes				= 48,
> +	VpGlobalIoTlbFlushCost				= 49,
> +	VpLocalIoTlbFlushes				= 50,
> +	VpLocalIoTlbFlushCost				= 51,
> +	VpFlushGuestPhysicalAddressSpaceHypercalls	= 52,
> +	VpFlushGuestPhysicalAddressListHypercalls	= 53,
> +	VpPostedInterruptNotifications			= 54,
> +	VpPostedInterruptScans				= 55,
> +	VpTotalCoreRunTime				= 56,
> +	VpMaximumRunTime				= 57,
> +	VpWaitingForCpuTimeBucket0			= 58,
> +	VpWaitingForCpuTimeBucket1			= 59,
> +	VpWaitingForCpuTimeBucket2			= 60,
> +	VpWaitingForCpuTimeBucket3			= 61,
> +	VpWaitingForCpuTimeBucket4			= 62,
> +	VpWaitingForCpuTimeBucket5			= 63,
> +	VpWaitingForCpuTimeBucket6			= 64,
> +	VpHwpRequestContextSwitches			= 65,
> +	VpPlaceholder2					= 66,
> +	VpPlaceholder3					= 67,
> +	VpPlaceholder4					= 68,
> +	VpPlaceholder5					= 69,
> +	VpPlaceholder6					= 70,
> +	VpPlaceholder7					= 71,
> +	VpPlaceholder8					= 72,
> +	VpContentionTime				= 73,
> +	VpWakeUpTime					= 74,
> +	VpSchedulingPriority				= 75,
> +	VpVtl1DispatchCount				= 76,
> +	VpVtl2DispatchCount				= 77,
> +	VpVtl2DispatchBucket0				= 78,
> +	VpVtl2DispatchBucket1				= 79,
> +	VpVtl2DispatchBucket2				= 80,
> +	VpVtl2DispatchBucket3				= 81,
> +	VpVtl2DispatchBucket4				= 82,
> +	VpVtl2DispatchBucket5				= 83,
> +	VpVtl2DispatchBucket6				= 84,
> +	VpVtl1RunTime					= 85,
> +	VpVtl2RunTime					= 86,
> +	VpIommuHypercalls				= 87,
> +	VpCpuGroupHypercalls				= 88,
> +	VpVsmHypercalls					= 89,
> +	VpEventLogHypercalls				= 90,
> +	VpDeviceDomainHypercalls			= 91,
> +	VpDepositHypercalls				= 92,
> +	VpSvmHypercalls					= 93,
> +	VpLoadAvg					= 94,
> +	VpRootDispatchThreadBlocked			= 95,
> +#endif
> +	VpStatsMaxCounter
> +};
> +
> +enum hv_stats_lp_counters {			/* HV_CPU_COUNTER */
> +	LpGlobalTime				= 1,
> +	LpTotalRunTime				= 2,
> +	LpHypervisorRunTime			= 3,
> +	LpHardwareInterrupts			= 4,
> +	LpContextSwitches			= 5,
> +	LpInterProcessorInterrupts		= 6,
> +	LpSchedulerInterrupts			= 7,
> +	LpTimerInterrupts			= 8,
> +	LpInterProcessorInterruptsSent		= 9,
> +	LpProcessorHalts			= 10,
> +	LpMonitorTransitionCost			= 11,
> +	LpContextSwitchTime			= 12,
> +	LpC1TransitionsCount			= 13,
> +	LpC1RunTime				= 14,
> +	LpC2TransitionsCount			= 15,
> +	LpC2RunTime				= 16,
> +	LpC3TransitionsCount			= 17,
> +	LpC3RunTime				= 18,
> +	LpRootVpIndex				= 19,
> +	LpIdleSequenceNumber			= 20,
> +	LpGlobalTscCount			= 21,
> +	LpActiveTscCount			= 22,
> +	LpIdleAccumulation			= 23,
> +	LpReferenceCycleCount0			= 24,
> +	LpActualCycleCount0			= 25,
> +	LpReferenceCycleCount1			= 26,
> +	LpActualCycleCount1			= 27,
> +	LpProximityDomainId			= 28,
> +	LpPostedInterruptNotifications		= 29,
> +	LpBranchPredictorFlushes		= 30,
> +#if IS_ENABLED(CONFIG_X86_64)
> +	LpL1DataCacheFlushes			= 31,
> +	LpImmediateL1DataCacheFlushes		= 32,
> +	LpMbFlushes				= 33,
> +	LpCounterRefreshSequenceNumber		= 34,
> +	LpCounterRefreshReferenceTime		= 35,
> +	LpIdleAccumulationSnapshot		= 36,
> +	LpActiveTscCountSnapshot		= 37,
> +	LpHwpRequestContextSwitches		= 38,
> +	LpPlaceholder1				= 39,
> +	LpPlaceholder2				= 40,
> +	LpPlaceholder3				= 41,
> +	LpPlaceholder4				= 42,
> +	LpPlaceholder5				= 43,
> +	LpPlaceholder6				= 44,
> +	LpPlaceholder7				= 45,
> +	LpPlaceholder8				= 46,
> +	LpPlaceholder9				= 47,
> +	LpPlaceholder10				= 48,
> +	LpReserveGroupId			= 49,
> +	LpRunningPriority			= 50,
> +	LpPerfmonInterruptCount			= 51,
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	LpCounterRefreshSequenceNumber		= 31,
> +	LpCounterRefreshReferenceTime		= 32,
> +	LpIdleAccumulationSnapshot		= 33,
> +	LpActiveTscCountSnapshot		= 34,
> +	LpHwpRequestContextSwitches		= 35,
> +	LpPlaceholder2				= 36,
> +	LpPlaceholder3				= 37,
> +	LpPlaceholder4				= 38,
> +	LpPlaceholder5				= 39,
> +	LpPlaceholder6				= 40,
> +	LpPlaceholder7				= 41,
> +	LpPlaceholder8				= 42,
> +	LpPlaceholder9				= 43,
> +	LpSchLocalRunListSize			= 44,
> +	LpReserveGroupId			= 45,
> +	LpRunningPriority			= 46,
> +#endif
> +	LpStatsMaxCounter
> +};
> +
> +/*
> + * Hypervisor statistics page format
> + */
> +struct hv_stats_page {
> +	union {
> +		u64 hv_cntrs[HvStatsMaxCounter];		/* Hypervisor counters */
> +		u64 pt_cntrs[PartitionStatsMaxCounter];		/* Partition counters */
> +		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
> +		u64 lp_cntrs[LpStatsMaxCounter];		/* LP counters */
> +		u8 data[HV_HYP_PAGE_SIZE];
> +	};
> +} __packed;
> +
>  /* Bits for dirty mask of hv_vp_register_page */
>  #define HV_X64_REGISTER_CLASS_GENERAL	0
>  #define HV_X64_REGISTER_CLASS_IP	1
> -- 
> 2.34.1

