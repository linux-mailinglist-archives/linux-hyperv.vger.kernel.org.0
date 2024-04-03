Return-Path: <linux-hyperv+bounces-1910-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B5896433
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 07:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912A71C224F1
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 05:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5C482DA;
	Wed,  3 Apr 2024 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pU/7X2fv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E7F2EB11;
	Wed,  3 Apr 2024 05:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712123033; cv=none; b=KD1dk062c2LxL3Xl3aZf0fkMd8bBaVRVQfq4d1AMmr7Xeg7vKRLqkmqu4N8Y+xOHuqASPLFnwBzXGHzisCOnd43yAaCx1E0ZPAs1+zBL6HV758W7j4RknTa/rmWMiXDGJU5b5jtKESOW8iIoMTccDEeORsk8uwn8KP28JqzpWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712123033; c=relaxed/simple;
	bh=Y2dZrNHPEhX+7//ljANF7dpLKPXIOdtiPvLZj5EPB4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQdwlPbjMNHLyundHGQt6PLasyJ7RunXJwgfZv6V0wF7FAtmhwgpuOJJNN0ZCjvxeO/AN3Vivlf46b1mwhXi2o84GcF2RgpjtXZBVJ4hVImWoGd2qdSLlMc4zClXRVGgOoqeXNqB6ZpQYH1CS+lRds7f089KN5r80LyEw6Z5sIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pU/7X2fv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 32B7E20E8C9A; Tue,  2 Apr 2024 22:43:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32B7E20E8C9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712123031;
	bh=eqr6ryp++wtR9G70yZFoMfybz5D1BNUxJE3/T3jBuO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pU/7X2fvQfV6xZ5FUwDBlbCukAKuKLO6HMZZqOHyPAFCQMlq4d8vTYehFu3q+Uxtx
	 Q2iineBG0ODQCg7cNt4Z670QJf3Q/TIbGt3pPs9N18lb7JM4hjb17XiiWPvmXc5UE4
	 /YCzfGdSlqEnNXH9mHIWKnf26/hmfrNCYHZdIcWw=
Date: Tue, 2 Apr 2024 22:43:51 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Alireza Dabagh <alid@microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] net :mana : Add per-cpu stats for MANA
 device
Message-ID: <20240403054351.GA18633@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240307090145.2fc7aa2e@kernel.org>
 <CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
 <20240308112244.391b3779@kernel.org>
 <20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240314025720.GA13853@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240314112734.5f1c9f7e@kernel.org>
 <DM6PR21MB14819A8CDB1431EBF88216ABCA292@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240314120528.1ac154d1@kernel.org>
 <SA3PR21MB39636B2DBFA00CFE3AD84845C1292@SA3PR21MB3963.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA3PR21MB39636B2DBFA00CFE3AD84845C1292@SA3PR21MB3963.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi all,
I have a newer version of this patch with netlink implementation ready, to support the usecase of per-cpu stats for RSS handling and imbalance investigations. Please let me know if we can proceed with that.

Thanks and regards,
Shradha.

On Thu, Mar 14, 2024 at 08:01:24PM +0000, Alireza Dabagh wrote:
> Per processor network stats have been supported on netvsc and Mellanox NICs for years. They are also supported on Windows.
> 
> I routinely use these stats to rule in/out the issues with RSS imbalance due to either NIC not handling RSS correctly, incorrect MSI-X affinity, or not having enough entropy in flows. 
> 
> And yes, I perfectly understand that there are cases that packets received on processor x are processed (in tcp/ip stack) on processor y. But in many cases, there is a correlation between individual processor utilization and the processor where these packets are received on by the NIC.
> 
> -thanks, ali
> (some suggested that I do mention on this thread that I am one of the original inventors of RSS. So there you have it. Personally I don't think that telling people "I invented the damn thing and I know what I am talking about" is the right way to handle this.) 
> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org> 
> Sent: Thursday, March 14, 2024 12:05 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Shradha Gupta <shradhagupta@microsoft.com>; linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-rdma@vger.kernel.org; netdev@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Ajay Sharma <sharmaajay@microsoft.com>; Leon Romanovsky <leon@kernel.org>; Thomas Gleixner <tglx@linutronix.de>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>; KY Srinivasan <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley <mikelley@microsoft.com>; Alireza Dabagh <alid@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH] net :mana : Add per-cpu stats for MANA device
> 
> On Thu, 14 Mar 2024 18:54:31 +0000 Haiyang Zhang wrote:
> > We understand irqbalance may be a "bad idea", and recommended some 
> > customers to disable it when having problems with it... But it's still 
> > enabled by default, and we cannot let all distro vendors and custom 
> > image makers to disable the irqbalance. So, our host- networking team 
> > is eager to have per-CPU stats for analyzing CPU usage related to 
> > irqbalance or other issues.
> 
> You need a use case to get the stats upstream.
> "CPU usage related to irqbalance or other issues" is both too vague, and irqbalance is a user space problem.

