Return-Path: <linux-hyperv+bounces-3166-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4D9A597F
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 06:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFB11F21E79
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 04:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB22156C63;
	Mon, 21 Oct 2024 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CUvLazQA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0164A;
	Mon, 21 Oct 2024 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484762; cv=none; b=hYF2NHdaQ5q+0mX8vseJ9T5GSK/257o5enIytTPR0rb7FjK9TFT7Tp0XdatkbLhDbYZthsEYm2sT0QbfUjSATm/x052LAwMOX2Af9BPqk+nEu/OoexZJcZvxG1+Au5MDsA/O5ptFnhf7uv7m6WU3rM/UT6rtenJ/xYKtwTT5SgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484762; c=relaxed/simple;
	bh=fLM9qfYZeCPfng/lwbW6TWRBq4xBAumooLv80zHLBIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWH5spzx2KOUle55DV2UzjYkxQki1yYu7vykjhZU28bptXziPg3oGeHiI4dxD8UCUzdBZ65yzRthMr8bHqNdH65yzXkkChryseuJjWMHH6YrDTfYf9Q5VeLd0XqYjnT3aMx3xq45ZN9SnQLMJvXHy+0926eJqfe5oYC3VPbseUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CUvLazQA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 0D804210B2CF; Sun, 20 Oct 2024 21:26:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D804210B2CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729484760;
	bh=cSQBNQqMkWZE+LHST1q0OFpAeBXgqtG5Oe8kYvSI6TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUvLazQAioC5HgaTgyPQCBebjlzbNu4T/pNEITWwqEQW9pFWrSU26DmMrgavrTYgB
	 Q58bO+tbOHkHFGcR1SsG+MQjZlBHdbR244d1Fkj+BWak3dnbbocYrJTEtroPajDyRg
	 bPDaTW5jiuhZ9+SyzTiIpk628bzJrprs7+HTWeuA=
Date: Sun, 20 Oct 2024 21:26:00 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Starks <jostarks@microsoft.com>, jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Log on missing offers
Message-ID: <20241021042600.GA25279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-3-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018115811.5530-3-namjain@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Oct 18, 2024 at 04:58:11AM -0700, Naman Jain wrote:
> From: John Starks <jostarks@microsoft.com>
> 
> When resuming from hibernation, log any channels that were present
> before hibernation but now are gone.
> 
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index bd3fc41dc06b..1f56d138210e 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2462,6 +2462,7 @@ static int vmbus_bus_suspend(struct device *dev)
>  
>  static int vmbus_bus_resume(struct device *dev)
>  {
> +	struct vmbus_channel *channel;
>  	struct vmbus_channel_msginfo *msginfo;
>  	size_t msgsize;
>  	int ret;
> @@ -2494,6 +2495,21 @@ static int vmbus_bus_resume(struct device *dev)
>  
>  	vmbus_request_offers();
>  
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> +		if (channel->offermsg.child_relid != INVALID_RELID)
> +			continue;
> +
> +		/* hvsock channels are not expected to be present. */
> +		if (is_hvsock_channel(channel))
> +			continue;
> +
> +		pr_err("channel %pUl/%pUl not present after resume.\n",
> +			&channel->offermsg.offer.if_type,
> +			&channel->offermsg.offer.if_instance);

Do we want to put a TODO here, so as to do cleanup of these channels
like force rescind etc later ?

- Saurabh


