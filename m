Return-Path: <linux-hyperv+bounces-4703-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB0FA70ADB
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 20:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E203188186F
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC123A564;
	Tue, 25 Mar 2025 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nMe+Ry21"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD401F1913;
	Tue, 25 Mar 2025 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932752; cv=none; b=DtO2AJTicX9u5Tv1fqQFlK2KKRzB4g1m+VUQS5jE3F3gSwjdVEvj0zIZcNh4FE3UUGlov7P4FIuMEjMnK+0rINQAOP8RUELrNefSY+Oajwjnnh84efWPD/N8qPFIEzVEPUlxu72Q5XaFG0UH0688Xw32QPfSEAXkv/cn44gX3hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932752; c=relaxed/simple;
	bh=Kmce4MR3+inOg7HfHkfr1xXue4qdR8d/2SSpd5/SfNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHJFGKA0qfh6+Ipybr8TE2C0wMyKOxSLsj78wTNA+55lxrjmNi2ml4pLSnMkt3dmv6F3Y+Bmq5+ZZd8oNUN+YTO0iZ9muQ7luyPqo8/J9SnxW/WIH+GsUMjS8YEtWpB98Oi2emVla5rKzrI2MWwV2icGEn/pDvGsYK+pbU1iM74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nMe+Ry21; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zASb+pDKpANBRsEZlpC72O+O+RlCzusRinXEvy0fxqU=; b=nMe+Ry21jpk3cRkc5nVgAP1JUk
	q4VJXR9zH6nu56ZEW7EvGapafBds7R97l1UOS1iypLq6k546wjGV974D7x3loABlnDVqiqUcOoYhn
	H7asLD5Hj/awUS9uWgvbOwpHOBuJXL+Y9ePnPrkAugLjbTVzw5vPjuL9F/RT48D8Xr7o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txAQI-00760q-Ox; Tue, 25 Mar 2025 20:58:54 +0100
Date: Tue, 25 Mar 2025 20:58:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>,
	"surenb@google.com" <surenb@google.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"erick.archer@outlook.com" <erick.archer@outlook.com>,
	"rosenp@gmail.com" <rosenp@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH 2/3] net: mana: Implement
 set_link_ksettings in ethtool for speed
Message-ID: <6396c1f7-756d-476a-833e-7ea35ae41da8@lunn.ch>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
 <fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
 <20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <adaaa2b0-c161-4d4f-8199-921002355d05@lunn.ch>
 <20250325122135.14ffa389@kernel.org>
 <MN0PR21MB3437DA2C43930B08036BB146CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB3437DA2C43930B08036BB146CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>

> This patch is just to support the ethtool option for the speed.
> And seems there is no option on ethtool to reset NIC to the default
> speed?

There is no such thing as default speed. Speed is either:

1) Negotiated with the link partner, picking the highest speed link
modes both partners support

2) Forced to a specific speed, based on one of the link modes the
interfaces supports.

Since you don't have link modes, you are abusing the API. You should
choose a different API which actually fits what you are doing,
configuring a leaky bucket shaper.

	Andrew

