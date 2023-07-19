Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D5875987C
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jul 2023 16:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGSOg5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jul 2023 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGSOg2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jul 2023 10:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E381711
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Jul 2023 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689777338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GW017PQkbwcyBZVSjL1eIJ3Tr23afBwEJMZO/sY3MB8=;
        b=Bk+dk1mBEQJDTKuW9K8t8hp3CB+h01vAXtIZOhfUUaOwjhn9QZJr3CrmMjGOtTHDmM5KZW
        vSQUlLA10dA9WKF3pWrhH871D3hn+/HeD7aooccGEqHBD5haE3RVpCeBrHeqIAGuJObE5/
        sZCUoatdaCiRxEVTfL/SXBzjE87DKv8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Gs57f6FvO8Wn6OBdP4iIcA-1; Wed, 19 Jul 2023 10:35:36 -0400
X-MC-Unique: Gs57f6FvO8Wn6OBdP4iIcA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbe4cecd66so39565535e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Jul 2023 07:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689777335; x=1690382135;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW017PQkbwcyBZVSjL1eIJ3Tr23afBwEJMZO/sY3MB8=;
        b=YFEMQ+5M+NVZFY7HjLNQPQvhYodB6dqYUQ7wzg2A46mCFoowIsyiesCzspLZBP+Maz
         IupOJhToxpe0VwmDapAOL0XnZ56JB+tDcrcRa0mwjC7qgQomlPkRxKBOCwtpDWpeHTTr
         nPtDf1TLtXNdOyQDo9Aq7/imt9Qv+puIkB2Ha5cnZZvOdUX5g4UEty0QYmejTmWvpm1m
         FjH5t+C6r1ZblgPH/F4lQqeDzqKStYQFYnWTqg1mjlVgYfsksTvRe3+/Ptl4aKGLFJGQ
         Y1ol2rwctzMAePHDdjUxjqNpxiP/PcDQgTuFY+8quQE2AJOOZUG+LeLx/h+JVFZSXNqy
         +eIQ==
X-Gm-Message-State: ABy/qLYb5wdmua6IolvT+qoryBDmgBGvAZujecgEDnk2p6UOnzGUQqRb
        QU957L7Ueb9CBWEGO8xIfwZo8URkaOzqSlOiib69pjZciHUaTLwhJ3IM6WRpBqsUhOD42YQGMsA
        fDEmPkEhuQEDq31Oos9pkQ5LN
X-Received: by 2002:a05:600c:20f:b0:3fb:ab76:164b with SMTP id 15-20020a05600c020f00b003fbab76164bmr2130595wmi.13.1689777335792;
        Wed, 19 Jul 2023 07:35:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGyN6MTy8oRS46HP6DzRqXrb5z9b00oXqiEwJ+r7OovxVf1XP/FK2uW1HDXjbNqEtS7mD81iA==
X-Received: by 2002:a05:600c:20f:b0:3fb:ab76:164b with SMTP id 15-20020a05600c020f00b003fbab76164bmr2130535wmi.13.1689777335451;
        Wed, 19 Jul 2023 07:35:35 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b003fba6a0c881sm1798903wmc.43.2023.07.19.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:35:35 -0700 (PDT)
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
Subject: Re: [PATCH v2 9/9] efi: move screen_info into efi init code
In-Reply-To: <20230719123944.3438363-10-arnd@kernel.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-10-arnd@kernel.org>
Date:   Wed, 19 Jul 2023 16:35:34 +0200
Message-ID: <874jm0hsuh.fsf@minerva.mail-host-address-is-not-set>
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
> After the vga console no longer relies on global screen_info, there are
> only two remaining use cases:
>
>  - on the x86 architecture, it is used for multiple boot methods
>    (bzImage, EFI, Xen, kexec) to commicate the initial VGA or framebuffer

communicate

>    settings to a number of device drivers.
>
>  - on other architectures, it is only used as part of the EFI stub,
>    and only for the three sysfb framebuffers (simpledrm, simplefb, efifb).
>
> Remove the duplicate data structure definitions by moving it into the
> efi-init.c file that sets it up initially for the EFI case, leaving x86
> as an exception that retains its own definition for non-EFI boots.
>
> The added #ifdefs here are optional, I added them to further limit the
> reach of screen_info to configurations that have at least one of the
> users enabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

