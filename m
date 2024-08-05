Return-Path: <linux-hyperv+bounces-2696-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E89473FB
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Aug 2024 05:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A1EB2100F
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Aug 2024 03:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D074D8B6;
	Mon,  5 Aug 2024 03:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NrDJ9Dof"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC3217C;
	Mon,  5 Aug 2024 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722829707; cv=none; b=MMOsBGWXjj7ovcc0H7w3hJId70IMx33s5GdxyiXwD0sJQFwbE3Udfz+eP0mTnFrcPLxHQy0KhA4Es920RIznXPE+jYmRQqxHS4S6EYcebZh6Pa8L/uB/qLsaNVVR0hrEKo9IXQ8KdugD78YoLF6ECvxDYao0TLTDNhQbEk/TSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722829707; c=relaxed/simple;
	bh=Kr8VkxqwdLJEc+8lOx1IkDrCAtqFKqHlW/+7miCSysE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH24TebcwgE3Wzkh/WIF0giEtPLkSrwaSCqkR00Ev0/GmrPdO+voHAuRmXUA2PhpFnEPhJeJ2nteetyvSDi02KDC3cP78QbFwdETnEkcjoqG6ltOEYbu+pUDWTFv4ABIg7hdxQJAfr7DxKRjOhcjv91hclUe7NVe7G8r6187nTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NrDJ9Dof; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E3DB920B7165; Sun,  4 Aug 2024 20:48:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3DB920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722829699;
	bh=FPsbgCxMbUXjFs/OhpM8wOzYmZyMHdRgGS32F/SfBnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrDJ9DofGmKuoc8YEMfKljJv5hpwMUL1rMOloJcJ/RxcsgsqKcuTDvx5rjdbyKT/W
	 FKEY/7l+sTWJaKTthE5gB+3qAfuAH0QOje3itL83xSSq+mTGJCqItnF/A+qjKRQ913
	 5iBjhiD8A+/uz93Xk+LcwHId6lKrl99qZRvV2sjo=
Date: Sun, 4 Aug 2024 20:48:19 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240805034819.GA13225@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
 <4c32b96f-d962-4427-87c2-4953c91c9e43@linux.dev>
 <20240803113154.67a37efb@hermes.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803113154.67a37efb@hermes.local>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Aug 03, 2024 at 11:31:54AM -0700, Stephen Hemminger wrote:
> On Sun, 4 Aug 2024 02:09:21 +0800
> Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> 
> > >   
> > >   	/*  The minimum size of the WQE is 32 bytes, hence
> > > -	 *  MAX_SEND_BUFFERS_PER_QUEUE represents the maximum number of WQEs
> > > +	 *  apc->tx_queue_size represents the maximum number of WQEs
> > >   	 *  the SQ can store. This value is then used to size other queues
> > >   	 *  to prevent overflow.
> > > +	 *  Also note that the txq_size is always going to be MANA_PAGE_ALIGNED,
> > > +	 *  as tx_queue_size is always a power of 2.
> > >   	 */
> > > -	txq_size = MAX_SEND_BUFFERS_PER_QUEUE * 32;
> > > -	BUILD_BUG_ON(!MANA_PAGE_ALIGNED(txq_size));
> > > +	txq_size = apc->tx_queue_size * 32;  
> > 
> > Not sure if the following is needed or not.
> > "
> > WARN_ON(!MANA_PAGE_ALIGNED(txq_size));
> > "
> > 
> > Zhu Yanjun
> 
> On many systems warn is set to panic the system.
> Any constraint like this should be enforced where user input
> is managed. In this patch, that would be earlier in mana_set_ringparam().
> Looking there, the only requirement is that txq_size is between
> the min/max buffers per queue and a power of 2.

Thanks Stephen, that's right.

