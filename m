Return-Path: <linux-hyperv+bounces-3338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E349CDA1D
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Nov 2024 08:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA2C283077
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Nov 2024 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56A18893C;
	Fri, 15 Nov 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZyYcW6mD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E53288DA;
	Fri, 15 Nov 2024 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657531; cv=none; b=KLscnAV4rMfNS+vgdlL0ZY95EGq1VW3dZlgvJsmtGe+GXlpMzsJYe2kTBRlSDmn7JYwfqsxVaYwzDCmc0Um7B+J8E91IgDf1Fbstlo/HDiZ+2E68gv90HxU1llRBbtdajzkd2Xb6aPx0/ukIYA3fML5l+RO3ujIu+taouXzHLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657531; c=relaxed/simple;
	bh=wIkiy+QteJhjeJ20sh1Xcq3Q2Jh4O4HpvU/DzWtMTJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMdi5AiKwPvGF4uHo5OcaAB6IsOFX5Os7kGv2az1OxBYCPtMse9gH8KADLvz1QFfkkqbnV3juPESer826yjZOlYjG13NshBg5gcoDVrkdbP6oW8mmAFScNAHYcUSPhZGCAIeBOXTlbe22W6FEhN7GKLQRUhLV2yD9LYdxj6Vyy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZyYcW6mD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 0A969206BCC9; Thu, 14 Nov 2024 23:58:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A969206BCC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731657529;
	bh=TuB/d6ReaTiRiZwBzzLa3GlP4F720U7qluSCKqYmo8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZyYcW6mD6BAra4UNC3p2uxqb9O7SPfSZg6I7lSLSreg4YRdJdAIlGWSdmsId9e3f1
	 +ufoa7ZuJhPA1gkLT/pAf+7CujtdmmVHTtX5zc/2dYwkx6Z2RSEiqqkZyH/I6DgErD
	 8EP1LWKo/1ZCKFJ8g7PYluJjE8WStyuWvZL6/YwM=
Date: Thu, 14 Nov 2024 23:58:48 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Starks <jostarks@microsoft.com>, jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v3 0/2] Drivers: hv: vmbus: Wait for boot-time offers and
 log missing offers
Message-ID: <20241115075848.GA11347@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241113084700.2940-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113084700.2940-1-namjain@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Nov 13, 2024 at 12:46:58AM -0800, Naman Jain wrote:
> After VM requests for channel offers during boot or resume from
> hibernation, host offers the devices that the VM is configured with and
> then sends a separate message indicating that all the boot-time channel
> offers are delivered. Wait for this message to make this boot-time offers
> request and receipt process synchronous.
> 
> Without this, user mode can race with VMBus initialization and miss
> channel offers. User mode has no way to work around this other than
> sleeping for a while, since there is no way to know when VMBus has
> finished processing boot-time offers.
> 
> This is in analogy to a PCI bus not returning from probe until it has
> scanned all devices on the bus.
> 
> As part of this implementation, some code cleanup is also done for the
> logic which becomes redundant due to this change.
> 
> Second patch prints the channels which are not offered when resume
> happens from hibernation to supply more information to the end user.
> 
> Changes since v2:
> https://lore.kernel.org/all/20241029080147.52749-1-namjain@linux.microsoft.com/
> * Incorporated Easwar's suggestion to use secs_to_jiffies() as his
>   changes are now merged.
> * Addressed Michael's comments:
>   * Used boot-time offers/channels/devices to maintain consistency
>   * Rephrased CHANNELMSG_ALLOFFERS_DELIVERED handler function comments
>     for better explanation. Thanks for sharing the write-up.
>   * Changed commit msg and other things as per suggestions
> * Addressed Dexuan's comments, which came up in offline discussion:
>   * Changed timeout for waiting for all offers delivered msg to 60s instead of 10s.
>     Reason being, the host can experience some servicing events or diagnostics events,
>     which may take a long time and hence may fail to offer all the devices within 10s.
>   * Minor additions in commit subject of both patches
> * Rebased on latest linux-next master tip
> 
> Changes since v1:
> https://lore.kernel.org/all/20241018115811.5530-1-namjain@linux.microsoft.com/
> * Added Easwar's Reviewed-By tag
> * Addressed Michael's comments:
>   * Added explanation of all offers delivered message in comments
>   * Removed infinite wait for offers logic, and changed it wait once.
>   * Removed sub channel workqueue flush logic
>   * Added comments on why MLX device offer is not expected as part of
>     this essential boot offer list. I refrained from adding too many
>     details on it as it felt like it is beyond the scope of this patch
>     series and may not be relevant to this. However, please let me know if
>     something needs to be added.
> * Addressed Saurabh's comments:
>   * Changed timeout value to 10000 ms instead of 10*1000
>   * Changed commit msg as per suggestions
>   * Added a comment for warning case of wait_for_completion timeout
>   * Added a note for missing channel cleanup in comments and commit msg
> 
> John Starks (1):
>   Drivers: hv: vmbus: Log on missing offers if any
> 
> Naman Jain (1):
>   Drivers: hv: vmbus: Wait for boot-time offers during boot and resume
> 
>  drivers/hv/channel_mgmt.c | 61 +++++++++++++++++++++++++++++----------
>  drivers/hv/connection.c   |  4 +--
>  drivers/hv/hyperv_vmbus.h | 14 ++-------
>  drivers/hv/vmbus_drv.c    | 31 ++++++++++----------
>  4 files changed, 67 insertions(+), 43 deletions(-)
> 
> 
> base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
> -- 
> 2.34.1
> 

The overall series looks good to me. However, I noticed a few checkpatch.pl warnings
that could be addressed. After fixing them:
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

