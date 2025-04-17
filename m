Return-Path: <linux-hyperv+bounces-4949-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751BFA91553
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014685A2337
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 07:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5D207678;
	Thu, 17 Apr 2025 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nwtZlzFg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D0183CCA;
	Thu, 17 Apr 2025 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875197; cv=none; b=jWajN/5YaT3kz8RdCn9lQi/2ODS3uDzIryVF24y1teQpuqrviSixqLEpVdGLTDJpKvuw//+LpOyPifudYJjYolIFzPyiL3zsUZSarazB3sJ7qG5+jPgugXjZ/w65IjLB27I25udN4xLjWJfJa3TT3AtE2O9l/uhfBktkTAG/6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875197; c=relaxed/simple;
	bh=2MWZisqiJzHC0fK+UcmZd1KNJxMwk62ic35PQviCkPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I11Hl5I2dbAODmcEieSj+McrTG426AbNlzYcdW9T8SJok26sb33q+OMCMQ8cNkZVHd25fJkjj///V/H7hdDeYDihXv7H197moAjLfNLFUlVPkvaTVnqGyFzmI/8yUXtho0KQeSVQ9cMpTw/TOqy7VazF57TsqZmlp8aRooFBjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nwtZlzFg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 4830221199C6; Thu, 17 Apr 2025 00:33:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4830221199C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744875195;
	bh=hDENS8fa6bk7Kg+o5j4QvDgbp95mqKd55Hld7Bm5eMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwtZlzFgF5QF9B6O4y1tGs6IrWBbPUV+Y1+1Q/qYpJt3q4sxhwio27dQ25KcPb3r9
	 Z9xioA/sGlMl0bw5yp7VNxGNbw1NbIJ6MO7yg6XCMf3J6ERDMdDa1n/8GwBLVG9CjZ
	 fGD6lkXY3ircCG980FkGSl2ANmEvQrRGxK4cCuCI=
Date: Thu, 17 Apr 2025 00:33:15 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Krzysztof Wilczy??ski <kw@linux.com>,
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
Message-ID: <20250417073315.GC20244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744817781-3243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250416183249.GA75632@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416183249.GA75632@bhelgaas>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Apr 16, 2025 at 01:32:49PM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 16, 2025 at 08:36:21AM -0700, Shradha Gupta wrote:
> > Currently, the MANA driver allocates pci vector statically based on
> > MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> > up allocating more vectors than it needs.
> > This is because, by this time we do not have a HW channel and do not know
> > how many IRQs should be allocated.
> > To avoid this, we allocate 1 IRQ vector during the creation of HWC and
> > after getting the value supported by hardware, dynamically add the
> > remaining vectors.
> 
> Add blank lines between paragraphs.
> 
> s/pci vector/MSI-X vectors/
> 
> Maybe also update subject to mention "MSI-X vectors" instead of "PCI
> vector", since "PCI vector" is not really a common term.

Understood, thanks Bjorn.

