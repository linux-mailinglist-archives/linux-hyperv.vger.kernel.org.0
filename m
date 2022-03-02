Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964094CA7F3
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 15:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiCBO0F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 09:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242888AbiCBO0E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 09:26:04 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A214C55B7;
        Wed,  2 Mar 2022 06:25:21 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id d3so3093425wrf.1;
        Wed, 02 Mar 2022 06:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kxdri9q+ImUk+tYNnXVNgw+CIHacKN0zItHgqZfNyWQ=;
        b=WYCqEibNCcrwhlb7IXnHxkjm2d87gdLVFMhZdPmycQwLmhrt4wCnDIH+TUas4yjfME
         3VyjyPY7Jjs6l7rB0puB4vGm4drhAlMxMnz2ltKvsiWHD6AwihIGBS6g0g4BQxaFQuWK
         H8WjWRlsMCL3MKl6rgz2rWVG9ZVFhz4ssOb+jUfGCffaEZjxSYPyurpJaemhOeYHiory
         IN6fRJAtmq7e6BTFwouL6bCGQV7VuqI+7DDMAK3b+HX2wPTjzvl1a1hH3Sp/B4QmnGk3
         Oq7luqWwwo3KdHVCeMGLpIqCqjWBFX5I1gFhyMHdD8lRP8sH3WOAVE7mlfmoQoz25vQI
         QEEA==
X-Gm-Message-State: AOAM533lc57vrsvgSjimETx2lizmUoeA9Tn/ndlCyKpz/MNR8i9ThvfW
        RhvmqL8RXI20uHRF/L2iEug=
X-Google-Smtp-Source: ABdhPJz2ihW0hJ9b0Jj5a4/ctp2ZUL3Ymzc6jcXIOIys+3eJOBqLVCiKIVUVwlVbTIJuILf6tYfObA==
X-Received: by 2002:adf:e804:0:b0:1ea:9c3b:8f41 with SMTP id o4-20020adfe804000000b001ea9c3b8f41mr23755756wrm.53.1646231119675;
        Wed, 02 Mar 2022 06:25:19 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c2c4c00b003816932de9csm5839440wmg.24.2022.03.02.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:25:19 -0800 (PST)
Date:   Wed, 2 Mar 2022 14:25:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 26/30] drivers: hv: dxgkrnl: Offer and reclaim
 allocations
Message-ID: <20220302142517.kgc5o7ufj2yf4cif@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <3a6779567438b02566012679f01ebb065e3761db.1646163379.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6779567438b02566012679f01ebb065e3761db.1646163379.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:46:13AM -0800, Iouri Tarassov wrote:
> Implement ioctls to offer and reclaim compute device allocations:
>   - LX_DXOFFERALLOCATIONS,
>   - LX_DXRECLAIMALLOCATIONS2
> 
> When a user mode driver (UMD) does not need to access an allocation,

What is a "user mode driver" in this context? Is that something that
runs inside the guest?

> it can "offer" it by issuing the LX_DXOFFERALLOCATIONS ioctl.  This
> means that the allocation is not in use and its local device memory
> could be evicted. The freed space could be given to another allocation.
> When the allocation is again needed, the UMD can attempt to"reclaim"
> the allocation by issuing the LX_DXRECLAIMALLOCATIONS2 ioctl. If the
> allocation is still not evicted, the reclaim operation succeeds and no
> other action is required. If the reclaim operation fails, the caller
> must restore the content of the allocation before it can be used by
> the device.
> 
> Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
