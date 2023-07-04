Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F243874766A
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jul 2023 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjGDQYj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Jul 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGDQYg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Jul 2023 12:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A41E7B
        for <linux-hyperv@vger.kernel.org>; Tue,  4 Jul 2023 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688487824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FITFWtbRXE3gky2EO4aMziTa3J/r1+wMO4yc2vs7Pc=;
        b=Yaj0XoGTnPY3jldtaJrBd3h0EFLc5QY5r2f1GcQiDU5Bwt+QkhnRA5Y3ClkBsx59aWT2Mc
        O1BXRKMpVO9+Wb82xQFvJuf17h84NyATS9f4N1wgCJHvmtmtX5bmQkya0n1s8pMiouL+Iu
        fyHZ1/QKZQcqnRr3IdPIPspTAWH3/GI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-GEcUMUa_NyC_KzOxzIc70A-1; Tue, 04 Jul 2023 12:23:43 -0400
X-MC-Unique: GEcUMUa_NyC_KzOxzIc70A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so8962875e9.3
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Jul 2023 09:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487822; x=1691079822;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FITFWtbRXE3gky2EO4aMziTa3J/r1+wMO4yc2vs7Pc=;
        b=NTNr7mvOU4JuH3osLW9yohNzceWgWsaFndQXJIs6twFcnwmQLb2l3/2AGGBli2lyWP
         7zlIhHGAD+WG8j2INPMcNwK2nf+TBHansZBAiHy5V3mN4xEImWZrjPyt1QG0uxn2FY/s
         J+SgjB6EtkWuMKl2SEIAgBJGgYtv6kF3T3rkmR6nSR3zahlycFE+mHQblXJazQKfkjsf
         Vg9+j8VPnKPUx1+6Rkpn/KF05/vOCCSH33CyaK4/uiQmNSxlA4oySuUCWjQZexYB5YOZ
         TxM1T+tPjGIiYkUgwQkDYyqLMJe/lkUlrRwZlh+5bntF6Xyep7TK6GMjLhO7IvnNJZ1r
         CF/g==
X-Gm-Message-State: AC+VfDx0ETbyskb8jyD0krSOWFE8bNCNZf0ijYOR/uM8SP5IfpIs09NN
        LLz7qReXKw34/23mWT9+tSM+0g8wKdnAI4PYBkJoPZg7NrYyhGXQ8g/lCmQgjLh1LQOETgdUC+B
        Pn2TNe2VgMZX8njQzslY4/rJu
X-Received: by 2002:a05:600c:2145:b0:3fb:415f:a85b with SMTP id v5-20020a05600c214500b003fb415fa85bmr18158807wml.3.1688487822321;
        Tue, 04 Jul 2023 09:23:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7T04nL74CM9kmUBFWNxbGLn7ruUc6nb3zVFQfaw7cBAYtqvH64gACvFSpImO/HrduwXThnBg==
X-Received: by 2002:a05:600c:2145:b0:3fb:415f:a85b with SMTP id v5-20020a05600c214500b003fb415fa85bmr18158793wml.3.1688487821958;
        Tue, 04 Jul 2023 09:23:41 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003faabd8fcb8sm24447459wmi.46.2023.07.04.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:23:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/12] efi: Do not include <linux/screen_info.h> from
 EFI header
In-Reply-To: <20230629121952.10559-2-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-2-tzimmermann@suse.de>
Date:   Tue, 04 Jul 2023 18:23:40 +0200
Message-ID: <87ilazlk6r.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The header file <linux/efi.h> does not need anything from
> <linux/screen_info.h>. Declare struct screen_info and remove
> the include statements. Update a number of source files that
> require struct screen_info's definition.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

