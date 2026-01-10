Return-Path: <linux-hyperv+bounces-8206-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBFAD0CCA5
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Jan 2026 03:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F03CF3028D59
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Jan 2026 02:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAD1C4A24;
	Sat, 10 Jan 2026 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd+3VEil"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E612B93;
	Sat, 10 Jan 2026 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010531; cv=none; b=KT/PXHkNGjz/uUSaJzmSYttDm8oDuyvXvgAyskrMfH0sp0AEkYsMV4zl7e6XPZ74e3HbaYgeSX0WB86sqLjlvjt1itsURegoa3MzsYpvB+adO5z/Sp5dUUh+Pk8/Xy62CX8sFHDA8lZ2sjj1oUKWccAZmfZhjnipGY0+w+gygFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010531; c=relaxed/simple;
	bh=1MOiVEexVGrwFEVsAZA/tszL4KabaceGog91OcJBTnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFamiTJN91fykmAvfsv4bOhmHCnXlSfQ3kmt3tGeyn1sbucYgtTTK9r9Ve0g6tIth8jiUAMgVS1538GR3SaBzlp6aryAVjVAG/6Yh76/XfJLJ/oDnDZ1INWXy/glYmU3NZNxRDUyHQ06dPOm+WcnmaIaJ4t7VxeaOMpRGAPSGxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd+3VEil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473D7C4CEF1;
	Sat, 10 Jan 2026 02:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768010531;
	bh=1MOiVEexVGrwFEVsAZA/tszL4KabaceGog91OcJBTnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wd+3VEilhx6c25iOV43CWBhiMYs6aEI1zKqAFF8/Y3YhE4igyDQLEViKqADeZF5HM
	 94/Eh2dUrycT5muvCfr5C33/S33uo7tjQ90p0UHqYQUxHceu9qhEjyl7+/H5O1Pk55
	 o6Ogq6ZBy7D2YdC54DKaditdUdTxkZntMSY6ZNMi0651hlKp4NPOU9/cTaZbt47tcp
	 hHbHzEeAm8lUphQO1Yf6zeKrW5O+6JWaBkp3GMwHGDR/cgJqc619zmIDDWIyMd/dMa
	 pUGI15Q/+z9wnX09byNq950AuIT6CQVo79FWt9lJXLwsO6r9vqJS2oFQfUCzH0JpH0
	 R9XRWxDjYYJNA==
Date: Fri, 9 Jan 2026 18:02:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v7] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20260109180209.023c50cf@kernel.org>
In-Reply-To: <20260106230438.GA13125@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260106230438.GA13125@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 15:04:38 -0800 Dipayaan Roy wrote:
> +static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
> +{
> +	struct mana_queue_reset_work *reset_queue_work =
> +			container_of(work, struct mana_queue_reset_work, work);
> +
> +	struct mana_port_context *apc = container_of(reset_queue_work,
> +						     struct mana_port_context,
> +						     queue_reset_work);

> +struct mana_queue_reset_work {
> +	/* Work structure */

Not sure what value this comment adds. Looks like something AI
generator would add.

> +	struct work_struct work;
> +};
> +
>  struct mana_port_context {
>  	struct mana_context *ac;
>  	struct net_device *ndev;
> +	struct mana_queue_reset_work queue_reset_work;

Why did you wrap the work in another struct with just one member?
It forces you to work thru two layers of container of.

Either way, container_of supports nested structs so I think something
like:

	struct mana_port_context *apc = container_of(work,
						     struct mana_port_context,
						     queue_reset_work.work);

should work (untested). But really, better to just delete the pointless
nesting.
-- 
pw-bot: cr

