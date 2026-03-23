Return-Path: <linux-hyperv+bounces-9692-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wItKI5FQwWnLSAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9692-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 15:39:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB32F4EE0
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA3630E89AE
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5F73B5825;
	Mon, 23 Mar 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv0Nbj3R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8D3AEF44;
	Mon, 23 Mar 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274334; cv=none; b=bHliIB+Jm2f+9VgIZMBpBGFWCoDcJf/3NDH1rgcqqv4YkO2BloFigwzF9O1cAjUg/gsn/ncPZf4Se+3piQ7UEp7VcaeSgopCJnSQjb/zMIlePncJU0jTedcUjClC2CisK4F1KNmbm5ZWno0tv3bwoycEwp2Zj/GcyQMHwKFspQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274334; c=relaxed/simple;
	bh=AKIGrahRS6MqycY/IVQEkczZoNB5oHx2vuV+286zxtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goxWkrklG8VppiXTUNbZ8Prutby6AZ945qhn4Ng8qIabJE4ZEhpDr4WucxOajB8E6KjqvHyVEZmsGJXTud59GnRxPyaA+HUk1Mtz6vHnzz6kQknFj0UOMxjhNiC/wWol0JlhtGieOdKT+G/KcvBxZxfoZThTf9uW7kRhfiqjwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv0Nbj3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7643C4CEF7;
	Mon, 23 Mar 2026 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274333;
	bh=AKIGrahRS6MqycY/IVQEkczZoNB5oHx2vuV+286zxtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rv0Nbj3RvQ3r6yIk7CDQKc+CBtzkVG91FT7R8KseLJwfwkKYLmF6/3lZvpE3laLDU
	 vKAlbmlepiou3Ef91Z8QXs5+1se6ZteTaYke/SkqVULJLzUCxg8vvX/9rpe4SWYm9W
	 Svof0b01MEnsCvUn5VVggSgIsDLGOrcxghOiG+dQZawXRNa7qRUeiDYGZJMYSFyQDS
	 P3ICritRi51nAR93v0pfCbpTdzblITK6BcOYN0fljR1WYgkFAcKehNbuQhsjjQ96J/
	 tYAt/xQLytiwhGJ/VEqJy5S2dgxRfQmGK6h+0o6zxpFPUzx+DlLgXbQxWudKEIyn8X
	 frcv6Cd3F/2PQ==
Date: Mon, 23 Mar 2026 13:58:48 +0000
From: Simon Horman <horms@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Set default number of queues to 16
Message-ID: <20260323135848.GA81558@horms.kernel.org>
References: <20260320233027.1603495-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320233027.1603495-1-longli@microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9692-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E3BB32F4EE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 04:30:27PM -0700, Long Li wrote:
> Set the default number of queues per vPort to MANA_DEF_NUM_QUEUES (16),
> as 16 queues can achieve optimal throughput for typical workloads. Users
> can increase the number of queues up to max_queues via ethtool if needed.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
>  include/net/mana/mana.h                       | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 49c65cc1697c..7cae8a7b9f31 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3357,7 +3357,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  	apc->ac = ac;
>  	apc->ndev = ndev;
>  	apc->max_queues = gc->max_num_queues;
> -	apc->num_queues = gc->max_num_queues;
> +	apc->num_queues = min(gc->max_num_queues, MANA_DEF_NUM_QUEUES);

Hi Long Li,

Maybe I am misunderstanding things.  But it seems to me that this patch
sets a ceiling on the default number of queues. Which is subtly different
to setting the default. Even if not in practice if max_num_queues is never
less than MANA_DEF_NUM_QUEUES.

If so I'm wondering if you could tweak the commit message accordingly.

>  	apc->tx_queue_size = DEF_TX_BUFFERS_PER_QUEUE;
>  	apc->rx_queue_size = DEF_RX_BUFFERS_PER_QUEUE;
>  	apc->port_handle = INVALID_MANA_HANDLE;

...

