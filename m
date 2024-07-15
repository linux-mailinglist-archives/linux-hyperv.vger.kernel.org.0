Return-Path: <linux-hyperv+bounces-2566-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B64931604
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jul 2024 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDB31F224EB
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jul 2024 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3D18C357;
	Mon, 15 Jul 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEOs2APd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490A1741CF;
	Mon, 15 Jul 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051153; cv=none; b=mzkWvpnd6GddjTe4b6QeAdyd+YEmPOjdw/0pJeG0Uo/dyxYOhL8pF5wUu+46X6FvV3iquouekbdMkWn2MyxcBQBsOHjLPd7Hy+3EALJmKdB8i+oMyO1B826JmFQwScJtFKleWSIWqHDpm/zGyAzf0epJKkbAYY6Y5EO1B5AZGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051153; c=relaxed/simple;
	bh=HVGY/h4cNN4DFAIeEiRfe9sGWKWRmKyBHgJJ93LF0CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpnpdvOTxVA11QFAHrIvuzQziUrCVxoxmCX3AV8z2Gu071mPdcJEPh7KhrOuOdTJhWUadssBJUHJ6CQIo02CRYA0bMWckbhMFLwwBqRER1uRogRQiYTMLxNZ79/IGutxTSPctIptHjfB5G35c6JwLX4pc8IyTYLUEdjHUxotSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEOs2APd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AFCC32782;
	Mon, 15 Jul 2024 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721051153;
	bh=HVGY/h4cNN4DFAIeEiRfe9sGWKWRmKyBHgJJ93LF0CQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TEOs2APdlr9nB8KQSYdCEhpSlXEM4ZB5hxlg8ww8JUyr0kjCBy8yuxROJ9FKcafZ1
	 On71BBQpyuQWTSBpHEv7Z8htHbDgQHLpBMRY0+cAHF+JYXju2zHfWrc8NkoqyxII+4
	 PhI6VI6thzptWqBtvYiDcXtkOHB6MzpBayA0xZaDnae8jjJVmyk9R9NUs2AtjlKnwN
	 BMgX6bo1JvguXIl6iLrrso+37JAfSsLFbYI8STexq6fl+syFm/3CsbPar4MfYpsABf
	 bPKBNbZiZGgBH5L8pZzY5mW2PO7Je56FisqkWzDoSdy/4K8MA9E0nzNv1LfTHwAdGl
	 /+W1hFtcaTN6A==
Date: Mon, 15 Jul 2024 06:45:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Long Li <longli@microsoft.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Simon Horman <horms@kernel.org>, Konstantin
 Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240715064551.6036d46b@kernel.org>
In-Reply-To: <1721014820-2507-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1721014820-2507-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jul 2024 20:40:20 -0700 Shradha Gupta wrote:
> +	if (ring->rx_jumbo_pending) {
> +		netdev_err(ndev, "%s: rx_jumbo_pending not supported\n", __func__);
> +		return -EINVAL;
> +	}
> +	if (ring->rx_mini_pending) {
> +		netdev_err(ndev, "%s: rx_mini_pending not supported\n", __func__);
> +		return -EINVAL;
> +	}

I think that core already checks this

> +	if (!apc)
> +		return -EINVAL;

Provably impossible, apc is netdev + sizeof(netdev) so it'd have to
wrap a 64b integer to be NULL :|

> +	old_tx = apc->tx_queue_size;
> +	old_rx = apc->rx_queue_size;
> +	new_tx = clamp_t(u32, ring->tx_pending, MIN_TX_BUFFERS_PER_QUEUE, MAX_TX_BUFFERS_PER_QUEUE);
> +	new_rx = clamp_t(u32, ring->rx_pending, MIN_RX_BUFFERS_PER_QUEUE, MAX_RX_BUFFERS_PER_QUEUE);
> +
> +	if (new_tx == old_tx && new_rx == old_rx)
> +		return 0;

Pretty sure core will also not call you if there's no change.
If it does please update core instead of catching this in the driver.

Please keep in mind that net-next will be closed for the duration
of the merge window.
-- 
pw-bot: cr

