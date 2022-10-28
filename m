Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7F610EE3
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Oct 2022 12:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiJ1KnH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Oct 2022 06:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJ1Kmz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Oct 2022 06:42:55 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D73D5B0;
        Fri, 28 Oct 2022 03:42:53 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so6343063wmr.2;
        Fri, 28 Oct 2022 03:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzy+UU3gjOa5g3ayQGLm9vYU6Ho6NVmbqvDVQZef+sU=;
        b=EZTw1oFqpPOGucJh8pZoQOAYelVRPlve0taEJCuPc1iWF4u9BgSnITVqbS2TCBzzs0
         nialgBmeQTXC1ALPFgyIgRgxCyu0uIb3KhrLRR/8ifbgfBmWJFscNwq9rschyOXPQG47
         YamkzuT/bkhxjZX64AVFIe8IBPsKUEvsLOESoaNsHQvL2MNZ1zetQoIyftCiWrp0bMCU
         ve4EKzaT0jyujG10yQ+OH8oNh1YAVCuu080dI+nvghGmTxdakszNXc0hD66I4+tzuWSz
         Z+xdqW3+uL69ssAR5Y2ip/jLNyhJwVo8VTbn84lEy8UeKhOmqeemXi2kEiQ8J+0F8rCF
         aOSw==
X-Gm-Message-State: ACrzQf0O3XQG79aCFNIX8X93gKqZXUH/PwaM9AVC+c/aRQ2lFdPqW/MU
        dURi7S81nKRkH2sJhLZ2fVM=
X-Google-Smtp-Source: AMsMyM6Ylw6n0ZvtWJuew2c9Z0/W8+r4x3X4HOPsGQAfPZHO93f21qUr5AyBAkE7U+Cy6W2MBsdh/A==
X-Received: by 2002:a05:600c:4f04:b0:3c6:fae5:b4d4 with SMTP id l4-20020a05600c4f0400b003c6fae5b4d4mr9150806wmq.103.1666953772302;
        Fri, 28 Oct 2022 03:42:52 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b003cdf141f363sm4336398wmq.11.2022.10.28.03.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:42:51 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:42:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v2 0/2] Configurable order free page reporting in hyper-v
Message-ID: <Y1uyKXva4M9PoGWY@liuwe-devbox-debian-v2>
References: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 29, 2022 at 11:01:37PM -0700, Shradha Gupta wrote:
[...]
> 
> Shradha Gupta (2):
>   mm/page_reporting: Add checks for page_reporting_order param
>   hv_balloon: Add support for configurable order free page reporting
> 

Applied to hyperv-next. Thanks.
