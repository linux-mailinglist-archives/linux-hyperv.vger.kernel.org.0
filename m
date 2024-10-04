Return-Path: <linux-hyperv+bounces-3121-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826899020F
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 13:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A2B283E19
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55A61459E0;
	Fri,  4 Oct 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iCKV5yLS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30D2AD18;
	Fri,  4 Oct 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041439; cv=none; b=njQEuc7FldZXwQCm/ABclTT8XaBB48XZq3JfgxG9wmYZSSndcdLPXCDrPZiHW5av8X9UoCN6Oi/ALxx2b0c5l5zAjn/7uDNJpqIPwAcFURMyGifUiBZmbbm7P24ptdVsbeRj6oCS+ZRfOmNFdrjkZ6mZAiTJy6c6+umuxufawDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041439; c=relaxed/simple;
	bh=X4Qp5mtEyhaiPFth6wO6wY8La16ABC5rN6ihpdlqSXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZbRrnxBhqhZkjPLOX/c9aHpUntMZEiTzG2iQvicddaQvo+jvSAApOScSKveazocwcDjeOVwvQoBqgYzdGKLzdDi2ekS/GVaETPOlL86yrivjM0xTbNwg5DwAhLWCAv8YVMswRWJ3vx9JbbQ0D7qN7UoW+iLcJDMoUQisFdupjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iCKV5yLS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id EF2CC20C6494; Fri,  4 Oct 2024 04:30:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF2CC20C6494
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728041437;
	bh=tG6C+FIVgM7dhsze/chEuSWLVSm53oBFmsuBI5COF2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCKV5yLSBap00xcS/CQybhJEZg3Vo18tEqBn3VldQp0Pvt/78aNPKdUTKVksXLW/R
	 Ctm5iYf+RUlWiRmKPa5fc6ggp7dDhLhq/KS9/Lchyuq7tTA9DN2h+p+KFwGSLc12Wa
	 CaMzKAdVM4vcYqKih743AvRCNrrqebbOZ3PlvzBU=
Date: Fri, 4 Oct 2024 04:30:37 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Enable debugfs files for MANA device
Message-ID: <20241004113037.GA8416@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1727754041-26291-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20241003170518.11cd9e20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003170518.11cd9e20@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Oct 03, 2024 at 05:05:18PM -0700, Jakub Kicinski wrote:
> On Mon, 30 Sep 2024 20:40:41 -0700 Shradha Gupta wrote:
> > @@ -1516,6 +1519,13 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  	gc->bar0_va = bar0_va;
> >  	gc->dev = &pdev->dev;
> >  
> > +	if (gc->is_pf) {
> > +		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
> > +	} else {
> > +		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
> > +							  mana_debugfs_root);
> > +	}
> 
> no need for brackets around single statements
> 
> 
> > @@ -1619,7 +1640,29 @@ static struct pci_driver mana_driver = {
> >  	.shutdown	= mana_gd_shutdown,
> >  };
> >  
> > -module_pci_driver(mana_driver);
> > +static int __init mana_driver_init(void)
> > +{
> > +	int err;
> > +
> > +	mana_debugfs_root = debugfs_create_dir("mana", NULL);
> > +
> > +	err = pci_register_driver(&mana_driver);
> > +
> 
> no need for empty lines between function call and its error check
> 
> > +	if (err)
> > +		debugfs_remove(mana_debugfs_root);
> > +
> > +	return err;
> > +}
> > +
> > +static void __exit mana_driver_exit(void)
> > +{
> > +	debugfs_remove(mana_debugfs_root);
> > +
> > +	pci_unregister_driver(&mana_driver);
> > +}
> > +
> > +module_init(mana_driver_init);
> > +module_exit(mana_driver_exit);
> >  
> >  MODULE_DEVICE_TABLE(pci, mana_id_table);
> >  
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index c47266d1c7c2..255f3189f6fa 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/filter.h>
> >  #include <linux/mm.h>
> >  #include <linux/pci.h>
> > +#include <linux/debugfs.h>
> 
> looks like the headers were previously alphabetically sorted.
> -- 
> pw-bot: cr

Thanks Jakub. I will get these in a newer version

