Return-Path: <linux-hyperv+bounces-3117-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644BE98FB63
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 02:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF02F1F23370
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 00:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B236B;
	Fri,  4 Oct 2024 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY893EPW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D09360;
	Fri,  4 Oct 2024 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000321; cv=none; b=Vu/ePtfKAtKCOhDJaEmuVpTjR02AiJ4x3xoPXbWR2MQ7wYYi3260GvHk5r72PfEKT77tCD5anlR9fgvNjebNrWtJfH8kqN/bAbxI750dz6jZFyzbYV7VoJIJGOUBzqjvCyp2Fxesov8CySWIOsNfW8T8JUMGYg/LAUesuffTKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000321; c=relaxed/simple;
	bh=+yEM14FSzR8BArfH6Kuafdug5D83cp/1opspSQcsrX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZrJ33M64g4q1d+ehMBeLY83NNx/yPpzOoWmc+7+K/CV9d5ZyISR8ABesb9DsRWqVH3VtrYLHkTkOSFtmBIGaC9JjU9saOW47mar3qoWzeInpr9w7/Ma9fWNSZHlH8d23sNVbKqH4BwZt3S+DSiY7PezvYJn/0D0Nu1aCdkUs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY893EPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0EAC4CEC5;
	Fri,  4 Oct 2024 00:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728000320;
	bh=+yEM14FSzR8BArfH6Kuafdug5D83cp/1opspSQcsrX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CY893EPWDDJFX7gRRCgurlWrALdvA4Mtc4eJfpJ5HyEH6GGX2DXzES2LtveQ3r6rC
	 EOQxewztjNAXN5EkEi7iQfyGtUVYbSny/KkPX2xBJFtRZ1PtCQMa9+lGJB9v04tYb3
	 PAHiZw3Utu7RYDpYhwFGmVXDgVOrNAX1rzQ/oA/6nRTdaHoyDRkfsYgi117bIPRNk6
	 pHvlvfDwJy4FOon9+qg08wZv8Qw3Osu5PvcH++KFV6cTMwvw16xtXSxpys5v/DeDgL
	 8HrsfCHclLw5lZOGcBRLNOlpuzDtR06W1Y/XaAg3CO663vkhlalvDU2yDgCFV5+Bbo
	 d08K5fcsjntRQ==
Date: Thu, 3 Oct 2024 17:05:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Long Li <longli@microsoft.com>, Simon Horman
 <horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>, Souradeep
 Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Colin Ian King <colin.i.king@gmail.com>,
 Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Enable debugfs files for MANA
 device
Message-ID: <20241003170518.11cd9e20@kernel.org>
In-Reply-To: <1727754041-26291-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1727754041-26291-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 20:40:41 -0700 Shradha Gupta wrote:
> @@ -1516,6 +1519,13 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	gc->bar0_va = bar0_va;
>  	gc->dev = &pdev->dev;
>  
> +	if (gc->is_pf) {
> +		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
> +	} else {
> +		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
> +							  mana_debugfs_root);
> +	}

no need for brackets around single statements


> @@ -1619,7 +1640,29 @@ static struct pci_driver mana_driver = {
>  	.shutdown	= mana_gd_shutdown,
>  };
>  
> -module_pci_driver(mana_driver);
> +static int __init mana_driver_init(void)
> +{
> +	int err;
> +
> +	mana_debugfs_root = debugfs_create_dir("mana", NULL);
> +
> +	err = pci_register_driver(&mana_driver);
> +

no need for empty lines between function call and its error check

> +	if (err)
> +		debugfs_remove(mana_debugfs_root);
> +
> +	return err;
> +}
> +
> +static void __exit mana_driver_exit(void)
> +{
> +	debugfs_remove(mana_debugfs_root);
> +
> +	pci_unregister_driver(&mana_driver);
> +}
> +
> +module_init(mana_driver_init);
> +module_exit(mana_driver_exit);
>  
>  MODULE_DEVICE_TABLE(pci, mana_id_table);
>  
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index c47266d1c7c2..255f3189f6fa 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -9,6 +9,7 @@
>  #include <linux/filter.h>
>  #include <linux/mm.h>
>  #include <linux/pci.h>
> +#include <linux/debugfs.h>

looks like the headers were previously alphabetically sorted.
-- 
pw-bot: cr

