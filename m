Return-Path: <linux-hyperv+bounces-9554-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MkXAFI/vGn6vgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9554-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 19:24:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0052D0CC2
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 19:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D9133109D07
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 18:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735B23F23D8;
	Thu, 19 Mar 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKADsNj8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0432FA2A;
	Thu, 19 Mar 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944341; cv=none; b=kTHBItf3HV2TQMpBcYHNrcTxG9wafcTJKZw/XFcAoCRF6EF24GDnKjQaLWuiigoaXgo8FcH0UjH7mfS1GBGud1aXbVKblYibgWQOcNjvB2lQ+N4UB0d9aY/GTxkclAcqxKYX+OeEzHrKKLz1HhVBeRTxDec51CfbGUgUxmafziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944341; c=relaxed/simple;
	bh=FlUARS6V5JcxJHgN8D+FNxzhQzzcnaRhP4FENq7ucS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMU5uDnrQKcaLNjcrw0OZOmhdnW+ca6uuE3M04R/luYvf6jTDkJUxPwvYbr4IzESYhOWVUFIoSM3ZM5PMlzs7IIq8bKwI9ce+mLhoY9j3S5yVhygPvi8vb+l+yitqL7YkuNZ9Rx2QtXhV67qYEdWdAdZCaOkhs9MqUZPWFyfLYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKADsNj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBDBC19425;
	Thu, 19 Mar 2026 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773944340;
	bh=FlUARS6V5JcxJHgN8D+FNxzhQzzcnaRhP4FENq7ucS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKADsNj8KeBvKbeBV2GCOYYkG+YKLgB0ae1U+9NmcEmzkfQTDJMqHK/jBKG/0B+OH
	 mBgRIsy6jEUk5C8l0ogq1JWGP4euzBlRiiLJbDxqDaJzQ5qhcgfovW6hzQTaKHIPlF
	 yvn95tm5feihGxkV5fr+GN0bnvWslafAsmtNYf2f4bn+NGFE9V/cGMtl52PQ3OwwmJ
	 QICp69hOPnt12m5d/TCOllqNcPVY22QCUfUQzGTeuziYf3OtoYz4BW9I0lmt2OPcWO
	 Jq3paNI6BXfGkz9HkJ0v8DvkVUXB+EFSSJ26G9W26dYw2dBwWyRFlPO726MgtC9KpU
	 VKZSOgMyU0+rw==
Date: Thu, 19 Mar 2026 18:18:54 +0000
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: mana: fix use-after-free in add_adev() error path
Message-ID: <20260319181854.GS1753385@horms.kernel.org>
References: <20260318154041.638747-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318154041.638747-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9554-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 8E0052D0CC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 11:40:41PM +0800, Guangshuo Li wrote:
> If auxiliary_device_add() fails, add_adev() calls
> auxiliary_device_uninit(adev), whose release callback adev_release()
> frees the containing struct mana_adev.
> 
> The current error path then falls through to init_fail and accesses
> adev->id. Since adev is embedded in struct mana_adev, this may lead
> to a use-after-free.

It isn't clear to me how the use-after-free manifests.
Could you elaborate?

> 
> Fix it by storing the allocated auxiliary device id in a local
> variable and using that saved id in the cleanup path after
> auxiliary_device_uninit().
> 
> Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

As a bug fix for code present in the net tree, this patch
should be targeted at that tree like this.

Subject: [PATCH net] ...

And it should apply to that tree.

As it is the CI tries to apply this patch to the default tree, net-next.
Which fails. So there is no further CI performed.

> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 1ad154f9db1a..70d71594c599 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3362,6 +3362,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
>  {
>  	struct auxiliary_device *adev;
>  	struct mana_adev *madev;
> +	int id;
>  	int ret;

Please preserve reverse xmas tree order for local variables - longest line
to shortest.

>  
>  	madev = kzalloc(sizeof(*madev), GFP_KERNEL);

...

-- 
pw-bot: changes-requested

