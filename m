Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D37261E3D
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 21:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgIHTsm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Sep 2020 15:48:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50287 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbgIHPuu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Sep 2020 11:50:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id e17so17791326wme.0;
        Tue, 08 Sep 2020 08:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g+fF122O7R17ki64qXX6rnyePilfcGBCv1/ck2Kz2cE=;
        b=ad4pUF5ULr5K0KjVE1Kx6P0NsWd7bJBcL4cOUyoDQNfsc4ozdCZMRLTXOUBjt3Ax9x
         XLVeStAxxGF7GIXuKDfgeP4AUnTQhaoW70ajXSEXxxQwfVpkhR3Ais5kTCNiHtZn+VDR
         nQfIhNiWXzIxo7uoy6R8vxuFOoGlBu9eJDod2qDLtWrT2VJOQcZjb5fTQPGkyHWlwxIq
         lxAbXA8yYMbnN+HzIaSnXKQsh8ilVzv4AkI1E9y6FO89IZG5FWEPSjvkSAgB8IDb/Rf8
         SGYBmM2uiYPIbIuc877/Sbam8jeajc6RrZ1wfnpG86KFw5hBQaxYqHLHlhdQbtlzgzPB
         hYuw==
X-Gm-Message-State: AOAM5313oI5xCIshn4fI7g0F9qiWQ7ZZoAe3sfLmO8vwBcxGY81r8Eal
        Y3GN+u554xZ1iM2NVXZ09+viqyjj8pbwOg==
X-Google-Smtp-Source: ABdhPJw43xrSDZbM980Q1wyWmczcPUCg8AtgaZXw5a+lncrCANbP6dkN49Y+7fuL7XSHkRq9MvMZ7w==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr4764047wmc.10.1599572190886;
        Tue, 08 Sep 2020 06:36:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v128sm31250006wme.2.2020.09.08.06.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:36:30 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:36:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 18/46] x86/msi: Consolidate MSI allocation
Message-ID: <20200908133628.ekh2jbasjf6bxa5z@liuwe-devbox-debian-v2>
References: <20200826111628.794979401@linutronix.de>
 <20200826112332.466405395@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826112332.466405395@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26, 2020 at 01:16:46PM +0200, Thomas Gleixner wrote:
[...]
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1534,7 +1534,7 @@ static struct irq_chip hv_msi_irq_chip =
>  static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
>  						   msi_alloc_info_t *arg)
>  {
> -	return arg->msi_hwirq;
> +	return arg->hwirq;
>  }

Acked-by: Wei Liu <wei.liu@kernel.org>
