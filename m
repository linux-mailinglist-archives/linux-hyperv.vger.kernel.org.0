Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5DC69970
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jul 2019 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfGOQ60 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Jul 2019 12:58:26 -0400
Received: from verein.lst.de ([213.95.11.211]:34043 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730782AbfGOQ6Z (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Jul 2019 12:58:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E47268B05; Mon, 15 Jul 2019 18:58:23 +0200 (CEST)
Date:   Mon, 15 Jul 2019 18:58:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: properly communicate queue limits to the DMA layer v2
Message-ID: <20190715165823.GA10029@lst.de>
References: <20190617122000.22181-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617122000.22181-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 17, 2019 at 02:19:52PM +0200, Christoph Hellwig wrote:
> Hi Martin,
> 
> we've always had a bit of a problem communicating the block layer
> queue limits to the DMA layer, which needs to respect them when
> an IOMMU that could merge segments is used.  Unfortunately most
> drivers don't get this right.  Oddly enough we've been mostly
> getting away with it, although lately dma-debug has been catching
> a few of those issues.

Ping?  What happened to this set of bug fixes?
