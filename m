Return-Path: <linux-hyperv+bounces-2048-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5408B3647
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Apr 2024 13:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA552834ED
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Apr 2024 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2639144D1D;
	Fri, 26 Apr 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eBiLJ1bI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869CF142E62;
	Fri, 26 Apr 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129596; cv=none; b=HQiMwQmW2yYR2yUMF5EqmP5r5OgL3RsmcG8IpUUwflWuV2swM0Mu/ctpjxlQ1SoygOmJoQbe4Ag/VW/eJASc+Q6a2LbjGWM23yL5npEYValJ64fGBFkfeUnPoHy9J09JNvK0LZM+zh/VrRUn8dpeNVw4mwCspesH5EH+UwRBquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129596; c=relaxed/simple;
	bh=sEdc3Wd2Fm3DEJTPTv7niYyLcLuR3dw+/x1Hk9vi/hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG51pZfjqvOfj5GLNpurL8pMLU/ag70rzwbowMWZJkrbdHQQBYTLX+TxErVSbQQRnrjk4hpUJjMGp9GP4IZLtkfZTom66Ql3+/hFDnVbQzjofOS3RBi17xt8uu8DKBHixXiC7e7381uXrE5NM2xhouMRoHva2zGTe+N8gICxuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eBiLJ1bI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 786D5210EF22; Fri, 26 Apr 2024 04:06:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 786D5210EF22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714129589;
	bh=xkuHjmKRLCXBtGZZ4FZ4i74BJRj9p2Go7cH+OnO/rk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBiLJ1bIi33wQRtMb/OLiSGvOBQe/3ClahGrmK4squu/fn+DxBcyR1aUbt2F9CNtt
	 djN9YxxAfntWQ71OYTFmgKXB5XhCxj72nGt5bwYROgrV8Cr6Ho6AFOxvKNNP2ZejmN
	 DHyRC6TGRfCfZyj+IJpn1q0rtWy2QEKpQeQCOTYY=
Date: Fri, 26 Apr 2024 04:06:29 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>, linux-hyperv@vger.kernel.org,
	shradhagupta@microsoft.com
Subject: Re: [PATCH net-next v2 1/2] net: Add sysfs atttributes for max_mtu
 min_mtu
Message-ID: <20240426110629.GA19743@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1713954817-30133-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240424202703.29f1b59a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424202703.29f1b59a@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Apr 24, 2024 at 08:27:03PM -0700, Jakub Kicinski wrote:
> On Wed, 24 Apr 2024 03:33:37 -0700 Shradha Gupta wrote:
> > Add sysfs attributes to read max_mtu and min_mtu value for
> > network devices
> 
> Absolutely pointless. You posted v1, dumping this as a driver
> specific value, even tho it's already reported by the core...
> And you can't even produce a meaningful commit message longer
> than one sentence.
> 
> This is not meeting the bar. Please get your patches reviewed
> internally at Microsoft by someone with good understanding of
> Linux networking before you post.
Noted, I'll do the needful going forward. Apologies.

