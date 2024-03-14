Return-Path: <linux-hyperv+bounces-1757-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716FB87C29F
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 19:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F421C211F5
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7987745C9;
	Thu, 14 Mar 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcgIDNo6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66FD1A38D0;
	Thu, 14 Mar 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440856; cv=none; b=uEMakciQGoqU96NluZsVAosGoACRx+mI9vMfM7NJeFG+TojDvQYNZhkcWnj03SwKyA0OBW9Ipa+tdsCVqxTrs/acGoVl1s+uDvKIhxLhbKEM3tyxHOafQAqi/WwVl8wpn+NLJfT7UuadOVUOuBZOO76vKf18KoxwXlUrR1DytLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440856; c=relaxed/simple;
	bh=wvZQ6EkK3Zr78gZKY6mbHSxOYjMQ/6C07pm5tHfcalc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPG6gHrMruWzQSGGUi2CRrahFsAQjZChMQUDwgvtCpIRtmSZ6DfWFhzJ4BUViennWyiRskm9HBiAwVsCwCJfkGax/xMHEyJM309smc7JfhqW2K//wFBo+02pMZTFneYCgg2ujxD4KmYJxSNWte8thVXU3pv/Xa/xbIL4HsY6J/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcgIDNo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD3CC433C7;
	Thu, 14 Mar 2024 18:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440856;
	bh=wvZQ6EkK3Zr78gZKY6mbHSxOYjMQ/6C07pm5tHfcalc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pcgIDNo6+Jx9g1FVdyq37yqerQyrpShtUOjQ9n27jtT7YMvFQeCuV1qZCgb3XcWQK
	 Q/v3tSCHmPIW56Zim33p+Env+4YdDQ5ztgPOHSZblgNt+Rv3GNKuzlRGtbcyC6jgj4
	 /af/RGyDWDWZirAiycP/RBEe58UHQvEe45XUragt5UhSnnTk3kM0COQ25ickIbMGkP
	 EGQ5Mq8rpuCWU09X2cKeOeJiuTCSnT6SdndVccRrpIm9eGM15t5TpZmzKZ8ANms1Om
	 3nW5JwaAM1NxFDPdn05JGGb0VsDv2KFc3PU+Z+qi0kPracqutTqUlTyvdwEtCHres0
	 BA13Ud52d9jNA==
Date: Thu, 14 Mar 2024 11:27:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Shradha Gupta
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
Message-ID: <20240314112734.5f1c9f7e@kernel.org>
In-Reply-To: <20240314025720.GA13853@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20240314025720.GA13853@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 19:57:20 -0700 Shradha Gupta wrote:
> Default interrupts affinity for each queue:
> 
>  25:          1        103          0    2989138  Hyper-V PCIe MSI 4138200989697-edge      mana_q0@pci:7870:00:00.0
>  26:          0          1    4005360          0  Hyper-V PCIe MSI 4138200989698-edge      mana_q1@pci:7870:00:00.0
>  27:          0          0          1    2997584  Hyper-V PCIe MSI 4138200989699-edge      mana_q2@pci:7870:00:00.0
>  28:    3565461          0          0          1  Hyper-V PCIe MSI 4138200989700-edge      mana_q3
> @pci:7870:00:00.0
> 
> As seen the CPU-queue mapping is not 1:1, Queue 0 and Queue 2 are both mapped 
> to cpu3. From this knowledge we can figure out the total RX stats processed by
> each CPU by adding the values of mana_q0 and mana_q2 stats for cpu3. But if
> this data changes dynamically using irqbalance or smp_affinity file edits, the
> above assumption fails. 
> 
> Interrupt affinity for mana_q2 changes and the affinity table looks as follows
>  25:          1        103          0    3038084  Hyper-V PCIe MSI 4138200989697-edge      mana_q0@pci:7870:00:00.0
>  26:          0          1    4012447          0  Hyper-V PCIe MSI 4138200989698-edge      mana_q1@pci:7870:00:00.0
>  27:     157181         10          1    3007990  Hyper-V PCIe MSI 4138200989699-edge      mana_q2@pci:7870:00:00.0
>  28:    3593858          0          0          1  Hyper-V PCIe MSI 4138200989700-edge      mana_q3@pci:7870:00:00.0 
> 
> And during this time we might end up calculating the per-CPU stats incorrectly,
> messing up the understanding of CPU usage by MANA driver that is consumed by 
> monitoring services. 

Like Stephen said, forget about irqbalance for networking.

Assume that the IRQs are affinitized and XPS set, correctly.

Now, presumably you can use your pcpu stats to "trade queues",
e.g. 4 CPUs / 4 queues, if CPU 0 insists on using queue 1
instead of queue 0, you can swap the 0 <> 1 assignment.
That's just an example of an "algorithm", maybe you have other
use cases. But if the problem is "user runs broken irqbalance"
the solution is not in the kernel...

