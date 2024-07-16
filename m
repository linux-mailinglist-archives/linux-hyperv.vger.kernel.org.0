Return-Path: <linux-hyperv+bounces-2570-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9293202E
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jul 2024 07:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDF21F22BBB
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jul 2024 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F56018633;
	Tue, 16 Jul 2024 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HHQo67fV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC611C286;
	Tue, 16 Jul 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721109022; cv=none; b=hpoLgTK1cQiUbloHIbOjSZcsXl1m12vZoTs9QcymmDQOgVBe4ByA17mh21dXWNWmVvMbgIjE8w16eJ1zFaHHtB/QIydlfC9RdHaeDZ8B+fpCZbIQbk/q9Iwanq8UD0yWkyu64WEBReO+J2wBKeeOSGRSxaeky/71aioceZ5Cuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721109022; c=relaxed/simple;
	bh=oel0VGQtFFVn7VcAvi3ianHKfhfy/DHPrz7TuNbCTcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru8BI6ETAyH5nmYGxvH6aV6W4ZhvLiF9rWsBO7SBMId9fXcM9nBEDBsJSVQPKc1py9M7MOtaH/K2wEw1jBYCoC2tJMvmI+/6aDkiq0wyaGdWF7D1QYA/lWkgNIhOHM3xpgZ/NPv5iP4JPO9vNYr2kZWeqIXx2SOFGkjiCoOdtn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HHQo67fV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 5C9C520B7165; Mon, 15 Jul 2024 22:50:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C9C520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721109020;
	bh=QXWx9lUrpLWs3EVn56AuR9gmfE5Q+7yYX5/1e3sAPYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHQo67fVhraUlcRpVybY1uhzc9QUCTGbRhtQG+IbIaToDruoEqjveTIwFyt5Jo9E6
	 jAtrWrxdUzXuTPwVshJqlml3YypZymr8tBPhERMSRUwMtZhM90+2+Is15lg1lvjwHP
	 y+4g231WJfh8rHvgUR3FlH6kkIYNM9OBXpX1WcvI=
Date: Mon, 15 Jul 2024 22:50:20 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240716055020.GB16469@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1721014820-2507-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240715132842.GF45692@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715132842.GF45692@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jul 15, 2024 at 02:28:42PM +0100, Simon Horman wrote:
> On Sun, Jul 14, 2024 at 08:40:20PM -0700, Shradha Gupta wrote:
> > Currently the values of WQs for RX and TX queues for MANA devices
> > are hardcoded to default sizes.
> > Allow configuring these values for MANA devices as ringparam
> > configuration(get/set) through ethtool_ops.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reviewed-by: Long Li <longli@microsoft.com>
> 
> ...
> 
> > diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> > index e39b8676fe54..3e27ca5155aa 100644
> > --- a/include/net/mana/mana.h
> > +++ b/include/net/mana/mana.h
> > @@ -38,9 +38,21 @@ enum TRI_STATE {
> >  
> >  #define COMP_ENTRY_SIZE 64
> >  
> > -#define RX_BUFFERS_PER_QUEUE 512
> > +/* This Max value for RX buffers is derived from __alloc_page()'s max page
> > + * allocation calculation. It allows maximum 2^(MAX_ORDER -1) pages. RX buffer
> > + * size beyond this value gets rejected by __alloc_page() call.
> > + */
> > +#define MAX_RX_BUFFERS_PER_QUEUE 8192
> > +#define DEF_RX_BUFFERS_PER_QUEUE 512
> > +#define MIN_RX_BUFFERS_PER_QUEUE 128
> >  
> > -#define MAX_SEND_BUFFERS_PER_QUEUE 256
> > +/* This max value for TX buffers is dervied as the maximum allocatable
> 
> nit: derived
> 
>      Flagged by checkpatch --codespell
Noted, Thanks for the review.
> 
> 
> 
> > + * pages supported on host per guest through testing. TX buffer size beyond
> > + * this value is rejected by the hardware.
> > + */
> > +#define MAX_TX_BUFFERS_PER_QUEUE 16384
> > +#define DEF_TX_BUFFERS_PER_QUEUE 256
> > +#define MIN_TX_BUFFERS_PER_QUEUE 128
> >  
> >  #define EQ_SIZE (8 * MANA_PAGE_SIZE)
> >  
> 
> ...

