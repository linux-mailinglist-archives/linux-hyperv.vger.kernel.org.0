Return-Path: <linux-hyperv+bounces-4705-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFDFA70BA3
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 21:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3837D3B2A62
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741EF266568;
	Tue, 25 Mar 2025 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eZWkwTAY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5021A5B88;
	Tue, 25 Mar 2025 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935115; cv=none; b=hSo4LyLDAspYqokh2GET8vUt1s0kRi3wnQkKShu7xBTUJhLHsZZ/jYAZlgMOS7ssxOnRUpfLBV4cZ0LT7mL+UsJGw5QdDst2GXGtJyt61fGSTjzYQLI7Wl4zCzUPhgXZY/q6WYOCuQZGY8A9z38Na18iZKSxue4e9x0oGKh/PMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935115; c=relaxed/simple;
	bh=eep9kvBkJcCshapLllM2aXRk30DdXOkhNpQwLtx8MaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOm6ae+wApJY2Yt6uZwll2LFj9jsltAi6pRa8rf5M00nqzceo8/1iyYF60cOibq66oqTYA5gF1vuLE9EiqM/vuFBprMJKy3tgNMyqq+65gijG2u/iM7SajZgW69qZCTxXKFHPb3hALzmuyYZZvhH9nuedsO8qt6vYGI9YbbTGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eZWkwTAY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7JpyzTPxTIDtp6S7hw/3Jis3LGxTRMLKQRCEej/p3O0=; b=eZWkwTAYZsERGHkH8IgZA89n2I
	CYvnb4lbmktg+Au5DTu2JSCZClWiREt/adBiFVqDF1dbAFnvk0f4MXIrqNEcP8uRlya8z01X1XMSM
	rGdmwB/e8FlTd/oSzHF2Dlo2lFzxHBdHqiTvkoU9Q9XKF4id+01NBT18jHOMXwJYFd7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txB2R-0076G2-MJ; Tue, 25 Mar 2025 21:38:19 +0100
Date: Tue, 25 Mar 2025 21:38:19 +0100
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
Message-ID: <f2619b80-8d5d-4484-a154-18f902d43d63@lunn.ch>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
 <fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
 <20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <adaaa2b0-c161-4d4f-8199-921002355d05@lunn.ch>
 <20250325122135.14ffa389@kernel.org>
 <MN0PR21MB3437DA2C43930B08036BB146CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
 <6396c1f7-756d-476a-833e-7ea35ae41da8@lunn.ch>
 <MN0PR21MB34376199FAFAE4901EF18E75CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB34376199FAFAE4901EF18E75CAA72@MN0PR21MB3437.namprd21.prod.outlook.com>

> Could you please point us to the interface struct, callback function
> names, and/or docs you are suggesting us to use?

If you cannot search the sources for tc htb, or net shaper, google the
same, etc, you probably cannot write the code either.

http://www.catb.org/esr/faqs/smart-questions.html

	Andrew

