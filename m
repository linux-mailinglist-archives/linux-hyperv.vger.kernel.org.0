Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA336C30
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 08:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfFFGZJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 02:25:09 -0400
Received: from verein.lst.de ([213.95.11.211]:47303 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFGZJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 02:25:09 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4448768B05; Thu,  6 Jun 2019 08:24:41 +0200 (CEST)
Date:   Thu, 6 Jun 2019 08:24:41 +0200
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
Message-ID: <20190606062441.GB26745@lst.de>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-9-hch@lst.de> <20190605202235.GC3273@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605202235.GC3273@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 05, 2019 at 05:22:35PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 05, 2019 at 09:08:31PM +0200, Christoph Hellwig wrote:
> > This ensures all proper DMA layer handling is taken care of by the
> > SCSI midlayer.
> 
> Maybe not entirely related to this series, but it looks like the SCSI
> layer is changing the device global dma_set_max_seg_size() - at least
> in RDMA the dma device is being shared between many users, so we
> really don't want SCSI to make this value smaller.
> 
> Can we do something about this?

We could do something about it as outlined in my mail - pass the
dma_params explicitly to the dma_map_sg call.  But that isn't really
suitable for a short term fix and will take a little more time.

Until we've sorted that out the device paramter needs to be set to
the smallest value supported.
