Return-Path: <linux-hyperv+bounces-7208-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A795BD6B8A
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 01:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC13E4E42AE
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18972C08C4;
	Mon, 13 Oct 2025 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rMyiyRR4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8C29B22F;
	Mon, 13 Oct 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397720; cv=none; b=UiOsA03yPa210WECRC4YSns4M5Cxc+Dw41PHWMN6QJX6PyKGpZtO8NB3e1hs7edXEK5o/ICEHsTPk5hiLpoM6cjS51WKJQbFdIbiOpq2cjbsAVAdAyTr65Kq3VbhWS2XdFeoTW9Dw41Et++OsN0WZ/PTCLBnyN9K0PtFZ/gHuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397720; c=relaxed/simple;
	bh=Q+y+hOZaxeraI2K323ODZg58MVzPDfgjCFg6q5BEDZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muk3vTisVP6+kfiKRWGiEQIgnskWDcj3iK4fU8EX+svF1MHjA0TFf0IA3PV59k/bqvry09yp86bNfU6gaF5AMotB/9AyJcAH4glyOXIWQWbHFChZuH4GGPJ1ulT0PynuzzEO7fYuF+GW1S2630AeILbjJ7kZEre8y1Y5YeMgw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rMyiyRR4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TxZs5j0GQr6gjRGpkRpFUDbUO8uzcXTBWTBz3HVACss=; b=rMyiyRR45hLIG7YWBawu1BNpgf
	BEAvDSgxch1+Kd4OEMXWdxTkJr6K2P+9Ya49OraVyX3KA5mTcW2j5VolDdYh6lRiuVvR1zdvXxtSr
	TWQbafvpqDtGgB6LTroad8vXJRvxzihaxNlGVjU92Iubm10AHWDTrP64ugZuaQewWOHs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8RrN-00AqZ5-I0; Tue, 14 Oct 2025 01:21:45 +0200
Date: Tue, 14 Oct 2025 01:21:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>,
	"dipayanroy@linux.microsoft.com" <dipayanroy@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net-next] net: mana: Support HW link state
 events
Message-ID: <4ea9acfd-be02-4299-b8c4-95bb69ad04cd@lunn.ch>
References: <1760384001-30805-1-git-send-email-haiyangz@linux.microsoft.com>
 <74490632-68da-401d-89a7-3d937d63cbe3@lunn.ch>
 <CY5PR21MB3447B6D69542EA4532547A5FCAEAA@CY5PR21MB3447.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR21MB3447B6D69542EA4532547A5FCAEAA@CY5PR21MB3447.namprd21.prod.outlook.com>

> > > +		if (link_up) {
> > > +			netif_carrier_on(ndev);
> > > +
> > > +			if (apc->port_is_up)
> > > +				netif_tx_wake_all_queues(ndev);
> > > +
> > > +			__netdev_notify_peers(ndev);
> > > +		} else {
> > > +			if (netif_carrier_ok(ndev)) {
> > > +				netif_tx_disable(ndev);
> > > +				netif_carrier_off(ndev);
> > > +			}
> > > +		}
> > 
> > It is odd this is asymmetric. Up and down should really be opposites.
> For the up event, we need to delay the wake up queues if the 
> mana_close() is called, or mana_open() isn't called yet.
> 
> Also, we notify peers only when link up.

But why is this not symmetric?

On down, if port_is_up is not true, there is no need to disable tx and
set the carrier off. There are also counters associated with
netif_carrier_off() and netif_carrier_on(), and if you don't call them
in symmetric pairs, the counters are going to look odd.

> cancel_work_sync()'s doc says "This function can be used
> even if the work re-queues itself".
> cancel_delayed_work_sync() calls the same underlying function but 
> with WORK_CANCEL_DELAYED flag. So it should be OK.

O.K, thanks

	Andrew

