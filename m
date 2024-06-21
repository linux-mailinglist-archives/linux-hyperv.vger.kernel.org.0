Return-Path: <linux-hyperv+bounces-2472-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0779122F5
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 13:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B274B21C3E
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6B171E54;
	Fri, 21 Jun 2024 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="glNe/R9F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9482D72;
	Fri, 21 Jun 2024 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967809; cv=none; b=UqVZMdaZXMFArQC6FEzO9/UZ9VrQDsxdboiKbGh2xrGIhO8qvKRdhX4IfMhJCHQCmp10SOOwwRtWXP+ZDdyeYEpBWT5CSpnDFp2JAkyWWnQAvEm7Jen70V2T23bUa8bOm9kavDSxyj6edUbl6dtg+2xaZxejHQEunj1JmS2aLRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967809; c=relaxed/simple;
	bh=G2mzDOlegupd7MzLPF0RMcnflCyfQVj0L1mDtkuQYmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZOK7aJNLoSbmZt+11X9KRRgrulnLwAqAPccrCqN3tJTTAt7bdAbDK08kiYY5PCuwRwc6HzkeTCID/ZHoNnS+XuqDudHasNVtNo5MsQdLroneVSAy/DaonZR8HCt8hrM4Lvt+lvF4/0pt2mofrx7wj9+joUWrg8WKB3t5NhOD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=glNe/R9F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id EC65420B7001; Fri, 21 Jun 2024 04:03:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC65420B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718967807;
	bh=NJIMPP/SpG3fq6y5+juMSnV7btfcUNm6kl6T9nrkIG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glNe/R9F96iK2xJmXyMvod2m/iy71i+/wz+mR6o2s1kH0xMko/4b0bT3kgh3i6tHY
	 9gfpQ/0EhE5VLJFOqObDe6kMjg0MdXnxDT4fdt0UYhPMgQpTGXuEw+18cSFKax/rbs
	 RWPJTjdQwjY6tRA/jwO7ZQLF3cnmvsRgYjcHLhXc=
Date: Fri, 21 Jun 2024 04:03:27 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: fix reading of PCI_INTERRUPT_LINE and
 PCI_INTERRUPT_PIN
Message-ID: <20240621110327.GA19602@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240621014815.263590-1-wei.liu@kernel.org>
 <SN6PR02MB4157C9FD41483E9AC7ED9E70D4C92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZnUbWUdVE7q8oNjj@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnUbWUdVE7q8oNjj@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jun 21, 2024 at 06:19:05AM +0000, Wei Liu wrote:
> On Fri, Jun 21, 2024 at 03:15:19AM +0000, Michael Kelley wrote:
> > From: Wei Liu <wei.liu@kernel.org> Sent: Thursday, June 20, 2024 6:48 PM
> > > 
> > > The intent of the code snippet is to always return 0 for both fields.
> > > The check is wrong though. Fix that.
> > > 
> > > This is discovered by this call in VFIO:
> > > 
> > >     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> > > 
> > > The old code does not set *val to 0 because the second half of the check is
> > > incorrect.
> > > 
> > > Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V
> > > VMs")

12 characters are preferred for Fixes commit id.
'Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")'

> > > Cc: stable@kernel.org
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > ---
> > >  drivers/pci/controller/pci-hyperv.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > > index 5992280e8110..eec087c8f670 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev
> > > *hpdev, int where,

<snip>


> I had a version that looked like this:
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 5992280e8110..cdd5be16021d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
>                    PCI_CAPABILITY_LIST) {
>                 /* ROM BARs are unimplemented */
>                 *val = 0;
> -       } else if (where >= PCI_INTERRUPT_LINE && where + size <=
> -                  PCI_INTERRUPT_PIN) {
> +       } else if ((where >= PCI_INTERRUPT_LINE && where + size <= PCI_INTERRUPT_PIN) ||
> +                  (where >= PCI_INTERRUPT_PIN && where + size <= PCI_MIN_GNT)) {

IMHO, I prefer this one due to consistency. We can have these 2 condition as separate "else if"
as well, which would align better with the rest of the logic in this function. However, I don't
have a strong preference on this matter.

- Saurabh

