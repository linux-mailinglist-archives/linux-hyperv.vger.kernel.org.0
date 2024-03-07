Return-Path: <linux-hyperv+bounces-1675-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23738754C6
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 18:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E741F22A7C
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1B12FF96;
	Thu,  7 Mar 2024 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V05fzXYX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F912FF7C;
	Thu,  7 Mar 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830908; cv=none; b=o0gxhTx+Y1BWLGRrVxMd6iaoMTZ1NgoaT6OnSpIV2KXvoZTC6txKHcH1jm/leaRuGUMkUdk0LnpXrYKRW8tG90PWqZa5LkxbUUKzw6JhtA79/HDgeEvzKYJAvmwlT3asZMQm7VsUGuSdeD7afwoQw51tIr2FyAeydyGVsU1dM2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830908; c=relaxed/simple;
	bh=7G4vPcy1mVijMS9YptzTs4Sy9VY1PByVCAyawRbldZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttkpggNCg8EBOJC0M5fVV4tc32asURq42SX8MhOMW4ej1N/rLBfKUFc1omxgCsBc7WVFO0re9+td2aZcjVcmgzRkLSeenhH4r1xbBm3jebj+c5lmVtlGRf57mcusf4qW95YLojCjGcNp2P9cul9SE9yerw0i4v/bg22bZTm7VzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V05fzXYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FAEC433F1;
	Thu,  7 Mar 2024 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709830907;
	bh=7G4vPcy1mVijMS9YptzTs4Sy9VY1PByVCAyawRbldZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V05fzXYXPZJtUZZkphCUMCbcmNTYxpe5srx+UWvP1T0xxlIrhwkrlFqnCihMnLfRw
	 mW1+jEfwzbc4uzz672NEfHJ9q1yUTmrzpvdawpMZVsM8khCyt6WqHDK4tMQh/5/0Dz
	 3P17nayM+w019SlqInHJRrmrRbVc6NnC/xg3Cu8XeVHkJhSDGEb7noBhMAWOCJlpzf
	 t6xm9DHf4fX+IkQPD4l7qkm8Uz64u/6vBJIozxfdHxS/sB1D50E1cRzyTyWLCEOlNB
	 nx8x8+trQODCI8eFY2DxsbuF2pEfMFl1LJHkxlHrLyzplpH/sapqinQqOBnfXgc9NA
	 5n+MloVbNUYBg==
Date: Thu, 7 Mar 2024 09:01:45 -0800
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
Message-ID: <20240307090145.2fc7aa2e@kernel.org>
In-Reply-To: <DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 15:49:15 +0000 Haiyang Zhang wrote:
> > > Extend 'ethtool -S' output for mana devices to include per-CPU packet
> > > stats  
> > 
> > But why? You already have per queue stats.  
> Yes. But the q to cpu binding is dynamic, we also want the per-CPU stat 
> to analyze the CPU usage by counting the packets and bytes on each CPU.

Dynamic is a bit of an exaggeration, right? On a well-configured system
each CPU should use a single queue assigned thru XPS. And for manual
debug bpftrace should serve the purpose quite well.

Please note that you can't use num_present_cpus() to size stats in
ethtool -S , you have to use possible_cpus(), because the retrieval
of the stats is done in a multi-syscall fashion and there are no
explicit lengths in the API. So you must always report all possible
stats, not just currently active :(

