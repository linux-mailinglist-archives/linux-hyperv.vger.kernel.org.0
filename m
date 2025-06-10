Return-Path: <linux-hyperv+bounces-5834-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A1AD44F1
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 23:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0D93A6D99
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEB1284B3E;
	Tue, 10 Jun 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft4a7voO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F89266B6B;
	Tue, 10 Jun 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591649; cv=none; b=k+ALiJaXnqe/BKJ9IClvIhnNZ2zztsLq7fgQIbKJZ8MMf0o89tYLkdk5fXEVx4e86he065LJLvrXIW+ajQBA96CzOHD18VloNLmVVM85WPT2nMwQwP+yEb537NOSGwSDKnY/pOTdtulUnpqFyrbfsS6AMSEatavmmqcQyoixr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591649; c=relaxed/simple;
	bh=BZq6T1x4KIZtBIcys6uVoEwFxLpJVCHmantsmFcGQDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5FBasJ99GJ5+g17sChNtEWAVsROJrIFhvrgslUCGEO54bX9foHsjJ4QZr69SgOmeRI2MKOUE53u6NhLg5V8uj9mDBswk5XoQDMzxzZL4CJNvNTUxOJUzUJw1uPyTzfqniaILtnuVF9hqtCVlCqMQxg4N4OXi0fHzV5SJ3USWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft4a7voO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAF8C4CEED;
	Tue, 10 Jun 2025 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749591649;
	bh=BZq6T1x4KIZtBIcys6uVoEwFxLpJVCHmantsmFcGQDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ft4a7voOspcJwOWlf2EJmAVYLdTwes/6C5mrPYEB+sfdxJnHknBXJDch63NcfTcya
	 uw+ct359WqwFSpW0sL4Ap7YbemhUGP00JxAitl+L+b1D8ZBQQzy0ajLO0L0TzuJRye
	 9mKDxnSpHoy4oXH51K1FDYuKPsqblCQ2S0FWOcXtBJpk4H046OHLD1wLZ0BeyCQ1Ni
	 twP0D0mMA1f/eHtzCvB3Zk4J4qOEhYZY/24EU8IIIBylNkIwaNYok7PyxQIDkV6Cqn
	 srrMJJtUnzfPXP6DSVfLeYDkb3oYr9zYDIEm3vijDdolOy1X+NHkyZZtMMEdO44ApE
	 rtgj5rgUhxTcQ==
Date: Tue, 10 Jun 2025 14:40:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>, Yury Norov
 <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Cameron
 <Jonathan.Cameron@huwei.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, Long Li
 <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?UTF-8?B?V2lsY3p577+9fkRz?=
 =?UTF-8?B?a2k=?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>, Maxim
 Levitsky <mlevitsk@redhat.com>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Paul Rosswurm
 <paulros@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v5 0/5] Allow dyn MSI-X vector allocation of MANA
Message-ID: <20250610144046.1deba9f3@kernel.org>
In-Reply-To: <1749476901-27251-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1749476901-27251-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 06:48:21 -0700 Shradha Gupta wrote:
> Since this patchset has patches from PCI and net tree, I am not entirely
> sure what should be the target tree. Any suggestions/recommendations on
> the same are welcomed.

Could you put these on a branch based on v6.16-rc1 ?
That why if someone else needs them before the next merge window
they can pull that branch. The patches look fine to me.

