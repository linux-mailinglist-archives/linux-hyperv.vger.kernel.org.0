Return-Path: <linux-hyperv+bounces-8329-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09944D2A065
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 03:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCD103008EB9
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 02:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DAD337B81;
	Fri, 16 Jan 2026 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X//KYJwT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AE337118;
	Fri, 16 Jan 2026 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529677; cv=none; b=I/BXaO2e8kaEkejweryANwwBf13U+sFc1C9EHEdQXRVG6GSHkGU9GuVaz6UZu/AX/D+ZA7RRFxooH7ZhKg6C5UzpCTUpauCst9ckaW6c9xhbUedWsvNESovjc1F3hRwfcSYLg//5pHhRdUIFLlH0WPsdTVg3KFxzn0srdmOCC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529677; c=relaxed/simple;
	bh=Wn0tUXC979x9pCkmMJyVpTI1cgSaVEHiWarrypJ7K4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkdOeVWBOenma44s6bUqpx+sAb1+2G+21ioJwv9La3wA28E8bDvv0TXoqLNr5irmGsisHOqV+HYHcMTSCYpze94TazqnG9rxcQ1/k85RSzWfRcHHZU821rMnFLKVY/ba37ewv17Yax1Lq3N1jrPgAItCydIOhJKfWFhcrwZuu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X//KYJwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1385C116D0;
	Fri, 16 Jan 2026 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768529676;
	bh=Wn0tUXC979x9pCkmMJyVpTI1cgSaVEHiWarrypJ7K4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X//KYJwT3bN2OJWMtKSoz+1hDIvthN9O61Xlg6jLUfieNIy43sWsrO3O6fiwQ9xr7
	 4lXLOxSwbWnCMvQPH89Plr4iwNj2iQdtgMkew545OzBEA6pYAqDeR8ngBH+vrGM+Ly
	 8TYnbF142VvYAmflRAosMjoAN3bA8p1ra6I1Ab0rYcFXwlCntpgePd3qHeKq4JyjNw
	 TFxaVWDZzBZUBqH+5vNbuvMUkFrvI8KBxBT4KzgQVHartyXjPWCmEaJxGAlROgJrek
	 VCVqZzBOaoUvfZiQyveUN2EuoWs0oxOg+aWHwEQbm6OE+ukljxd4+SAa1cQ1sOItVK
	 bEf9D6rb/58WA==
Date: Thu, 15 Jan 2026 18:14:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni
 Sri Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Aditya Garg
 <gargaditya@linux.microsoft.com>, Dipayaan Roy
 <dipayanroy@linux.microsoft.com>, Shiraz Saleem
 <shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Message-ID: <20260115181434.4494fe9f@kernel.org>
In-Reply-To: <SA3PR21MB38673CA4DDE618A5D9C4FA99CA8CA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260113170948.1d6fbdaf@kernel.org>
	<SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260114185450.58db5a6d@kernel.org>
	<SA3PR21MB38673CA4DDE618A5D9C4FA99CA8CA@SA3PR21MB3867.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 19:57:44 +0000 Haiyang Zhang wrote:
> > > When coalescing is enabled, the device waits for packets which can
> > > have the CQE coalesced with previous packet(s). That coalescing process
> > > is finished (and a CQE written to the appropriate CQ) when the CQE is
> > > filled with 4 pkts, or time expired, or other device specific logic is
> > > satisfied.  
> > 
> > See, what I'm afraid is happening here is that you are enabling
> > completion coalescing (how long the device keeps the CQE pending).
> > Which is _not_ what rx_max_coalesced_frames controls for most NICs.
> > For most NICs rx_max_coalesced_frames controls IRQ generation logic.
> > 
> > The NIC first buffers up CQEs for typically single digit usecs, and
> > then once CQE timer exipred and writeback happened it starts an IRQ
> > coalescing timer. Once the IRQ coalescing timer expires IRQ is
> > triggered, which schedules NAPI. (broad strokes, obviously many
> > differences and optimizations exist)
> > 
> > Is my guess correct? Are you controlling CQE coalescing>
> > 
> > Can you control the timeout instead of the frame count?  
> 
> Our NIC's timeout value cannot be controlled by driver. Also, the
> timeout may be changed in future NIC HW.
> 
> So, I use the ethtool/rx-frames, which is either 1 or 4 on our
> NIC, to switch the CQE coalescing feature on/off.

I feel like this is not the first time I'm having a conversation with
you where you are not answering my direct questions, not just one
sliver. IDK why you're doing this, but being able to participate 
in  an email exchange is a bare minimum for participating upstream.
Please consider this a warning.

If I interpret your reply correctly you are indeed coalescing writeback.
You need to add a new param to the uAPI. Please add both size and
timeout. Expose the timeout as read only if your device doesn't support
controlling it per queue.

