Return-Path: <linux-hyperv+bounces-2780-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BC8954E37
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Aug 2024 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB17283CB6
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Aug 2024 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849F1BD515;
	Fri, 16 Aug 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f58ktCbw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF11DFFC;
	Fri, 16 Aug 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823564; cv=none; b=GIkERXVq7mq5aNhixtnB1VAoBcgqHpIKI27Wszj1l7+6I0WByMV5dwh2HplT3HYA/W/c8rU7KggFaLFk38miaU4Cdf/lebRp5vmNg8Zb94CX4SQUO3kNqdjqqjL7q+boJP8jlC11jpDrp9G3KB7QgSBN6D0zhwMIBAPSAp+Ril0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823564; c=relaxed/simple;
	bh=ACqyElDZy+CTnC1ceAx9rNBXspwkSCEMVM7SUZDX/NA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuiX0s/zH3B4LO51AB2Myh10l+yeGhDStLUoIKwGAyTtsSx2892zBYLhVi0vKGd/X4sB6ytkZzJGqm8mJebn1uwUBi2M/WeQdZ7gYZj5toQFpVW74tePVyh9fCzz9v27HhvXB4iGmgMNT840/2d+YVqelwXKrM0asDrYCJpHuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f58ktCbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E2AC32782;
	Fri, 16 Aug 2024 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723823563;
	bh=ACqyElDZy+CTnC1ceAx9rNBXspwkSCEMVM7SUZDX/NA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f58ktCbwXMaJD77pMegEw3oVBuXepbMBdPFvwzHIuIoHf7JbgRxNZiI92S7JYn1Xc
	 5ZP8l7NBNxwDJgeyy80pN92AWdNXJ7ZBPw8KC6u3P9IiOPzihD9V8Znmk7gTNtdMB1
	 xakQOLhmIqnvql3Ys9zab13xVwBCSZSYYj4sJ09HSp6bM41P8cg1wWclha5Mf51309
	 VblLngPWcPgMvkHinl/a8wmen4EXRlqYV3VfxmySLwnG2tod+fDsqb2X96j1sjCndC
	 I44u5Q+t5/HqYu6/XDQ0G3nGK4skHagvBnfzVMP5Vdi8f1facEkkKncdEu7cvdGL8a
	 3II39X6hy12VA==
Date: Fri, 16 Aug 2024 08:52:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, Erni Sri Satya
 Vennela <ernis@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: netvsc: Update default VMBus channels
Message-ID: <20240816085241.326978a6@kernel.org>
In-Reply-To: <CH2PPF910B3338DB4798D086CB50600C2FBCA802@CH2PPF910B3338D.namprd21.prod.outlook.com>
References: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
	<20240815090856.7f8ec005@kernel.org>
	<CH2PPF910B3338DB4798D086CB50600C2FBCA802@CH2PPF910B3338D.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 19:23:50 +0000 Haiyang Zhang wrote:
> Your suggestion on netif_get_num_default_rss_queues() is not ignored.
> We discussed internally on the formula we used for the num_chn, and
> chose a similar formula for higher number of vCPUs as in 
> netif_get_num_default_rss_queues().
> For lower number of vCPUs, we use the same default as Windows guests,
> because we don't want any potential regression.

Ideally you'd just use netif_get_num_default_rss_queues()
but the code is close enough to that, and I don't have enough
experience with the question of online CPUs vs physical CPUs.

I would definitely advise you to try this on real workloads.
While "iperf" looks great with a lot of rings, real workloads
suffer measurably from having more channels eating up memory
and generating interrupts.

But if you're confident with the online_cpus() / 2, that's fine.
You may be better off coding it up using max:

	dev_info->num_chn = max(DIV_ROUND_UP(num_online_cpus(), 2),
				VRSS_CHANNEL_DEFAULT);

