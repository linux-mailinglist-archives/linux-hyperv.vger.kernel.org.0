Return-Path: <linux-hyperv+bounces-8226-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA71D1431B
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 17:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0ABF3002BA7
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD2364036;
	Mon, 12 Jan 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="gRO5Jvl7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E436E46D;
	Mon, 12 Jan 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236957; cv=none; b=CMb1YP9LWGUoNYOB8zyEGVfnEEqpppczMj6F0UIxnkt+TFUzdcxTM9rP5IMc1B94Haummu1t3NrT/BZsVP48hXmsA4GuHgcP4PQ3Fws5Mz/iYh0vPze9K807MFHAwiMhFLLJdteZXlwxISr7x+2MqiZYjB78vyrE61qEO9rGgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236957; c=relaxed/simple;
	bh=KVX5MxmSTaO9QC6XAGHbbVFh9hxe355q3X3nJViMtbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw61uyTRh3+sOfPH4eguQdnswwgZF9ax1xaABRZ7VR1CMxL0mmZYH6mH8E0aixxY2Z1t0oVmkP+hQ5IE72C73+0leXBs/R+sTcccZseQXMciThMSptElqSPa8FWb0a0toQCtIMFQKjahlzlzdHXZaLFbBzIfpIrRAh+QhXjlSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=gRO5Jvl7; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XVqfR8Xq2h2BVs0MCgdAImBeBi3MhN9EdFXYum4ZEd0=; t=1768236955; x=1769100955; 
	b=gRO5Jvl7yImqb6qDJcGVIBS/yUlZ2pbuGuxfSqGt/T0wj9/4KQuZzNl+BIQVHp9SoZgdoduwX+x
	w9GGbeRyhBcko0lC3hiwxWRaJ2kD6Op22QR/bi2HxQmeEBtsHh1rkyqZsSeib50Qye95YzXRboDn4
	B41+Sfl04GO9hMQ0fqjWP+DKO9L4UrF4YO9ENpRfSxAVW67IV427gkeHYAy5E1dBPK86HqhV+4oG9
	mH6z6oSuapKJEEjz/zumOTGQ0WRpbWg2G7liwBBka6aehC1rZlBUnJED5B2tdAgRtc9/LtOXhMsye
	nnlmhbwzBErCgtAknK0v0wF1XpNGjAlW0ofw==;
Received: from [49.207.196.83] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1vfLCn-006dCy-S5;
	Mon, 12 Jan 2026 11:55:50 -0500
Date: Mon, 12 Jan 2026 22:25:41 +0530
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
Message-ID: <aWUnjXIMgE--hCgg@csail.mit.edu>
References: <20260111170034.67558-1-mhklinux@outlook.com>
 <aWUFPUxrMkM32zDD@csail.mit.edu>
 <SN6PR02MB4157BFB422607900AC1EBD82D481A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157BFB422607900AC1EBD82D481A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Jan 12, 2026 at 03:54:51PM +0000, Michael Kelley wrote:
> From: Srivatsa S. Bhat <srivatsa@csail.mit.edu> Sent: Monday, January 12, 2026 6:29 AM
> > Hi Michael,
> > 
> > On Sun, Jan 11, 2026 at 09:00:34AM -0800, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > Field pci_bus in struct hv_pcibus_device is unused since
> > > commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.
> > >
> > 
> > Since that commit is several years old (2021), I was curious if this was found by
> > manual inspection or if the compiler was able to flag the unused
> > variable as well.
> 
> Code inspection. I was brushing up on how the structs defined
> in pci-hyperv.c relate to the standard Linux PCI struct pci_bus and
> struct pci_dev. Having a pointer to struct pci_bus in struct
> hv_pcibus_device makes sense, and I was a bit surprised to find
> it's not set or used. Instead, the PCI bus is always found through
> the PCI bridge.
> 

Ah, I see, thank you for the background!

Regards,
Srivatsa

> 
> > 
> > > No functional change.
> > >
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > 
> > Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
> > 
> > Regards,
> > Srivatsa
> > Microsoft Linux Systems Group
> > 
> > > ---
> > >  drivers/pci/controller/pci-hyperv.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > > index 1e237d3538f9..7fcba05cec30 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -501,7 +501,6 @@ struct hv_pcibus_device {
> > >  	struct resource *low_mmio_res;
> > >  	struct resource *high_mmio_res;
> > >  	struct completion *survey_event;
> > > -	struct pci_bus *pci_bus;
> > >  	spinlock_t config_lock;	/* Avoid two threads writing index page */
> > >  	spinlock_t device_list_lock;	/* Protect lists below */
> > >  	void __iomem *cfg_addr;
> > > --
> > > 2.25.1
> > >
> > >

