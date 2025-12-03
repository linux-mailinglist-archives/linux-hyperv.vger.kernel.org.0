Return-Path: <linux-hyperv+bounces-7939-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3407CA15EE
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC0530C5BA2
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 19:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACB330AD0B;
	Wed,  3 Dec 2025 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jn/yTFVa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921F2FB08C;
	Wed,  3 Dec 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788787; cv=none; b=Z42cBjQFDEcaRBRwB9L3QQWenJKseV5pKvxJaP/Ons0yQzrTJ541FnqP463Jlwlnxk51MlQ9QOMBl8M318F82IhSVJO3RnrIeDSWqra0//PedPNXDBfQt3bkD/xRKfek9jGJ4asKsNljdxMG/i7DREdE5u76XrqnF96L7+s9JaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788787; c=relaxed/simple;
	bh=+Md3TZ9N1GTH9XzEX+MyG/PMotIxpn6VSAAOfmyNTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8URCC7zEK8rHcqINevThGkavKN5SVHKuXrbIY3q9q6kpad8XNUOHOL2Ul1VYXz7Qmw4LXcRM1oN0M4fTqzM5Pg/+vrU5kQe6tq4B+x2bCNymzCM6YmEXrYEzAV00BcGVhSXo5DfO4eWITCQ2ViFRXaw1inLcT40uLJIWHWKMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jn/yTFVa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3FDFE2120712;
	Wed,  3 Dec 2025 11:06:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FDFE2120712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764788785;
	bh=oxs+DBKshEDPWSc4QMukh7SMSfzf1nRBBhkPtjReCoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jn/yTFVafk/Fuzv8aQIWyrhqswSfTtLvYRic9m4BmipqamU9Lvylqg1VZJ51jX1as
	 8bFAClDaCeffMqini1lrmxVenngmmdpCjlMdLzvm8v9ZxBcYkd2WR8MGOTiSu+OMil
	 IULylFTW5ADkJkWf/7UR+75oqhpiWs9lrQDwPkhM=
Date: Wed, 3 Dec 2025 11:06:23 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
	prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 2/3] mshv: Add definitions for stats pages
Message-ID: <aTCKL1XBxZ8w6kqY@skinsburskii.localdomain>
References: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764784405-4484-3-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764784405-4484-3-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Dec 03, 2025 at 09:53:24AM -0800, Nuno Das Neves wrote:
> Add the definitions for hypervisor, logical processor, and partition
> stats pages.
> 
> Move the definition for the VP stats page to its rightful place in
> hvhdk.h, and add the missing members.
> 
> These enum members retain their CamelCase style, since they are imported
> directly from the hypervisor code They will be stringified when printing
> the stats out, and retain more readability in this form.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |  17 --
>  include/hyperv/hvhdk.h      | 437 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 437 insertions(+), 17 deletions(-)
> 

<snip>

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
> +#if IS_ENABLED(CONFIG_X86)

Why isn't this CONFIG_X86_64 instead (here and below)?

Thanks,
Stanislav

