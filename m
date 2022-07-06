Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15A569153
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 20:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiGFSCN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 14:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiGFSCM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 14:02:12 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8D2982A;
        Wed,  6 Jul 2022 11:02:11 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id s1so23132200wra.9;
        Wed, 06 Jul 2022 11:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MasjB4ti5D0nWT5bZJTXtMcJnOkBN1+uFVq/8iV4VKs=;
        b=yu1aQTs7WkcJ4kh9JGIWPWeCA0t2+XlcbxrWbfoEskEA3JBNk2j353lHwk71M7qL3E
         vpAnMHxrkNihs5+x3WiCXQpefaFdl5VfUvzPrlbW5WKMznnsCsrfLoShP+8DsACGZzMY
         qvJog6pv8cGmp8Mvhwv1PdAejAWPoZTDYejDOvaUDyYnOipcoe8JqJlbIi5iYDtC+AMI
         2CuKzbG1EmovX96TKLFH4w5K94smRFgzvguXj97OUO1BcbyYD5eGza6ex7081udSw8HI
         OtQeCuYOyQ/vY9gucGhjChEPyEiq9yrFDoHvZhparA7/4lak4M9Phuz718DcwK4GSQRq
         Qzzg==
X-Gm-Message-State: AJIora/mg3DzKCbmoWVvsQD862FCNUFFX69hAhBg7j4MSwmgfXX1W/1E
        h0WrBIkhHHCDGI/x0vgxLsw=
X-Google-Smtp-Source: AGRyM1tk/U4/6eCYpFPdnfxUnu5ItxivRnpw+FlWiwuiHP6kV0yGCCQgDA5ISI8avG5T8OlQIWHpOg==
X-Received: by 2002:a05:6000:2cf:b0:21b:a920:182c with SMTP id o15-20020a05600002cf00b0021ba920182cmr39869750wry.317.1657130530233;
        Wed, 06 Jul 2022 11:02:10 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u1-20020a5d6ac1000000b0021b95bcaf7fsm8780497wrw.59.2022.07.06.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:02:09 -0700 (PDT)
Date:   Wed, 6 Jul 2022 18:02:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        kernel@openvz.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Create debugfs file with hyper-v balloon usage
 information
Message-ID: <20220706180202.bzbm6boi232bruct@liuwe-devbox-debian-v2>
References: <20220705094410.30050-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705094410.30050-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 05, 2022 at 09:44:09AM +0000, Alexander Atanasov wrote:
[...]
> +/*
> + * DEBUGFS Interface
> + */
> +#ifdef CONFIG_DEBUG_FS
> +
> +/**
> + * virtio_balloon_debug_show - shows statistics of balloon operations.

C&P error here. :-)

> + * @f: pointer to the &struct seq_file.
> + * @offset: ignored.
> + *
> + * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
> + *

Ditto.

Wei.
