Return-Path: <linux-hyperv+bounces-9071-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHsYEEFspGmmgQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9071-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 01 Mar 2026 17:41:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A31D0AAF
	for <lists+linux-hyperv@lfdr.de>; Sun, 01 Mar 2026 17:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17C133006832
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Mar 2026 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A333509B;
	Sun,  1 Mar 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCEqx7Z5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05B3332ECB;
	Sun,  1 Mar 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772383294; cv=none; b=s1IHay3eIwWcnXPR+cSo0Sgd9QfdMsqoQtYt4mbEJfjP8CAT9byd2W0p17ka3ihiBVqv6sVcVIRau1VRU8VC/6Uu4Un5LFKVttjpmWAF+hyadAZnX44x0AvxpVfl7der9Wv7JEYsXPxQLUZQfn96qfOiYYtG5J9iLlzPUCucfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772383294; c=relaxed/simple;
	bh=Lhw6y9gr6xwGO8OAR1p1JEDus6x1O3Q9UHjcsImSwxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HePZfh6/jzqmOi6cQa+vjkTbaiiFRE050fh2xpyRNVcdl+4ShTwEj/IPTjqb4ri9NEF3YCGayYiiQJxAmnDJPGMOXj2b8tEfeS64mKLDHWj5s6CUY4lM0vRTDefoEPh4lH7mVzFpZey//eB2TOzA4GdLyJegriUFNx+n6Gg5IO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCEqx7Z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BD0C116C6;
	Sun,  1 Mar 2026 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772383293;
	bh=Lhw6y9gr6xwGO8OAR1p1JEDus6x1O3Q9UHjcsImSwxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LCEqx7Z5/FdZC7Fx5FshWKSJACjHYBu3q3IAyCk+0MbipHN7spLuH1LbDfLntABCx
	 T6KZ6nSqVSwxhv6PTzE4OnEOq7yksFbl1lazTHGdldbphO8L/Jk1qEwyjho+9ZTixS
	 OAqBm6DgyqU+/GS71e5wMva7YRz/9UktfDrBFRKyb+wkg/9tkZn+FSizRlmTPZxLmt
	 VvoIDUZivPIsY0NDIucmOip2zQevNB0TkRpubJMBonpzj3W30zk+WmpZ74JqMCkDEu
	 MaDo1cHg5O7APyu2M2oNEdrfeVk6mrU8cfT1pnPconINJwAe2DnV56b4vsnrD0anP0
	 jwQHBIO6xKcxw==
Date: Sun, 1 Mar 2026 16:41:27 +0000
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, ssengar@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Add MAC address to vPort logs and
 clarify error messages
Message-ID: <aaRsN8FDf8aH54QB@horms.kernel.org>
References: <20260225192252.943534-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225192252.943534-1-ernis@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9071-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: DE3A31D0AAF
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:22:41AM -0800, Erni Sri Satya Vennela wrote:
> Add MAC address to vPort configuration success message and update error
> message to be more specific about HWC message errors in
> mana_send_request.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

...

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c

...

> @@ -893,8 +895,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  	if (!wait_for_completion_timeout(&ctx->comp_event,
>  					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
>  		if (hwc->hwc_timeout != 0)
> -			dev_err(hwc->dev, "HWC: Request timed out: %u ms\n",
> -				hwc->hwc_timeout);
> +			dev_err(hwc->dev, "%s:%d: Command 0x%x timed out: %u ms\n",
> +				__func__, __LINE__, command, hwc->hwc_timeout);

I have reservations about the usefulness of including __func__ and __LINE__
in debug messages. In a nutshell, it requires the logs to be correlated
(exactly?) with the source used to build the driver. And at that point
I think other mechanism - e.g. dynamic trace points - are going to be
useful if the debug message (without function and line information)
is insufficient to pinpoint the problem.

This is a general statement, rather than something specifically
about this code. But nonetheless I'd advise against adding this
information here.

>  
>  		/* Reduce further waiting if HWC no response */
>  		if (hwc->hwc_timeout > 1)
> @@ -914,9 +916,9 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  			err = -EOPNOTSUPP;
>  			goto out;
>  		}
> -		if (req_msg->req.msg_type != MANA_QUERY_PHY_STAT)
> -			dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
> -				ctx->status_code);
> +		if (command != MANA_QUERY_PHY_STAT)
> +			dev_err(hwc->dev, "%s:%d: Command 0x%x failed with status: 0x%x\n",
> +				__func__, __LINE__, command, ctx->status_code);

>  		err = -EPROTO;
>  		goto out;
>  	}

...

