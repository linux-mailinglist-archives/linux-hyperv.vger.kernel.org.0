Return-Path: <linux-hyperv+bounces-1467-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EDB83A6CE
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 11:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CD7288388
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375718E3A;
	Wed, 24 Jan 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaBuLENr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE31AAA5;
	Wed, 24 Jan 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092189; cv=none; b=Lg2RNkBZXr92pxdkkQn6ZvEQPja6ou+cuQguVpp+5BmR4Tointd6ziN8teBvd4ddOteXw9wFllpBFGSG2gm/bx7ZmBYY2MWL19s1b1it+b4EO6dWYlde23XSl9qzOczug0dxzBoGQEi5t2WelQ3OWEz0h+zj3cDTb5Pn4ZshmXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092189; c=relaxed/simple;
	bh=vGeH8O/idxM0sz+OcKnGybYW1xtFoz1P9rDGvF9sN+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm8blExf1pVvOKWGsu2KW+1KvWsEffQ942ALjBt7Hls+PMHkeZ20CSSZ2aD8+QeMXV94bwO7T7oYlFm/P8dpHKC46rorNg7rLylLJI9L5gxREmBgcjt4p83CovrcUBsBg4KIjXvyhWjv/83TcqWRFWZd6O2pTD5GtlQU1uHiJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaBuLENr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C1EC433F1;
	Wed, 24 Jan 2024 10:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092189;
	bh=vGeH8O/idxM0sz+OcKnGybYW1xtFoz1P9rDGvF9sN+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TaBuLENrsiM5ybt4sZQDl1B4vwATyWMkK62EPQErt5aSPY3Gibg/JcV5Qt+tS12PR
	 r4LaGlAr/6UDr0af4KDFvM3doYb9CZGjuUjGtTJxeiT7pzsQv5hCESEmWuOkF/lxMy
	 mBNHYNlcbCoc4Fa/lWPA3+HzjCbcYnJ/rf/dFPxJ31ADgbm1ZwTX9bSt6A4YzTLn4g
	 74WknBmtdbNsT8Ca/WiIno1FnafcSvf2e70lq7z60NKKZSV3cE9pO5qyCf4zm70DkM
	 OymxETo4VEBdh6tyTcNaLpN015nsZhZOZsJZYjHwoUlBBmj//Zkw2RRQmLKW1Re3gg
	 cov2HRISizh0Q==
Date: Wed, 24 Jan 2024 10:29:44 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net 1/1] hv_netvsc: Calculate correct ring size when
 PAGE_SIZE is not 4 Kbytes
Message-ID: <20240124102944.GW254773@kernel.org>
References: <20240122162028.348885-1-mhklinux@outlook.com>
 <SN6PR02MB415753E9E46CCC4AC809220DD4742@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415753E9E46CCC4AC809220DD4742@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Jan 23, 2024 at 05:13:12PM +0000, Michael Kelley wrote:
> From: Simon Horman @ 2024-01-22 20:49 UTC (permalink / raw)
> > 
> > On Mon, Jan 22, 2024 at 08:20:28AM -0800, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > Current code in netvsc_drv_init() incorrectly assumes that PAGE_SIZE
> > > is 4 Kbytes, which is wrong on ARM64 with 16K or 64K page size. As a
> > > result, the default VMBus ring buffer size on ARM64 with 64K page size
> > > is 8 Mbytes instead of the expected 512 Kbytes. While this doesn't break
> > > anything, a typical VM with 8 vCPUs and 8 netvsc channels wastes 120
> > > Mbytes (8 channels * 2 ring buffers/channel * 7.5 Mbytes/ring buffer).
> > >
> > > Unfortunately, the module parameter specifying the ring buffer size
> > > is in units of 4 Kbyte pages. Ideally, it should be in units that
> > > are independent of PAGE_SIZE, but backwards compatibility prevents
> > > changing that now.
> > >
> > > Fix this by having netvsc_drv_init() hardcode 4096 instead of using
> > > PAGE_SIZE when calculating the ring buffer size in bytes. Also
> > > use the VMBUS_RING_SIZE macro to ensure proper alignment when running
> > > with page size larger than 4K.
> > >
> > > Cc: <stable@vger.kernel.org> # 5.15.x
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > 
> > Hi Michael,
> > 
> > As a bug fix this probably warrants a fixes tag.
> > Perhaps this is appropriate?
> > 
> > Fixes: 450d7a4b7ace ("Staging: hv: ring parameter")
> > 
> 
> [This email is cobbled together because for some reason I didn't directly
> receive your original reply.  So it won't thread correctly with yours.]
> 
> I thought about a Fixes: tag, but the situation is a bit weird.  The original
> code was correct enough at the time it was written in 2010 because Hyper-V
> only ran on x86/x64 with a 4 Kbyte guest page size.   In fact, all the Hyper-V
> guest code in the Linux kernel tended to assume a 4 Kbyte page size.
> During 2019 and 2020, I and others made changes to remove this
> assumption, in prep for running Hyper-V Linux guests on ARM64.  The
> ARM64 support was finally enabled with commit 7aff79e297ee in August
> 2021 for the 5.15 kernel.  Somehow we missed fixing this case in the netvsc
> driver, and a similar case in the Hyper-V synthetic storage driver (see [1]).
> 
> As a result, there's no point in backporting this fix to anything earlier than
> 5.15, because there's no ARM64 support for Hyper-V guests in earlier kernels.
> So picking a "Fixes:" commit from back in 2010 doesn't seem helpful.  I could
> see doing
> 
> Fixes: 7aff79e297ee ("Drivers: hv: Enable Hyper-V code to be built on ARM64")
> 
> But the connection between that commit and this fix isn't very evident, so I
> opt'ed for just putting the 5.15.x notation on the Cc: stable@vger.kernel.org
> line.  That said, I don't feel strongly about it.  I'm just trying to do what's best
> for the stable branch maintainers and avoid generating backports to kernel
> versions where it doesn't matter.

Thanks for the explanation.

FWIIW, I would probably have gone for the tag above (7aff79e297ee)
as presumably that is when the bug started manifesting.
But I appreciate that it isn't straightforward.

