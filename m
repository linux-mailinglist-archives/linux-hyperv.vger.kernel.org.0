Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF2640CE3
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Dec 2022 19:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiLBSPq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Dec 2022 13:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiLBSPn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Dec 2022 13:15:43 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4AAE8E0A;
        Fri,  2 Dec 2022 10:15:42 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso5278153wmb.0;
        Fri, 02 Dec 2022 10:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msJewYeboYMFgXI2NUEobXZkko02PEBqK9n1fYacMPA=;
        b=jpgG/D1ul+ElyJYd7z4x2KYUXKhck5YmLi7ebyHe5aWs1OV28BDUuzqmmnGddsZaaE
         KnMTG9CDxhyiewHlbYy+q/+70U/IAsuV0aKsqlJDfanme0NMizSe+ZXu8zZHY1EUUiiq
         Mt0j8jNfj/RV5gbm328QP/VIQU9ajgYssUTWeoTsk11Ws+7OFLc33miX0jwXkBmEEbu5
         wRwzOWPZ5BJTJr0uF9NlhCgsKwn1lTdHHAYuLHDwlU5xWUWGIQAPvdkY5Whsn+Zh+MB/
         qqIdDpgoldmOGQ7OUVlQzAeVPavtzScBXIJvus69aqOV/oQ3R/8YAiRpz9sZFGEFumDL
         sSAg==
X-Gm-Message-State: ANoB5pn0OAkHmqhPCqXaL+6q9YBelWPD8gPzMMQn1V7phsfHUuNntBCV
        SfPQxLKe7flnH0S3HMoRW80=
X-Google-Smtp-Source: AA0mqf60+SpmVm5NfdP20KIOIpCF1VNVqb0ig3ph/ERtU6Ww7TwZWVB+R9Wgbsk9E3I2pj91jfnK4Q==
X-Received: by 2002:a05:600c:1f17:b0:3c6:c796:1071 with SMTP id bd23-20020a05600c1f1700b003c6c7961071mr8922185wmb.138.1670004941397;
        Fri, 02 Dec 2022 10:15:41 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id bs4-20020a056000070400b0023677081f3asm7634604wrb.42.2022.12.02.10.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:15:40 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:15:39 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dexuan Cui <decui@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        x86@kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v3 0/4] hyper-v: Introduce TSC page for root partition
Message-ID: <Y4pAy5j1iEv1GnwU@liuwe-devbox-debian-v2>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <Y3JIk6sW9lZ6UvC7@liuwe-devbox-debian-v2>
 <5f6dac1e-5d17-122c-5e52-1b15bff7630f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f6dac1e-5d17-122c-5e52-1b15bff7630f@linaro.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Dec 02, 2022 at 01:55:35PM +0100, Daniel Lezcano wrote:
> On 14/11/2022 14:54, Wei Liu wrote:
> > On Thu, Nov 03, 2022 at 05:58:43PM +0000, Stanislav Kinsburskii wrote:
> > > 
> > > Stanislav Kinsburskiy (4):
> > >        drivers/clocksource/hyper-v: Introduce a pointer to TSC page
> > >        drivers/clocksource/hyper-v: Introduce TSC PFN getter
> > >        drivers/clocksource/hyper-v: Use TSC PFN getter to map vvar page
> > >        drivers/clocksource/hyper-v: Add TSC page support for root partition
> > 
> > Applied to hyeprv-next. Thanks.
> 
> The series should have go through the clocksource/timer tree or at least
> should have specified the targeted tree for an Acked-by from the clocksource
> maintainers.
> 
> In the future, please follow the process

Sure thing.

> 
> That said,
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thank you very much!

Wei.
