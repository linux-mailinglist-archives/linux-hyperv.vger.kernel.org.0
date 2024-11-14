Return-Path: <linux-hyperv+bounces-3336-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355BB9C9117
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Nov 2024 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A682848B7
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Nov 2024 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57D218BB9F;
	Thu, 14 Nov 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dGEpXD8C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BD718B484;
	Thu, 14 Nov 2024 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606433; cv=none; b=sz75DTtiVhvm3sn1g4OI7s6PaPKYmjJJREV2K033ZChTe7CgzSsVMMBJch4NpQ4QpsCJPktJcq+nTnA9F1w7gAvYFART62ZaG3Z25Ge8QUmCJWcf22x/dOd6cE+vImEdigB0BzKivIZGKjWTPHEO0Z9n8/qt+yqJY2oXV9okdb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606433; c=relaxed/simple;
	bh=ID8ZhFiwzsT6f68DK1Sq/ms9TWIt+cLdct40zfYVDhQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SurJl+5OPWa2duATDV9ZiEal0b2njTN5sFEMC1RjKlCT1Baq00U7rstCEGNhYT2Oq+e1MX377ONgBDvc7r1bAvj1/25A9NaXHXeGgiriLrud8Vny6ZeXIqpXBhT3d8L2iuL4u/6IWbyGHc7uDJGA0jdtSQQ6lvL3PTM65nRYhPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dGEpXD8C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0F7F120BEBFD;
	Thu, 14 Nov 2024 09:47:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F7F120BEBFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731606430;
	bh=tv6R0dfqeJn4Gt9XYkh+9bVP07MCUYjrl1v5JAVZfsE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dGEpXD8C934fobk6knh2OeWKyFUtuXwN5EKsxyMqluoYdmPY9/v5yrBk/nEPeUZXJ
	 mqNMtESikRdQQmFjTcKnLmgXRZSiy7loawioMT2eUFmTqkzmZRPnDiADBSeTyW8vzq
	 HToL/wLvV1rq2amU+q4Dnp0m2iIMJo9C2bLiLMt0=
Message-ID: <34a3e85d-4dbd-4550-a74b-5807d71a007e@linux.microsoft.com>
Date: Thu, 14 Nov 2024 09:47:09 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Starks <jostarks@microsoft.com>,
 jacob.pan@linux.microsoft.com, Michael Kelley <mhklinux@outlook.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v3 0/2] Drivers: hv: vmbus: Wait for boot-time offers and
 log missing offers
To: Naman Jain <namjain@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
References: <20241113084700.2940-1-namjain@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20241113084700.2940-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/2024 12:46 AM, Naman Jain wrote:
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

For the series:

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

