Return-Path: <linux-hyperv+bounces-8134-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA6CEF82A
	for <lists+linux-hyperv@lfdr.de>; Sat, 03 Jan 2026 01:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44FFC300518B
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Jan 2026 00:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA2318AFD;
	Sat,  3 Jan 2026 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8xc7vQp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777A4C98;
	Sat,  3 Jan 2026 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399109; cv=none; b=TT7myt2/h2mR2yey48rkEpQ7BSW2bMs5mPZD1RD/ujf3Ba1eAO7Dlh7agGPUWG9XYJmJfpjwGO1GfhEwYlCWjfrSvUz0FuW7HgG60N20LGjc2pGNqsME4Nih/u5zb5+PezI3GLEF3nPt5VEYT4Kf1VmEeXSmsssZRdyOG8Vi+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399109; c=relaxed/simple;
	bh=Q4cqK6bWZbz53wf+meTq+cGhMlhlz+v2zwMEOGPTWHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxBE85pUCjYiiTw2y8aD4N3kJTQAlq9Ve+2y85BPk3hlix3m4tuxYluL2ev5tyBqX653SAe8RUQ+BXSw5VZve53TSODbVJTq5b0hSzRon+er4UCMd7+8ZPw/n2RJSGGgj3McerGtXUGtvBCjwk3ltuE0uMGxeBAHMwEbE8ymASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8xc7vQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7839C116B1;
	Sat,  3 Jan 2026 00:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767399109;
	bh=Q4cqK6bWZbz53wf+meTq+cGhMlhlz+v2zwMEOGPTWHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I8xc7vQpClXbzklOTkMvDhQFVVS7rsbST2x8T3vrbqX7+bR3aUsWknPLf6zMBuHBT
	 KcoIA33xtp82BlwJMX/IdQEs72DZ1fr6Pfvk5qEj0ahKm21WvOJji2DXtT+MeONwNt
	 0ZZMCYZmFnugF0fQrXNO6PKsTxW+DZ4+TPUyo8DtwfSAGrIS8eMRvHzSVcGHSWp8X0
	 3oUN9zReW3gE+mOPOrLwd0W2uPiKONX2TA+VqP9TQQ5XcFU2Xb8vFrZzWsOOfTpDSZ
	 cvOJHlZRFy41H3GQ9i3+1tciDWjkCzqJbsg8k/zxSqspgGOlM44rpZgnx+p+NRe9B7
	 tWcr7XeHFhWUg==
Date: Fri, 2 Jan 2026 16:11:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Long Li
 <longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Aditya Garg
 <gargaditya@linux.microsoft.com>, Dipayaan Roy
 <dipayanroy@linux.microsoft.com>, Shiraz Saleem
 <shirazsaleem@microsoft.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, paulros@microsoft.com
Subject: Re: [PATCH net-next, 1/2] net: mana: Add support for coalesced RX
 packets on CQE
Message-ID: <20260102161147.1938b51d@kernel.org>
In-Reply-To: <1767389759-3460-2-git-send-email-haiyangz@linux.microsoft.com>
References: <1767389759-3460-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767389759-3460-2-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Jan 2026 13:35:57 -0800 Haiyang Zhang wrote:
> +		NL_SET_ERR_MSG_FMT(extack, "Set rx-frames to %u failed:%d\n",
> +				   ec->rx_max_coalesced_frames, err);

No trailing new line in extack messages, please.
Also please do not duplicate the err value in the message itself,
it's already passed to user space. Well behaved user space will format
this as eg:

  Set rx-frames to 123 failed:-11: Invalid argument
-- 
pw-bot: cr

