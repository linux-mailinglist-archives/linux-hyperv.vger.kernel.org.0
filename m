Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE22A5235D3
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 May 2022 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbiEKOmK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 May 2022 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbiEKOmJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 May 2022 10:42:09 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0010633B0;
        Wed, 11 May 2022 07:42:07 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id q23so3334513wra.1;
        Wed, 11 May 2022 07:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wWjzqUVJD0Jte80wOSD+g8/wcFURTJpU9/E2wgFugws=;
        b=N7uepyHGbC+tksq7Mkcncvgk9IXVyL9Mj9qx/CKFMx55E2qQSjqCu2EijqYVfcdm0/
         cG5kkhJt2WGK3Q63Fw9WeQRlJdl+mw8QNsNpUJDd9xB1SccnqYwda9ibjqaFoZ2318+A
         7VCINuDluVU4FGca679u3sSEmkEKf/DsU663CvIUBRl/pnZ/gBX78Ko9gcfi6ZFx8bNB
         jxTRPrfKjH0bxloQm7cCMhypKJIXsxVEIy9zDHFe+UuSG6xgQxqw9VXaN9akEtjXdI0n
         GE4hBnfWloOXkVua9B9HjI3aTQ8XIdP+FC84A4AetfoL6kUK2m2pQMXgwd6+2V1k+6xX
         5Feg==
X-Gm-Message-State: AOAM532f/3spfknKrGEO0fLYDXsiKl62oDYkLjz8zXUve7J5Ka6gBiXI
        6cIYKnVP/KCEgi0l3iMLr38=
X-Google-Smtp-Source: ABdhPJyJHl0yysMgUBB0X0fbIv9vHIIwvc08c3iHw4pfVSZWejdHpsGKKrKasDCwPGrEq2VYeEJO7A==
X-Received: by 2002:a05:6000:1c02:b0:20c:7d20:cad6 with SMTP id ba2-20020a0560001c0200b0020c7d20cad6mr23036511wrb.373.1652280126132;
        Wed, 11 May 2022 07:42:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s10-20020a7bc0ca000000b003942a244f34sm23407wmh.13.2022.05.11.07.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:42:05 -0700 (PDT)
Date:   Wed, 11 May 2022 14:42:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com,
        decui@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, jejb@linux.ibm.com, martin.petersen@oracle.com,
        deller@gmx.de, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove support for Hyper-V 2008 and 2008R2/Win7
Message-ID: <20220511144204.ilpsk2oiyknh7cys@liuwe-devbox-debian-v2>
References: <1651509391-2058-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651509391-2058-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 02, 2022 at 09:36:27AM -0700, Michael Kelley wrote:
> Linux code for running as a Hyper-V guest includes special cases for the
> first released versions of Hyper-V: 2008 and 2008R2/Windows 7. These
> versions were very thinly used for running Linux guests when first
> released more than 12 years ago, and they are now out of support
> (except for extended security updates). As initial versions, they
> lack the performance features needed for effective production usage
> of Linux guests. In total, there's no need to continue to support
> the latest Linux kernels on these versions of Hyper-V.
> 
> Simplify the code for running on Hyper-V by removing the special
> cases. This includes removing the negotiation of the VMbus protocol
> versions for 2008 and 2008R2, and the special case code based on
> those VMbus protocol versions. Changes are in the core VMbus code and
> several drivers for synthetic VMbus devices.
> 
> Some drivers have driver-specific protocols with the Hyper-V host and
> may have versions of those protocols that are limited to 2008 and
> 2008R2. This patch set does the clean-up only for the top-level
> VMbus protocol versions, and not the driver-specific protocols.
> Cleaning up the driver-specific protocols can be done with
> follow-on patches.
> 
> There's no specific urgency to removing the special case code for
> 2008 and 2008R2, so if the broader Linux kernel community surfaces
> a reason why this clean-up should not be done now, we can wait.
> But I think we want to eventually stop carrying around this extra
> baggage, and based on discussions with the Hyper-V team within
> Microsoft, we're already past the point that it has any value.
> 
> Michael Kelley (4):
>   Drivers: hv: vmbus: Remove support for Hyper-V 2008 and Hyper-V
>     2008R2/Win7
>   scsi: storvsc: Remove support for Hyper-V 2008 and 2008R2/Win7
>   video: hyperv_fb: Remove support for Hyper-V 2008 and 2008R2/Win7
>   drm/hyperv: Remove support for Hyper-V 2008 and 2008R2/Win7

Applied to hyperv-next.
