Return-Path: <linux-hyperv+bounces-5864-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A02AD561A
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 14:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E25A3A63C0
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038F1283FE8;
	Wed, 11 Jun 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PAl+gLGd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66958283141;
	Wed, 11 Jun 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646517; cv=none; b=uj6ezA6LJk088KdhiSf2Pevzjh7b3j2/F6HIdz4pzAHU34RILAoV1KbKgVLnmuWDyJ3tLuR5lNCepqlOQ/FZHPJxPWl6LRptMsoQpIuRc4mFz2SHNZ7mfIyvm8jfGEjNhQdcw0+f+Xdri4/12bk2FDzJXkCuaRjmhFCMNrbSvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646517; c=relaxed/simple;
	bh=QkhZi3FU1sey8L3Wa1mNnXtLz2q7e9LWK29b8Qyi1lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqF5X9rPFu63RGQmb6aYJrfNU9src6Fz/7iYYcSHU7uaBYXSmv6Ud8CK1y28LjSzX8tMSivK3kMLJn65ujF0glk3Mpn+El8+5f0twSl3Wx2ax2Tj1ULN49aQ8DNIEfLNzJrB4LgHuCtSrWh8+M8uZa0YhAh5QXRMc2tTNoC4NMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PAl+gLGd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id EE46C211518E; Wed, 11 Jun 2025 05:55:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE46C211518E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749646509;
	bh=Ri1hYdHfAQj4ltRI0jgAUTpeJneNKRaFwaxSP5kdq+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAl+gLGd6fFsNagRHPk9zMpkXGnli0J7ihpPQgTIjCdhKYquI5MoY/V/4kjL+B7Vz
	 hZnOCuCNpf7iCZc2gxjzlDfOE620JhDc0Fz7/PKjVGBO3lAUGmKOXjyeLelIyG0Sgx
	 5XVHatwQdWSMjY0/zP0mKyWlRGy8j6bnjFog1nEE=
Date: Wed, 11 Jun 2025 05:55:09 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kotaranov@microsoft.com, longli@microsoft.com, horms@kernel.org,
	shirazsaleem@microsoft.com, leon@kernel.org,
	shradhagupta@linux.microsoft.com, schakrabarti@linux.microsoft.com,
	rosenp@gmail.com, sdf@fomichev.me, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: mana: Fix potential deadlocks in mana
 napi ops
Message-ID: <20250611125509.GA22813@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
 <1749631576-2517-2-git-send-email-ernis@linux.microsoft.com>
 <20250611110352.GA31913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611110352.GA31913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jun 11, 2025 at 04:03:52AM -0700, Saurabh Singh Sengar wrote:
> On Wed, Jun 11, 2025 at 01:46:13AM -0700, Erni Sri Satya Vennela wrote:
> > When net_shaper_ops are enabled for MANA, netdev_ops_lock
> > becomes active.
> > 
> > The netvsc sets up MANA VF via following call chain:
> > 
> > netvsc_vf_setup()
> >         dev_change_flags()
> > 		...
> >          __dev_open() OR __dev_close()
> > 
> > dev_change_flags() holds the netdev mutex via netdev_lock_ops.
> > 
> > During this process, mana_create_txq() and mana_create_rxq()
> > invoke netif_napi_add_tx(), netif_napi_add_weight(), and napi_enable(),
> > all of which attempt to acquire the same lock,
> > leading to a potential deadlock.
> 
> commit message could be better oriented.
> 
> > 
> > Similarly, mana_destroy_txq() and mana_destroy_rxq() call
> > netif_napi_disable() and netif_napi_del(), which also contend
> > for the same lock.
> > 
> > Switch to the _locked variants of these APIs to avoid deadlocks
> > when the netdev_ops_lock is held.
> > 
> > Fixes: d4c22ec680c8 ("net: hold netdev instance lock during ndo_open/ndo_stop")
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 39 ++++++++++++++-----
> >  1 file changed, 30 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index ccd2885c939e..3c879d8a39e3 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -1911,8 +1911,13 @@ static void mana_destroy_txq(struct mana_port_context *apc)
> >  		napi = &apc->tx_qp[i].tx_cq.napi;
> >  		if (apc->tx_qp[i].txq.napi_initialized) {
> >  			napi_synchronize(napi);
> > -			napi_disable(napi);
> > -			netif_napi_del(napi);
> > +			if (netdev_need_ops_lock(napi->dev)) {
> > +				napi_disable_locked(napi);
> > +				netif_napi_del_locked(napi);
> > +			} else {
> > +				napi_disable(napi);
> > +				netif_napi_del(napi);
> > +			}
> 
> Instead of using if-else, we can used netdev_lock_ops(), followed by *_locked api-s.
> Same for rest of the patch.
> 

I later realized that what we actually need is:

  if (!netdev_need_ops_lock(napi->dev))
	netdev_lock(dev);

not

  if (netdev_need_ops_lock(napi->dev))
        netdev_lock(dev);

Hence, netdev_lock_ops() is not appropriate. Instead, netdev_lock_ops_to_full()
seems to be a better choice.

> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> - Saurabh
> 

