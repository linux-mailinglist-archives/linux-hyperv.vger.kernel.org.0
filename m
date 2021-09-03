Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8885A3FFE8A
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Sep 2021 13:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhICLBx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Sep 2021 07:01:53 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42727 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhICLBw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Sep 2021 07:01:52 -0400
Received: by mail-wr1-f53.google.com with SMTP id q11so7636166wrr.9;
        Fri, 03 Sep 2021 04:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z6GVL1wIeWVALqU3jsQmSjsKn0n0m0G8vPnD8bplNA8=;
        b=Q3scn8Vom6UJ7snhFLNDmLLiTeQoxEdP8KEYoRqyUTU1nAPZSniFEcaqJtEevqRoU3
         uFLtHMS5unfHmH1tokv4mobuf9MQo16my0ayw4uy2LsYfYsj7MZmemsq+ekuKjWYCE5M
         wsYf5IjGWTUDdTH1AR4CkCNddBw+gKyEk0SP04KHunQC5gjpuWPtjSzdoawXBiTZxqH2
         cfej8oq6eLgRPiGQAhQJ9lgd/G0qjdHmJ6f0PCxvqhV1grlH7McyU7T9a4yt4X2SIGqe
         gSUnBqP4MpESvHYzpqSllMJ562EBxs5T6SAu02wKDrY53J4vq2Br4HQ8rzw+PKAt71Ng
         y2/g==
X-Gm-Message-State: AOAM530qpc5xRQIwMtQTPrsjKWn8eapTIV9SGY/dLio9rW8SWegUHscv
        fYFGS+f+kOpo/65fwWlQgQ8=
X-Google-Smtp-Source: ABdhPJxzaN4IfPLvVvi3SBQ5W3dyON4YPrGcq2aLE4xAMpbwRDQ2P5MCbbkguEZu/PWedMZ0+K9/yQ==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr3354526wrs.271.1630666851930;
        Fri, 03 Sep 2021 04:00:51 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m186sm4181069wme.48.2021.09.03.04.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 04:00:51 -0700 (PDT)
Date:   Fri, 3 Sep 2021 11:00:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, Andres Beltran <lkmlabelt@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix kernel crash upon unbinding a
 device from uio_hv_generic driver
Message-ID: <20210903110049.so5otrec4bvjse3j@liuwe-devbox-debian-v2>
References: <20210831143916.144983-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831143916.144983-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:16PM +0200, Vitaly Kuznetsov wrote:
> The following crash happens when a never-used device is unbound from
> uio_hv_generic driver:
> 
[...]
> Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied to hyperv-fixes. Thanks.
