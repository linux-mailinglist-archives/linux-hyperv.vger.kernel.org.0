Return-Path: <linux-hyperv+bounces-3352-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3879D8D44
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2024 21:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F6F2884EC
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2024 20:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C201C07D1;
	Mon, 25 Nov 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8ui214J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BDB2500CC;
	Mon, 25 Nov 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565441; cv=none; b=oFARlrsBQiNe1Ocw7iUu76Q5GgfCJVQMkolyOWpsVk/kvMt9IYc/EhRO4dcTdNiW4RL6bMUiw36p8B/BGKTLcrzxT3xUKciIH5RcLnk8UJikmRM357229Y/9dGhDV7cBhfkP/6uMG2CMLFGTDFl/LgponrXr11PnBA/WrTA8YBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565441; c=relaxed/simple;
	bh=zboED+kpkW+ASDfxQ+ZPDvHBUtGPLJh28jHT0QdrMBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESowPlz6NNNnjl6VdK7/GGFQ1XQ4ehcW+IFuhCz+XjRj2tew42QKm9oRIidCJXLTGGhnrBXZMpm2FC3gp32FSMFJHkHPSyWTMNciWmR9ojdiMleS/kylaH6NYeEV8t+8yS/f14beqkoswy1qENvxgVJGy6mKCcPLGviSYGwfFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8ui214J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B89C4CECE;
	Mon, 25 Nov 2024 20:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732565441;
	bh=zboED+kpkW+ASDfxQ+ZPDvHBUtGPLJh28jHT0QdrMBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8ui214JEajAn6wwGq43HQ06tol4an5RwJquNndUiizaGbh67FhMio1UhQGCORUuq
	 Qo80CdHikY4aAxCjsCh2p+kUrIlcSU3o/JiWKccvWTcXETdKLCGJGiH67RcrMWFLTo
	 NDeZoYTlDKo9f652lyL6Dzx6Bn1AgVmlULnvI5oPtz+MPjxXDX2RKYLDFHHY86JQfx
	 eTfWmZfR46zq+Mzpr7t2JuGwDwR+9s2CTCyFVh9/zB0TP44+4tHgtQRFDUwCcnkhnq
	 KIR3JZKo8Cz1IRN+XaVUm+I95AgrYg31SOAtP9Ock09gKelT6dzEt1BrMTcFVi82Cy
	 V67DferJjk4xw==
Date: Mon, 25 Nov 2024 22:10:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: "NBU-Contact-longli (EXTERNAL)" <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Message-ID: <20241125201036.GK160612@unreal>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal>
 <CH3PR21MB43989630F6CA822AF3DFB32CCE222@CH3PR21MB4398.namprd21.prod.outlook.com>
 <CY8PR12MB719506ED60DBD124D3784CB6DC2E2@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719506ED60DBD124D3784CB6DC2E2@CY8PR12MB7195.namprd12.prod.outlook.com>

On Mon, Nov 25, 2024 at 03:56:01PM +0000, Parav Pandit wrote:
> 
> 
> > From: Long Li <longli@microsoft.com>
> > Sent: Thursday, November 21, 2024 5:34 AM
> > 
> > > >
> > > > Actually, another alternative solution for mana_ib is always set the
> > > > slave device, but in the GID mgmt code we need the following patch.
> > > > The problem is that it may require testing/confirmation from other
> > > > ib providers
> > > as in the worst case some GIDs will not be listed.
> > >
> > > is_eth_active_slave_of_bonding_rcu() is for bonding.
> > 
> > Sorry, need to bring this issue up again.
> > 
> > This patch has broken user-space programs (e.g DPDK) that requires to
> > export a kernel device to user-mode.
> > 
> > With this patch, the RDMA driver grabbed a reference from the master
> > device, it's impossible to move the master device to user-mode.
> > 
> > I think the root cause is that the individual driver should not decide on which
> > (master or slave) address should be used for GID. roce_gid_mgmt.c should
> > handle this situation.
> > 
> > I think Konstantin's suggestion makes sense, how about we do this (don't
> > need to define netdev_is_slave(dev)):
> > 
> > --- a/drivers/infiniband/core/roce_gid_mgmt.c
> > +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> > @@ -161,7 +161,7 @@ is_eth_port_of_netdev_filter(struct ib_device
> > *ib_dev, u32 port,
> >         res = ((rdma_is_upper_dev_rcu(rdma_ndev, cookie) &&
> >                (is_eth_active_slave_of_bonding_rcu(rdma_ndev, real_dev) &
> >                 REQUIRED_BOND_STATES)) ||
> > -              real_dev == rdma_ndev);
> > +              (real_dev == rdma_ndev &&
> > + !netif_is_bond_slave(rdma_ndev)));
> > 
> >         rcu_read_unlock();
> >         return res;
> > 
> > 
> > is_eth_port_of_netdev_filter() should not return true if this netdev is a
> > bonded slave. In this case, only use the address of its bonded master.
> > 
> Right. This change makes sense to me.
> I don't have a setup presently to verify it to ensure I didn't miss a corner case.
> Leon,
> Can you or others please test the regression once with the formal patch?

Sure, once Long will send the patch, I'll make sure that it is tested.

Thanks

> 

