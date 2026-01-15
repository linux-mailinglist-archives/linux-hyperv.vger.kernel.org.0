Return-Path: <linux-hyperv+bounces-8303-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B952ED2232B
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 03:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC75A301B664
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 02:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D64270540;
	Thu, 15 Jan 2026 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNvy7nvT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331F21771B;
	Thu, 15 Jan 2026 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768445693; cv=none; b=cJEX3MnY11s5ID+AH+kbLsRS/9OveRKbDvE/FkbdnFs0rZn4aVlpMVzJDXIYouJsSxY4bQOhEN3TwXZi8Pv3aM8Y9C9mUEvbSdhmxQc7PwKu41+h6KN7pJYAMk/pnIbiJqUvdS7lvNR6unxbbAP4rG+8mQRAZNESZBUzM+OQAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768445693; c=relaxed/simple;
	bh=ReE9y3cpx7nfrJ/EI3c/BSACDpTiFZ3k4jBkHJnx2zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFgrJ3bOx2cfcHPiccwRcn+zMfmu/dT00+RBQWNGkY0pKEeDIZKY6ml2iyTLQGl/hm8CmkTnGAu5Gd/TSQKu5OgpmfW3ZsB5huTlN25HtHjXeIPf786sfIDkuJjbjAIDq1sNwoZcF8P66Fn/zEKAEVN7SEaxtH+zXqQz3Gt9ZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNvy7nvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC87C4CEF7;
	Thu, 15 Jan 2026 02:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768445692;
	bh=ReE9y3cpx7nfrJ/EI3c/BSACDpTiFZ3k4jBkHJnx2zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tNvy7nvTbYt57gDannbLvJRPECjFoYh5ylkqlUn7uvPmKR+JRLmipLhPkOcPCjf7z
	 uHP5V57EckjsdxmTzP9KixXv5M1rZN/aoCUIk3PM2Rnel5NgMkiw+0lC3vLzk3YoyB
	 lIz7/MSisKT7bGNYR9Blu2Eg8Hz7YGsvd1x1J1wp2lANoW+G2BfZDOoIQMAQ4xgYwS
	 MCVFwMasCZh/3XSVlen24lA5Wxi2KZ6P3jQzRl1JOn48ATEJli21atm3WOU27PnaLG
	 W2p/8N1CAGWkWbVlBEQ0dfsODueziN/13j5PGbuvLM7FHFsG7En6hmVPySbJwG/ORA
	 RCnHRYBtxMxQQ==
Date: Wed, 14 Jan 2026 18:54:50 -0800
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
Message-ID: <20260114185450.58db5a6d@kernel.org>
In-Reply-To: <SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260113170948.1d6fbdaf@kernel.org>
	<SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 18:27:50 +0000 Haiyang Zhang wrote:
> > > And, the coalescing can add up to 2 microseconds into one-way latency.  
> > 
> > I am asking you how the _device_ (hypervisor?) decides when to coalesce
> > and when to send a partial CQE (<4 packets in 4 pkt CQE). You are using
> > the coalescing uAPI, so I'm trying to make sure this is the correct API.
> > CQE configuration can also be done via ringparam.  
> 
> When coalescing is enabled, the device waits for packets which can 
> have the CQE coalesced with previous packet(s). That coalescing process 
> is finished (and a CQE written to the appropriate CQ) when the CQE is 
> filled with 4 pkts, or time expired, or other device specific logic is 
> satisfied.

See, what I'm afraid is happening here is that you are enabling
completion coalescing (how long the device keeps the CQE pending). 
Which is _not_ what rx_max_coalesced_frames controls for most NICs.
For most NICs rx_max_coalesced_frames controls IRQ generation logic.

The NIC first buffers up CQEs for typically single digit usecs, and
then once CQE timer exipred and writeback happened it starts an IRQ
coalescing timer. Once the IRQ coalescing timer expires IRQ is
triggered, which schedules NAPI. (broad strokes, obviously many
differences and optimizations exist)

Is my guess correct? Are you controlling CQE coalescing>

Can you control the timeout instead of the frame count?

