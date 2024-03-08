Return-Path: <linux-hyperv+bounces-1684-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D6875D90
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 06:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976F5283CB3
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 05:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BE32E647;
	Fri,  8 Mar 2024 05:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PTfa9+jt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8032564;
	Fri,  8 Mar 2024 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709875865; cv=none; b=XGNas+N2e3NOLOB41tmxc6zTx4NHVA+cKlPy0ZxNbMtTh4iIQnTGqzPn+nCSbpQCvzqHgIEB8AoRvEavIGeY+Hp+mHeNkkhtn6nfDOPDxm1xLFOGRnG74Th6N5J6KCZC2eQCkvPl7nXO/MWL+8m/GKdxz/X/17k7TdJ7f0RITO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709875865; c=relaxed/simple;
	bh=4QA+qfkTVt82T4MJ6mB+KmRrnBaFSpMS1IGiL/1JjJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMoSf8/pMBCSoPeCal5+i+72QuACjYleabrCtrwzpSTT7Lc6yj/Dqs9ViKsSEhMlpmlazWy04NxI1tAJJOK8PoVlil6zwIMCmVUFFONfZFQpRF5UdJYIxAYUVlpxdJHRyzoY6affHUFACS/nVJP4jy7NRxeLgVvpKWJBnZuRA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PTfa9+jt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 238CE20B74C0; Thu,  7 Mar 2024 21:30:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 238CE20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709875856;
	bh=u2kPWb3IsqjyN6FSEPkizuq4H3ww/4ROAGYubZNDML8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTfa9+jt0Q6hKwjBdaXtnHtFyd5ME7DtKa/Q8PYhW+s6pOgjSxmzLDFquvbnH1yh7
	 4oaRwleRRtKqtNLao+7oXEFtJ67BPVLXXgglcbspIIUogItaQ2qhuJVT9N9+697WD0
	 vnRBA/gNCCbPWUJF689KDtyKXn9qEWGZjtVTqdr8=
Date: Thu, 7 Mar 2024 21:30:56 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
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
	Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240308053056.GA16944@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240307072923.6cc8a2ba@kernel.org>
 <DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240307090145.2fc7aa2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307090145.2fc7aa2e@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

Thanks for the comments, I am sending out a newer version with these fixes.

On Thu, Mar 07, 2024 at 09:01:45AM -0800, Jakub Kicinski wrote:
> On Thu, 7 Mar 2024 15:49:15 +0000 Haiyang Zhang wrote:
> > > > Extend 'ethtool -S' output for mana devices to include per-CPU packet
> > > > stats  
> > > 
> > > But why? You already have per queue stats.  
> > Yes. But the q to cpu binding is dynamic, we also want the per-CPU stat 
> > to analyze the CPU usage by counting the packets and bytes on each CPU.
> 
> Dynamic is a bit of an exaggeration, right? On a well-configured system
> each CPU should use a single queue assigned thru XPS. And for manual
> debug bpftrace should serve the purpose quite well.
> 
> Please note that you can't use num_present_cpus() to size stats in
> ethtool -S , you have to use possible_cpus(), because the retrieval
> of the stats is done in a multi-syscall fashion and there are no
> explicit lengths in the API. So you must always report all possible
> stats, not just currently active :(

