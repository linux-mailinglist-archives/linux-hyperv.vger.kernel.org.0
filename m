Return-Path: <linux-hyperv+bounces-2912-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED9D963EE0
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 10:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4225C1C22279
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2799F18C325;
	Thu, 29 Aug 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CUzmpdSI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33DD189B9D;
	Thu, 29 Aug 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921040; cv=none; b=Lhf3EgtxvgoUK6jd9fCTQvNbgdM0kRzjfWXLHplSfdCZF7VJHZdm+TX+QDtpekbD6Ik/m9MnJXwXWTbjpxO2yWUrTsN4jxXVB8qcVPkq3SzhFL4BYgSQiWij0xS0IuUQ5p58SmARgVcR1OrH6bPVq/yKzJmxici0FHI77w+ydFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921040; c=relaxed/simple;
	bh=2C0YSL35AO+qbcMzCggkTk7ZR8ZizdAacVd9eprVcDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njN54YkREeZ/+Yt6FLXa3VT0NhfrEVBNi/wHNsQLHO+jExaqeSHzttfLJeIw7AGE/fIbuBZCG28lMkx2daXtBRP7tgqW0+5ukq5j/esHaROV/GlGf3/8M2yByeyTev7FGZkRrD5UUJnFnosGu072EmjbXJ9NFiPEW8R7h1VUMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CUzmpdSI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 6046720B7165; Thu, 29 Aug 2024 01:43:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6046720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724921038;
	bh=fjV6bhL7oCv81jbrq2vTPTnkfRQIIJK+sztlGGSrG8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUzmpdSI1zlx3cq7BX+BJ7Dm1eXC8AHcvb6LDRcURXH+u16/YY6K3479uaaZ1Ns61
	 EOuoYo1u3cOAcGQ3+tFgnvrbiz+vRWZYV/WdlG5yFFQcpGz2bUySIFxs8ytLDaHH5Q
	 uecQynjJUXgLimk4Wukte6jJXUTDVzagcxHMuWgI=
Date: Thu, 29 Aug 2024 01:43:58 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, longli@microsoft.com, yury.norov@gmail.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	schakrabarti@microsoft.com
Subject: Re: [PATCH V2 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Message-ID: <20240829084358.GA15997@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1724406269-10868-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20240827132637.31b7eb36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827132637.31b7eb36@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Aug 27, 2024 at 01:26:37PM -0700, Jakub Kicinski wrote:
> On Fri, 23 Aug 2024 02:44:29 -0700 Souradeep Chakrabarti wrote:
> > @@ -2023,14 +2024,17 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
> >  
> >  	napi = &rxq->rx_cq.napi;
> >  
> > -	if (validate_state)
> > -		napi_synchronize(napi);
> > +	if (napi->dev == apc->ndev) {
> >  
> > -	napi_disable(napi);
> > +		if (validate_state)
> > +			napi_synchronize(napi);
> >  
> > -	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> > +		napi_disable(napi);
> >  
> > -	netif_napi_del(napi);
> > +		netif_napi_del(napi);
> > +	}
> > +
> > +	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> 
> Please don't use internal core state as a crutch for your cleanup.
> 
> IDK what "validate_state" stands for, but it gives you all the info you
> need on Rx. On Rx NAPI registration happens as the last stage of rxq
> activation, once nothing can fail. And the "cleanup" path calls destroy
> with validate_state=false. The only other caller passes true.
> 
> So you can rewrite this as:
> 
> 	if (validate_state) { /* rename it maybe? */
> 		napi_disable(napi);
> 		...
> 	}
> 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> 
> You can take similar approach with Tx. Pass a bool which tells the
> destroy function whether NAPI has been registered.
Thanks Jakub for the suggestion. I have changed the implementation
in the V3. I have added a new txq and rxq structure attribute to check
that per queue napi is initialized.
The use of a local flag like validate_state will not be possible with
current design of txq destroy function, as it uses the hole vport
and loops for all the queues for that port.
-
Souradeep
> -- 
> pw-bot: cr

