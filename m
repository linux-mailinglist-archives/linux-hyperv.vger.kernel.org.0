Return-Path: <linux-hyperv+bounces-2509-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D83091D7F9
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 08:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C151F20FD6
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 06:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301639FCE;
	Mon,  1 Jul 2024 06:16:31 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3D2B9BF;
	Mon,  1 Jul 2024 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719814591; cv=none; b=YyxodEubEv/oNW8LWDovKU217J/rqVK8aQEwc6o+eVxXA8taX9/73rsYy6+fpiha0CNxTKkFhmqpSR05v06scn9KEn6H2vMsHJ+edy0BpXLjKcrd8e8B2QYoh8d+kbOP80elAHo04ces52g7IaGCyCqYRG/mz5shIJyDjISoehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719814591; c=relaxed/simple;
	bh=+oYyA2t91VJ5Zv4CluJBZ7kYxo1DqJ18AJpDzTQeCHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF8sKK05ffCYqyT2qEJuVnbQQMnV8HzzS26RUZmbXcaeo42hvW0DrpClp5vgQYjqXCMUCMkF7T/4TIB8MBoeTbyvuoa7aX+cjpzX9P6nzo3JDUIv8HoYECGV1aymByLCFaeQXerlLzEFR5KeAjji/mS7/naneaHe/JYOYXUhD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d63332595cso1177941b6e.3;
        Sun, 30 Jun 2024 23:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719814589; x=1720419389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTyii9XBbJ4Ky0TNjSfhn+DHUjISOA38nQqAS4bi8KQ=;
        b=UwxpPYsoq19fdFZHZ5r8RLWmCOzlTEFAYYHyV8ZmJbWEdPMLPXO5Uo8eMS9nGofiiL
         PEjShq9f7HZaXi2m10DaM5OToYSWaDffHw77XdChv37QT+Jbh9cVsfBBUJs/zOPEB4aN
         O2GK4JvMtM1VMKfWldu4AB1i51Np3KfgOUfVJnvLD2eqc5p7hfwhpZ9O2ZDSWhuHV+X0
         7awbEXY+YWvC0hJjPO0KnGJHx1nyvJt4XCn9oUZyf+Iis11RIcCNhdI0DCVBb8+3U/Ch
         eyP9MqZcsoOR92yf+Q1Vehq1OfNZvl+mllV/+MbygNfhynRtgItxA+pPua1xpKuSckT5
         cbKg==
X-Forwarded-Encrypted: i=1; AJvYcCXVAPLCjn31dzOimi1TVubE4mFRip7kTD8b6Dd2IWafcqfo1FO3PicfxMg+/S6q/Y3VhiVPldTqRILsijZfd/BZwqk67xA1+wGvwW1uMf3Ddn+vMQ7CrgLFqJCP/3zf0CMLfVS7+5c9EPkZCOFJvv61PMPi0gSfMFlQsO49IjrfoO4vc6rv
X-Gm-Message-State: AOJu0YxO4GIEeC/yCioaCYJMjw09klINdrzgxSW+G2kysz9KE01Q3NXG
	nLRwbg+2fHLkmGwlGNw/5p2kd+rvQUl8xmCYY47BQwmXDoFsw7wb
X-Google-Smtp-Source: AGHT+IFYqg+/QLVGWkm2Bb11LtZmSlEFPu4ScAz9HoXJiKNTs0C3lcornbmodvP0o7eEZaKOlW86BQ==
X-Received: by 2002:a05:6808:2288:b0:3d6:331d:b52d with SMTP id 5614622812f47-3d6b2f07e53mr7284293b6e.4.1719814588940;
        Sun, 30 Jun 2024 23:16:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac419sm5655629b3a.164.2024.06.30.23.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 23:16:28 -0700 (PDT)
Date: Mon, 1 Jul 2024 06:16:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	stable@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: hv: fix reading of PCI_INTERRUPT_PIN
Message-ID: <ZoJJsolJJcLUYiVG@liuwe-devbox-debian-v2>
References: <20240621210018.350429-1-wei.liu@kernel.org>
 <20240626151039.GA1466747@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626151039.GA1466747@bhelgaas>

On Wed, Jun 26, 2024 at 10:10:39AM -0500, Bjorn Helgaas wrote:
> 1) Capitalize subject to match history

What do you mean here? I got the "PCI: hv: ..." format from recent
commits. "PCI" is capitalized. You want to to capitalize "fix"?

> 2) Say something more specific than "fix reading ..."
> 
> Apparently this returns garbage in some case where you want to return
> zero?

Yes. *val is not changed in the old code, so garbage is returned.

Here is the updated commit message. I can resend once you confirm you're
happy with it.

    PCI: hv: Fix reading of PCI_INTERRUPT_PIN

    The intent of the code snippet is to always return 0 for both
    PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.

    The check misses PCI_INTERRUPT_PIN. This patch fixes that.

    This is discovered by this call in VFIO:

        pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);

    The old code does not set *val to 0 because it misses the check for
    PCI_INTERRUPT_PIN. Garbage is returned in this case.

    Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
    Cc: stable@kernel.org
    Signed-off-by: Wei Liu <wei.liu@kernel.org>

Thanks,
Wei.


> 
> On Fri, Jun 21, 2024 at 09:00:18PM +0000, Wei Liu wrote:
> > The intent of the code snippet is to always return 0 for both
> > PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.
> > 
> > The check misses PCI_INTERRUPT_PIN. This patch fixes that.
> > 
> > This is discovered by this call in VFIO:
> > 
> >     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> > 
> > The old code does not set *val to 0 because it misses the check for
> > PCI_INTERRUPT_PIN.
> > 
> > Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> > Cc: stable@kernel.org
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > v2:
> > * Change the commit subject line and message
> > * Change the code according to feedback
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 5992280e8110..cdd5be16021d 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
> >  		   PCI_CAPABILITY_LIST) {
> >  		/* ROM BARs are unimplemented */
> >  		*val = 0;
> > -	} else if (where >= PCI_INTERRUPT_LINE && where + size <=
> > -		   PCI_INTERRUPT_PIN) {
> > +	} else if ((where >= PCI_INTERRUPT_LINE && where + size <= PCI_INTERRUPT_PIN) ||
> > +		   (where >= PCI_INTERRUPT_PIN && where + size <= PCI_MIN_GNT)) {
> >  		/*
> >  		 * Interrupt Line and Interrupt PIN are hard-wired to zero
> >  		 * because this front-end only supports message-signaled
> > -- 
> > 2.43.0
> > 

