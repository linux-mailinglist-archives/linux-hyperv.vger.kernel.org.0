Return-Path: <linux-hyperv+bounces-5926-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD2ADBE72
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 03:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2B61894457
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 01:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471BA19ADA2;
	Tue, 17 Jun 2025 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDUz+tgm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF2915B0EC;
	Tue, 17 Jun 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122711; cv=none; b=olD5bYR8I39YumzmsWiLq22w2xvtabhEU83yPfJKnecBl34r7+SWso9zR5Rwr45IXOYw3TYb0cbrkYXVtjwxFboAqvi40jiLSrWrQVOOh5nHD8flZdsL9E2Ip4n2HbxIHySxevaemo/uFZ8JcwnmOLSD2RfQh+AcuWprX5vGGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122711; c=relaxed/simple;
	bh=iVaWv2RzWaaVpLuDLobgnSNSuWym8RHkG55Fpi0YUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2pMR5cN/Urpmch8nFkkn8IyH2BYgW2Tx9VQLt6H6WsVozODryMzL1Zgbv4L2S+3cY6GiMTT1qWmFEyUygFpULIrykT0iy+jvVJCRUN/gLdw2e4Ie3l33gnHVpgmc2G8ZLPJnH2aln2eU1NkPiXjC+uN9s4Y/XLlghtX1Zs1KNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDUz+tgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE66C4CEEA;
	Tue, 17 Jun 2025 01:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750122710;
	bh=iVaWv2RzWaaVpLuDLobgnSNSuWym8RHkG55Fpi0YUmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZDUz+tgmmat53i4A+5QK7mFlGbgaBHM2POFECs9Tkk4AWrIz7JOaEfJskAUaum+oW
	 4O6FJx5D5oAtBuWaPZPUFPlmKOrip8yd8026FEsnB+qyo5o0VeOPWy+xSZA64ZEZGw
	 PmzX/vZJHfYY5T31ZpqfrXWu3f/PRzAq/dkpQo3K6GAXHJYvqkzFDRW6W7S/ALevJM
	 mT89C+Tv37QjS0UF4x58lvSnig0A47YWCnkC8GnMkaa3+MhANIRZndmi56+aKqnoI/
	 zeG4OQKyWFF3Li1Cct2omWAFieEmrVJbgeNQV8LNma7YzgOPTGRgyTs926/PnDfZUA
	 wou35Gs6DxCug==
Date: Mon, 16 Jun 2025 18:11:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>, Yury Norov
 <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Cameron
 <Jonathan.Cameron@huwei.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, Long Li
 <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof Wilczy???~Dski
 <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Leon
 Romanovsky <leon@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Erni
 Sri Satya Vennela <ernis@linux.microsoft.com>, Peter Zijlstra
 <peterz@infradead.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Paul Rosswurm <paulros@microsoft.com>, Shradha Gupta
 <shradhagupta@microsoft.com>
Subject: Re: [PATCH v6 0/5] Allow dyn MSI-X vector allocation of MANA
Message-ID: <20250616181148.2aed5dfe@kernel.org>
In-Reply-To: <20250612061055.GA20126@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20250611085416.2e09b8cd@kernel.org>
	<20250612061055.GA20126@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 23:10:55 -0700 Shradha Gupta wrote:
> On Wed, Jun 11, 2025 at 08:54:16AM -0700, Jakub Kicinski wrote:
> > On Wed, 11 Jun 2025 07:09:44 -0700 Shradha Gupta wrote:  
> > > Changes in v6
> > >  * rebased to linux-next's v6.16-rc1 as per Jakub's suggestion  
> > 
> > I meant a branch, basically apply the patches on the v6.16-rc1 tag
> > and push it out to GitHub, kernel.org or somewhere else public.
> > Then we can pull it in and maintain the stable commit IDs.
> > No need to repost the patches, FWIW, just share the branch here
> > once you pushed it out..  
> 
> Oh, understood. Thanks for the clarity. Here is a github repo branch
> with the changes on v6.16-rc1 tag
> https://github.com/shradhagupta6/linux/tree/shradha_v6.16-rc1

The tag was good, but when I pulled it my check scripts complained:

Commit a19036b86845 ("net: mana: Allocate MSI-X vectors dynamically")
	committer Signed-off-by missing
	author email:    shradhagupta@linux.microsoft.com
	committer email: shradhagupta@microsoft.com
	Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

etc. You seem to have committed the patches with a slightly different
email address. Not a huge deal but better to fix it if we can.

So please base the tag. The code can stay the same just adjust the
committer or author/signoff email addrs. We can use this as an
opportunity to add Bjorn's email.

No need to repost the code just ping here once you updated the tag.

