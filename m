Return-Path: <linux-hyperv+bounces-1896-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6387894A50
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 06:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660ABB227BB
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 04:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83685175BC;
	Tue,  2 Apr 2024 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkTzWbGD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA0168B1;
	Tue,  2 Apr 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031155; cv=none; b=WWGAcXRZBG6WqcYFo/kcCH5a5j/yLX3toKSm3um8JujzmesowbABT1jaxLFhK01MotoXEK7xbLvvHu76aD6qN1DOIV/3AZecCXPoh0DI0AJfkap00rj8z3cUPVcpMSL9VUooBEYkZKaiIyHSZnscbQjhAZI9B3H2FMQIAI//u+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031155; c=relaxed/simple;
	bh=aI3eJF8HniXat2ib1QyBX8zCGp45TAApFBysvadGBQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noVgS2SVCt8ST8HcgSW+vNT5yM6YTB2kvMzM5h9Md/Hyi/DhO+2/FLepbpY6osHTfoCDfVwIbX2PRmGxum5CO0NrgUgCWw+l9iiL+/XMMZ4y353fO0rgUexLmXMA7rdI4xD9yAkwUnVUluuuiGqV2AIBWLwRybJW8vH/kDDst3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkTzWbGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672A3C433C7;
	Tue,  2 Apr 2024 04:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712031154;
	bh=aI3eJF8HniXat2ib1QyBX8zCGp45TAApFBysvadGBQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nkTzWbGDGnmj8/6m7801zLy+B6JjA/ZXpJtp/FkRdEg9tN9IzGfm0CgMNlSQZ95KA
	 HqxuhIuo0Z8jXpeg7+WS8AqPQMI3opBF15vPciltVh6dp1j4k9FufIgrSaC/5V2kCt
	 YEPK5SKsvPPG6KBRWKu0WIHe8/jRr1UzS/lOZBFygL9M7mX0OYThU3fLemJ6C6UhXx
	 eZZxq598IWatnRW/We9rCVsWeiyKs8JcHDpSLnBbSEV5DuEgCQtyF4olFeKEa5c0ou
	 eYO3Jbd1Y/f6t6QROP/ViG0ZZliYkzMGtNSo1LuXTlS+lLNb7DndsBZc/K6DXHLcv+
	 82IVNF+FUIJlA==
Date: Mon, 1 Apr 2024 21:12:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Wei Hu <weh@microsoft.com>, stephen
 <stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>, Long Li
 <longli@microsoft.com>, "ssengar@linux.microsoft.com"
 <ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "ast@kernel.org" <ast@kernel.org>, "sharmaajay@microsoft.com"
 <sharmaajay@microsoft.com>, "hawk@kernel.org" <hawk@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Message-ID: <20240401211232.57b17081@kernel.org>
In-Reply-To: <CY5PR21MB37590FD539C1E380FBDC96B0BF3E2@CY5PR21MB3759.namprd21.prod.outlook.com>
References: <1711748213-30517-1-git-send-email-haiyangz@microsoft.com>
	<CY5PR21MB375904FD3437BA610E6BDBD1BF392@CY5PR21MB3759.namprd21.prod.outlook.com>
	<CH2PR21MB1480E02C74E7BB5A52A71859CA3F2@CH2PR21MB1480.namprd21.prod.outlook.com>
	<CY5PR21MB37590FD539C1E380FBDC96B0BF3E2@CY5PR21MB3759.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 01:23:08 +0000 Dexuan Cui wrote:
> > > I suggest the Fixes tag should be updated. Otherwise the fix
> > > looks good to me.  
> > 
> > Thanks for the suggestion. I actually thought about this before
> > submission.
> > I was worried about someone back ports the jumbo frame feature,
> > they may not automatically know this patch should be backported
> > too.   
> 
> The jumbo frame commit (2fbbd712baf1) depends on the MTU
> commit (2fbbd712baf1), so adding "Fixes: 2fbbd712baf1" (
> instead of "Fixes: ca9c54d2d6a5") might make it easier for people
> to notice and pick up this fix.
> 
> I'm OK if the patch remains as is. Just wanted to make  sure I
> understand the issue here.

Please update the tag to where the bug was actually first exposed.

