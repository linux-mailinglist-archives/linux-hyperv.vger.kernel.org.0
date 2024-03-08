Return-Path: <linux-hyperv+bounces-1690-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F90876B28
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 20:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E001F21457
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02BE5A4CD;
	Fri,  8 Mar 2024 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLbL0vLh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73E25774;
	Fri,  8 Mar 2024 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925766; cv=none; b=K7oLXBWBrc/6V6sqgFo3axL4wgZDcRBr5JaSbfMTIzVkwnQ8LagndnF9Rf49A7u3Ohufje03AtQyEsTG2JsV9p55heooSZ85xlB5nxyFDQTPDBbXGbRJmXi/vmyM57y6ZvfS0iRyqJ9MSMUKjIsMVtPoUpSZ8+s6cWxRBGw434I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925766; c=relaxed/simple;
	bh=YeZa26lHQuEywHRgaJ3tIFPzhotZ2Y6RUoWM5+cEY0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lwi2REX0GkSgXtkhbqSGmBQ3CNTHwgse2ZSJzAyhNVICuLa1qi9oo/ADUgQbod5NllSorjp+ezne23T39QSl6E4Svz2HhTACly/ejhwZbz2b2w0IoR5fLHBHrtRSbCLeGiTgQ3tmouCBquEcoBM3qdYI/Tj35S5W/n8hlEZqgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLbL0vLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E6EC433C7;
	Fri,  8 Mar 2024 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709925766;
	bh=YeZa26lHQuEywHRgaJ3tIFPzhotZ2Y6RUoWM5+cEY0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mLbL0vLh3uxjSc/tz2NW1uqzXYnWbKTsF5nd84lYxxnQfwMFNWjZz4eu9d4we7rYo
	 75ffhr8hWrPH3CJoYeotCnMMIZ/VdJA051iW4mRr7PKoXHxchiiDLR0UVPpaFNeoxx
	 lSlbUyKA+DtFiLuMRT0YuELSqE1IbuozBgrnD7nJ4NwWiuPfJ48TSnELBbVE9sSE5G
	 VGKsHQYawfJIGZmgF8N5IPP9GpslurnKFXS3WL/qIwlK4IySJW7rPzzrrZk81xthoa
	 MRulNesxNJbP9SVv7Z5oSWu9ialLhrHodc+Ob83YyQNCdxZsjUYk01B5P1GNuZLZU/
	 e0Q6CoEY53dwQ==
Date: Fri, 8 Mar 2024 11:22:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ajay Sharma <sharmaajay@microsoft.com>, Leon
 Romanovsky <leon@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Michael Kelley
 <mikelley@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240308112244.391b3779@kernel.org>
In-Reply-To: <CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 18:51:58 +0000 Haiyang Zhang wrote:
> > Dynamic is a bit of an exaggeration, right? On a well-configured system
> > each CPU should use a single queue assigned thru XPS. And for manual
> > debug bpftrace should serve the purpose quite well.  
> 
> Some programs, like irqbalancer can dynamically change the CPU affinity, 
> so we want to add the per-CPU counters for better understanding of the CPU 
> usage.

Do you have experimental data showing this making a difference
in production?

Seems unlikely, but if it does work we should enable it for all
devices, no driver by driver.

