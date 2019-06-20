Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F31A4C7C5
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2019 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfFTG7c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Jun 2019 02:59:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39516 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbfFTG72 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Jun 2019 02:59:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so1226778qkd.6
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Jun 2019 23:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYwaJavZltkT0IqtHMYJOwkZx6rbcF+95m0pIfGAx5I=;
        b=crG2lk2tlGqIP1PfPDUg8NRjFOniWeCFYI53co71jJQiK6ZCTHOFAsOC5PO3H96FzZ
         UnyK2Fm5vMBFlbgMVp5GvPoRdPCUEVJEjK/Oy2V/xG62FU5Dy3ro6wl2DwpVz1OaOQ36
         j1afto59o+BBhHjV2YA2uyxqS1ee97MgDYlOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYwaJavZltkT0IqtHMYJOwkZx6rbcF+95m0pIfGAx5I=;
        b=ZOiKx15aygtek21/+FjyzefKn3s20q81lJvu1Qnc6se1FIA57YcLwazMlhgIFcmGNT
         WnRN5Px0yPzEkRhqUQbrBAXdlAX57I3cwqt7g4Q1KJ4L69sxtH26GRQ0y3vNoymRJh6m
         PUu0F04cfAjPp93j4Y0xJjZgyhRTcMKLRX741FAMNGeh4CnDsI9bxe2V4kPQCL3x86Tk
         IR06FQPKstMsgW7FTetuPUOGQGR/8xIrHMIKCqaAGMKNasq/AAFpLtvYrwCf8xSmTa7i
         JAvrLxpNoPdnk8clezm5bV235WdF9P3UI/G34BpnYvB5g+NUcJeGazo86pl6F9CgH4wN
         JDoQ==
X-Gm-Message-State: APjAAAXXU8LKr/kD2XhDr0kGrfkaYOJQB92FD+10MCQ4We+3G9MMxUOY
        SZMqf7VBLFOh53O76Z6hy6CHECR66YaUlG4chVRNyA==
X-Google-Smtp-Source: APXvYqzBzaAZyBM/D0T+vUfaMfDcyln8br8o/mo/+d348fHSCjDQxzbVZx1yS07/H1zYIOChUzgBFaMdMYIohlW3kKM=
X-Received: by 2002:a37:9cc4:: with SMTP id f187mr84520479qke.23.1561013967454;
 Wed, 19 Jun 2019 23:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122000.22181-1-hch@lst.de> <20190617122000.22181-8-hch@lst.de>
 <CACVXFVObpdjN6V9qS-C9NG5xcrPqmx-X22qVamOSZf81Vog6zw@mail.gmail.com>
In-Reply-To: <CACVXFVObpdjN6V9qS-C9NG5xcrPqmx-X22qVamOSZf81Vog6zw@mail.gmail.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 20 Jun 2019 12:34:05 +0530
Message-ID: <CA+RiK64sFfY79i7q2YbN5HcZ4wzVOcLWgDJnPbf6=ycdcmC-Mg@mail.gmail.com>
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

Please consider this as Acked-by: Suganath Prabu
<suganath-prabu.subramani@broadcom.com>


On Tue, Jun 18, 2019 at 6:16 AM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Mon, Jun 17, 2019 at 8:21 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > When using a virt_boundary_mask, as done for NVMe devices attached to
> > mpt3sas controllers we require an unlimited max_segment_size, as the
> > virt boundary merging code assumes that.  But we also need to propagate
> > that to the DMA mapping layer to make dma-debug happy.  The SCSI layer
> > takes care of that when using the per-host virt_boundary setting, but
> > given that mpt3sas only wants to set the virt_boundary for actual
> > NVMe devices we can't rely on that.  The DMA layer maximum segment
> > is global to the HBA however, so we have to set it explicitly.  This
> > patch assumes that mpt3sas does not have a segment size limitation,
> > which seems true based on the SGL format, but will need to be verified.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > index 1ccfbc7eebe0..c719b807f6d8 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> > @@ -10222,6 +10222,7 @@ static struct scsi_host_template mpt3sas_driver_template = {
> >         .this_id                        = -1,
> >         .sg_tablesize                   = MPT3SAS_SG_DEPTH,
> >         .max_sectors                    = 32767,
> > +       .max_segment_size               = 0xffffffff,
>
> .max_segment_size should be aligned, either setting it here correctly or
> forcing to make it aligned in scsi-core.
>
> Thanks,
> Ming Lei
