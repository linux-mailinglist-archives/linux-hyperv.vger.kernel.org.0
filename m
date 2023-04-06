Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD66DA489
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Apr 2023 23:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjDFVQG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Apr 2023 17:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFVQF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Apr 2023 17:16:05 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B806D59D3;
        Thu,  6 Apr 2023 14:16:04 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so20760423wms.5;
        Thu, 06 Apr 2023 14:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815763; x=1683407763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lOB5ARfGOYEbOJuOOIkoDNFazek9EYhd8NdB3O+Pqc=;
        b=T1EQxXwBGxRCzd+nQ/X9dscNsP85DNGmxbnIPhED2zM/jcIkui9WY00IC7LFaQcSdq
         pV8l8n7gtGFhPlFYXTPnRmRaipn0ayUuz6EAmsuO8J9nu/EKNCk89lMH9QP7asAzS+pv
         84LVB9uVdCldScuIyRDRY/TvnkRXfYszm17UqT03ndftjj5PC01b154UGP5Xj4lhk6KG
         DEcIQJ8qE8vsdvRQc6SkKyhA2DYcHJdglzrDR116lA2fBRs8RcXx+K7NS+1LgP8f0Sp/
         W0Q/TYU0L8dx1Hb0KLtbXrLRGa/Bv+m9U/lxaF2TtSQ1guHp38ZXbWhIVpjIjOWgztiW
         8EAw==
X-Gm-Message-State: AAQBX9cRB5toQ7gSjUJooW3JJafknxsA8CbCNbK1XdLoYUiChJ4o+sho
        CXnChuyggbgBGA+ZJsycqqQ=
X-Google-Smtp-Source: AKy350bFBFVzLm2hXJDAAJFmqfFoFiqu7tuqcsv6GPx8JyFGzRWcMGQcFcO3U1/dMGr4ogDL/rsj8w==
X-Received: by 2002:a05:600c:b53:b0:3ed:9a09:183 with SMTP id k19-20020a05600c0b5300b003ed9a090183mr8535149wmr.2.1680815762942;
        Thu, 06 Apr 2023 14:16:02 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c378800b003edff838723sm2637515wmr.3.2023.04.06.14.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:16:02 -0700 (PDT)
Date:   Thu, 6 Apr 2023 21:15:59 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v9 0/5] Device tree support for Hyper-V VMBus driver
Message-ID: <ZC82j/M2DTozOmo0@liuwe-devbox-debian-v2>
References: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 20, 2023 at 12:47:35AM -0700, Saurabh Sengar wrote:
> This set of patches expands the VMBus driver to include device tree
> support. This feature allows for a kernel boot without the use of ACPI
> tables, resulting in a smaller memory footprint and potentially faster
> boot times. This is tested by enabling CONFIG_OF and OF_EARLY_FLATTREE
> for x86.
> 
> The first two patches enable compilation of Hyper-V APIs in a non-ACPI
> build.
> 
> The third patch converts the VMBus driver from acpi to more generic
> platform driver.
> 
> The fourth patch introduces the device tree documentation for VMBus.
> 
> The fifth patch adds device tree support to the VMBus driver. Currently
> this is tested only for x86 and it may not work for other archs.
> 
[...]
>  .../bindings/bus/microsoft,vmbus.yaml         |  54 ++++++++
>  MAINTAINERS                                   |   1 +
>  drivers/clocksource/hyperv_timer.c            |  15 ++-
>  drivers/hv/Kconfig                            |   5 +-
>  drivers/hv/vmbus_drv.c                        | 122 ++++++++++++++----
>  include/linux/acpi.h                          |   5 +
>  6 files changed, 172 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> 

Applied to hyperv-next.

Thanks,
Wei.

> -- 
> 2.34.1
> 
