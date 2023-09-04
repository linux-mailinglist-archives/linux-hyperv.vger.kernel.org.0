Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E93F7917E2
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Sep 2023 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353006AbjIDNTB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Sep 2023 09:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjIDNTA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Sep 2023 09:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEC1BF
        for <linux-hyperv@vger.kernel.org>; Mon,  4 Sep 2023 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693833490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBLzSQTLv+8pipDzuuK9IQr80p06o9JPiTCzfewmJxw=;
        b=JSaCtwUapIaYsR7l6FcK6XEyuFHlAlzDnqiO4Eek9d4+nHsEvbWuDhAWkA/iuV3ED49Zpv
        +4Zyi1mp9cFMyBoDFHPfGUByd0ZA9lNlRafBtPhCgxUYviZv5A/7FXQyKJh/DmbXX1uOim
        ecO3+3TaxDJiwLl+2kpBg0nQbbzMgT4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-iJMlC1DpO6itQjw9AmTlPg-1; Mon, 04 Sep 2023 09:18:09 -0400
X-MC-Unique: iJMlC1DpO6itQjw9AmTlPg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so9332075e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Sep 2023 06:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693833488; x=1694438288;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBLzSQTLv+8pipDzuuK9IQr80p06o9JPiTCzfewmJxw=;
        b=O9v2if388SZmu9INTwsn8oLWmhMT2mWjN1VkTi8emMZpSOqFWL6BXuZOceBDE9Lt9H
         ydHKlybafUIAVIrHy3psksD4/edlHwXgFedJJFTp9KC6mZn4QXv4pfX0vN13cgHAKRjg
         3CvnitNYI1ArYPOmhwB/KD0jH6pN2wsSpHWqckgAgZ8VJHKmz5cf6+XMlrI8ZG66Unal
         35Q+dqYCsdvTjuHuPUNReaqcPh7jON2pwyH9egO4oWMP3CSYvn+Gz8Tqw8I+M2+vweGE
         EA/SuabI84bd1rl0X1UzaMn5sxlloNqRsHvbUxEL8BB0B/+Xu6YfEDKqKbahb7UNnvOo
         Oj/w==
X-Gm-Message-State: AOJu0Yy168BPWpCnXz2TTU/I5uSSzIOErtJpRYIof/asdjI8HoVZfNYB
        oshCgd+5nq6RT7hghqnQ1u9MCdqIgATXfD4kH3P2LMQnWtR0SLWT1g5mrMDMH02HZoHBcaF+832
        IYnnSehXA7lbQDSD2P4WIVdqp
X-Received: by 2002:a05:6000:82:b0:31d:cd2f:4a4b with SMTP id m2-20020a056000008200b0031dcd2f4a4bmr6453153wrx.50.1693833488026;
        Mon, 04 Sep 2023 06:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMneOVTl+tO7EjPHxWk7aAIbA+6YIUPO8GkkaydyT763T9pc7YLR5Hmg/1C6iUl0u80TgQ3Q==
X-Received: by 2002:a05:6000:82:b0:31d:cd2f:4a4b with SMTP id m2-20020a056000008200b0031dcd2f4a4bmr6453136wrx.50.1693833487752;
        Mon, 04 Sep 2023 06:18:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d6643000000b00318147fd2d3sm14498682wrw.41.2023.09.04.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:18:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 4/8] fbdev/hyperv_fb: Use fb_ops helpers for deferred I/O
In-Reply-To: <20230828132131.29295-5-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-5-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:18:06 +0200
Message-ID: <87fs3ucc1d.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Generate callback functions for struct fb_ops with the fbdev macro
> FB_GEN_DEFAULT_DEFERRED_IOMEM_OPS(). Initialize struct fb_ops to
> the generated functions with fbdev initializer macros.
>
> The hyperv_fb driver is incomplete in its handling of deferred I/O
> and damage framebuffers. Write operations do no trigger damage handling.
> Fixing this is beyond the scope of this patch.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

