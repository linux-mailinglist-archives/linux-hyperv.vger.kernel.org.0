Return-Path: <linux-hyperv+bounces-4946-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD8A90B59
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268133AB540
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Apr 2025 18:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E102236EF;
	Wed, 16 Apr 2025 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPdfzYqt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E9214A9F;
	Wed, 16 Apr 2025 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828371; cv=none; b=N1LoyJz4eQxwE07bRI0gwyZ9uytHZPwxdq2JJtZezOE3SCHByw20K+BSbLsSTJ5vszAMeIFI+jyzWwgy6xYd4BgPSckh+oJeFVIlOGdNSbDxwHFqnirzxAUSIZ5qTLb4sZyMS5UjKM70qb7FaPNomfCJr1/ssb+O8x3xIf9yv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828371; c=relaxed/simple;
	bh=pnIad4wV2NGVjaSWGkqF/6RCxOMpMI6wZHEAk1tRJF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zo6z7iZHy/fezmwR5oeJaLnOqGGFsH6n6CLrxRB76y0Q6hps/6tVaOhR3v/O7+9EUv5ydPLyDqjDQEff3sGaOKMXj6N28qEi/U0SEYCxBOONjAO6S+ssen9h0ojt7eiNfeCARv1+KAv3SeTlFScoZojsVhEK9UcM1fY9AX6q5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPdfzYqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87485C4CEE2;
	Wed, 16 Apr 2025 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744828370;
	bh=pnIad4wV2NGVjaSWGkqF/6RCxOMpMI6wZHEAk1tRJF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lPdfzYqtJFKuc2VmoxG5d22kG/0AAN/A7m0qvkvAwiVuaVomhrnOJk6CKsY14GmJf
	 Nf2F/xkynRVp48IisSC4CCjFXQ9/RAM7H3qbsmWzlsWyXKbln+88F/1BvsebPZ8AG5
	 JGRAnRQ9JRgx1UER+tC5bOY5jeVgXsqv2pxjz/YEzHqsuIIG7RA3gfWkMKO4hClqeD
	 jncrbSZotyGR+vcvpw+4w2VSyY6dwb5MRU+4SSkVNLdUcTXhBN2W+OJllRvjFq61oK
	 6yqXCTvDqgrma0TqATI0HF8c4GGZVUseQJKFURlQ02CFt8aKvbyJS8pphJZGEKK1bG
	 1g9MhPcPzgP1g==
Date: Wed, 16 Apr 2025 13:32:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH 2/2] net: mana: Allow MANA driver to allocate PCI vector
 dynamically
Message-ID: <20250416183249.GA75632@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744817781-3243-1-git-send-email-shradhagupta@linux.microsoft.com>

On Wed, Apr 16, 2025 at 08:36:21AM -0700, Shradha Gupta wrote:
> Currently, the MANA driver allocates pci vector statically based on
> MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> up allocating more vectors than it needs.
> This is because, by this time we do not have a HW channel and do not know
> how many IRQs should be allocated.
> To avoid this, we allocate 1 IRQ vector during the creation of HWC and
> after getting the value supported by hardware, dynamically add the
> remaining vectors.

Add blank lines between paragraphs.

s/pci vector/MSI-X vectors/

Maybe also update subject to mention "MSI-X vectors" instead of "PCI
vector", since "PCI vector" is not really a common term.

