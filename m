Return-Path: <linux-hyperv+bounces-6169-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C400DAFF556
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 01:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21EE3A7D46
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 23:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF0246BD7;
	Wed,  9 Jul 2025 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrQfy/0j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96882E55B;
	Wed,  9 Jul 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752103496; cv=none; b=Os0GanJ2POmNbxWYjmdVDE5Lu9ldilAlAj9IUS0BTsRTtbO4jKlR0KuBZWX+LZ9sgURAB2eIQ1zBhNey+4cbLtR31L1M57h6ffDf9F9wuOrJfAc6ablqhwXdAs/OJ84msQh1Wu3o77xHgmZ7X6QLt2FJ+j3IMVPkGUAhUL6zsEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752103496; c=relaxed/simple;
	bh=66rawdc3Mz7H+A7CTXyf5/QM2sFvP2bbZjXqhGgjzCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqaDiVBLlb3MrUeJP8Q2yKS94Oh+y+ugr7DnVsqTK8k4+q3Aa4DuFPEhYetdAtJf2cpFowUnWcHoH/aA2MBfXd50pQAYmGkecIci4IQ6qWu36vbVeHrGMxOpY/yKUo45qoK+A8jB+XOW3+gPlH2eq5xmqTKP8OUpqhbGB06MQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrQfy/0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC87C4CEEF;
	Wed,  9 Jul 2025 23:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752103495;
	bh=66rawdc3Mz7H+A7CTXyf5/QM2sFvP2bbZjXqhGgjzCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrQfy/0j1vDof7KV445cxDl9o0bXazLoAERKFPpUV3jOhOfx1yw6VyebseKopMcTN
	 ZYyrK40JxgzhnbPSV6Cfm4OUCI2fUm6FaI8+J9bjDSHktWgcJhyYUGkTynSbOoSqS7
	 tt7z0zdDxistEw3BdRQwHQx84RxRabnwZp6GTNbh+sx1YRykrFQ3tGn1VYFtnupBkR
	 RZTwScnVJlc5PcASxVCG8w2ObrzH1t+2YjTKC6ZzyUVwtG5A6vmkPu2Z1RwvQhNTrb
	 u9fSm+yiCxA5lPwJ2L/rNgW54Mto4PPQyH61dsJyFYwbKLt8UdvGlADMDz4xhIJp7C
	 OCT1fVxfh0YJQ==
Date: Wed, 9 Jul 2025 23:24:53 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	namjain@microsoft.com, "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH] Drivers: hv: Fix the check for HYPERVISOR_CALLBACK_VECTOR
Message-ID: <aG76RTo4aleKdqbi@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250707084322.1763-1-namjain@linux.microsoft.com>
 <5f3ca2ac-cf06-4c81-89bd-e8685b222aa9@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3ca2ac-cf06-4c81-89bd-e8685b222aa9@linux.microsoft.com>

On Mon, Jul 07, 2025 at 10:58:03AM -0700, Roman Kisel wrote:
> 
> 
> On 7/7/2025 1:43 AM, Naman Jain wrote:
> > __is_defined(HYPERVISOR_CALLBACK_VECTOR) would return 1, only if
> > HYPERVISOR_CALLBACK_VECTOR macro is defined as 1. However its value is
> > 0xf3 and this leads to __is_defined() returning 0. The expectation
> > was to just check whether this MACRO is defined or not and get 1 if
> > it's defined. Replace __is_defined with #ifdef blocks instead to
> > fix it.
> > 
> > Fixes: 1dc5df133b98 ("Drivers: hv: vmbus: Get the IRQ number from DeviceTree")
> > Cc: stable@kernel.org
> > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > ---
> 
> [...]
> 
> Appreciate fixing that! From what I learned from you, x86 was broken.
> Very likely I did a smoke test there only while focusing on arm64. Sorry
> about that, thanks again!!
> 
> LGTM.
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com
> 

Applied to hyperv-fixes. Thanks!


