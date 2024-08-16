Return-Path: <linux-hyperv+bounces-2779-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1B2954D21
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Aug 2024 16:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881A128A19B
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Aug 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ADE1BD4F1;
	Fri, 16 Aug 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DKv5Jqpc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E281B8EA0;
	Fri, 16 Aug 2024 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819731; cv=none; b=cwt1vZfnG/YXh3p0Sz2HFsF2+Y9cEaoaEqJlqY0rniflsnVU7Gxfm+9sFS1BUZ44Sq3W/xNcNwZtBkod4RyX9P6Iu/mntraZm/ZtVd1w37Tv1ZzFKp4GLX+iqzAtXLT9iFK7CclYVY/2T0epQ1nWucZI985En4zOugj1iZCFFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819731; c=relaxed/simple;
	bh=wUUZt68W5TSFTs8g2OOy4LOdhMv3gikKhPW9Fz33RZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlVs5ME293QXTgEguaq5ypHB/LC9z+HtGHw3tGyprGtcwYcX4hutryuWswKbAli8DfAAHXNxNoA1lfklQCbAfKuNAUZqUbsz45FuBOWRh/uh+24LD76xIFGrqlNciT4lnARiDycZeSMS5fy1djEo8TjiKY1UJI4Kt50FwT0U7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DKv5Jqpc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4D7EB20B7165; Fri, 16 Aug 2024 07:48:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D7EB20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723819727;
	bh=V+dT4zs9I5lkBTlL0snnuXlkW9cxOnIPH3HT0S1qiX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKv5JqpcEsy1dMqJFPcsn6ex2ohRwhQPjJRszVDKZLbaYuuX5hUlYs6fraWAXLps0
	 IW4qm6frZoXjavb1FCYHGuqYrmRCkiFvEElwTrMozFTUs4IDkp14yZ/kB71EjgXLXd
	 A62/HWSS9yW6RGLRN+W0EEjXKJsyF0TG0mKgUSIk=
Date: Fri, 16 Aug 2024 07:48:47 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com
Subject: Re: [PATCH v2] net: netvsc: Update default VMBus channels
Message-ID: <20240816144847.GA9829@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
 <20240815090856.7f8ec005@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815090856.7f8ec005@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 15, 2024 at 09:08:56AM -0700, Jakub Kicinski wrote:
> On Wed, 14 Aug 2024 09:59:13 -0700 Erni Sri Satya Vennela wrote:
> > Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> > Linux netvsc from 8 to 16 to align with Azure Windows VM
> > and improve networking throughput.
> > 
> > For VMs having less than 16 vCPUS, the channels depend
> > on number of vCPUs. Between 16 to 32 vCPUs, the channels
> > default to VRSS_CHANNEL_DEFAULT. For greater than 32 vCPUs,
> > set the channels to number of physical cores / 2 as a way
> > to optimize CPU resource utilization and scale for high-end
> > processors with many cores.
> > Maximum number of channels are by default set to 64.
> > 
> > Based on this change the subchannel creation would change as follows:
> > 
> > -------------------------------------------------------------
> > |No. of vCPU	|dev_info->num_chn	|subchannel created |
> > -------------------------------------------------------------
> > |  0-16		|	16		|	vCPU	    |
> > | >16 & <=32	|	16		|	16          |
> > | >32 & <=128	|	vCPU/2		|	vCPU/2      |
> > | >128		|	vCPU/2		|	64          |
> > -------------------------------------------------------------
> > 
> > Performance tests showed significant improvement in throughput:
> > - 0.54% for 16 vCPUs
> > - 0.83% for 32 vCPUs
> > - 1.76% for 48 vCPUs
> > - 10.35% for 64 vCPUs
> > - 13.47% for 96 vCPUs
> 
> Is there anything that needs clarifying in my feedback on v1?
> 
> https://lore.kernel.org/all/20240807201857.445f9f95@kernel.org/
> 
> Ignoring maintainer feedback is known to result in angry outbursts.

I sincerely apologize for the miss on my part. I will make sure this
never happens again. As Haiyang mentioned, we were trying to use a
similar logic as in netif_get_num_default_rss_queues(), and trying to
make sure there are no potential regressions. I will work on Michael's
and  Haiyang's follow up comments. 
Please let us know your opinion on the same.

