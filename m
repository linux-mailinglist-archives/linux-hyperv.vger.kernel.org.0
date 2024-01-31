Return-Path: <linux-hyperv+bounces-1486-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41384366F
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 07:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E351F25992
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 06:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5C13E477;
	Wed, 31 Jan 2024 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K2T7mqJc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA123E46B;
	Wed, 31 Jan 2024 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706681399; cv=none; b=jWgNraJ/2Sw9knZTP7jsfHIcN6QgzBsAm6TXHFwpemW8/VzgRBS2wcRHOE6oG3VwlfOJMQmIfd6QhzE6E+D3Ld4IedJTCGIKLjKLZxQU7D5DcpDB3KaXBjil9DilXtUTdooGGDi01Lyc8Oa42lhBc93p/Wk1h/MMoN9EkYy6xcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706681399; c=relaxed/simple;
	bh=xUlblym0tJsdi+bNCvzWtxF6YMnO9/+z+WSb3s72Nl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR4FGq5mWkKetTnO4idGS6LVilGOwJ1Iso6MR6253rxbhyv9g742lmulcTKUwEc5uPS2QvKeF3FoKV7l7ClIGhdseLiVO9CRjmyoN31Ar0p119UnVAE2iZqIQtUI2xCBTAKGFOkIKYdwFrwUfKLCd85qNCaGbZYSsRq7fKGnSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K2T7mqJc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id A96E32057C14; Tue, 30 Jan 2024 22:09:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A96E32057C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706681397;
	bh=yg+VJO0K+0/jLaTvRKDfXImeE8FTSu6c4RAr38E++AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2T7mqJcI3CDBQ69l4jhStujPhYFfTIlKTpyTqQKKQwHNbyoRLjUDvkEEHh9lwcGy
	 p7ogwcmO5gPvaH7vvrGp1+h8grCN77aaKMGQztN3X/jbPw2jugZlbSj6MHX5123aZO
	 spFj/giH4uzoa5A3dIBwetLsr680eMjv7D9dCPeQ=
Date: Tue, 30 Jan 2024 22:09:57 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, shradhagupta@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Message-ID: <20240131060957.GA15733@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240130182914.25df5128@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130182914.25df5128@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 30, 2024 at 06:29:14PM -0800, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 23:18:55 -0800 Shradha Gupta wrote:
> > If hv_netvsc driver is removed and reloaded, the NET_DEVICE_REGISTER
> > handler cannot perform VF register successfully as the register call
> > is received before netvsc_probe is finished. This is because we
> > register register_netdevice_notifier() very early(even before
> > vmbus_driver_register()).
> > To fix this, we try to register each such matching VF( if it is visible
> > as a netdevice) at the end of netvsc_probe.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 85520856466e ("hv_netvsc: Fix race of register_netdevice_notifier and VF register")
> > Suggested-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> Does not seem to apply to net/main, please respin
This patch applies to net, which is missed in the subject. I will fix this in the new version of the patch. Thanks

