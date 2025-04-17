Return-Path: <linux-hyperv+bounces-4955-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20CFA9188B
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248E95A11D2
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D15722618F;
	Thu, 17 Apr 2025 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0utEg9jG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SYEN2p5i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396314900F;
	Thu, 17 Apr 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884032; cv=none; b=OJgE8I9/pGMZx2Py3lgnq6tNEZw6ry/iODtQ7E4c1WCs/cMQSiUxHheOVErzG9vgXhp8UXui3n6BIcgXHP+UZOw52NY7tL/V2HncUC4tN7ueUCKuefOcxvxcyO8wBUDl3pW7K7dWyj/av/MSWTC5VxOXNdxsVFqplgVXdYI3r9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884032; c=relaxed/simple;
	bh=gBCWhHaYJt7IxdQVoQevVAf1TPYRlg9+br4MdJZH6vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S1A88m1XTs5HuiTGFPQD1dWtwwOIw4gIPQftUGjC8f7zZSJ3fd95x5AcJ71+ninIkgHPrvrox2aJncdkDrW6NPs0bFxLYQEmz9CxiZdzq6ut+wVaDCEDAk2fgL9kSgTtqZjthmlH1w2rC7Y1FveE2L9eCZCT0xtWS4E7LC5+804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0utEg9jG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SYEN2p5i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744884028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwp7yIk0XmtP5iY6T5jFpOlt63W6YtGrfCUkWNHR/Lo=;
	b=0utEg9jGanYt9LWfTQu6fUSd7lDoSNe4CIP6rKc+J2NVQPgMiK3kmc94ldnj7r7K+mPRO3
	8X/GIxTn7IG/qjO09G0cK37GvQVRuZQMLEueyN1/t365SRzvDKJ25pImZEznDohat4vBDN
	zIiM5bvOtlBgIjxb7bQfKMDUZdIyHennPnifMM4Byz6YHsYtonWWo7nnXp9hY7q61IHtMg
	7Lv4bkhoRXy0tFw910ufTLY0/w3ka0bH4BOaaZR4diiH8uvrVtuJFxXkDMf5UBOLSRjker
	uJZzROHgyNO3VIprf7P1bMbsIBQ1SQxPHEOiv7xjAw0kumCGMA5YrJhefVo4OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744884028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwp7yIk0XmtP5iY6T5jFpOlt63W6YtGrfCUkWNHR/Lo=;
	b=SYEN2p5iIzUMbGAQpOLql9MqGGmSRePe47QozGCcXB5ZOaC0TgnHEnkj9lY+hrWR3s1OK/
	1MH4kR48gl33JNBA==
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan
 Cameron <Jonathan.Cameron@huwei.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Shivamurthy Shastri
 <shivamurthy.shastri@linutronix.de>, Kevin Tian <kevin.tian@intel.com>,
 Long Li <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob
 Herring <robh@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Leon
 Romanovsky <leon@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Erni
 Sri Satya Vennela <ernis@linux.microsoft.com>, Peter Zijlstra
 <peterz@infradead.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>
Cc: Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH 1/2] PCI: hv: enable pci_hyperv to allow dynamic vector
 allocation
In-Reply-To: <1744817766-3134-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1744817747-2920-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1744817766-3134-1-git-send-email-shradhagupta@linux.microsoft.com>
Date: Thu, 17 Apr 2025 12:00:28 +0200
Message-ID: <87cydbrttv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 16 2025 at 08:36, Shradha Gupta wrote:
> For supporting dynamic MSI vector allocation by pci controllers, enabling
> the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
> to prepare the desc is needed. Export pci_msix_prepare_desc() to allow pci
> controllers like pci-hyperv to support dynamic MSI vector allocation.
> Also, add the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and use
> pci_msix_prepare_desc() in pci_hyperv controller

Seems your newline key is broken. Please structure changelogs properly
in paragraphs:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

>  drivers/pci/controller/pci-hyperv.c | 7 +++++--
>  drivers/pci/msi/irqdomain.c         | 5 +++--
>  include/linux/msi.h                 | 2 ++

This wants to be split into a patch which exports
pci_msix_prepare_desc() and one which enables the functionality in
PCI/HV.

Thanks,

        tglx

