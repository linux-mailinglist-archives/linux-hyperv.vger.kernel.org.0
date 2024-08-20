Return-Path: <linux-hyperv+bounces-2785-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BFF958E79
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2024 21:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720AF284DCB
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E41547F7;
	Tue, 20 Aug 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jSmrmKBi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C114C5A3;
	Tue, 20 Aug 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181139; cv=none; b=nXb/+wa3kHO3jOcF3vYr5nGWrbLbAAzbLwbBBfSZhXSHBELEhyRGgkhcIca9Lwx/RoIWFZ+8tBwHq9IQ1F7s/yG9P5TUhjUUEgmmfaCsw5PnSNOSkUPY1MIvPch0E8/LS+hZNcrFAhOklJCpp4ESN5ZZlZpP3OfA6K8RwvOaf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181139; c=relaxed/simple;
	bh=CQgWYc56r5iE9h8k6AEkA3iGag7hNM9c1UA9/XpCiLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD+/uR0qV8FWCvaiaP2U3hjtK0bbFSeBnNdajUToz466unoayBfNVyz/M5IVECkN0bH/H+GHQIj0BZDLXXkedy5SKqHOEk5IOxCp0ThH3TMGRupuutJHAymwPr8T2xnduFc1LLvdGOsg7O2DfNEsY6RdbIC0BPrnPW+tSJezunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jSmrmKBi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 03BCC20B7165; Tue, 20 Aug 2024 12:12:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 03BCC20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724181132;
	bh=OQg0JXOAKQX95k93uaZW7X/palY8JO7oGBXbVZmigB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSmrmKBipkrhLyX6+tlRxvz/eRUfuiM9wGNW8tp63kBO8g3R/262/eOSnIbV0aVr9
	 RpJn2JHd0qCu9ZukAHw6SvRWfKXH5erwerr45Qmrkf03MtBNBYnUL2b9eEY99JflCD
	 KSpIOhBBK0FTUKbM4AtrhMjgYJZ4wx/2SkDTjTbM=
Date: Tue, 20 Aug 2024 12:12:11 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Erni Sri Satya Vennela <ernis@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: netvsc: Update default VMBus channels
Message-ID: <20240820191211.GA15387@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
 <20240815090856.7f8ec005@kernel.org>
 <CH2PPF910B3338DB4798D086CB50600C2FBCA802@CH2PPF910B3338D.namprd21.prod.outlook.com>
 <20240816085241.326978a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816085241.326978a6@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Aug 16, 2024 at 08:52:41AM -0700, Jakub Kicinski wrote:
> On Thu, 15 Aug 2024 19:23:50 +0000 Haiyang Zhang wrote:
> > Your suggestion on netif_get_num_default_rss_queues() is not ignored.
> > We discussed internally on the formula we used for the num_chn, and
> > chose a similar formula for higher number of vCPUs as in 
> > netif_get_num_default_rss_queues().
> > For lower number of vCPUs, we use the same default as Windows guests,
> > because we don't want any potential regression.
> 
> Ideally you'd just use netif_get_num_default_rss_queues()
> but the code is close enough to that, and I don't have enough
> experience with the question of online CPUs vs physical CPUs.
> 
> I would definitely advise you to try this on real workloads.
> While "iperf" looks great with a lot of rings, real workloads
> suffer measurably from having more channels eating up memory
> and generating interrupts.
> 
> But if you're confident with the online_cpus() / 2, that's fine.
> You may be better off coding it up using max:
> 
> 	dev_info->num_chn = max(DIV_ROUND_UP(num_online_cpus(), 2),
> 				VRSS_CHANNEL_DEFAULT);
Due to hyper-threading, #of physical cores = online CPUs/2.
Therefore, netif_get_num_default_rss_queues() returns 
#of physical cores/2 = online CPUs/4.

In my testing, the throughput performance was similar for both the
configurations even for higher SKUs.To utilize lesser CPU resources, 
will be using netif_get_num_default_rss_queues() for the next version 
of the patch.
 

