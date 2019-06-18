Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0408549651
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2019 02:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfFRAfg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 20:35:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36847 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRAff (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 20:35:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so3857463wrs.3;
        Mon, 17 Jun 2019 17:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qETu5gkd+kWozQLOI0tdWFOpyOwPNFgXHRZvfET+Xhw=;
        b=DK5h054Rn6wGZi/ZouF5j9HKZDl9o7A1whpnNNWMKTF38nwjB4hak08MP536T4etUs
         a7N9OgcYcIvBxhEGGBd35URBCRkk+sx2glCYXrtON3PBOF28EjjTjFcQkS6U5js9jfnL
         85YIuQjGOhEOuZK979VnFx3igySso5SsPgS6013+JNRs4x80CXRMJMnnrP2nvFWaK/m6
         nX0LVKMywNUffPKpaNNaOsaiyP9iqXgAGQULfNd6SyKpGXt52AnAz4EOiNzkFqQiWWSi
         5XwhusyCNdafT8NrbPmnK3rAEXSzPhzUDfIUmoDA6sRcLSoaje7Wk5y6eH0s59tl/aOP
         roKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qETu5gkd+kWozQLOI0tdWFOpyOwPNFgXHRZvfET+Xhw=;
        b=cNffg4v5sf7S+XCmwuxMcS7yUz75OecTwr/iR3Q3aEgtqa2mBdSBvdWZ5dIrka3/lq
         LjT6radqdyeHao+riN5XcZI6iIBIpHYZUajcY6UfJqAgYgYmeRtxQ2IRT99WiTy0GUkX
         nCE4InY9NqqQZoD2sHSHw6LAKESLfYF8QCyFonF2m+7uOznn+lI+NcFKqP4RzvYtle+8
         6B8OqblONv2xDEHe4esEjvRNPdbTRaj23S894BArzFjJi4Il5TOmUgUa69yFb97+CtPm
         iHWbf9Kjcu4Naxb0OBOYBnA5v0wyeVEVz3glOVmmwwOGcWjGJSWwjF9U5Y9WMK4fbOaF
         +i6Q==
X-Gm-Message-State: APjAAAWeChxn0JxpK6DwFC5Abb3lnKsKlY82sbT7adWwvN19M64iWZKj
        nP5+7GfX49IsYkgYIT3Gylruy6ejV3WmN0h45IY=
X-Google-Smtp-Source: APXvYqxgZeHnsjgwvahP3ryGid7aL0uS9ed7w3FR0orFAkYeHvDCv7jitsS6z0Yk2kGh7gQnvIz775XRQfZxSRtZNTk=
X-Received: by 2002:a5d:4647:: with SMTP id j7mr7526631wrs.334.1560818133023;
 Mon, 17 Jun 2019 17:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122000.22181-1-hch@lst.de> <20190617122000.22181-2-hch@lst.de>
In-Reply-To: <20190617122000.22181-2-hch@lst.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 18 Jun 2019 08:35:21 +0800
Message-ID: <CACVXFVOwCeM2JzefBpKsVZrEaWpSBR0DF8qp4oKfoHm+pwLBYw@mail.gmail.com>
Subject: Re: [PATCH 1/8] scsi: add a host / host template field for the virt boundary
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 17, 2019 at 8:21 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This allows drivers setting it up easily instead of branching out to
> block layer calls in slave_alloc, and ensures the upgraded
> max_segment_size setting gets picked up by the DMA layer.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/hosts.c     | 3 +++
>  drivers/scsi/scsi_lib.c  | 3 ++-
>  include/scsi/scsi_host.h | 3 +++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index ff0d8c6a8d0c..55522b7162d3 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -462,6 +462,9 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>         else
>                 shost->dma_boundary = 0xffffffff;
>
> +       if (sht->virt_boundary_mask)
> +               shost->virt_boundary_mask = sht->virt_boundary_mask;
> +
>         device_initialize(&shost->shost_gendev);
>         dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>         shost->shost_gendev.bus = &scsi_bus_type;
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 65d0a10c76ad..d333bb6b1c59 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1775,7 +1775,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>         dma_set_seg_boundary(dev, shost->dma_boundary);
>
>         blk_queue_max_segment_size(q, shost->max_segment_size);
> -       dma_set_max_seg_size(dev, shost->max_segment_size);
> +       blk_queue_virt_boundary(q, shost->virt_boundary_mask);
> +       dma_set_max_seg_size(dev, queue_max_segment_size(q));

The patch looks fine, also suggest to make sure that max_segment_size
is block-size aligned, and un-aligned max segment size has caused trouble
on mmc.

Thanks,
Ming Lei
