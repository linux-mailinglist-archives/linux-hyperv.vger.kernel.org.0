Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD24F7ED75
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfHBHaW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 03:30:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389655AbfHBHaW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 03:30:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so76067484wru.13
        for <linux-hyperv@vger.kernel.org>; Fri, 02 Aug 2019 00:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qpvX7/WeVyRtLNS5W1XR6+ViveiHMM5DFdzi+nH8f/c=;
        b=k+nk7ZavB98cTEaAw3S4gPxvdyunWwIqZqRj5tFoGTp8y8blApQMlGnuTSB48zrKxy
         JpBi8Z0Uu60Ur1foma0nEfLazZq+9wSxyjaSx8GhdBslk7GQXffjFdy3MHLErG9+aRrc
         IZsds0F/Q+ofjke11LKlPrJpPKHFG8cDCctgyIjoiji1GkOEFgyXfS7ZKSdQrnk4Tg0q
         29G9pwkBB9NJqNVKwH0mF/ZHaQP8r7HvKxGQvHgFm9anuchZ25N2WQnSU4LFXXc9PIhD
         Rs3HB2AZcmknl5vZVmsz1BqKNLk/3+it7JvFdHIdgWU7ykQIw0s/WWyCBETqBdU3clP1
         2drA==
X-Gm-Message-State: APjAAAU6mB1R0zhYjKNB1SQrS3ipfkpUR/pKNEFrOZmvEq8JS3G9r+cO
        h3DqfG2OqPe21Qq8A/7so/JXDw==
X-Google-Smtp-Source: APXvYqxmdlPd/oQ5dQRfxfIqrgz1a/a7DfY/skn79VPh1U4+qZY7pWaVE7vccEualPXpFdaLBMOXjw==
X-Received: by 2002:adf:9f0e:: with SMTP id l14mr4855268wrf.23.1564731020432;
        Fri, 02 Aug 2019 00:30:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id c78sm102668211wmd.16.2019.08.02.00.30.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 00:30:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Branden Bonaby <brandonbonaby94@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH 0/3] hv: vmbus: add fuzz testing to hv devices
In-Reply-To: <cover.1564527684.git.brandonbonaby94@gmail.com>
References: <cover.1564527684.git.brandonbonaby94@gmail.com>
Date:   Fri, 02 Aug 2019 09:30:18 +0200
Message-ID: <87ftmkgh2t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Branden Bonaby <brandonbonaby94@gmail.com> writes:

> This patchset introduces a testing framework for Hyper-V drivers.
> This framework allows us to introduce delays in the packet receive
> path on a per-device basis. While the current code only supports 
> introducing arbitrary delays in the host/guest communication path,
> we intend to expand this to support error injection in the future.
>
> Branden Bonaby (3):
>   drivers: hv: vmbus: Introduce latency testing
>   drivers: hv: vmbus: add fuzz test attributes to sysfs
>   tools: hv: add vmbus testing tool
>
>  Documentation/ABI/stable/sysfs-bus-vmbus |  22 ++
>  drivers/hv/connection.c                  |   5 +
>  drivers/hv/ring_buffer.c                 |  10 +
>  drivers/hv/vmbus_drv.c                   |  97 ++++++-

Can we have something like CONFIG_HYPERV_TESTING and put this new 
code under #ifdef?

>  include/linux/hyperv.h                   |  14 +
>  tools/hv/vmbus_testing                   | 326 +++++++++++++++++++++++
>  6 files changed, 473 insertions(+), 1 deletion(-)
>  create mode 100644 tools/hv/vmbus_testing

-- 
Vitaly
