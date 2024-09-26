Return-Path: <linux-hyperv+bounces-3076-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1298763F
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 17:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18C51C243B4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18914B959;
	Thu, 26 Sep 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0uA6VNJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E0EAD5;
	Thu, 26 Sep 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363429; cv=none; b=PR6OJkoSvASqB8U1jXgxCbwMaHCu9iPdtC3HaGUrt+gu75/t1bj56Y2o+X+svUL/5SCaudUgHExaTwh8UpNGQtub7Hu6Cd0GtHNJICsTz1obnLAFgyhBD1OFM+vcNcVYlNJwLtDVGmJqdA9jjLWWQfXy2pSqRUp+U9CccViQzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363429; c=relaxed/simple;
	bh=podp9cyTxPT2gpzGQLu7FN3TIUGpAM5koVjYtwJgWHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKvTeRlVrmGiHimvCFOMrjDqsfZ2Ul4CpSMVAVZzyoUqgPQ5jvGfQ67QO0L/7y3jOKBi3xoGb2LJvhpsWqXRr0ttow9Y+KRY+BBPpwZZ376CDi3U2WBLv5TRIY+VTAIQPUO49LB+IJwLVCElgAUiCHUzEwof9Ba7A2JK5fCr9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0uA6VNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74C0C4CEC5;
	Thu, 26 Sep 2024 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727363429;
	bh=podp9cyTxPT2gpzGQLu7FN3TIUGpAM5koVjYtwJgWHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0uA6VNJ1v404EQG/3yAfO3apjMEV7nz1IOW1P8HZlz6W3rcv64z9amQb9utZAMJF
	 /ecdFTP+5ItJK92Vq5Dv6bn5exk/aeyGRLQrXAJcjvVW5386orNG/LdH3WDLsw5kfk
	 cJ9kuQJWOTuE8V/khFt1WyGt/BLFSO7WbXsfqSquyh5E5LXoSpsnN0yZLlGO1lHjnr
	 Wvp3M5B005c09k21jNbSoH1ZVP2klnzABM3w6ckKvI4sO9Plv0/Vf/iKxiVFyK1QRh
	 C8JN6BWSQt46p702E8ygoEbaI/vp7Ly/WavzrJRamZUsCQUK4CuFIen3yMrvJ6vCZs
	 k3vRDTSmXhRYA==
Date: Thu, 26 Sep 2024 16:10:24 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Message-ID: <20240926151024.GE4029621@kernel.org>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924234851.42348-2-jdamato@fastly.com>

On Tue, Sep 24, 2024 at 11:48:51PM +0000, Joe Damato wrote:
> Use netif_queue_set_napi to link queues to NAPI instances so that they
> can be queried with netlink.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
>  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 2b6ec979a62f..ccaa4690dba0 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device *device)
>  	for (i = 0; i < net_device->num_chn; i++) {
>  		/* See also vmbus_reset_channel_cb(). */
>  		/* only disable enabled NAPI channel */
> -		if (i < ndev->real_num_rx_queues)
> +		if (i < ndev->real_num_rx_queues) {
> +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX, NULL);

Hi Joe,

When you post a non-RFC version of this patch, could you consider
line-wrapping the above to 80 columns, as is still preferred for
Networking code?

There is an option to checkpatch that will warn you about this.

...

