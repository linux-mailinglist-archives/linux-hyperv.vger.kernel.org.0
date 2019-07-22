Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6CA6F941
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jul 2019 08:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfGVGBF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jul 2019 02:01:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35759 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfGVGBF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jul 2019 02:01:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so38004615wrm.2;
        Sun, 21 Jul 2019 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37hfVhLnIa1r6NGFMm8G0EEpkeWfL8ItIfeqkfN0XWo=;
        b=J4pcGSVR+pUnkaC5agCYVX670aS1EMHlDf7aOpRo3ia4EFQjZDZcSgUP/v+GZPRtqj
         4om3zTyntyQnfYZ1ZFLhUSgRDsho+hlUo6FH9MVveM0O9Ar+WfOMav+2H0DHi4VO0dfB
         AMuXo/JiHcESdhbcOIM0sgpraKsh1Ax3xtSl8zR+ZqEZzfEdNlKIXZqIQsYfapFEhKuA
         mvLjKnItaTjdoDat+6js8yq2UIK1ZM9kOICyNYlhftxQ06w9a7HPXT3l+HhN0ESyy5T/
         A84wEaLkjc2LSLqwuEufI0owb+aKvpJuvE48b4a0/RwXHvWPFqXn4qorUEADSbdgF9+W
         Jaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37hfVhLnIa1r6NGFMm8G0EEpkeWfL8ItIfeqkfN0XWo=;
        b=VJMPwp2FhNfaG36l6ly8/sVTxbTXlaNMoGFPZ3lss1qXugGmKNuWxOdmGjvCq3WMru
         vSjMPD0LMf0UA1/yvNar676vUbK4K1+MIh4kr+pCFzzk8KxM21F/9Y/qjqd7aMSSVZID
         I0FfsWLxF0Hl9GpAkpcDrqJ6waUjmJMKRBVeflUOi1xdcATXbxGqxOzbqdWBhO52FviO
         rohdP13D5jwegZjti2Al0U5VU8X+ucnwhcDuA3jUcCWyFNc8l0WiC7cik4ecVoMzdBD3
         NUQUL8Eaig32xQxrd8Od/iOsEBAI1kKM9kW1i0LYKh9szqOi2/o85GpIydJPnw3Zn1Y2
         WdUw==
X-Gm-Message-State: APjAAAUI/+WQGbeA1Hpkf4Ts2ZrYorWJNhDDl5VupRcxlc9ujK1qzu/p
        B64xon48C+/EkXXGzPCT0CZuuxP5ICkNzWexKTVr2tPulrRHDA==
X-Google-Smtp-Source: APXvYqxRw9caGGBAMDV6+dJ4KfufK/4O1gQP8+o+uyG+5KKxIOoYwVdMP8Zud5H7axQkNLSdJmz/t0mGsBcxsv7w3ZM=
X-Received: by 2002:adf:f088:: with SMTP id n8mr28707513wro.58.1563775261860;
 Sun, 21 Jul 2019 23:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122000.22181-1-hch@lst.de> <20190617122000.22181-3-hch@lst.de>
 <5d143a03-edd5-5878-780b-45d87313a813@acm.org>
In-Reply-To: <5d143a03-edd5-5878-780b-45d87313a813@acm.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 22 Jul 2019 14:00:48 +0800
Message-ID: <CACVXFVMWM3xg6EEyoyNjkLPv=8+wQKiHj6erMS_gGX25f-Ot4g@mail.gmail.com>
Subject: Re: [PATCH 2/8] scsi: take the DMA max mapping size into account
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
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

On Tue, Jun 18, 2019 at 4:57 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/17/19 5:19 AM, Christoph Hellwig wrote:
> > We need to limit the devices max_sectors to what the DMA mapping
> > implementation can support.  If not we risk running out of swiotlb
> > buffers easily.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   drivers/scsi/scsi_lib.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index d333bb6b1c59..f233bfd84cd7 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1768,6 +1768,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
> >               blk_queue_max_integrity_segments(q, shost->sg_prot_tablesize);
> >       }
> >
> > +     shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> > +                     dma_max_mapping_size(dev) << SECTOR_SHIFT);
> >       blk_queue_max_hw_sectors(q, shost->max_sectors);
> >       if (shost->unchecked_isa_dma)
> >               blk_queue_bounce_limit(q, BLK_BOUNCE_ISA);
>
> Does dma_max_mapping_size() return a value in bytes? Is
> shost->max_sectors a number of sectors? If so, are you sure that "<<
> SECTOR_SHIFT" is the proper conversion? Shouldn't that be ">>
> SECTOR_SHIFT" instead?

