Return-Path: <linux-hyperv+bounces-1954-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70AB8A125E
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 12:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19F91C210D4
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6C146D79;
	Thu, 11 Apr 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md+x0skq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C19146A74;
	Thu, 11 Apr 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833124; cv=none; b=mEvkcUUAPMsL9Ftr1YnrEBN/eZiMLa7RpoFmu8c46Eo08+V1NqDYOxI3lSDR77/1wcbNFqxTsBAaFNjvvai3f7XQ55mibaDZ7tfuJ/QCAUZghtDVwIq5hHN89kKlMORPyR2z80RkTeEXKEiYEvZ6HpWgB/9s/nnH7xBeTG8iJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833124; c=relaxed/simple;
	bh=ZFt2FgqJLD7/gLiutE/ebb+N6CTG7vGzNaG/smf7tEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJtVpyZ0a18cv26YdXkO+3p71h23cJJ/SPxnQuOnnNBg9r8hJqsghsg8kbNoEVG4QNE1rXCSjiRFujMq5Hccz4eFqfm07N1m3lGxmzXO2Wqdj+gs5yT5sRjAKFJGwGeYO3lH1H1lUEskgVH3r/GR0zo4y++1Rm9O7oy2eJfxZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md+x0skq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0205DC433C7;
	Thu, 11 Apr 2024 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833123;
	bh=ZFt2FgqJLD7/gLiutE/ebb+N6CTG7vGzNaG/smf7tEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Md+x0skqmrQ0bdIhKDQbJoPVky1ILIxBqDWPkc5ntpGNwvzj+EIYoCvzCMSpjDsSS
	 OEcnruhA5jN/tkwLBFyGr7NlzmqHTwHXM9csV7fTkfV/RHjcfwgAUBQUV4yvj8e6SD
	 GrhihLbDytZ7Fy7++/dECmxgklzC0Q41MV5koamg5hgMzaqmkEMDgsic85PVo1+Muk
	 rEdb6faiuY7s6rE92ALkAbErg0pXB9wr/sipLa3z+UJtHhYTjPqwboo9ljG+pNALeO
	 3c/Isc3zJb9cBA4AZuICvzps5EG1jNhtnJX+HyvcIUPelj/XNDxA9xY7Aj1ITmWToN
	 1o9A3jNS9mGBw==
Date: Thu, 11 Apr 2024 13:58:39 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Erick Archer <erick.archer@outlook.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/3] RDMA/mana_ib: Add flex array to struct
 mana_cfg_rx_steer_req_v2
Message-ID: <20240411105839.GN4195@unreal>
References: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240408110730.GE8764@unreal>
 <20240408183657.7fb6cc35@kernel.org>
 <ca8a0df8-b178-31ff-026f-b2d298f3aa84@gmail.com>
 <20240409144419.6dc12ebb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409144419.6dc12ebb@kernel.org>

On Tue, Apr 09, 2024 at 02:44:19PM -0700, Jakub Kicinski wrote:
> On Tue, 9 Apr 2024 18:01:40 +0100 Edward Cree wrote:
> > > Shared branch would be good. Ed has some outstanding patches 
> > > to refactor the ethtool RSS API.  
> > 
> > For the record I am extremely unlikely to have time to get those
> >  done this cycle :(
> > Though in any case fwiw it doesn't look like this series touches
> >  anything that would conflict; mana doesn't appear to support
> >  custom RSS contexts and besides the changes are well away from
> >  the ethtool API handling.
> 
> Better safe than sorry, since the change applies cleanly on an -rc tag
> having it applied to both trees should be very little extra work.

I prepared mana-ib-flex branch https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=mana-ib-flex
and merge ti to our wip branch https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/leon-for-next&id=e537deecda03e0911e9406095ccd48bd42f328c7

Thanks

