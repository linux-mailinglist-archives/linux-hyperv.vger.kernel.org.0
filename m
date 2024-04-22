Return-Path: <linux-hyperv+bounces-2017-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392658ACA48
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Apr 2024 12:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88562B21AC6
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Apr 2024 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67613DDCB;
	Mon, 22 Apr 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dPP0TSga"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195513DBB2;
	Mon, 22 Apr 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780496; cv=none; b=mmYY5cOt2afxKbQQ4kPyaE0FACOgIZOXvDlmRlNfxzrsynY45kSLQFBudmobIGUiB1siFqRU9eS4P+G0SaARxVvXttNnWcOaqY6C7EY7oNAWPD1AKh2+lnuJQQpnosYdAaArO9wxzZQx7TLJyuPpTgK/pxDWcSAvGu2icbiVnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780496; c=relaxed/simple;
	bh=5t1Bfop7a73SP2Xoc+JjPX3eauf9YdecV0ZqhsEjPCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuVBuBEZino09RyhkDxIP2acCOjRvDSwGJGjunQk80gNsJG2ypDsgxgzlpO2fy3w39zcBOZcD2XdKl0Fq6hiAYcVt1JnjBrM6QxWCuQ5eS5OI8gQeMPAaH7E63SE3jFOvfhtwhnlHJgWR5kFsFR/rZRUvGKEey8nFXYGOJPUm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dPP0TSga; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 5A40E20FEB70; Mon, 22 Apr 2024 03:08:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A40E20FEB70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713780489;
	bh=p/91VOpGr+sXlA4jv/RAoPR3l3/fwg6j5nhp26gdg74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPP0TSgaJivoAFhSsrYk9liFUNizFn+wcBwR9iR/96vvpWhIJ69DCFlE4IpyE5UuF
	 0XveB92uwHC46KXjCMY1uBItDd0eSw0IfWb6BHVAM9EH4fQ6s9Qny5cJhpK2ClRmmL
	 nxtJWq6M81hbyyDZt/fiDiPALWzxvP39K2cVGn94=
Date: Mon, 22 Apr 2024 03:08:09 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20240422100809.GA9873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
 <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
 <b34bfb11-98a3-4418-b482-14f2e50745d3@lunn.ch>
 <20240418060108.GB13182@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240418175059.GZ223006@ziepe.ca>
 <f3e7ea07-2903-4f19-ba86-94bba569dae9@lunn.ch>
 <20240419165926.GC506@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <fc345b4d-0747-4ca3-aee0-c53064cc7fe1@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc345b4d-0747-4ca3-aee0-c53064cc7fe1@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Apr 19, 2024 at 08:51:02PM +0200, Andrew Lunn wrote:
> On Fri, Apr 19, 2024 at 09:59:26AM -0700, Shradha Gupta wrote:
> > On Thu, Apr 18, 2024 at 08:42:59PM +0200, Andrew Lunn wrote:
> > > > >From an RDMA perspective this is all available from other APIs already
> > > > at least and I wouldn't want to see new sysfs unless there is a netdev
> > > > justification.
> > > 
> > > It is unlikely there is a netdev justification. Configuration happens
> > > via netlink, not sysfs.
> > > 
> > >     Andrew
> > 
> > Thanks. Sure, it makes sense to make the generic attribute configurable
> > through the netdevice ops or netlink implementation. I will keep that in
> > mind while adding the next set of configuration attributes for the driver.
> > These attributes(from the patch) however, are hardware specific(that show
> > the maximum supported values by the hardware in most cases).
> 
>         ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
>         ndev->min_mtu = ETH_MIN_MTU;
> 
> This does not appear to be specific to your device. This is very
> generic. We already have /sys/class/net/eth42/mtu, why not add
> /sys/class/net/eth42/max_mtu and /sys/class/net/eth42/min_mtu for
> every driver?
> 
> Are these values really hardware specific? Are they really unique to
> your hardware? I have to wounder because you clearly did not think
> much about MTU, and how it is actually generic...
> 
>      Andrew
That makes sense. I will make these as generic attributes in the next version.
Thanks.

