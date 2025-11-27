Return-Path: <linux-hyperv+bounces-7862-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 613FCC8CC93
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 05:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B5A3B0CCB
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 04:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2052D2481;
	Thu, 27 Nov 2025 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBBg9IU/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFD3595D;
	Thu, 27 Nov 2025 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764216343; cv=none; b=CDUySK467ZFa6nGKysd7cuN0YA6dbi76Z6WdHIFSDY21uPeFDurWvOtw94/bcO9RDP4MsVcBJzXfZfgIRLZV9otYVsdaVTT+3rT72kk8jiRY6UKAuoSobjdIHdJnPlQo3pro37RwRXyGGghwNhNRypLsXck2vhaDmaI0Z34GOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764216343; c=relaxed/simple;
	bh=ngfO4JdLWiXUNR+lbSQDH07CvdmvNAc4Esy3trJSZYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/jQBjtMmetfVNQpO1imIntgyF+s1f1vElcvNMp2S0iBdnsAfGQ2z6tQbXQmjfE+f9Fi4oO1xsn2LubNDD03xq7QTs2lF8ujYdtK02brJ6mM7UkJcsV195Puz2WLZbLhCMyQ2sxxfHurWyZ1R6e8+iXgTNwbLaQbl0Qm1ITEUCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBBg9IU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55022C4CEF8;
	Thu, 27 Nov 2025 04:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764216343;
	bh=ngfO4JdLWiXUNR+lbSQDH07CvdmvNAc4Esy3trJSZYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBBg9IU/SdfDU/VUSINnIwuz3NItEv8TvI/efpdI7lT9AlmfpXzlkGF4d8+TnAZTP
	 3fW3jYxFYOHeDxcfMqmcjvJShrJSURqktJsS5m7ercDz1ksUHbxla3EuVUQeJuoBXZ
	 aQCj+KD2bMB6aww72EdN9tATqFd8lsGnYuNwPs2WaMsVYX8WItwSzPllBGY3tUprw8
	 PGKuWrg5yBVFLAxOpkovq1SwpFACY8IS2hP7g4fcPXUjxS3zSs9VCIEmCQCw4a4dFa
	 vvgBQwWdJC0HQdpP13Ry54BVRbCFg+0VV4SAg7cWbYkmMxqxj2iYYFxSMp5aJbvfL1
	 rV/gRl8t6gZQA==
Date: Wed, 26 Nov 2025 20:05:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v4] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20251126200541.00e5270f@kernel.org>
In-Reply-To: <20251123180818.GA18398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251123180818.GA18398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Nov 2025 10:08:18 -0800 Dipayaan Roy wrote:
> Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detected
> and a device-controlled port reset for all queues can be scheduled to a
> ordered workqueue. The reset for all queues on stall detection is
> recomended by hardware team.
> 
> The change introduces a single ordered workqueue
> "mana_per_port_queue_reset_wq" queuing one work_struct per port,
> using WQ_UNBOUND | WQ_MEM_RECLAIM so stalled queue reset work can
> run on any CPU and still make forward progress under memory
> pressure.

And we need to be able to reset the NIC queue under memory pressure
because.. ?  I could be wrong but I still find this unusual / defensive
programming, if you could point me at some existing drivers that'd help.

> @@ -3287,6 +3341,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  	ndev->min_mtu = ETH_MIN_MTU;
>  	ndev->needed_headroom = MANA_HEADROOM;
>  	ndev->dev_port = port_idx;
> +	ndev->watchdog_timeo = 15 * HZ;

5 sec is typical, off the top of my head

> @@ -3647,6 +3717,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  		free_netdev(ndev);
>  	}
>  
> +	if (ac->per_port_queue_reset_wq) {
> +		destroy_workqueue(ac->per_port_queue_reset_wq);
> +		ac->per_port_queue_reset_wq = NULL;
> +	}

I think you're missing this cleanup in the failure path of mana_probe
-- 
pw-bot: cr

