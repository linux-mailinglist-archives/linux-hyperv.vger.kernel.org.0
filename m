Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2801570A2F
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiGKS45 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jul 2022 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiGKS4z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jul 2022 14:56:55 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CAA286E9;
        Mon, 11 Jul 2022 11:56:53 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id v14so8202844wra.5;
        Mon, 11 Jul 2022 11:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KfynU0ONiT7u475l+/1mcod2Mte8wQCqPX/XFpyPGaI=;
        b=InaMixG2s2edf71K+Cng4fG/iq6LGdU68qclDEk8V4wyjxfEUAdE600O5LXkIgcK5N
         k1G2EOdYhak6trtqU9Vykh5Nfux4EJxJYPlQExOO3oSxKabNKuvnFuCTz68JmRSND3eH
         p73Z4tqv5212GJguDaMByRMsvbGcmTsnGjpA8VMVUZGaeYT5Wit7dO6jSKnVMKPhZuiw
         RfhtTSRjDhFQ6liz3+BzKjKJC7U64dc5XsH3dJwS3fvc4V09d7rVobeQB+bmfHTWGSe7
         kx8bk5zfgKcS9yDY6nk7PXfnGr9Heb5Bpx/Q1476IzkH5ESuLTjcaMXcRM1BP5RT5uak
         VLTQ==
X-Gm-Message-State: AJIora8sW4o390mQW/idNICWbYiA/zP+A1ObgCjETtKqt6ipqTI1Ozhg
        sZ2WWWQnXjjX45TNi7VbdaGPgJVl6KE=
X-Google-Smtp-Source: AGRyM1sZ+MEU9/ctQbiVEb+E4IvUgo/f3lmZ4jaZf3VeHLufT2UTzEHC0tZWu9HEnPzIpgyzzJ7jsw==
X-Received: by 2002:a05:6000:887:b0:21d:4fca:44fc with SMTP id ca7-20020a056000088700b0021d4fca44fcmr18746416wrb.495.1657565812270;
        Mon, 11 Jul 2022 11:56:52 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003a2cf5eb900sm4931754wmi.40.2022.07.11.11.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 11:56:52 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:56:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>, corbet@lwn.net
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Documentation: hyperv: Add basic info on Hyper-V
 enlightenments
Message-ID: <20220711185640.px4bwf4ldqqqw5ij@liuwe-devbox-debian-v2>
References: <1657561704-12631-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657561704-12631-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 11, 2022 at 10:48:21AM -0700, Michael Kelley wrote:
> This documentation is a high level overview to explain the basics
> of Linux running as a guest on Hyper-V. The intent is to document
> the forest, not the trees. The Hyper-V Top Level Functional Spec
> provides conceptual material and API details for the core Hyper-V
> hypervisor, and this documentation provides additional info on
> how that functionality is applied to Linux. Also, there's no
> public documentation on VMbus or the VMbus synthetic devices, so
> this documentation helps fill that gap at a conceptual level. This
> documentation is not API-level documentation, which can be seen
> in the code and associated comments.
> 
> More topics will be added in future patches, including:
> 
> * Miscellaneous synthetic devices like KVP, timesync, VSS, etc.
> * Virtual PCI support
> * Isolated/Confidential VMs
> * UIO driver
> 
> If you think I'm missing a topic that fits into the overall
> approach as described, feel free to suggest text, or let me
> know and I can add it to my list.
> 
> Changes in v2:
> * Updated clocks.rst to use section hierarchy that matches
>   overview.rst and vmbus.rst [Wei Liu]
> 
> Michael Kelley (3):
>   Documentation: hyperv: Add overview of Hyper-V enlightenments
>   Documentation: hyperv: Add overview of VMbus
>   Documentation: hyperv: Add overview of clocks and timers

Content-wise all patches look good to me.

Jonathan, let me know how you would like to handle this series. I'm
happy to carry them in hyperv-next.

Thanks,
Wei.
