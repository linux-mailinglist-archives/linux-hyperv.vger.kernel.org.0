Return-Path: <linux-hyperv+bounces-7206-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED2BD6556
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 23:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E819A0127
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23926561D;
	Mon, 13 Oct 2025 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DUxTdpLb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E11219E8;
	Mon, 13 Oct 2025 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390013; cv=none; b=Ab0uzHOffP9/RjOg61aO7h3P0ehOs4VaGZQfOx/y/NZetLeFge4BgjbXku8WOFLLMRujHBQPIDB6EujsRMj7sbRv8B4WP05ZIsM2dA+F8BVxGLMTW35VhH8kUz3BYOCIMQLmLaRhVmQsn+lcW7nqQQZZ/tbVG7VRR3bZPZGdw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390013; c=relaxed/simple;
	bh=4RZ1W/0OtJO42EVel9j3/ON3Ful8VIZ1NXg+yp0Riug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiV13WsX1apnd2/vpg8lpkaGFqjc0CGOUyuxyepOZ5RaEw3H1dHaWbHzi4LpZ2vE73IAHIKbkq7rZx5t+CKG9e0Fw8EnLpTtoTa70VyoilvTc91BrVYVgvRH5T346oqBXngFD6MyDD19WA1QJCNJKNrUcAkWH9uH6iKptNzjYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DUxTdpLb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lILPrmAnEJYFOg9nKICbbMK/wh/wWM1Gf/ZklRUMM3I=; b=DUxTdpLbIDoIluCHOCvrB+0FqV
	mqoyAUuQ3hL2gr991kawpdf16Ct5d3qyamLT3uD2R91pK8PpqtDx2FYS34fbunxAYr/Fyim9PLUFk
	RZtVr2+BYJ7hS2sIZ5CbyfLtBtywiZtS3aVcCZUDWMnTTEyRG97zp6MTcYGocgpkc4as=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8Pr6-00Aq7D-5J; Mon, 13 Oct 2025 23:13:20 +0200
Date: Mon, 13 Oct 2025 23:13:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	haiyangz@microsoft.com, paulros@microsoft.com, decui@microsoft.com,
	kys@microsoft.com, wei.liu@kernel.org, edumazet@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, leon@kernel.org,
	mlevitsk@redhat.com, yury.norov@gmail.com,
	shirazsaleem@microsoft.com, andrew+netdev@lunn.ch,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Support HW link state events
Message-ID: <74490632-68da-401d-89a7-3d937d63cbe3@lunn.ch>
References: <1760384001-30805-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760384001-30805-1-git-send-email-haiyangz@linux.microsoft.com>

> +static void mana_link_state_handle(struct work_struct *w)
> +{
> +	struct mana_context *ac =
> +		container_of(w, struct mana_context, link_change_work.work);
> +	struct mana_port_context *apc;
> +	struct net_device *ndev;
> +	bool link_up;
> +	int i;

Since you don't need ac here, i would postpone the assignment into the
body of the function, so keeping with reverse christmass tree.

> +
> +	if (!rtnl_trylock()) {
> +		schedule_delayed_work(&ac->link_change_work, 1);
> +		return;
> +	}

Is there a deadlock you are trying to avoid here? Why not wait for the
lock?

> +
> +	if (ac->link_event == HWC_DATA_HW_LINK_CONNECT)
> +		link_up = true;
> +	else if (ac->link_event == HWC_DATA_HW_LINK_DISCONNECT)
> +		link_up = false;
> +	else
> +		goto out;
> +
> +	/* Process all ports */
> +	for (i = 0; i < ac->num_ports; i++) {
> +		ndev = ac->ports[i];
> +		if (!ndev)
> +			continue;
> +
> +		apc = netdev_priv(ndev);
> +
> +		if (link_up) {
> +			netif_carrier_on(ndev);
> +
> +			if (apc->port_is_up)
> +				netif_tx_wake_all_queues(ndev);
> +
> +			__netdev_notify_peers(ndev);
> +		} else {
> +			if (netif_carrier_ok(ndev)) {
> +				netif_tx_disable(ndev);
> +				netif_carrier_off(ndev);
> +			}
> +		}

It is odd this is asymmetric. Up and down should really be opposites.

> @@ -3500,6 +3548,8 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  	int err;
>  	int i;
>  
> +	cancel_delayed_work_sync(&ac->link_change_work);

I don't know delayed work too well. Is this sufficient when the work
requeues itself because it cannot get RTNL?

	Andrew

