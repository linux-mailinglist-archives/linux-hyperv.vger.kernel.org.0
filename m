Return-Path: <linux-hyperv+bounces-7415-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D87C38733
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 01:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA04E57FC
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8F01459F6;
	Thu,  6 Nov 2025 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txxNrIn9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650C11713;
	Thu,  6 Nov 2025 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388276; cv=none; b=TDvD8eIlweuAU0kdcebSdxJ1WET4/cfjisSeZEsLKf/Ut0r7EonLDQ9NV63BJ8VXEgx9XhkjnCOFV+nhRYfH952M0/kTO+M1RK63dj6Kj1gZLavDx0UskpG/yOOpSZgi0Wezh1AbzMP/JZFR2jShWNMKGzOP9aiH55OtQ/dxokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388276; c=relaxed/simple;
	bh=GVz+TVoRh+RjWKgd1xdbBvSkK6ruOqrTXrULqH739jY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECgvNIRv/MANTEdTZ29dlRqChJIHQ79Ec+cKXI9q0uWjrVnSSSZkhRO7/GBgM//jGOw1NNqY00sljJeGguVF6Wva60OuE0i2hbN//eys+RkbZf9hR7JZo8pn9QSQpAXXZsC2sVceZuA5y0GzeREbDF7+vMFhgWtY2f1Egy3o110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txxNrIn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28746C4CEF5;
	Thu,  6 Nov 2025 00:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762388276;
	bh=GVz+TVoRh+RjWKgd1xdbBvSkK6ruOqrTXrULqH739jY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=txxNrIn90M/a5q/AZXy6vsUneD21zc4Nryy5OMeU1JH94vrA2MHX+DJkUXTFPWu6x
	 FHIMUxv70o48VAr+lkiH0R5AOQm8ecBiyLbRpNTI2vYo5NrKvMoDLzJT5aY+2x8YV7
	 fh61ewGWMAkRqe76wR/auwZr6USnYiDqOTu3hudCQ7yy/EPjX+XcUIW83CC3xuTQLs
	 BBT06OSz3uaDlQ76wabhcOZk9HGU+fjLm6AgXZT+vf0kNayy1i/shUYU2WgvPhFFqo
	 n3RgYBRg9fAwz50m9HChfiCOUdNdMLevmNhgW245kz2dLc9Jl9PXlHA9Cz9iL/UHbh
	 yxK+8+4OEg6Zw==
Date: Wed, 5 Nov 2025 16:17:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gargaditya@microsoft.com
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
Message-ID: <20251105161754.4b9a1363@kernel.org>
In-Reply-To: <82bcd959-571e-42ce-b341-cbfa19f9f86d@linux.microsoft.com>
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20251031162611.2a981fdf@kernel.org>
	<82bcd959-571e-42ce-b341-cbfa19f9f86d@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Nov 2025 22:10:23 +0530 Aditya Garg wrote:
> >>   	if (err) {
> >>   		(void)skb_dequeue_tail(&txq->pending_skbs);
> >> +		mana_unmap_skb(skb, apc);
> >>   		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);  
> > 
> > You have a print right here and in the callee. This condition must
> > (almost) never happen in practice. It's likely fine to just drop
> > the packet.
>
> The logs placed in callee doesn't covers all the failure scenarios,   
> hence I feel to have this log here with proper status. Maybe I can 
> remove the log in the callee?

I think my point was that since there are logs (per packet!) when the
condition is hit -- if it did in fact hit with any noticeable frequency
your users would have complained. So handling the condition gracefully
and returning BUSY is likely just unnecessary complexity in practice.

The logs themselves I don't care all that much about. Sure, having two
lines for one error is a bit unclean.
 
> > Either way -- this should be a separate patch.
> >   
> Are you suggesting a separate patch altogether or two patch in the same 
> series?

The changes feel related enough to make them a series, but either way
is fine.

