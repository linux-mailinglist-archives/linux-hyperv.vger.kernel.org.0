Return-Path: <linux-hyperv+bounces-5892-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B89C6AD88E5
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 12:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72D4188D017
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74792D0278;
	Fri, 13 Jun 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VZUm+CvL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9382C15B3;
	Fri, 13 Jun 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809411; cv=none; b=F4qALTZ5+Y+KnjV1SJbdHZqc/VZ2TFRCdIFcqlMOjgMIwzwAs/TRlMcJz8HIKHSamxPdRj1hJ2O/J8wwJtSKOT9u1cMjyrJlz7ZUUqxb2BjUxdVCqqcxcW0JHyImxH0/iFtaBdXxI5bHI/mA0NOkvLnj2fn/pw21PJuZHzpgSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809411; c=relaxed/simple;
	bh=MSQEzZimZFiP8UxDR0lIiGr0YaE93yf6tKIfacLa2go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvaMG5ZBu5IERKo1boZskIIptGkHGO67AI5iaz4mAKiehfC+OEWKtf1NGoP/ltNCyQaVbSA8uMTuoJfRwBC5TUrp+CYfi4BUI7wniZgn+6XGmaungNinLebGd/niNMFmRGept7ecP9zf1SwdzWStZdRDNEHSnSpApZxb8+Bjapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VZUm+CvL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 95F73201C76D; Fri, 13 Jun 2025 03:10:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95F73201C76D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749809409;
	bh=u3Gp11a6JIg0TmeXwKofqMg0udwSO6wIvBEHRLqaXCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZUm+CvL1MYvwPl591IuixNbM/MjUqxAyW5r6/wuMB5nWmVOkV1JJLcryryUaF2oY
	 bO088Edwi+IzpN3ySiDVDaXgPGLpLr9cK57ToTzduPpolMDK058J+KGp4ZdkCyAMUn
	 rZKDbzZlmCC9HCx8Z3/znNEX3RZ59mPRfAkYfYVk=
Date: Fri, 13 Jun 2025 03:10:09 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"rosenp@gmail.com" <rosenp@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 1/4] net: mana: Fix potential deadlocks in mana
 napi ops
Message-ID: <20250613101009.GA23310@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
 <1749631576-2517-2-git-send-email-ernis@linux.microsoft.com>
 <20250611110352.GA31913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250611125509.GA22813@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <LV2PR21MB33009692C01762F9BCF06D98CE75A@LV2PR21MB3300.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV2PR21MB33009692C01762F9BCF06D98CE75A@LV2PR21MB3300.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jun 11, 2025 at 05:36:51PM +0000, Long Li wrote:
> > Subject: Re: [PATCH net-next 1/4] net: mana: Fix potential deadlocks in mana
> > napi ops
> > 
> > On Wed, Jun 11, 2025 at 04:03:52AM -0700, Saurabh Singh Sengar wrote:
> > > On Wed, Jun 11, 2025 at 01:46:13AM -0700, Erni Sri Satya Vennela wrote:
> > > > When net_shaper_ops are enabled for MANA, netdev_ops_lock becomes
> > > > active.
> > > >
> > > > The netvsc sets up MANA VF via following call chain:
> > > >
> > > > netvsc_vf_setup()
> > > >         dev_change_flags()
> > > > 		...
> > > >          __dev_open() OR __dev_close()
> > > >
> > > > dev_change_flags() holds the netdev mutex via netdev_lock_ops.
> > > >
> > > > During this process, mana_create_txq() and mana_create_rxq() invoke
> > > > netif_napi_add_tx(), netif_napi_add_weight(), and napi_enable(), all
> > > > of which attempt to acquire the same lock, leading to a potential
> > > > deadlock.
> > >
> > > commit message could be better oriented.
> > >
> > > >
> > > > Similarly, mana_destroy_txq() and mana_destroy_rxq() call
> > > > netif_napi_disable() and netif_napi_del(), which also contend for
> > > > the same lock.
> > > >
> > > > Switch to the _locked variants of these APIs to avoid deadlocks when
> > > > the netdev_ops_lock is held.
> > > >
> > > > Fixes: d4c22ec680c8 ("net: hold netdev instance lock during
> > > > ndo_open/ndo_stop")
> > > > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > > Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > > ---
> > > >  drivers/net/ethernet/microsoft/mana/mana_en.c | 39
> > > > ++++++++++++++-----
> > > >  1 file changed, 30 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > > index ccd2885c939e..3c879d8a39e3 100644
> > > > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > > @@ -1911,8 +1911,13 @@ static void mana_destroy_txq(struct
> > mana_port_context *apc)
> > > >  		napi = &apc->tx_qp[i].tx_cq.napi;
> > > >  		if (apc->tx_qp[i].txq.napi_initialized) {
> > > >  			napi_synchronize(napi);
> > > > -			napi_disable(napi);
> > > > -			netif_napi_del(napi);
> > > > +			if (netdev_need_ops_lock(napi->dev)) {
> > > > +				napi_disable_locked(napi);
> > > > +				netif_napi_del_locked(napi);
> > > > +			} else {
> > > > +				napi_disable(napi);
> > > > +				netif_napi_del(napi);
> > > > +			}
> > >
> > > Instead of using if-else, we can used netdev_lock_ops(), followed by *_locked
> > api-s.
> > > Same for rest of the patch.
> > >
> > 
> > I later realized that what we actually need is:
> > 
> >   if (!netdev_need_ops_lock(napi->dev))
> > 	netdev_lock(dev);
> > 
> > not
> > 
> >   if (netdev_need_ops_lock(napi->dev))
> >         netdev_lock(dev);
> > 
> > Hence, netdev_lock_ops() is not appropriate. Instead, netdev_lock_ops_to_full()
> > seems to be a better choice.
> 
> Yes, netdev_lock_ops_to_full() seems better

Thankyou, Saurabh and Long, for the suggestion. I'll make sure to
incorporate this API in my next version.

> Long

