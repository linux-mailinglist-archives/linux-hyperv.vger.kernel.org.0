Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDFA543047
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jun 2022 14:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiFHM1j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Jun 2022 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiFHM1j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Jun 2022 08:27:39 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3556B2383F8;
        Wed,  8 Jun 2022 05:27:38 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id q26so17786771wra.1;
        Wed, 08 Jun 2022 05:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=olXSHoK0AVfUatuPzpksjr3kjUvIgoKcvlcJNQWKpqg=;
        b=ChxkkUQRoDL6yMY9Y9uRxuDS1I3u95QMzjFt4BpH/dj5UC3Z9kGOc9Aa1H+JjFyJZH
         pcB6krn8VjkViWJWFP/2hA68Ng9SNXs40Z4xxU18rPgEf7MI6xPeRhn8lF8SG/iL1jXs
         x915nfB9pYP31GTz3bdR1brc1PNH7KQCmo7Dr4dNIZo4I9nv2gpcLxcfVCZuFLT6A3Wg
         aezL3FjjhGn1UHQsExyMCAO+fPhFVTmOT8CODEIf6qzlf/S24Nc1nBmV2Sl5rL+qDre4
         JHT5z3YXj5eg0rTfk65HDTMZvaNAJDelXbmjQ5Mt5THSFp0CgHQ/q9PqnIKNvRsLlj81
         4Zdg==
X-Gm-Message-State: AOAM530Lwqw12cxrNCdrmcl/9J2SSQGFIb2tvfNCs6W4heLBHpcA9UQ2
        yH6N1zCyo19Pnjcy76NKBUE=
X-Google-Smtp-Source: ABdhPJyDnp51cvsxq0KnEnlHaLonX92SKXnq8QCyunTkm09ZTePIxCWrkyJMGc8CFXoQUJkJQd2Lpg==
X-Received: by 2002:a05:6000:1ac8:b0:218:4187:aab6 with SMTP id i8-20020a0560001ac800b002184187aab6mr14902511wry.236.1654691256539;
        Wed, 08 Jun 2022 05:27:36 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b003973ea7e725sm35966983wmq.0.2022.06.08.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 05:27:36 -0700 (PDT)
Date:   Wed, 8 Jun 2022 12:27:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: hyper-v: unexport __init-annotated
 hv_init_clocksource()
Message-ID: <20220608122734.m25chzpwbr5ancnm@liuwe-devbox-debian-v2>
References: <20220606050238.4162200-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606050238.4162200-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 06, 2022 at 02:02:38PM +0900, Masahiro Yamada wrote:
> EXPORT_SYMBOL and __init is a bad combination because the .init.text
> section is freed up after the initialization. Hence, modules cannot
> use symbols annotated __init. The access to a freed symbol may end up
> with kernel panic.
> 
> modpost used to detect it, but it has been broken for a decade.
> 
> Recently, I fixed modpost so it started to warn it again, then this
> showed up in linux-next builds.
> 
> There are two ways to fix it:
> 
>   - Remove __init
>   - Remove EXPORT_SYMBOL
> 
> I chose the latter for this case because the only in-tree call-site,
> arch/x86/kernel/cpu/mshyperv.c is never compiled as modular.
> (CONFIG_HYPERVISOR_GUEST is boolean)
> 
> Fixes: dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocksource ISA agnostic")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied to hyperv-fixes. Thanks.
