Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6557597F3
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jul 2023 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGSOSG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jul 2023 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjGSOSB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jul 2023 10:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D1B1726
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Jul 2023 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689776231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YjdFQRNR08a24eSSE2jcx3RnjwPdI3D1UG9L8u3hsoE=;
        b=FWguGfwOO+rfjs0fvFjrSrzQ32kjEPT8o8EekxSSjdUeLTnsXWYM0nd6YMEMHuPUN0EVYE
        lFM0Qbd2QSn5B7CaU296PsZiorG6xTgOmjiO8mppIyDzasutEqBcqNNcUaB86UlJEEIAq5
        LWw7EaryBsiA4dajwANVCpkbAmntw5s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-PV8vNnOiO0-I9Ouu8LkhMw-1; Wed, 19 Jul 2023 10:17:10 -0400
X-MC-Unique: PV8vNnOiO0-I9Ouu8LkhMw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbe4cecd66so39440455e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Jul 2023 07:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776229; x=1690381029;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjdFQRNR08a24eSSE2jcx3RnjwPdI3D1UG9L8u3hsoE=;
        b=cppIJwLUDQ4uXxZJlhY/nF0Cv3QfMMccZ8e1uHj0gtbfLEwzxLMdFSY7T2Tgi4o0OG
         G6qe1MC4JxOQ6xn5aYMU3gIXC0zTOszcXmngJ4cIypw1XdY+w29vpIdj33WgiyHDmXFm
         Mx7HL6UKFa8pqMVhBTjDg99To+NzmQHbGmIFFMSpMlvo3UlKy3OpRC1MWPjgDoQ8WE9p
         J17rc8LHaUSx9m0pLVi/37dCSKcNc8MGER5pJmGRWsTh/NUaqt/6comNrCnQ56Nwz61n
         2PGK6KkdbHUBPzP1VUwqu5Eo46+MBMzozeRgINI1ZS89em0cye9CyGlH19ieVmJXpeoI
         BtyA==
X-Gm-Message-State: ABy/qLaH2whlbPX+OYci0sK+vpnS74vl1fCHBjRIuQiY2aYFfyl+OVcw
        eWj5rxXvid//1Ium512ztcKVEE6j8XJxibMt7WP6R+yqyFNKIQ8JswmfBlI+rRPpcsCHlqWPysJ
        ADCytUOIYlnU5ASwxVItroCS4
X-Received: by 2002:a05:600c:3651:b0:3fc:627:ea31 with SMTP id y17-20020a05600c365100b003fc0627ea31mr2123114wmq.38.1689776229125;
        Wed, 19 Jul 2023 07:17:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHY6b0TgUW8MDG3POksnXdAxeQBRH+KD9U9aN090eyMWJPzhTreLBf0F2Av+qSumHgaL9gGUQ==
X-Received: by 2002:a05:600c:3651:b0:3fc:627:ea31 with SMTP id y17-20020a05600c365100b003fc0627ea31mr2123053wmq.38.1689776228833;
        Wed, 19 Jul 2023 07:17:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h21-20020a1ccc15000000b003fbacc853ccsm1833816wmb.18.2023.07.19.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:17:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Wei Liu <wei.liu@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 6/9] vgacon: clean up global screen_info instances
In-Reply-To: <20230719123944.3438363-7-arnd@kernel.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-7-arnd@kernel.org>
Date:   Wed, 19 Jul 2023 16:17:07 +0200
Message-ID: <87cz0ohtp8.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> To prepare for completely separating the VGA console screen_info from
> the one used in EFI/sysfb, rename the vgacon instances and make them
> local as much as possible.
>
> ia64 and arm both have confurations with vgacon and efi, but the contents

is this a typo for configurations ?

> never overlaps because ia64 has no EFI framebuffer, and arm only has
> vga console on legacy platforms without EFI. Renaming these is required
> before the EFI screen_info can be moved into drivers/firmware.
>
> The ia64 vga console is actually registered in two places from
> setup_arch(), but one of them is wrong, so drop the one in pcdp.c and
> the fix the one in setup.c to use the correct conditional.
>

s/the fix the/fix the

> x86 has to keep them together, as the boot protocol is used to switch
> between VGA text console and framebuffer through the screen_info data.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Patch looks good to me, but I'm not that familiar with some of the arches
to give a proper reviewed-by.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

