Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E67791801
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Sep 2023 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjIDNZt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Sep 2023 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjIDNZs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Sep 2023 09:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B66CFB
        for <linux-hyperv@vger.kernel.org>; Mon,  4 Sep 2023 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693833895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPaq3CuDZRpQmuDqucr0HZhD9ZzK56uaUpku88i4nOk=;
        b=aV8iGJYhjWOrFmYCMCEtW4CPcXF9KHZMmlZ8Mh9TY1hcYWJj7IxwlocLx/hrFRP6kfHe77
        7szm99mXwhagoPZYkJlIJUFo4FvznceR8Op+90UBNVkCaV3BW4ez8NBl6WU/w0IM9nCdTQ
        +x6SOn7WGI4HvqQPLOEkyq7ZE3psiGs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-uzElP2NhOpC9m6Xa3oGX_Q-1; Mon, 04 Sep 2023 09:24:54 -0400
X-MC-Unique: uzElP2NhOpC9m6Xa3oGX_Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-402cba95486so7082525e9.0
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Sep 2023 06:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693833893; x=1694438693;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPaq3CuDZRpQmuDqucr0HZhD9ZzK56uaUpku88i4nOk=;
        b=Bx7tzHNjL7vn5lkJF3O5ZALc/mXrZEMjLiuv3fMSxncy2ZN/M55IrwjqIjP4/gKEl5
         sbCvPmhRcQV50HibTq5rYqYIx7d7LsLAzSKF3TOhiXoIAaOebEdEqDUt/5F9OA4+Py8a
         1skAyythbe1AXqMh0iCr9/hlnuTjpNwp4kkXJXT0QZ9bSq4kPmmhzUkdqaY2+H53EH99
         yiZdld4FfTZQz0J3ZSq60kOlRt99B0m0uvG3fvElGF7oGhqNdpk5uHuzY4HQXCAgla6V
         GrgIQxU2W62iznQ40TSkD4xtK5yRoIVFgamUhDrUemhg0qQP3Ze02TG5I3x6eqED0EA8
         fgAA==
X-Gm-Message-State: AOJu0Yy1J3AToSaGUhSqW3Ld2yEadDElPPsEAxnd9VQDg/jEsGlfRpvc
        ltmrtFYcuoGRENZVWaWzZysPltPRE1rbIiJH9Wre8yYgrPcOt15MlHs8d/4saSVK/yuT1dmyTiS
        G9lWM9FQS+lY4Kkq35odyH0zK
X-Received: by 2002:a7b:ce18:0:b0:3fb:f0ef:4669 with SMTP id m24-20020a7bce18000000b003fbf0ef4669mr7620184wmc.17.1693833893703;
        Mon, 04 Sep 2023 06:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVceTFRRCJx3QEHC1v0Fwwk5gpR/JTxujmvjvpSbrcXuud5RQf6XSV8UmJ3S8NFK1PJ6NVpQ==
X-Received: by 2002:a7b:ce18:0:b0:3fb:f0ef:4669 with SMTP id m24-20020a7bce18000000b003fbf0ef4669mr7620172wmc.17.1693833893448;
        Mon, 04 Sep 2023 06:24:53 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fed630f560sm14111682wmc.36.2023.09.04.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:24:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 5/8] hid: Remove trailing whitespace
In-Reply-To: <20230828132131.29295-6-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-6-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:24:52 +0200
Message-ID: <87cyyycbq3.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix coding style in Kconfig. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

