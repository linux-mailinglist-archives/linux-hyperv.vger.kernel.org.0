Return-Path: <linux-hyperv+bounces-4966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F82A92E88
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 02:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B166188AD7A
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 00:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956884A21;
	Fri, 18 Apr 2025 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpk/L5+M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425B10E3;
	Fri, 18 Apr 2025 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934454; cv=none; b=Z4hbTDabR9YT5ZyYUTgm+RB+tavJXeit7EXQ+rxFuWppSyXC4zMNQm5CBKLmHyWXwezKbw9/JbCi6V8/XMk8Ir33XVlHQw1M8wFzSXDVte87J0JAPRVUAeSlMjqdrlCdED17ucQF+ExKFNw9S9Nc8/ah7bTweNGik/IMbk8xPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934454; c=relaxed/simple;
	bh=9OXUn704riJZPO/RvXHx66+z0xB7yRptffOmIPYtnug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Phi0GpVNbtm+omu2WuOK6zcFYuzBIy7qRvlx+kh9TrxsaRABzr5SmOd/BAE9+Du036Zf3bJTkFCKus4zT5tUytkUYo3X6C0Mlf91zTwM6IIlLss9OMzPwIvS2To8LXm8YXc7TrQuaVhKR6O7QgXCe/j/MVVsr9aZDl9pp032LD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpk/L5+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1022C4CEE4;
	Fri, 18 Apr 2025 00:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744934453;
	bh=9OXUn704riJZPO/RvXHx66+z0xB7yRptffOmIPYtnug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dpk/L5+Mx544xE6D9Tv+G+44z4vyLj1gddYimunxBzlIV8AIJ3KD7UaUC+O45NFhk
	 SVL1IHgpqnBAegNm2Wh4NPrNt/nXVPuQ9sEAr+MVFx0cLOmVh5RB7xpKIkaws5pnjY
	 Bg8aG7jdHJDlGDlZiJwz+sQ3dCEpJ3V9qNPe42RUn5raPfDcj2wrCjqC1q4FWFC8g0
	 WMa46QLOfUGpoXB4yt5RPn7/jSItCqLfxStqZ9AisTG7nIuC7ht6U8vWaWiGwGyhip
	 zDb5DUjKSksPchn1/lIJLXpXcJVAmcUwNqHGgFy+7IGxNy94pmZn6D/xx97Tqe3uXw
	 5gSn78dFY5bug==
Date: Thu, 17 Apr 2025 17:00:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, longli@microsoft.com, kotaranov@microsoft.com,
 horms@kernel.org, kent.overstreet@linux.dev, brett.creeley@amd.com,
 schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, rosenp@gmail.com, paulros@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250417170052.76e52039@kernel.org>
In-Reply-To: <20250417194727.GB10777@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
	<1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
	<20250417081053.5b563a92@hermes.local>
	<20250417194727.GB10777@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 12:47:27 -0700 Erni Sri Satya Vennela wrote:
> > A single leaf is just Token Bucket Filter (TBF).
> > Are you just trying to support some vendor config?  
> TBF does not support hardware offloading.

Did you take a look at net_shapers? Will it not let you set a global
config the way you intend?

