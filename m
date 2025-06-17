Return-Path: <linux-hyperv+bounces-5933-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1F7ADC8B8
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 12:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EECF189758D
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 10:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F872D12E3;
	Tue, 17 Jun 2025 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S8y3ONei"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CA52192EA;
	Tue, 17 Jun 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157616; cv=none; b=G0iYiQEljZvKcLDiPvgzgxr4y9veBhp9hJStPxCAZd6b78R3mlF+kOwyvnP6uyX1OYv4bWjsBHKH4qlFS7EwYOXglM2vYquS7QlL4rMx/XO4PTAdM+Z1tc9PXPHM8Ntx+llZHHGn9C+kkFkx9Io7K46wuYx6HOQjQ2x10qtMIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157616; c=relaxed/simple;
	bh=LXzxy9GJIJvOZ6hEU8LpqCZKVoKFWaP9J0LdMqIm7TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9/e3hQGOP0Y0h7RWhN5MHuIUtmsLm0LgwErQjLz1qVS1Zk/y/EV8cISknWOC653t7lT2EV3hjYPA2BpMZEj1LZHW01S9uFRIuOnROWrr9mG2SLqYqQgDO0sF3st7XsELxQq9K5WCpPtbzbl6abrw2dHSSa7oK7/j84Y/RZkm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S8y3ONei; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 28DA321176D6; Tue, 17 Jun 2025 03:53:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28DA321176D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750157614;
	bh=xsFfvfMOhD513ZWl589KLiqfUEOcBNPPyV+LjOiXiLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8y3ONeiQr4oBJBn8VMHAJxLV/eWmSHN6tWd+UG5WGdZTb6TB5cRHkJp2t9T/SqCM
	 geCh8p2qHCfvb3IginFivGq4/3ftZUOs8vXnFtzF+xkYzx+MDLXIJU9sMPtVBEaBrN
	 ueF3s+jFbMuwsHyOr2GOOw7R6QPYFnhbUoElCDP4=
Date: Tue, 17 Jun 2025 03:53:34 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy???~Dski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v6 0/5] Allow dyn MSI-X vector allocation of MANA
Message-ID: <20250617105334.GC23702@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250611085416.2e09b8cd@kernel.org>
 <20250612061055.GA20126@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250616181148.2aed5dfe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616181148.2aed5dfe@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jun 16, 2025 at 06:11:48PM -0700, Jakub Kicinski wrote:
> On Wed, 11 Jun 2025 23:10:55 -0700 Shradha Gupta wrote:
> > On Wed, Jun 11, 2025 at 08:54:16AM -0700, Jakub Kicinski wrote:
> > > On Wed, 11 Jun 2025 07:09:44 -0700 Shradha Gupta wrote:  
> > > > Changes in v6
> > > >  * rebased to linux-next's v6.16-rc1 as per Jakub's suggestion  
> > > 
> > > I meant a branch, basically apply the patches on the v6.16-rc1 tag
> > > and push it out to GitHub, kernel.org or somewhere else public.
> > > Then we can pull it in and maintain the stable commit IDs.
> > > No need to repost the patches, FWIW, just share the branch here
> > > once you pushed it out..  
> > 
> > Oh, understood. Thanks for the clarity. Here is a github repo branch
> > with the changes on v6.16-rc1 tag
> > https://github.com/shradhagupta6/linux/tree/shradha_v6.16-rc1
> 
> The tag was good, but when I pulled it my check scripts complained:
> 
> Commit a19036b86845 ("net: mana: Allocate MSI-X vectors dynamically")
> 	committer Signed-off-by missing
> 	author email:    shradhagupta@linux.microsoft.com
> 	committer email: shradhagupta@microsoft.com
> 	Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> etc. You seem to have committed the patches with a slightly different
> email address. Not a huge deal but better to fix it if we can.
> 
> So please base the tag. The code can stay the same just adjust the
> committer or author/signoff email addrs. We can use this as an
> opportunity to add Bjorn's email.
> 
> No need to repost the code just ping here once you updated the tag.

Hi Jakub,

I have updated the tag with the corrected author and committer details
and added Bjorn's ack:
https://github.com/shradhagupta6/linux/tree/shradha_v6.16-rc1

By 'please base the tag', did you mean we rebase the changes with rc2?
If so, I have also created a rc2 tag branch, JFYI
https://github.com/shradhagupta6/linux/tree/shradha_v6.16-rc2

Hope this helps.

Thanks,
Shradha.

