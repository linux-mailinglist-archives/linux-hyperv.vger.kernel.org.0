Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D244C759
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2019 08:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfFTGRe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Jun 2019 02:17:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33977 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfFTGRe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Jun 2019 02:17:34 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so75118iot.1
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Jun 2019 23:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=mtli3rBvWIToeUr29Uw+Ypdz0JV5neJvf4CS556KrxE=;
        b=NulylrgyQaHJls93qgYUS6gchWZBQuVNjK0XX5s+yZYBluAT7ANsFeWjDQbYSpguGL
         JRVnkaHsN6ksyUxAWDaFFaEsicKKE+JA/f0mEyTlNK/ayBZkIgmtuhpZ8eBcqmNdir0i
         XgHJ3FCYTbtg3iKw6k3//5WGRQPWmgeoEtCbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=mtli3rBvWIToeUr29Uw+Ypdz0JV5neJvf4CS556KrxE=;
        b=O5ejjZQ4HfKCenagHRmN5UcjC6YpCVo6NZqs/y/BX7V4w4RhcYNzmFhL3k5PeeUaF2
         Oq/B0csba/BpgOfv3yt+BYp307upUB+JgLRr30/XbcfYqLFutwbdloQU9Yd2LiIT0f4F
         ePwuaV8ctiy/BDnocMPo+SzCkuNz+479dVs7i2VEWe1b+Bm5nD/ZQmn3AmE+RypC9w3U
         YwMq9tz6HovxLheX+OdxpWJBeu3BkjePCZ1gB5+INzqaiPYHXCvEzdvg177GYuBxlmv8
         d3NmQ7FtIq14ocP337SwVCta1T2q6OnYUglKA7WHJXzoDc2llWD9WBZ1c7pyyb8++twz
         AeTg==
X-Gm-Message-State: APjAAAW1rhaUa9G4NskrYLg4UgDovUqpBnUcfaLgGtCjzfH60rwKtjat
        vAsPlqqPvn0uGmkFVzsM66lq8zJIFqRHn1WPU/UW8Q==
X-Google-Smtp-Source: APXvYqzO8Y0ucXarVWi9Uatq6tK9bmPYC+5T+Y98XJfchKmWQ39MK3nAL9+TrQFImzlpZIcOrMz/XkDik4kq2kIiXWc=
X-Received: by 2002:a5d:9b1a:: with SMTP id y26mr13527500ion.238.1561011453186;
 Wed, 19 Jun 2019 23:17:33 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190617122000.22181-1-hch@lst.de> <20190617122000.22181-2-hch@lst.de>
 <CACVXFVOwCeM2JzefBpKsVZrEaWpSBR0DF8qp4oKfoHm+pwLBYw@mail.gmail.com>
In-Reply-To: <CACVXFVOwCeM2JzefBpKsVZrEaWpSBR0DF8qp4oKfoHm+pwLBYw@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJRkq8kgUxIwCwNEXeP0B3fyGmx3wFs9i1PAgoiQ2Wlj4BA8A==
Date:   Thu, 20 Jun 2019 11:47:29 +0530
Message-ID: <6dd62da3ba56142d4a67bc207aa55a59@mail.gmail.com>
Subject: RE: [PATCH 1/8] scsi: add a host / host template field for the virt boundary
To:     Ming Lei <tom.leiming@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        PDL-MPT-FUSIONLINUX <mpt-fusionlinux.pdl@broadcom.com>,
        linux-hyperv@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> -----Original Message-----
> From: megaraidlinux.pdl@broadcom.com
> [mailto:megaraidlinux.pdl@broadcom.com] On Behalf Of Ming Lei
> Sent: Tuesday, June 18, 2019 6:05 AM
> To: Christoph Hellwig <hch@lst.de>
> Cc: Martin K . Petersen <martin.petersen@oracle.com>; Sagi Grimberg
> <sagi@grimberg.me>; Max Gurtovoy <maxg@mellanox.com>; Bart Van
> Assche <bvanassche@acm.org>; linux-rdma <linux-rdma@vger.kernel.org>;
> Linux SCSI List <linux-scsi@vger.kernel.org>;
> megaraidlinux.pdl@broadcom.com; MPT-FusionLinux.pdl@broadcom.com;
> linux-hyperv@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/8] scsi: add a host / host template field for the
> virt
> boundary
>
> On Mon, Jun 17, 2019 at 8:21 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > This allows drivers setting it up easily instead of branching out to
> > block layer calls in slave_alloc, and ensures the upgraded
> > max_segment_size setting gets picked up by the DMA layer.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/scsi/hosts.c     | 3 +++
> >  drivers/scsi/scsi_lib.c  | 3 ++-
> >  include/scsi/scsi_host.h | 3 +++
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c index
> > ff0d8c6a8d0c..55522b7162d3 100644
> > --- a/drivers/scsi/hosts.c
> > +++ b/drivers/scsi/hosts.c
> > @@ -462,6 +462,9 @@ struct Scsi_Host *scsi_host_alloc(struct
> scsi_host_template *sht, int privsize)
> >         else
> >                 shost->dma_boundary = 0xffffffff;
> >
> > +       if (sht->virt_boundary_mask)
> > +               shost->virt_boundary_mask = sht->virt_boundary_mask;
> > +
> >         device_initialize(&shost->shost_gendev);
> >         dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
> >         shost->shost_gendev.bus = &scsi_bus_type; diff --git
> > a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c index
> > 65d0a10c76ad..d333bb6b1c59 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1775,7 +1775,8 @@ void __scsi_init_queue(struct Scsi_Host *shost,
> struct request_queue *q)
> >         dma_set_seg_boundary(dev, shost->dma_boundary);
> >
> >         blk_queue_max_segment_size(q, shost->max_segment_size);
> > -       dma_set_max_seg_size(dev, shost->max_segment_size);
> > +       blk_queue_virt_boundary(q, shost->virt_boundary_mask);
> > +       dma_set_max_seg_size(dev, queue_max_segment_size(q));
>
> The patch looks fine, also suggest to make sure that max_segment_size is
> block-size aligned, and un-aligned max segment size has caused trouble on
> mmc.

I validated changes on latest and few older series controllers.
Post changes, I noticed max_segment_size is updated.
find /sys/ -name max_segment_size  |grep sdb |xargs grep -r .
/sys/devices/pci0000:3a/0000:3a:00.0/0000:3b:00.0/0000:3c:04.0/0000:40:00.0/0000:41:00.0/0000:42:00.0/host0/target0:2:12/0:2:12:0/block/sdb/queue/max_segment_size:4294967295

I verify that single SGE having 1MB transfer length is working fine.

Acked-by: Kashyap Desai < kashyap.desai@broadcom.com>

>
> Thanks,
> Ming Lei
>
