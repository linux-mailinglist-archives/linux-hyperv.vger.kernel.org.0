Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927DC13814B
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jan 2020 13:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgAKMIX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Jan 2020 07:08:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36139 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgAKMIX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Jan 2020 07:08:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so4720573wma.1;
        Sat, 11 Jan 2020 04:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gtjh3mkRUNQhRLfkU3LSwvngpCN57b8JcnSgu0JgPt4=;
        b=vWwD3l3v4WIvc51UphwLC2wvJKEEMnIndL8BIv07ZYBlGItqdhngNdb8W+QkzzwuPJ
         czuSUW3E6MoHnRWWfNYcbXxksQ4OLjRuLO5bedZZsS7hTJocKohXwLZSMujdf7qUr3Vt
         bGNAtDX4du93LbTDcLHm2HWu1Ez8txAtG/Ecfu1PCA5aVlfezm78o/DEne5XkdjMYTNA
         leVJ5X7EFtrjpTSClmfDQiJTdv/Oqm4IMq/uQUTeuCvxocNAgLg8NVMuSp2COfQtl3ta
         c0qARR0D2f//i8MOWmpS3DP2Oksd6UppjcfXJuDunOW2qDH7ok8kyF8mv8R+E/AoPtPQ
         I9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gtjh3mkRUNQhRLfkU3LSwvngpCN57b8JcnSgu0JgPt4=;
        b=PF+phO6qyuOCWVok091QSLJnzzZXgpyVw0ds5b2YZOJs88OCL4nHnKxTs0slNhpjab
         16l5mhSs9bO4i8m12iBDKMM0ZnD0Qj7UFvLOhe01UX/xL1pt5iiX7TCF4GlkW+pMKtPt
         oxB2TTx09APhQTnVUcUmUQNVhNcLXDMjR7Yifr0b0mLL0bpzdXkX3bDpMdkJZ+NUyuqS
         H6lRTocywS+h413aP3t5rME3wh3FQIxutnnPPYqsdbg/ptQurnhgF/lQ4CvmPeLi1WdB
         Nu2ZIE/M832hRH5m2h2dJl7vzF6wZtvk0F75M6ZIvVflSCA6oK8u/TInwKI0PIF+gy07
         Xa2w==
X-Gm-Message-State: APjAAAUYz71gfmXP4Wk713H9DfA8XASAkusAkhOkcOGIRx5b+6fuEDUD
        MKBHzSv05EFdM7ya2qBGpkV7GSnXF4j9p3KPRco=
X-Google-Smtp-Source: APXvYqyQ1k1E8gWMY4lUkgRf/8mPwzKsPlmBvNGLTcF344kRbD9XiwJnjctr6wE4a2g45bjuhC8BZmo+a3WpLrHT7cY=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr10139432wml.55.1578744501107;
 Sat, 11 Jan 2020 04:08:21 -0800 (PST)
MIME-Version: 1.0
References: <1578730634-109961-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1578730634-109961-1-git-send-email-longli@linuxonhyperv.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 11 Jan 2020 20:08:09 +0800
Message-ID: <CACVXFVOJnDG9HTxdHMKjttHkVsu+12LmbO9+AAU5+TrFYhAz_w@mail.gmail.com>
Subject: Re: [PATCH] scsi: storvsc: Correctly set number of hardware queues
 for IDE disk
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jan 11, 2020 at 4:17 PM <longli@linuxonhyperv.com> wrote:
>
> From: Long Li <longli@microsoft.com>
>
> Commit 0ed881027690 ("scsi: storvsc: setup 1:1 mapping between hardware queue and CPU queue")
> introduced a regression for disks attached to IDE. For these disks the host VSP only offers
> one VMBUS channel. Setting multiple queues can overload the VMBUS channel and result in
> performance drop for high queue depth workload on system with large number of CPUs.
>
> Fix it by leaving the number of hardware queues to 1 (default value) for IDE
> disks.
>
> Fixes: 0ed881027690 ("scsi: storvsc: setup 1:1 mapping between hardware queue and CPU queue")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index f8faf8b3d965..992b28e40374 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1842,9 +1842,11 @@ static int storvsc_probe(struct hv_device *device,
>          */
>         host->sg_tablesize = (stor_device->max_transfer_bytes >> PAGE_SHIFT);
>         /*
> +        * For non-IDE disks, the host supports multiple channels.
>          * Set the number of HW queues we are supporting.
>          */
> -       host->nr_hw_queues = num_present_cpus();
> +       if (dev_id->driver_data != IDE_GUID)
> +               host->nr_hw_queues = num_present_cpus();
>
>         /*
>          * Set the error handler work queue.
> --
> 2.20.1
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
