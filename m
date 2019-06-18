Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD14966A
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2019 02:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfFRAqy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 20:46:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33338 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFRAqy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 20:46:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so1100775wme.0;
        Mon, 17 Jun 2019 17:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8040MIo3hoL1siZlh+IJp6lN+yzLI4mFWNXimyvlAT8=;
        b=icnDnXp2u0Gupr9hz5qzVK3sx/3roplA+0k5zd87GQng1nhz6SqoI9E/novxYoKwEE
         lDapE2xsyKXmDEcfKzyyGSJO4UvZdJOviYjvwxqimwFPQ1Wa2/Ht/iE79Gmve6jMIEtC
         Jvao9tinNnvRSJ5Zj1z/RquntQwL2Bria4lsckZyZPjw+qLyXD9VLXzZxG/6M+0Hwe8b
         +qOcMZi/96TSSJ9iMyTLyNhuBaMOapSTjmP/ho9zdnB9PqViGM1v6uyXqEQAPL8vAtQ8
         weaAmGBCWsrh+SFbRgt46IDw/hRb6T5hP9PQPFWkggP/47wl84BjQ2hQyAtgeD6z0c8K
         Gf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8040MIo3hoL1siZlh+IJp6lN+yzLI4mFWNXimyvlAT8=;
        b=g6a3jcIr10lG78mzNFPDkSlvCptboKvI3zrBetvr4slCXMuJirzwm9415SgijUbhH8
         tlb6rzjZuUgBvWcVKtVFxbX1P+/Vtxy8IuPyPVDxPpjLE0pg0Je3MAXiO1yUuEYmjyjp
         0ql7KA5zxhMuHa/C1iJE+sYJ1/mTFyuL/JRwJAHCYIZi4Uo4433RvhGbCTDyQAug3zao
         1FOqRnDyZEhSEA1G2GSVRfWXECXDhR69MN4UWxj1a6yFYkiDFLPmMzoa3/Z9xwRdIkpe
         6dpMkP/lp5hKGqRURbTVAMuPc+72vxgld25otYdA/qX1tI1pefuzhT1cLuPGp/x4GPQX
         w8Ww==
X-Gm-Message-State: APjAAAUZzW1qNvg+mx6em+MVbKvLpTL0Y6S+WLs8BLhUTiWbhBXwD+rE
        G6VOcmahaXkLaXibAgFsdJ70X635RAqHIyD/S+I=
X-Google-Smtp-Source: APXvYqxMSUnTcEGSu/iiFpFg9Mxu8aSAdN3/6SxVGuAWKQLmuwThyhLKW85M76Jcf4jRiGyxe2H+tYw93p+WDXmfkhQ=
X-Received: by 2002:a05:600c:204c:: with SMTP id p12mr813975wmg.121.1560818811702;
 Mon, 17 Jun 2019 17:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122000.22181-1-hch@lst.de> <20190617122000.22181-8-hch@lst.de>
In-Reply-To: <20190617122000.22181-8-hch@lst.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 18 Jun 2019 08:46:40 +0800
Message-ID: <CACVXFVObpdjN6V9qS-C9NG5xcrPqmx-X22qVamOSZf81Vog6zw@mail.gmail.com>
Subject: Re: [PATCH 7/8] mpt3sas: set an unlimited max_segment_size for SAS
 3.0 HBAs
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
> When using a virt_boundary_mask, as done for NVMe devices attached to
> mpt3sas controllers we require an unlimited max_segment_size, as the
> virt boundary merging code assumes that.  But we also need to propagate
> that to the DMA mapping layer to make dma-debug happy.  The SCSI layer
> takes care of that when using the per-host virt_boundary setting, but
> given that mpt3sas only wants to set the virt_boundary for actual
> NVMe devices we can't rely on that.  The DMA layer maximum segment
> is global to the HBA however, so we have to set it explicitly.  This
> patch assumes that mpt3sas does not have a segment size limitation,
> which seems true based on the SGL format, but will need to be verified.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> index 1ccfbc7eebe0..c719b807f6d8 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -10222,6 +10222,7 @@ static struct scsi_host_template mpt3sas_driver_template = {
>         .this_id                        = -1,
>         .sg_tablesize                   = MPT3SAS_SG_DEPTH,
>         .max_sectors                    = 32767,
> +       .max_segment_size               = 0xffffffff,

.max_segment_size should be aligned, either setting it here correctly or
forcing to make it aligned in scsi-core.

Thanks,
Ming Lei
