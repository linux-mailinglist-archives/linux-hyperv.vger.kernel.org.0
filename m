Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8248F04D
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jan 2022 20:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243979AbiANTNL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jan 2022 14:13:11 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:44825 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiANTNK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jan 2022 14:13:10 -0500
Received: by mail-wm1-f49.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so7439883wmf.3;
        Fri, 14 Jan 2022 11:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=80fbgApjgxRqmQ/SUBxRZx2r8MYqVc4l2XpDiV7SkBM=;
        b=irS5VW+96mvUlD17dHtUUD+q4jmXY4vqtc/g+92N1VXrHOsQC8A7Zrrf9Ik01F1kaY
         uWCgFK2yV+PtjrNdCX+rMMvYIz4WVq6n1OFh0nSRuf9veMQ3GQB8BN/5e0fUsdFCWOrr
         xRfm5+mb3vYMXAzEASJH5iuj+QYIN+MEjJEJPpaItgF+Ay26GWFZnpW+iGKhf7sfyfiR
         ogLLs3WCX2zCjzh5jyInRMWj68bXCUjEfBHQBJTiy6zT+R7AT9dAyEovmgHRGP1Ev7xp
         SZlIrD4pI1U9/uKKxsvdJB/RrFhdC45bZBg0ydFs0pvZ2DSFwRLQeaA5a75d3ERXKHbl
         nBGA==
X-Gm-Message-State: AOAM533RHNoEUsgE/6GzyXYXCpKe1AIQ6Ai1+HYYHo9sbi/X7rCBZWqn
        O5WBci29QQC9wWf4JH0BYuGhWlBUjDk=
X-Google-Smtp-Source: ABdhPJy6FfH4KDLMgZmC0MFcbsFJm4Zgm0/mXIWR4k8R0ydt6WvRRewAXvkkhnsGqSP3BX2Qwg91pg==
X-Received: by 2002:a05:600c:6020:: with SMTP id az32mr3830646wmb.149.1642187589431;
        Fri, 14 Jan 2022 11:13:09 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z6sm7961353wmp.9.2022.01.14.11.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 11:13:08 -0800 (PST)
Date:   Fri, 14 Jan 2022 19:13:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Yanming Liu <yanminglr@gmail.com>, linux-hyperv@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, mikelley@microsoft.com, lkmlabelt@gmail.com
Subject: Re: [PATCH v2] hv: account for packet descriptor in maximum packet
 size
Message-ID: <20220114191307.uu2oel7wbxhiqe56@liuwe-devbox-debian-v2>
References: <20220109095516.3250392-1-yanminglr@gmail.com>
 <20220110004419.GA435914@anparri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110004419.GA435914@anparri>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 10, 2022 at 01:44:19AM +0100, Andrea Parri wrote:
> (Extending Cc: list,)
> 
> On Sun, Jan 09, 2022 at 05:55:16PM +0800, Yanming Liu wrote:
> > Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V
> > out of the ring buffer") introduced a notion of maximum packet size in
> > vmbus channel and used that size to initialize a buffer holding all
> > incoming packet along with their vmbus packet header. Currently, some
> > vmbus drivers set max_pkt_size to the size of their receive buffer
> > passed to vmbus_recvpacket, however vmbus_open expects this size to also
> > include vmbus packet header. This leads to corruption of the ring buffer
> > state when receiving a maximum sized packet.
> > 
> > Specifically, in hv_balloon I have observed of a dm_unballoon_request
> > message of 4096 bytes being truncated to 4080 bytes. When the driver
> > tries to read next packet it starts from a wrong read_index, receives
> > garbage and prints a lot of "Unhandled message: type: <garbage>" in
> > dmesg.
> > 
> > The same mismatch also happens in hv_fcopy, hv_kvp, hv_snapshot,
> > hv_util, hyperv_drm and hyperv_fb, though bad cases are not observed
> > yet.
> > 
> > Allocate the buffer with HV_HYP_PAGE_SIZE more bytes to make room for
> > the descriptor, assuming the vmbus packet header will never be larger
> > than HV_HYP_PAGE_SIZE. This is essentially free compared to just adding
> > 'sizeof(struct vmpacket_descriptor)' because these buffers are all more
> > than HV_HYP_PAGE_SIZE bytes so kmalloc rounds them up anyway.
> > 
> > Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
> > Suggested-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > Signed-off-by: Yanming Liu <yanminglr@gmail.com>
> 
> Thanks for sorting this out; the patch looks good to me:
> 
> Reviewed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> 

Thanks. I will pick this up after 5.17-rc1 is out.

Wei.
