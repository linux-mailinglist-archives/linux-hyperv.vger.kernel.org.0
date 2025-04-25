Return-Path: <linux-hyperv+bounces-5149-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261DEA9CE3E
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECFA7AB225
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E61B423E;
	Fri, 25 Apr 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfMLaA9S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D41A9B53;
	Fri, 25 Apr 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598958; cv=none; b=g93fkORlKr4MQIVghWJFbC2CV+PTPLW15h5/J9ScNMEVFKlTh3NDuq7E9mjldm2LujrJPWWFmWls0NUNSMA6cbz8iYJtR28C4mTp9OUSwFa19PgwzY2lWF7gqlIimnbSCUKjbSOkIAJ/u1RvCTwsooFCNudv4KYL4VPF4aLRQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598958; c=relaxed/simple;
	bh=FsR4f8RipLNPNkpkDoIHdHQnHxmjYdk4APWukvEffD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQNf5yveGqTYwVry1havz4+TP9W1yj/T+guuf7IAW5u0r2beBMbN95vdBtHUZmHZxqp85TWWTbj82QmXHSsLjGS8yIsDxucoz9KXV5R2Bji2OvF+GZPI9g/48crOav1gfPRfshS2RToC1dO8lFnz1lgg7OPlpKP0LmS8OaEyFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfMLaA9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D0BC4CEE4;
	Fri, 25 Apr 2025 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745598958;
	bh=FsR4f8RipLNPNkpkDoIHdHQnHxmjYdk4APWukvEffD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RfMLaA9SCMn4O8Dq+CtX3lf7Nc63kO8LsATyxdnS8mFHA1v3NsH01veC5keY6dSlY
	 OXb8/P3EgnNVNJyHzdUm32fZMqhPSPFGNiAzBLNkIxl95k1pXuot+Xg43iV6AuPcV1
	 /5pEsEs9agtKxVq+jTtx01tfc+zjCkYA6cnu0KXhr6tntRZUEwvDZdve5sqKFO8Cq5
	 X9fL7UBMFLaHJoZ3kdY5dprxAfAQInGL4S9fB17varuwuwSyYuqknykqYdrtOd3nmI
	 x3B9V02oOypHvO49Nt3Tmwev0BWSndmvEKtaXa+fm+nwlVScJ85vzcwCFD+M5KZEWB
	 rOeXBX7TXxvyw==
Date: Fri, 25 Apr 2025 09:35:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>, Yury Norov
 <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Cameron
 <Jonathan.Cameron@huwei.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, Long Li
 <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Leon
 Romanovsky <leon@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Erni
 Sri Satya Vennela <ernis@linux.microsoft.com>, Peter Zijlstra
 <peterz@infradead.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Paul Rosswurm <paulros@microsoft.com>, Shradha Gupta
 <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Message-ID: <20250425093556.30104eda@kernel.org>
In-Reply-To: <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
	<1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 03:54:38 -0700 Shradha Gupta wrote:
> +	spin_lock_irqsave(&gc->irq_ctxs_lock, flags);
> +	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);

Could you please test your submissions on a kernel with debug options
enabled? Thank you!
-- 
pw-bot: cr

