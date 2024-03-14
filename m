Return-Path: <linux-hyperv+bounces-1760-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640587C34C
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 20:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BAB282E4D
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8815E74E23;
	Thu, 14 Mar 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7lgmnIb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5F43AD7;
	Thu, 14 Mar 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710443131; cv=none; b=alpOaqKMt4QRCo4lJ2CdppOnsZq1W3Kg0TIJYOSIOahS+zPoVKQorEXoWYzsa/CKRBaoYpSdVz9PbWB005OGVIhOl+Il09YLd+ZPAvCJUF9UqhneDjWbMX8A0zvhHTQp02w6CzWGPRT8FTerAwMpuE1HA/9rqK6P/P3ApPMZ1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710443131; c=relaxed/simple;
	bh=qZFoNjK7/mZ/PeVekRSJtmaHMzHJsH0JeAgm3Vvoj2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqlGr8IMWV7ZucdcOrLxKA0p5faZVw1df8nAfmPf5g8A5nSz+nju8ROPQkvqsX93KXv1Bu0QqKJVYCBJ7hINFwlxK+XFZkdiLY35oe/1VTK8cW2JrlpqEPvr4RJGZPhcBHB8OOin/cN7IrAwZdm5L5xEP0BhcqlzOrpZ11FpyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7lgmnIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A82C433C7;
	Thu, 14 Mar 2024 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710443130;
	bh=qZFoNjK7/mZ/PeVekRSJtmaHMzHJsH0JeAgm3Vvoj2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s7lgmnIbdC1nn4gqbhJLDJTjGfmbSXQqbPqdIJXWyAJ6eC5VxPE5zPozOy63sgPTo
	 WAQfOo6rhNNpoVir6ADJCp0Hb+PLaFiN5pplALmNSYhP2Bj+KHjWrUcvdJolWmX7Zm
	 8wptTSjXcVsgOXdp+Dk6rtWACB4kwZlsFSQoSOb1WlTDH9JHdEmy9kSndJwaSytM3/
	 tivwnUBURT9aaQ2WZg4k7HaU0TG3c8wZ3WbIDY60o3ROiBeGzCa9+n9xuY7BNr7RNF
	 /uKrdsxFOMyuCxZZ9ZJb9wr0YTUDfV/slLXyHiVdu+K5V2gMcAiAs0a8VwGjmoRIQa
	 Q4/2sv9RPr3/A==
Date: Thu, 14 Mar 2024 12:05:28 -0700
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
 <mikelley@microsoft.com>, Alireza Dabagh <alid@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240314120528.1ac154d1@kernel.org>
In-Reply-To: <DM6PR21MB14819A8CDB1431EBF88216ABCA292@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20240314025720.GA13853@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20240314112734.5f1c9f7e@kernel.org>
	<DM6PR21MB14819A8CDB1431EBF88216ABCA292@DM6PR21MB1481.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 18:54:31 +0000 Haiyang Zhang wrote:
> We understand irqbalance may be a "bad idea", and recommended some 
> customers to disable it when having problems with it... But it's 
> still enabled by default, and we cannot let all distro vendors 
> and custom image makers to disable the irqbalance. So, our host-
> networking team is eager to have per-CPU stats for analyzing CPU 
> usage related to irqbalance or other issues.

You need a use case to get the stats upstream.
"CPU usage related to irqbalance or other issues" is both too vague,
and irqbalance is a user space problem.

