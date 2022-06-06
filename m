Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06F53E245
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jun 2022 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiFFHAJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jun 2022 03:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiFFG75 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jun 2022 02:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB84912093
        for <linux-hyperv@vger.kernel.org>; Sun,  5 Jun 2022 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654498794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOtzSuAWugs2jYxku/paVOt/7+PibxrDQ20HWjPBIW0=;
        b=Po9c3jcjIubOWPVhMQmaBDe5kQNiVo9AvTM2abNeH+UlvglQsR71az921UJXCVCZ3Nuu02
        Q/C6lCNtBIYJUPAfqLGk5fykKJ8AYeWXvjKH+FX31mSWGzxoiRbO7uYfJjSvCDYJkhAY8b
        em8fFqT8z6fIUV7BM2ooyVisjVNudCg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-ZQB1SY-yOzqF8xKpIV8_lw-1; Mon, 06 Jun 2022 02:59:50 -0400
X-MC-Unique: ZQB1SY-yOzqF8xKpIV8_lw-1
Received: by mail-wr1-f72.google.com with SMTP id c11-20020adffb4b000000b0020ff998391dso2478297wrs.8
        for <linux-hyperv@vger.kernel.org>; Sun, 05 Jun 2022 23:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gOtzSuAWugs2jYxku/paVOt/7+PibxrDQ20HWjPBIW0=;
        b=pPTdjSemECuNkQMskEkMrlRKmo0CIMObBeCxXOnxaJ+mO9HP+TY/bsauA/pv3GDeZH
         kgIi0zraPQJsutGd1NO7sJswlgNIYw0OMyAmYKp0g79OPIIgayP8cdYPQyVZ3S6TKpwP
         TcYSW7idDYKSRhImwDD6B9w5VIKqwCXG1G4lcssFpTUYl+zhFSk4uuy/6NgcxT0RM9+J
         fjFJWgxjRVOb9+HVeJ8FATi2Kb0YtyyTKCiOW+/7mJoZpbla/CnI+e4XkevhGVuAVgH5
         zV2tR1a3FtPl2BaHhPsCRqMDN3ujN67vjevXFhKkiBBVNL8Iwdo/rK6hcN5KI2zvKWXu
         qgiA==
X-Gm-Message-State: AOAM532jkawjzG5dThcHxF6WuxyaXck+6uc71bSO6FqRd+uETVZbpup3
        FKnNll8100qEE/0jK2pcenL8eW8cljaR/KoyKtiZrwnJdKS+9EcxmDIeZPxwBdTNW27ZAMcELOs
        SSa7kXht2FP6m+QdpSzxyofnmfLiDyiN7Qm9pFmlTYAADLdRItqnMpkGtf1QncXwtRQjGuttLFs
        gX
X-Received: by 2002:a05:6000:1250:b0:210:3385:1c8b with SMTP id j16-20020a056000125000b0021033851c8bmr20109083wrx.623.1654498789680;
        Sun, 05 Jun 2022 23:59:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHeKxOBS3tR5Dn9HZuuYl4ChO3EJmHj+F54erbEVQCK6MD/uO0HjL4EbwLRBh3LwM4erMheQ==
X-Received: by 2002:a05:6000:1250:b0:210:3385:1c8b with SMTP id j16-20020a056000125000b0021033851c8bmr20109059wrx.623.1654498789452;
        Sun, 05 Jun 2022 23:59:49 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfea43000000b0020d02262664sm14195815wrn.25.2022.06.05.23.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 23:59:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] clocksource: hyper-v: unexport __init-annotated
 hv_init_clocksource()
In-Reply-To: <20220606050238.4162200-1-masahiroy@kernel.org>
References: <20220606050238.4162200-1-masahiroy@kernel.org>
Date:   Mon, 06 Jun 2022 08:59:48 +0200
Message-ID: <87bkv6nuor.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

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
> ---
>
>  drivers/clocksource/hyperv_timer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ff188ab68496..bb47610bbd1c 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -565,4 +565,3 @@ void __init hv_init_clocksource(void)
>  	hv_sched_clock_offset = hv_read_reference_counter();
>  	hv_setup_sched_clock(read_hv_sched_clock_msr);
>  }
> -EXPORT_SYMBOL_GPL(hv_init_clocksource);

hv_init_clocksource() is not called from modules indeed, 

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

