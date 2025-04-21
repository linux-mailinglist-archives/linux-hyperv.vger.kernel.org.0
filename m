Return-Path: <linux-hyperv+bounces-4985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AEDA955D1
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 20:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702FF3AF63C
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D271E9B2F;
	Mon, 21 Apr 2025 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U3WelcRf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804D1E9B18;
	Mon, 21 Apr 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259260; cv=none; b=rEnxmzjOKYkZm94gh3xaiWRujTaM5nprH2/Sv/ZyZeokhlhfOA57Ewy0jMhq/QRfsssQctrYzl8gL+8WoDzekIAmgFHRf+PKrkQ+hSv4xIy1x3Zei/hbSiNltMlGgI3vJ29mJuE/hs23klwQxPdukDQDZZBOX0jw2DIxF7ufOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259260; c=relaxed/simple;
	bh=WU7+PH7Aon92/3Ezl8juCWIV0+5fdafHUQuh8yPApZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6QYIkp+Zgy3X1cgO9laLUR4WWw2FOjeQ/NnDvDwsXaV6NsiRFa5kELN/EDa1SoqM/E48/u9OioWbrSW772MNJC81L56Z7ZBc6GAPYXXMSi4Doj08CdO/a6xgFRhq4JgBgFTdHsbGK45MJVcnPKnf6QpHfKQTC1gMUxsMjdhFWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U3WelcRf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 13DA1203B867; Mon, 21 Apr 2025 11:14:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13DA1203B867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745259252;
	bh=GPITtWCUzrpM+RzwsOn+M9sSZbmXk+2qVYGwk2dgTOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3WelcRfP+3HM6y55yij5DGCLK+oXqsouZjg849PRjBIINHAE/30U8qeV4J8UstMa
	 +m4cuHqfTgCfWy2gkCXCXpMjuPoZWuW4daoTLI1xwt3ZVnsmp/b222mRvSXxdLhacY
	 kulOIeKgnusVMKYOIzrlt3ci3wp9C644FFmngqic=
Date: Mon, 21 Apr 2025 11:14:12 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	mhklinux@outlook.com, pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev, brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, leon@kernel.org, rosenp@gmail.com,
	paulros@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: mana: Add speed support in
 mana_get_link_ksettings
Message-ID: <20250421181412.GA5652@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
 <1745217220-11468-2-git-send-email-ernis@linux.microsoft.com>
 <c481c8a8-4e0f-4498-89f9-988673a584f6@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c481c8a8-4e0f-4498-89f9-988673a584f6@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 21, 2025 at 02:36:43PM +0200, Andrew Lunn wrote:
> On Sun, Apr 20, 2025 at 11:33:38PM -0700, Erni Sri Satya Vennela wrote:
> > Add support for speed in mana ethtool get_link_ksettings
> > operation. This feature is not supported by all hardware.
> 
> This needs a lot more justification. tc(1) will show you the current
> HTB Qdisc setting. No other MAC driver i know of will show you Qdisc
> info in ksettings. So why is mana special?
> 
> Something your said in an earlier thread might be relevant here. There
> are two shaper settings involved. The Hypervisor can configure a
> limit, which the VM has no control over. And then you have this second
> limit the VM can set, which only has any effect if it is lower than
> the hypervisor limit.
> 
> The hypervisor limit is much more like the value ksettings represents,
> the media speed, which is impossible to go above, and the machine has
> no control over. Reporting that limit in ksettings would seem
> reasonable. But it does not appear your firmware offers that?
> 
>     Andrew
> 
Yes, that is correct. I will keep the ethtool mana_get_link_ksettings
unchanged, since the link speed can be reported using tc too. I will
make this change in the next version of the patch.
Thankyou for the pointer, Andrew.
> ---
> pw-bot: cr

