Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA05E156C
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2019 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390590AbfJWJKm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Oct 2019 05:10:42 -0400
Received: from verein.lst.de ([213.95.11.211]:39233 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390530AbfJWJKm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Oct 2019 05:10:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DAB3A68BE1; Wed, 23 Oct 2019 11:10:37 +0200 (CEST)
Date:   Wed, 23 Oct 2019 11:10:37 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Wei Hu <weh@microsoft.com>
Cc:     "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "dcui@microsoft.com" <dcui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb
 on HyperV Gen 1 VMs.
Message-ID: <20191023091037.GB21910@lst.de>
References: <20191022110905.4032-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191022110905.4032-1-weh@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> +	select DMA_CMA

Thіs needs to be

	select DMA_CMA if HAVE_DMA_CONTIGUOUS

> +#include <linux/dma-contiguous.h>

> +	/* Allocate from CMA */
> +	// request_pages = (request_size >> PAGE_SHIFT) + 1;
> +	request_pages = (round_up(request_size, PAGE_SIZE) >> PAGE_SHIFT);
> +	page = dma_alloc_from_contiguous(NULL, request_pages, 0, false);

dma_alloc_from_contiguous is an internal helper, you must use it
through dma_alloc_coherent and pass a struct device to that function.

> +	if (!gen2vm) {
> +		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> +			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> +		if (!pdev) {
> +			pr_err("Unable to find PCI Hyper-V video\n");
> +			return -ENODEV;
> +		}
> +	}

Please actually implement a pci_driver instead of hacks like this.

> +			par->need_docopy = false;
> +			goto getmem1;
> +		} else {

No need for an else after a goto.

