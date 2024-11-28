Return-Path: <linux-hyperv+bounces-3376-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C019DB4DD
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Nov 2024 10:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCC4282DFA
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Nov 2024 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD11885BF;
	Thu, 28 Nov 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1wEIyvt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F4172767;
	Thu, 28 Nov 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786792; cv=none; b=F7bl4caOsO/fpC88liYn6fM14GB8Jgbk3CjAkkik0F1W0Fh11aPjmlDEXfrYKKWzcqvGJwFXTqhhWCs1ZPwVxnc327BC+xFundsV7s5bgGm3jE3lm66vc5p7k0Y5Xqkr3PNEDo8QaURyEeOHCmbaj6bhQAdkNl+86QBLIs6N7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786792; c=relaxed/simple;
	bh=gpZawZf4vvEGxMBlzOfTYu8D4Aw3jJQi/uScP72UgNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ1cD+Obj7ju3r9obSjL2o8uvoyUrMCp07YzBuwB3HR3jpsXHRQX8R99O7lv7In9Jp9r11/noW7ULxYuBwjWmYG9ymWFzUvnx1ndkclZ8giJYhLMHWGiAeheBkhcsmygo4T4TQXnHXt7b7mWprIGh7ETF/vPneqckjlq4M80mdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1wEIyvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A836C4CECE;
	Thu, 28 Nov 2024 09:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732786792;
	bh=gpZawZf4vvEGxMBlzOfTYu8D4Aw3jJQi/uScP72UgNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1wEIyvt1ljagrlcifMtQvqkJGXCQx9je6FED0s+wIkv5SEOnlVfClAEC/qPvI3yE
	 NAH9oIxX5E/didBbNGcxOhKLmyqI4e5w4OnfP25B4jYSRNMym4OTlZYAdLq/oyebk/
	 Yb3AK+EngnuCjRDn8efpvEoG92Dr+Zcsvhxk6k2zrBWq6OWZTYoTvFwkkqOW6VV/8r
	 qWybU9YocAYz1xF4jOpC6f+ap3yAexTorSOkOG4MFoKI7jfhnBrQWWlBaFn/BpsLE8
	 pXir1jfGks3qIF3+Y//CYAjA+BlqpUZoIfMUmgskdRpZS1QZGnuLnd4TathvJxMN9v
	 /CYh21X+ijmzA==
Date: Thu, 28 Nov 2024 11:39:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Parav Pandit <parav@nvidia.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct
 device into ib
Message-ID: <20241128093947.GG1245331@unreal>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal>
 <CH3PR21MB43989630F6CA822AF3DFB32CCE222@CH3PR21MB4398.namprd21.prod.outlook.com>
 <CY8PR12MB719506ED60DBD124D3784CB6DC2E2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20241125201036.GK160612@unreal>
 <CH3PR21MB4398E0C57E7B6BC73B1A8F04CE282@CH3PR21MB4398.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR21MB4398E0C57E7B6BC73B1A8F04CE282@CH3PR21MB4398.namprd21.prod.outlook.com>

On Wed, Nov 27, 2024 at 07:46:39PM +0000, Long Li wrote:
> 
> > > > I think Konstantin's suggestion makes sense, how about we do this
> > > > (don't need to define netdev_is_slave(dev)):
> > > >
> > > > --- a/drivers/infiniband/core/roce_gid_mgmt.c
> > > > +++ b/drivers/infiniband/core/roce_gid_mgmt.c
> > > > @@ -161,7 +161,7 @@ is_eth_port_of_netdev_filter(struct ib_device
> > > > *ib_dev, u32 port,
> > > >         res = ((rdma_is_upper_dev_rcu(rdma_ndev, cookie) &&
> > > >                (is_eth_active_slave_of_bonding_rcu(rdma_ndev, real_dev) &
> > > >                 REQUIRED_BOND_STATES)) ||
> > > > -              real_dev == rdma_ndev);
> > > > +              (real_dev == rdma_ndev &&
> > > > + !netif_is_bond_slave(rdma_ndev)));
> > > >
> > > >         rcu_read_unlock();
> > > >         return res;
> > > >
> > > >
> > > > is_eth_port_of_netdev_filter() should not return true if this netdev
> > > > is a bonded slave. In this case, only use the address of its bonded master.
> > > >
> > > Right. This change makes sense to me.
> > > I don't have a setup presently to verify it to ensure I didn't miss a corner case.
> > > Leon,
> > > Can you or others please test the regression once with the formal patch?
> > 
> > Sure, once Long will send the patch, I'll make sure that it is tested.
> > 
> > Thanks
> > 
> 
> I posted patches for discussion.
> https://lore.kernel.org/linux-rdma/1732736619-19941-1-git-send-email-longli@linuxonhyperv.com/T/#t

Please resend these patches as series with cover letter and don't embed
extra patch (the one which is not numbered) into the series.

Thanks

> 
> Thank you,
> Long
> 

