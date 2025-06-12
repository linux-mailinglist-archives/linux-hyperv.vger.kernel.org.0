Return-Path: <linux-hyperv+bounces-5885-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA291AD67A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Jun 2025 08:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838063ACFDE
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Jun 2025 06:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F51EE03B;
	Thu, 12 Jun 2025 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Joy80Sg4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE41DFE20;
	Thu, 12 Jun 2025 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708657; cv=none; b=eoItsJhRBHCUul7+lbyZdQ9z0fGDPDKodvZ9eLBo0n/01efb7C/8WgeDgTN1djbcLhxDula2/QNi2ybsx0FSNlhs8/Wg/ix0A7EE0e6YTbIHlm5Cu0tahw6zYDQl5w0KKCqtEIxVM/DYGUUNQoLMXhWEn9+Cz7trvbsnY1P13P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708657; c=relaxed/simple;
	bh=H9PA9PCo638QQZPWDPbj0Ba1bybAEdQxDFbiE72JlkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPssS/SxQpOP/YlsMQ1fm1H+55V7Sn2QfjATn78tY7ZQ67nhNu0hI8D1Zx4Ys+qAcXzLbzdR5Xk6MJXRoDqRNKdcG6QrQKoiw2QSy6zpIdh+Sr35fUZVgIXH1FhqITdcU5/P2YBVSIne8z2dew26ZoAfQ7vFaeOcsOPlru9NvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Joy80Sg4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 76086201C75A; Wed, 11 Jun 2025 23:10:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76086201C75A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749708655;
	bh=HN++Rtd2kvEZX5dTxYCxgeHtSgU5q6eX3FDdzeIu4N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Joy80Sg4iBtXAMbefgcBZB2I+MjPH66brawgypplOEsp1AczKCZB8ggW7gQR+TJ8K
	 aXx/jPCBna4WI8HhmRdmW7OAyRvVS/QMan46Eh0xvbsyLy9+0vHWyjkYR7xhoOtX0q
	 B3fiNpxGp6smskSMSw+52pUtmsW2y6xzPFNHhRuk=
Date: Wed, 11 Jun 2025 23:10:55 -0700
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
Message-ID: <20250612061055.GA20126@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250611085416.2e09b8cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611085416.2e09b8cd@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jun 11, 2025 at 08:54:16AM -0700, Jakub Kicinski wrote:
> On Wed, 11 Jun 2025 07:09:44 -0700 Shradha Gupta wrote:
> > Changes in v6
> >  * rebased to linux-next's v6.16-rc1 as per Jakub's suggestion
> 
> I meant a branch, basically apply the patches on the v6.16-rc1 tag
> and push it out to GitHub, kernel.org or somewhere else public.
> Then we can pull it in and maintain the stable commit IDs.
> No need to repost the patches, FWIW, just share the branch here
> once you pushed it out..

Oh, understood. Thanks for the clarity. Here is a github repo branch
with the changes on v6.16-rc1 tag
https://github.com/shradhagupta6/linux/tree/shradha_v6.16-rc1

Would this suffice?

regards,
Shradha.

