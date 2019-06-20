Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE65E4C7D4
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2019 09:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfFTHEP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Jun 2019 03:04:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41761 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfFTHEP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Jun 2019 03:04:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so1225614qkk.8
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Jun 2019 00:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qra3uPbmwxdDyA4AaZlBHKJVrJf/WvX+mVnEuv9KXzU=;
        b=W8Kq8n3Tk/T94dHOWAMcyWhdnrnuJks3EX2wE7Bfqelm6h6U/w8oSPk7CCXKmTjmoU
         TfeeCKVRvJNzayy9f6Wi+t1jtIkmar2UUzYZX9NejWdA9c0Y6KWK9OBS3ZGo5Qs2aFIW
         DRhFxFA4WqFOqWagNobpAj/17ziKwPPEJgIUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qra3uPbmwxdDyA4AaZlBHKJVrJf/WvX+mVnEuv9KXzU=;
        b=HNq3oih2DGGFAj+efx6uOMHHPom1wHcj/zjE+YuY64toJ5FMycmTIROkBYOdFyeQyi
         Yj3Gf3Ay2uzeF5aDbYtTRazpwej6B9akrv5Sp5vmCuZdlZ7b692pQgEx7kYpQi2VD5gS
         S1CrtRISIXqIt6ZnOC38nH9rIAT948e4oFucLtQLGdtD/cbgnT4qwGSZ/SeWZ3N8trvj
         JoEKY/qBQSiD3kGNVb6nlzYXK8tCQokkSO1H5VvToaMg9yTRMgOk/QPCNF7CAk1eQeO5
         L3iwEO44GVzZc2mjwJn+0f+hR5Io7brkb34MZbHkcC95zxc66qrolELecjdYmRi42Xi5
         AkVw==
X-Gm-Message-State: APjAAAVXnLb4n/LwHwRQOFqwkSuUTKlKQZmUJvkloOrvN76M1MQ1Bqlr
        WcJff9WwZZtZccO39jBvD/GlCVAzPI4HkFsmHL+Qfw==
X-Google-Smtp-Source: APXvYqyn0Z6SBnEwII20nrJnyGd3pOxDX+LJHUmak7ix9Cp2YOWeFQYLIzeYzQfPuf1S6FLxj/0GSbcuVaf/Pu4uJV4=
X-Received: by 2002:a37:ea0c:: with SMTP id t12mr35032475qkj.117.1561014254295;
 Thu, 20 Jun 2019 00:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122000.22181-1-hch@lst.de> <20190617122000.22181-8-hch@lst.de>
 <CACVXFVObpdjN6V9qS-C9NG5xcrPqmx-X22qVamOSZf81Vog6zw@mail.gmail.com> <CA+RiK64sFfY79i7q2YbN5HcZ4wzVOcLWgDJnPbf6=ycdcmC-Mg@mail.gmail.com>
In-Reply-To: <CA+RiK64sFfY79i7q2YbN5HcZ4wzVOcLWgDJnPbf6=ycdcmC-Mg@mail.gmail.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 20 Jun 2019 12:38:52 +0530
Message-ID: <CA+RiK64_31h+UHA7r3BdPo7AjUTyfEKYfskEquqbCZ84d4pbKw@mail.gmail.com>
Subject: Re: [PATCH 7/8] mpt3sas: set an unlimited max_segment_size for SAS
 3.0 HBAs
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        megaraidlinux.pdl@broadcom.com,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        linux-hyperv@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Acked-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

On Thu, Jun 20, 2019 at 12:34 PM Suganath Prabu Subramani
<suganath-prabu.subramani@broadcom.com> wrote:
>
> Please consider this as Acked-by: Suganath Prabu
> <suganath-prabu.subramani@broadcom.com>
>
>
> On Tue, Jun 18, 2019 at 6:16 AM Ming Lei <tom.leiming@gmail.com> wrote:
> >
> > On Mon, Jun 17, 2019 at 8:21 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > When using a virt_boundary_mask, as done for NVMe devices attached to
> > > mpt3sas controllers we require an unlimited max_segment_size, as the
> > > virt boundary merging code assumes that.  But we also need to propagate
> > > that to the DMA mapping layer to make dma-debug happy.  The SCSI layer
> > > takes care of that when using the per-host virt_boundary setting, but
> > > given that mpt3sas only wants to set the virt_boundary for actual
> > > NVMe devices we can't rely on that.  The DMA layer maximum segment
> > > is global to the HBA however, so we have to set it explicitly.  This
> > > patch assumes that mpt3sas does not have a segment size limitation,
> > > which seems true based on the SGL format, but will need to be verified.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > > index 1ccfbc7eebe0..c719b807f6d8 100644
> > > --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > > +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > > @@ -10222,6 +10222,7 @@ static struct scsi_host_template mpt3sas_driver_template = {
> > >         .this_id                        = -1,
> > >         .sg_tablesize                   = MPT3SAS_SG_DEPTH,
> > >         .max_sectors                    = 32767,
> > > +       .max_segment_size               = 0xffffffff,
> >
> > .max_segment_size should be aligned, either setting it here correctly or
> > forcing to make it aligned in scsi-core.
> >
> > Thanks,
> > Ming Lei
