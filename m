Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024DA39BB9
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Jun 2019 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfFHIO3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 8 Jun 2019 04:14:29 -0400
Received: from verein.lst.de ([213.95.11.211]:60567 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFHIO3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 8 Jun 2019 04:14:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B4A7168C7B; Sat,  8 Jun 2019 10:14:00 +0200 (CEST)
Date:   Sat, 8 Jun 2019 10:14:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
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
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        PDL-MPT-FUSIONLINUX <mpt-fusionlinux.pdl@broadcom.com>,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi
 host
Message-ID: <20190608081400.GA19573@lst.de>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-11-hch@lst.de> <cd713506efb9579d1f69a719d831c28d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd713506efb9579d1f69a719d831c28d@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 06, 2019 at 09:07:27PM +0530, Kashyap Desai wrote:
> Hi Christoph, Changes for <megaraid_sas> and <mpt3sas> looks good. We want
> to confirm few sanity before ACK. BTW, what benefit we will see moving
> virt_boundry setting to SCSI mid layer ? Is it just modular approach OR any
> functional fix ?

The big difference is that virt_boundary now also changes the
max_segment_size, and this ensures that this limit is also communicated
to the DMA mapping layer.
