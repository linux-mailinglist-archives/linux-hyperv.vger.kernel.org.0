Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029DE47DF3
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfFQJK2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 05:10:28 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:44819 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfFQJK2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 05:10:28 -0400
Received: by mail-io1-f54.google.com with SMTP id s7so19483735iob.11
        for <linux-hyperv@vger.kernel.org>; Mon, 17 Jun 2019 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=Mj+s4plNnZbEVe10BIzmZ1IijmMEuCHawFgLwkcZqoI=;
        b=ZVXe7pF/DKKbAtg0BLq1kHz+Yf8AmgubdjAQekKwZeBkWQQeo+lrwMdIAePBmlOgcE
         WJ3paACJ9GsoxC9mAywQ6EfBHW7Qhb1RZpLg6OjDRo0//12nX9SRpN+HRZNsKHbLnYNY
         mXR2sr52mBeN/pkOHc0Q5eeZBCOpWx8hMerKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=Mj+s4plNnZbEVe10BIzmZ1IijmMEuCHawFgLwkcZqoI=;
        b=qvzQc+3z2rc8EkLRsosuti3qwS0XGowqkGI30CS5OeUlr8FbcxFyw1ZS7YP+gK4q74
         Tx4IUolxRxOUHErI11YWNIlA8hQUM6Bz5HKYvd7LCywp55pTqcKe4iB1PihH0P6UIUPw
         df8NLBpm2pTgwZ2cTj2y+5J8r+YeFmcBlwTYVcLif7qHV/2iccbbLIfg9vQECwiEvAtL
         CJBpqkMCtzFtQ6GA28TD3A8Sd/40Hfh70sVJu6pU9zN1HeGI41fjpYLbgc7SOOvmSrv+
         ApqvShKtk1CzS+bzEbTkHbeaoBQ9mltYBif0G9Ps+FOwwCHZlAUKSlWf3FdmUROpfU8Q
         tOJA==
X-Gm-Message-State: APjAAAWSqtZBhUajSDJ3jkXQCcyKZZsCM/WJS+i8ikC6dKn5HC8DcwHt
        f4ernnnawLFlnM6YEqacNh76dJCMI1lmN//Ilptkhg==
X-Google-Smtp-Source: APXvYqwKR2USXudxvvKfOK55glU2D5y5FMiBAo7oI/W/qo2pfnh4b2Kx5on0RhBtIfzYHBRJ2BHKN9CUkaC5PBmqWrM=
X-Received: by 2002:a02:298b:: with SMTP id p133mr87239176jap.37.1560762627424;
 Mon, 17 Jun 2019 02:10:27 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-11-hch@lst.de>
 <cd713506efb9579d1f69a719d831c28d@mail.gmail.com> <20190608081400.GA19573@lst.de>
 <98f6557ae91a7cdfe8069fcf7d788c88@mail.gmail.com> <20190617084433.GA7969@lst.de>
In-Reply-To: <20190617084433.GA7969@lst.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQNLjZIO2zMn7N+9xPobnDbFSu4o5gI2RJdJAgF+bYgBfxw4kQGu5dmvAzKBgtajXfsrgA==
Date:   Mon, 17 Jun 2019 14:40:25 +0530
Message-ID: <e7443be50725bbdcdb6f1f4cc73955aa@mail.gmail.com>
Subject: RE: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sebastian Ott <sebott@linux.ibm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>
> On Fri, Jun 14, 2019 at 01:28:47AM +0530, Kashyap Desai wrote:
> > Is there any changes in API  blk_queue_virt_boundary? I could not find
> > relevant code which account for this. Can you help ?
> > Which git repo shall I use for testing ? That way I can confirm, I
> > didn't miss relevant changes.
>
> Latest mainline plus the series (which is about to get resent).
> blk_queue_virt_boundary now forced an unlimited max_hw_sectors as that
is
> how PRP-like schemes work, to work around a block driver merging bug.
But
> we also need to communicate that limit to the DMA layer so that we don't
set
> a smaller iommu segment size limitation.
>
> > >From your above explanation, it means (after this patch) max segment
> > >size
> > of the MR controller will be set to 4K.
> > Earlier it is possible to receive single SGE of 64K datalength (Since
> > max seg size was 64K), but now the same buffer will reach the driver
> > having 16 SGEs (Each SGE will contain 4K length).
>
> No, there is no more limit for the size of the segment at all, as for
PRPs each
> PRP is sort of a segment from the hardware perspective.
> We just require the segments to not have gaps, as PRPs don't allow for
that.
Thanks for clarification. I have also observed that max_segment_size Is
unchanged and it is 64K.
>
> That being said I think these patches are wrong for the case of megaraid
or
> mpt having both NVMe and SAS/ATA devices behind a single controller.
> Is that a valid configuration?
Yes. This is a valid configuration.
