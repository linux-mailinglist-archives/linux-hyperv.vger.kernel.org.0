Return-Path: <linux-hyperv+bounces-858-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C017E8F60
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Nov 2023 10:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C181C2030E
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Nov 2023 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1B53A1;
	Sun, 12 Nov 2023 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLosm4Tw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6085235;
	Sun, 12 Nov 2023 09:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C05C433C7;
	Sun, 12 Nov 2023 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699782334;
	bh=OB/TnIUPp8h8xH68B7wjC4cmDf3tWH563iHB+jmZzlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLosm4TwwZoY2bJ+rW5VRYe0hJiWvYBuZYkqYZBW658Q3BsWFPT+vKDGC/KPt+IM7
	 nFVoyCaaG7BWW+yFKXy+mrWVq8mQe91e4dHwikc4CvXjZzM9cGX5GSsCM7kEnrChc7
	 0mLJ8e2lHGUq8/ebxcGVmVNQmSuSu5OdRmJyO0xAPOaD/omKwqNZHJnoVhy4jo6TUC
	 URiDNqwSJ6J7NwFDumtTT1XkerWIv0dYnNEdQ2GXsKmkmcagGCCUb4rL7U5G7v2rMP
	 gnf581OhMHFylepHTE3bJARq7/wwCTCDhz67gM6/tJQblEzJm5EAHqwd7vEWWPHjcd
	 90nlGLDhe+PsQ==
Date: Sun, 12 Nov 2023 09:45:24 +0000
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net,v4, 1/3] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Message-ID: <20231112094524.GF705326@kernel.org>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
 <1699627140-28003-2-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699627140-28003-2-git-send-email-haiyangz@microsoft.com>

On Fri, Nov 10, 2023 at 06:38:58AM -0800, Haiyang Zhang wrote:
> The rtnl lock also needs to be held before rndis_filter_device_add()
> which advertises nvsp_2_vsc_capability / sriov bit, and triggers
> VF NIC offering and registering. If VF NIC finished register_netdev()
> earlier it may cause name based config failure.
> 
> To fix this issue, move the call to rtnl_lock() before
> rndis_filter_device_add(), so VF will be registered later than netvsc
> / synthetic NIC, and gets a name numbered (ethX) after netvsc.
> 
> Cc: stable@vger.kernel.org
> Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