Now the patch has been committed, '<< SECTOR_SHIFT' needs to be fixed.

Also the following kernel oops is triggered on qemu, and looks
device->dma_mask is NULL.

[    5.826483] scsi host0: Virtio SCSI HBA
[    5.829302] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    5.831042] SCSI Media Changer driver v0.25
[    5.832491] ==================================================================
[    5.833332] BUG: KASAN: null-ptr-deref in
dma_direct_max_mapping_size+0x30/0x94
[    5.833332] Read of size 8 at addr 0000000000000000 by task kworker/u17:0/7
[    5.835506] nvme nvme0: pci function 0000:00:07.0
[    5.833332]
[    5.833332] CPU: 2 PID: 7 Comm: kworker/u17:0 Not tainted 5.3.0-rc1 #1328
[    5.836999] ahci 0000:00:1f.2: version 3.0
[    5.833332] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS ?-20180724_192412-buildhw-07.phx4
[    5.833332] Workqueue: events_unbound async_run_entry_fn
[    5.833332] Call Trace:
[    5.833332]  dump_stack+0x6f/0x9d
[    5.833332]  ? dma_direct_max_mapping_size+0x30/0x94
[    5.833332]  __kasan_report+0x161/0x189
[    5.833332]  ? dma_direct_max_mapping_size+0x30/0x94
[    5.833332]  kasan_report+0xe/0x12
[    5.833332]  dma_direct_max_mapping_size+0x30/0x94
[    5.833332]  __scsi_init_queue+0xd8/0x1f3
[    5.833332]  scsi_mq_alloc_queue+0x62/0x89
[    5.833332]  scsi_alloc_sdev+0x38c/0x479
[    5.833332]  scsi_probe_and_add_lun+0x22d/0x1093
[    5.833332]  ? kobject_set_name_vargs+0xa4/0xb2
[    5.833332]  ? mutex_lock+0x88/0xc4
[    5.833332]  ? scsi_free_host_dev+0x4a/0x4a
[    5.833332]  ? _raw_spin_lock_irqsave+0x8c/0xde
[    5.833332]  ? _raw_write_unlock_irqrestore+0x23/0x23
[    5.833332]  ? ata_tdev_match+0x22/0x45
[    5.833332]  ? attribute_container_add_device+0x160/0x17e
[    5.833332]  ? rpm_resume+0x26a/0x7c0
[    5.833332]  ? kobject_get+0x12/0x43
[    5.833332]  ? rpm_put_suppliers+0x7e/0x7e
[    5.833332]  ? _raw_spin_lock_irqsave+0x8c/0xde
[    5.833332]  ? _raw_write_unlock_irqrestore+0x23/0x23
[    5.833332]  ? scsi_target_destroy+0x135/0x135
[    5.833332]  __scsi_scan_target+0x14b/0x6aa
[    5.833332]  ? pvclock_clocksource_read+0xc0/0x14e
[    5.833332]  ? scsi_add_device+0x20/0x20
[    5.833332]  ? rpm_resume+0x1ae/0x7c0
[    5.833332]  ? rpm_put_suppliers+0x7e/0x7e
[    5.833332]  ? _raw_spin_lock_irqsave+0x8c/0xde
[    5.833332]  ? _raw_write_unlock_irqrestore+0x23/0x23
[    5.833332]  ? pick_next_task_fair+0x976/0xa3d
[    5.833332]  ? mutex_lock+0x88/0xc4
[    5.833332]  scsi_scan_channel+0x76/0x9e
[    5.833332]  scsi_scan_host_selected+0x131/0x176
[    5.833332]  ? scsi_scan_host+0x241/0x241
[    5.833332]  do_scan_async+0x27/0x219
[    5.833332]  ? scsi_scan_host+0x241/0x241
[    5.833332]  async_run_entry_fn+0xdc/0x23d
[    5.833332]  process_one_work+0x327/0x539
[    5.833332]  worker_thread+0x330/0x492
[    5.833332]  ? rescuer_thread+0x41f/0x41f
[    5.833332]  kthread+0x1c6/0x1d5
[    5.833332]  ? kthread_park+0xd3/0xd3
[    5.833332]  ret_from_fork+0x1f/0x30
[    5.833332] ==================================================================



Thanks,
Ming Lei
