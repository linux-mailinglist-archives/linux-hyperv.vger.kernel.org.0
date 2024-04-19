Return-Path: <linux-hyperv+bounces-2009-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BF68AB405
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 18:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA72AB2202B
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C932413A3E5;
	Fri, 19 Apr 2024 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l6NJClBx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8094C63A;
	Fri, 19 Apr 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545967; cv=none; b=mLIQ+0Wcg797t/aAFWWGOUAizSaeS3teRyxRAqaxhx2w5EvQSO2mA4A6Yv/grGDqWL7wl6cb66mRmbCcPpPIQCoYWvdRqGq2xbMRGdI5mPzXiY21utD6xYD0XvWtKRm+hrGJwbPpC3gMfr751aPOs1Rynkd+2S2WSfJ6dELk6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545967; c=relaxed/simple;
	bh=Z7YH0CvhpgqXNh0KlZ+NJZMQQx43ZiBcsIHLxUcuADU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvHBaKurKlRYcUpfnRA3x4/TPTNSej+La1GymcqhLb7j2OBDA4F4eH9qGZ7hH1PKDg11GT6Ir2yY5BQJYXymmb3uNr9U3D5dO1tjFeKNee4vvKEYKVTOtkF8vwYVQkR+OuBW0+FB7Op+3nQOjioyrPumKgVK6xMjTVFxxnBq144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l6NJClBx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 2988A20FDAA1; Fri, 19 Apr 2024 09:59:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2988A20FDAA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713545966;
	bh=y/qgfgGYyhPfmyF6SjIYu3rIjqvmvUNw7mws9b1MVpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6NJClBxCk4a3k/YEHO3EnfhE/ohLexA50S4Hi2qR8Qzdu69a4ZZPtWL/fkQ1ll3D
	 iHcC/QJx7eAd/vrlyRMiIoh+xHLLxlN3MeeNoiOnVI4PIQL/n2SXnvBeZUGSgL4YsK
	 ON23nNvME5OhTSJ7q8Uq6sDmjvQS8ymfE7Jxk8fs=
Date: Fri, 19 Apr 2024 09:59:26 -0700
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
Message-ID: <20240419165926.GC506@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
 <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
 <b34bfb11-98a3-4418-b482-14f2e50745d3@lunn.ch>
 <20240418060108.GB13182@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240418175059.GZ223006@ziepe.ca>
 <f3e7ea07-2903-4f19-ba86-94bba569dae9@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e7ea07-2903-4f19-ba86-94bba569dae9@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Apr 18, 2024 at 08:42:59PM +0200, Andrew Lunn wrote:
> > >From an RDMA perspective this is all available from other APIs already
> > at least and I wouldn't want to see new sysfs unless there is a netdev
> > justification.
> 
> It is unlikely there is a netdev justification. Configuration happens
> via netlink, not sysfs.
> 
>     Andrew

Thanks. Sure, it makes sense to make the generic attribute configurable
through the netdevice ops or netlink implementation. I will keep that in
mind while adding the next set of configuration attributes for the driver.
These attributes(from the patch) however, are hardware specific(that show
the maximum supported values by the hardware in most cases). We want them
to be a part of sysfs so that they are readily available in the production
for improving debuggability. I will change the names of these attribute to
indicate the same to avoid possible confusion.

Regards,
Shradha.

