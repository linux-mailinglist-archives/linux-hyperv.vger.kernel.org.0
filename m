Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E846B39C256
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 23:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhFDV2L (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Jun 2021 17:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhFDV2K (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Jun 2021 17:28:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99B4261106;
        Fri,  4 Jun 2021 21:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622841984;
        bh=Gui3O5Hg4UntSL86u71QCTzn6Ff++kMTUZPRfpQKiyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QNhcezxfRsjXoDrXp7aaNT5h5/R5Vxvl1wuGbFSFZn5tIOs/iLV52MbwcP8fwOBU3
         lwD1+Xz66OIqfYdMxUyLj+svXn2fVEdZlbIlaY/VSwcvd8rqD2xpouHN163tWI6fhP
         zkxkZ8TF9JfuCiT4fELNEQI9MrWt5U//g4i4POlhEiAGLDWXyIxH3S3xXJ3veA/Zv1
         jYh64lRiEIL/SnMTj/QirbusH7dwRiiJRZxmKCy+wxdUWNvfpjOs1eQlFv4A3LZ1Zy
         gQySY12V4FF/BROPFvJufoffJrLlXaHLLmDFTd23GnzbN6fJSrNlPRees3vFe0UbCR
         VngXyuZ1RXr/w==
Date:   Fri, 4 Jun 2021 16:26:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, kys@microsoft.com, olaf@aepfle.de,
        vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci-hyperv: Add check for hyperv_initialized in
 init_hv_pci_drv()
Message-ID: <20210604212622.GA2241239@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602103206.4nx55xsl3nxqt6zj@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 02, 2021 at 10:32:06AM +0000, Wei Liu wrote:
> On Tue, May 25, 2021 at 04:17:33PM -0700, Haiyang Zhang wrote:
> > Add check for hv_is_hyperv_initialized() at the top of init_hv_pci_drv(),
> > so if the pci-hyperv driver is force-loaded on non Hyper-V platforms, the
> > init_hv_pci_drv() will exit immediately, without any side effects, like
> > assignments to hvpci_block_ops, etc.
> > 
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reported-and-tested-by: Mohammad Alqayeem <mohammad.alqyeem@nutanix.com>
> 
> Hello PCI subsystem maintainers, are you going to take this patch or
> shall I?

This was mistakenly assigned to me, so I reassigned it back to
Lorenzo.

If you *do* take this, please at least update it to follow the PCI
commit log conventions, e.g.,

  PCI: hv: Add check ...

and wrap the text so it fits in 75 columns.

> > ---
> >  drivers/pci/controller/pci-hyperv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 6511648271b2..bebe3eeebc4e 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -3476,6 +3476,9 @@ static void __exit exit_hv_pci_drv(void)
> >  
> >  static int __init init_hv_pci_drv(void)
> >  {
> > +	if (!hv_is_hyperv_initialized())
> > +		return -ENODEV;
> > +
> >  	/* Set the invalid domain number's bit, so it will not be used */
> >  	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
> >  
> > -- 
> > 2.25.1
> > 
