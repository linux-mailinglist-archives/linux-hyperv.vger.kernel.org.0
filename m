Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7067B36C6E
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFFGmV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 02:42:21 -0400
Received: from verein.lst.de ([213.95.11.211]:47422 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFGmV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 02:42:21 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9AB2968B05; Thu,  6 Jun 2019 08:41:53 +0200 (CEST)
Date:   Thu, 6 Jun 2019 08:41:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
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
Subject: Re: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi
 host
Message-ID: <20190606064153.GD27033@lst.de>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-11-hch@lst.de> <345c3931-0940-7d59-ebc6-fa1ea56c60ac@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345c3931-0940-7d59-ebc6-fa1ea56c60ac@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 06, 2019 at 08:02:07AM +0200, Hannes Reinecke wrote:
> >  	scsi_change_queue_depth(sdev, device_qd);
> >  
> What happened to the NOMERGES queue flag?

Quote from the patch description:

"Also remove the bogus nomerges flag, merges do take the virt_boundary
 into account."
