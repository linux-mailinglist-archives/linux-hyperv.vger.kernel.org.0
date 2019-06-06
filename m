Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB653763D
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfFFOUT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 10:20:19 -0400
Received: from verein.lst.de ([213.95.11.211]:49883 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbfFFOUS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 10:20:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BE3A968B20; Thu,  6 Jun 2019 16:19:50 +0200 (CEST)
Date:   Thu, 6 Jun 2019 16:19:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] IB/iser: set virt_boundary_mask in the scsi host
Message-ID: <20190606141950.GB15112@lst.de>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-9-hch@lst.de> <20190605202235.GC3273@ziepe.ca> <20190606062441.GB26745@lst.de> <20190606125935.GA17373@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606125935.GA17373@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 06, 2019 at 09:59:35AM -0300, Jason Gunthorpe wrote:
> > Until we've sorted that out the device paramter needs to be set to
> > the smallest value supported.
> 
> smallest? largest? We've been setting it to the largest value the
> device can handle (ie 2G)

Well, in general we need the smallest value supported by any ULP,
because if any ULP can't support a larger segment size, we must not
allow the IOMMU to merge it to that size.  That being said I can't
really see why any RDMA ULP should limit the size given how the MRs
work.
