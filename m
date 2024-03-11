Return-Path: <linux-hyperv+bounces-1702-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3D2877A4B
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 05:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B6D1C20C2D
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 04:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E3187F;
	Mon, 11 Mar 2024 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cHChZkNW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733871860;
	Mon, 11 Mar 2024 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710130791; cv=none; b=Z0msIyeSi6JYXWCOdqCnkAd+UDFssOpRc8SdHzUicB2df0KrFXlDFDkNspjUaFcn5QOss43gl2k2Dwa0a0mQlVsn7wZVyTG7CrlO405LEIF7DQy/n2qHjr74iLpheKwvr7y6IDnvXRKuoqFcQTRGPoyUlFJVJfy9sZgzcieco4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710130791; c=relaxed/simple;
	bh=TfT4qUsYYO3TPRTV9dSEUTKXFozwef3QMPa20ojB+1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaM5LPbOCyU8x3FyxyOI5rK9w5DBLt6vhADhrir/S9t2XrpqrLXaAJ4LM7jNhcAg1ddlbHmsCqlGNUSb2TZnai0rKeZbrM2e5uAA8P+a89o2JQ/8ocq0/O7oXC1CFPF2Cgnux+bX/ZS2zdIbu4qQCebtc3x6kjo9kevva40l2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cHChZkNW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 1937B20B74C0; Sun, 10 Mar 2024 21:19:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1937B20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710130790;
	bh=zJSmJpS2VA8+3zoHUmrWNe/kRtWurXh4YXWEvTl15fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHChZkNWLo5P90MreNlBgmPyAGhFP7K/gZqb3yil3ATXKV3J0kuPEW5u0dDUoCfAt
	 T87L8KZleIzdP8qrg4sC0zFB0CHsdPk2gQCEmHYvTR9yOaIZ73W0lcJh/Sxg83iCJM
	 xVHhLtsPiuTxR4mMT5pAafvbsX0C+ZFld3CLDaCw=
Date: Sun, 10 Mar 2024 21:19:50 -0700
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
Message-ID: <20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240307072923.6cc8a2ba@kernel.org>
 <DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240307090145.2fc7aa2e@kernel.org>
 <CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
 <20240308112244.391b3779@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308112244.391b3779@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Mar 08, 2024 at 11:22:44AM -0800, Jakub Kicinski wrote:
> On Fri, 8 Mar 2024 18:51:58 +0000 Haiyang Zhang wrote:
> > > Dynamic is a bit of an exaggeration, right? On a well-configured system
> > > each CPU should use a single queue assigned thru XPS. And for manual
> > > debug bpftrace should serve the purpose quite well.  
> > 
> > Some programs, like irqbalancer can dynamically change the CPU affinity, 
> > so we want to add the per-CPU counters for better understanding of the CPU 
> > usage.
> 
> Do you have experimental data showing this making a difference
> in production?
Sure, will try to get that data for this discussion
> 
> Seems unlikely, but if it does work we should enable it for all
> devices, no driver by driver.
You mean, if the usecase seems valid we should try to extend the framework
mentioned by Rahul (https://lore.kernel.org/lkml/20240307072923.6cc8a2ba@kernel.org/)
to include these stats as well?
Will explore this a bit more and update. Thanks.

