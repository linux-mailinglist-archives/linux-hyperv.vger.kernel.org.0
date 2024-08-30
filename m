Return-Path: <linux-hyperv+bounces-2920-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2DF9656C4
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Aug 2024 07:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8C528596E
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Aug 2024 05:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4814B097;
	Fri, 30 Aug 2024 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b1kUcZ0m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC0481AB;
	Fri, 30 Aug 2024 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994803; cv=none; b=QdU28DUTuPQKXk58RQru6xTOD2bvD1p/wKIo9RlE8K4dIrxjPWs9an5Mwv3bVswetWau9uoFxA1d6rI1OyRtT933/4oIOgJ5m+RUkpMrlpGMgOEzamqPvKFcpwadoHRQDOexIJiBMKdo3tXbNKr3H1T6vrjvV+cbHswQUKInHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994803; c=relaxed/simple;
	bh=rYuq24tDv4iwGP+294pdnVpKjFZjbqF7wVoyu8pG2R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkdkTw7YJtqY+AbbV3Y/t8EV8VHAt9hF/E/34JpzOU3R786STQuYGk0cBw6q+D9C5Ia9BjApq20FPhcIEObSAPRrUXj028c8DakHkr+lLU8Ou0i0LHjL1ftdcY9ZOV4IE9SB4+2LwgiB9VWdOtf9aKOProgOKQPOgrPWAdcVkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b1kUcZ0m; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id CBEF720B7165; Thu, 29 Aug 2024 22:13:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBEF720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724994801;
	bh=YupYlTwGydwIzVuxwU1WXxJUQluJb6OWyZQcjr8vBJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1kUcZ0mU6xjnCTVCqbmIkSwL4Rky4Grfb0dLrjf1WDk9e/Yud+pUBhLOqSUlZQAz
	 cOzsan9XoXIkuNgMfblIDYVrcXf73FypetUBKbFVyeGHMAlhhqmvYkMFp4NFrjNDYN
	 WYTvEpn7aaJyBQ1e6ndDUXIGSN/0+IKLlKM4u0Is=
Date: Thu, 29 Aug 2024 22:13:21 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Improve mana_set_channels() for low
 mem conditions
Message-ID: <20240830051321.GA27295@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1724941006-2500-1-git-send-email-shradhagupta@linux.microsoft.com>
 <d73d45af-e76e-4e87-8df1-0ed71e823abc@engleder-embedded.com>
 <PH7PR21MB32606D2D49A7F0837A29835DCA962@PH7PR21MB3260.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB32606D2D49A7F0837A29835DCA962@PH7PR21MB3260.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 29, 2024 at 09:00:05PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Gerhard Engleder <gerhard@engleder-embedded.com>
> > Sent: Thursday, August 29, 2024 3:54 PM
> > To: Shradha Gupta <shradhagupta@linux.microsoft.com>; linux-
> > hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> > <decui@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Long Li <longli@microsoft.com>; Simon Horman
> > <horms@kernel.org>; Konstantin Taranov <kotaranov@microsoft.com>;
> > Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>; Erick Archer
> > <erick.archer@outlook.com>; Pavan Chebbi <pavan.chebbi@broadcom.com>;
> > Ahmed Zaki <ahmed.zaki@intel.com>; Colin Ian King
> > <colin.i.king@gmail.com>; Shradha Gupta <shradhagupta@microsoft.com>
> > Subject: Re: [PATCH net-next] net: mana: Improve mana_set_channels() for
> > low mem conditions
> > 
> > [Some people who received this message don't often get email from
> > gerhard@engleder-embedded.com. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On 29.08.24 16:16, Shradha Gupta wrote:
> > > The mana_set_channels() function requires detaching the mana
> > > driver and reattaching it with changed channel values.
> > > During this operation if the system is low on memory, the reattach
> > > might fail, causing the network device being down.
> > > To avoid this we pre-allocate buffers at the beginning of set
> > operation,
> > > to prevent complete network loss
> > >
> > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > ---
> > >   .../ethernet/microsoft/mana/mana_ethtool.c    | 28 +++++++++++-------
> > -
> > >   1 file changed, 16 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > > index d6a35fbda447..5077493fdfde 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> > > @@ -345,27 +345,31 @@ static int mana_set_channels(struct net_device
> > *ndev,
> > >       struct mana_port_context *apc = netdev_priv(ndev);
> > >       unsigned int new_count = channels->combined_count;
> > >       unsigned int old_count = apc->num_queues;
> > > -     int err, err2;
> > > +     int err;
> > > +
> > > +     apc->num_queues = new_count;
> > > +     err = mana_pre_alloc_rxbufs(apc, ndev->mtu);
> > > +     apc->num_queues = old_count;
> > 
> > Are you sure that temporary changing num_queues has no side effects on
> > other num_queues users like mana_chn_setxdp()?
> > 
> 
> mana_chn_setxdp() is protected by rtnl_lock, which is OK. But I'm not sure
> if all other users are protected. mana_get_stats64() seems not.
> 
> @Shradha Gupta You can add num_queues as an argument of mana_pre_alloc_rxbufs()
> to avoid changing apc->num_queues.
> 
> Thanks,
> - Haiyang

Thanks Haiyang and Gerhard. Instead of changing the apc structure value,
I will pass it to the mana_pre_alloc_rxbufs() function in the next
version. That should make sure other calls are unaffected.

Thanks,
Shradha.

