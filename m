Return-Path: <linux-hyperv+bounces-2011-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763E8AB539
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 20:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EC22829A7
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF5212D748;
	Fri, 19 Apr 2024 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KBEvA+an"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F1D268;
	Fri, 19 Apr 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552669; cv=none; b=urX1NQPXAJrbp9oGBy7K4y7q0LZxNRy72TAuBTx8v4WzXjB1BapEl9YMV3lE+ZgL6CJv7wtTArxNt2nMO2oai0oSJbP95YpYHX27KaFPVxsiN87nYm7N0pEKeI1vvNrmF6nBf2hUYC31BKUshMvYF4F7wb3zW4Cdu0agn9Sh9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552669; c=relaxed/simple;
	bh=P4EtuerERfS5igN+jp36Qe+A7aj+Bbvo7bQyGhs8zHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKZA5ke/MX3G8KwUWIyxIMe0qLvvLgiYKetBcdWtHmaiP9V3woGU1sgl3trevOvs7i7DgMWm3RMxe1uMqCFvs1pZVe9YccPDQSqgq6wj6+iZ/6LTfrNev2yR0Lbcxmrpajvm88GnRjU1u5ARNC7KS2cZQs5M/kyvSPQMjU7cadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KBEvA+an; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jRVHW2PCpBb94pqr05BjINl9EOFyc8yE25pKcg6N4Ao=; b=KBEvA+anCYQeH7oaHpSIuEiU3p
	zaq2qt2V/W3XaJNXKU6wKxZ1uvt6SUB52khMl5RscIcjN2+zV5ZcuEJz3ONS5VrpBTKIFTgP/q5lv
	oRYfhuf01Ms8nK7wX4vQvMoBYZu3hmR67ZScYXXaqLFwblTT7o+7AgLpAP9LdWSpaSzM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxtKA-00DTWj-F5; Fri, 19 Apr 2024 20:51:02 +0200
Date: Fri, 19 Apr 2024 20:51:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Add new device attributes for mana
Message-ID: <fc345b4d-0747-4ca3-aee0-c53064cc7fe1@lunn.ch>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
 <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
 <b34bfb11-98a3-4418-b482-14f2e50745d3@lunn.ch>
 <20240418060108.GB13182@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240418175059.GZ223006@ziepe.ca>
 <f3e7ea07-2903-4f19-ba86-94bba569dae9@lunn.ch>
 <20240419165926.GC506@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419165926.GC506@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Fri, Apr 19, 2024 at 09:59:26AM -0700, Shradha Gupta wrote:
> On Thu, Apr 18, 2024 at 08:42:59PM +0200, Andrew Lunn wrote:
> > > >From an RDMA perspective this is all available from other APIs already
> > > at least and I wouldn't want to see new sysfs unless there is a netdev
> > > justification.
> > 
> > It is unlikely there is a netdev justification. Configuration happens
> > via netlink, not sysfs.
> > 
> >     Andrew
> 
> Thanks. Sure, it makes sense to make the generic attribute configurable
> through the netdevice ops or netlink implementation. I will keep that in
> mind while adding the next set of configuration attributes for the driver.
> These attributes(from the patch) however, are hardware specific(that show
> the maximum supported values by the hardware in most cases).

        ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
        ndev->min_mtu = ETH_MIN_MTU;

This does not appear to be specific to your device. This is very
generic. We already have /sys/class/net/eth42/mtu, why not add
/sys/class/net/eth42/max_mtu and /sys/class/net/eth42/min_mtu for
every driver?

Are these values really hardware specific? Are they really unique to
your hardware? I have to wounder because you clearly did not think
much about MTU, and how it is actually generic...

     Andrew

