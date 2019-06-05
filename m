Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D04036828
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 01:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFEXfR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 19:35:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:47051 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEXfR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 19:35:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id 203so271769oid.13;
        Wed, 05 Jun 2019 16:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sP5Jo/+KivdI/bxh9Ffstcmb0kFLHw7pjLkPnap8FYc=;
        b=NTdJRAn38Knw/o6Kpz/DTy4VHA00ps4Mlf+O/OUDpJv2kE7FLxTf21fLcN6f5AhjKs
         BDNIbngrm+6cwPr8Nj8qT/BFM5rJcHdyWjMiK4Subnv++rms9EXd79hOxs96Qs2cYODF
         DafQnhciKV5UIQ+q2cznW0yYkXPG+EyEQpaUzBqAnpQbXfZJ0MMiM/3hBRzv1lIeU2jC
         HsPCa0qF+n060RsHi/nhmZGrdhgZB5AyWEJYS8n/ri+YuRCMphJxNkT6AHJwzl3+34Zi
         T406AUeC4IolYF+2PeTXMT8PLIjAJN3BmnU7a8AAw+GlUV3HPwGJx2bKSiHvOSs6lwVb
         H5hQ==
X-Gm-Message-State: APjAAAVNBtkbAV/O4Kjg4bvytKvVSQCorrMTFnERYs1EOVz8ssw2GehO
        vXAsOoM0yXXsQWFrttZtyFXCGSCh
X-Google-Smtp-Source: APXvYqxKdRuZiaGzWrM69Xb9VlwdZWMVuRphCu6AjNPc/fgK/sF4SQPpB4XYM1onfx/CRY0xjH7dIQ==
X-Received: by 2002:aca:dd08:: with SMTP id u8mr5800529oig.27.1559777716296;
        Wed, 05 Jun 2019 16:35:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id m32sm56535otc.55.2019.06.05.16.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 16:35:15 -0700 (PDT)
Subject: Re: [PATCH 08/13] IB/iser: set virt_boundary_mask in the scsi host
To:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sebastian Ott <sebott@linux.ibm.com>,
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
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-9-hch@lst.de> <20190605202235.GC3273@ziepe.ca>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b3e46295-4257-86ad-6994-f83b736c8f40@grimberg.me>
Date:   Wed, 5 Jun 2019 16:35:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605202235.GC3273@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


>> This ensures all proper DMA layer handling is taken care of by the
>> SCSI midlayer.
> 
> Maybe not entirely related to this series, but it looks like the SCSI
> layer is changing the device global dma_set_max_seg_size() - at least
> in RDMA the dma device is being shared between many users, so we
> really don't want SCSI to make this value smaller.
> 
> Can we do something about this?

srp seems to do the right thing:
target_host->max_segment_size = ib_dma_max_seg_size(ibdev);

But iser does not, which means that scsi limits it to:
BLK_MAX_SEGMENT_SIZE (64k)

I can send a fix to iser.

> Wondering about other values too, and the interaction with the new
> combining stuff in umem.c

The only other values AFAICT is the dma_boundary that rdma llds don't
set...
