Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D495691AA
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 20:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiGFSZp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiGFSZp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 14:25:45 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01164C0B;
        Wed,  6 Jul 2022 11:25:44 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r14so17425784wrg.1;
        Wed, 06 Jul 2022 11:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TIOB9IrtLnqFf4KPQh9ItO5Gaokkdn7VSUsHLdejGLY=;
        b=F99/DD4PUqwSp5su9sXgvfnL2FI137VvBJQ5F9nCDfGmFZzdt4+49DxF9ONdw0PXHH
         2P7IvJmgGPkv4ZAfNBjd0NBFEiJ3bRqF8dvywNBoey9TLd/poZ0GDmetydKUa+NkSszb
         Mf3NJEmuaz8bzpAgzmBQ74m54ryvV7ej31Haf8LEBMy8xeRKXNCepS2yKc0TyY/GlJFn
         PM/EQ+3YLQUnrsTn6wNJ8WQGJkbX1Brt2mgJdi+Yk+RicgqIGPB4nwH4A0ZTpT/fElF0
         d17KHHLhLZB8fVhxVZ+rDlb7ohCIloSYJBAxgtu2dJdWzAxtKU0AKu4PK0NjTj0ozpcl
         OVXQ==
X-Gm-Message-State: AJIora+AQqF21USnv2PALAPm09H8Q5uHF48vk4S5ltA5bFuFkg8pBGO0
        ohWfQbqP2Z+G7FmUYXyCoV5GU0q5uzg=
X-Google-Smtp-Source: AGRyM1vzLWCAi6yfOQV8RQeZC4m18r7v7kCpv4ISozeEehSZliLjv0JJUt12KNR1sffkZdMH6kQ1Bw==
X-Received: by 2002:a5d:44d1:0:b0:21d:7471:2094 with SMTP id z17-20020a5d44d1000000b0021d74712094mr9742793wrr.374.1657131942608;
        Wed, 06 Jul 2022 11:25:42 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m1-20020a056000008100b0021d7ff34df7sm1690160wrx.117.2022.07.06.11.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:25:42 -0700 (PDT)
Date:   Wed, 6 Jul 2022 18:25:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: hyperv: Add overview of clocks and
 timers
Message-ID: <20220706182534.kh2f4qmjss4635bf@liuwe-devbox-debian-v2>
References: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
 <1657035822-47950-4-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657035822-47950-4-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 05, 2022 at 08:43:42AM -0700, Michael Kelley wrote:
> Add documentation topic for clocks and timers when running as a
> guest on Hyper-V.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  Documentation/virt/hyperv/clocks.rst | 73 ++++++++++++++++++++++++++++++++++++
>  Documentation/virt/hyperv/index.rst  |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/virt/hyperv/clocks.rst
> 
> diff --git a/Documentation/virt/hyperv/clocks.rst b/Documentation/virt/hyperv/clocks.rst
> new file mode 100644
> index 0000000..e4ba2890
> --- /dev/null
> +++ b/Documentation/virt/hyperv/clocks.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Clocks and Timers
> +-----------------

This seems to be inconsistent with regard to the other two files -- they
use "=" signs for the title.

> +
> +arm64
> +~~~~~

And the other files use "-" for this (second?) level.

Thanks,
Wei.
