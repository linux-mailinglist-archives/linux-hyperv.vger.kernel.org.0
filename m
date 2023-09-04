Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B8F791AA2
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Sep 2023 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351622AbjIDP3N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Sep 2023 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353272AbjIDP3N (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Sep 2023 11:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3935132
        for <linux-hyperv@vger.kernel.org>; Mon,  4 Sep 2023 08:28:22 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-acFwj4m7NjmEZruWfmeg-Q-1; Mon, 04 Sep 2023 11:28:20 -0400
X-MC-Unique: acFwj4m7NjmEZruWfmeg-Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso11099385e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Sep 2023 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693841300; x=1694446100;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrkFFETteuVae/tXCmZrIh7LT8QUm9zk2gxUS8x5iBg=;
        b=J0wk3AG3bJ6kvCnjjR4ZVW9qut2tPcm5x9v/oQADTg1LADFR1iBssnT+Hk1m4eN2aQ
         5j1R2NAl2TKjQaeLzQA0aciiUFCVc8k4IPEOihPNqV/3+w0C/zo66d4DRxfGsWbf/WK1
         W9P7ytqeKx/eEYmIGRGvfnfk/xPXDiQGneEQDK7n/Ji2XfuiC3ao6G6JiOrpvzI138C+
         +TMsCpdLYOGSWQT7cFVMug0TNZ46owrVgG0RQeOb1ZQN9CNBfty/qEeGHcOGhzm0DXYW
         KjO950z2JArGKnq9qjiNwPnaOdopbDTJHsKSJf+jYy/ficoRFEXzT0LxcDTrNWFz+lwn
         f7CA==
X-Gm-Message-State: AOJu0YzMcQ56D3TI/s66h6sZmQ5YmFfxwl4Z6a/gyMsVa+bLKqj7xvTb
        twHVNAh0qR5kxSGcn3vT3n0VqOPuSVNS7r5pTCEDUGVxNTmzjeWYQwpfDEeOO5XPjoSElR81/W2
        4x0F/0to5tDv263UlP/LqpCn3
X-Received: by 2002:a05:6000:151:b0:317:5d60:2fea with SMTP id r17-20020a056000015100b003175d602feamr8786749wrx.52.1693841299901;
        Mon, 04 Sep 2023 08:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqr9n5OuCxsaX4v3hREg3LRHhHWX1kh5NPq1tl5TVMsK10UjE7B2EYUhMfWqJeDR4jr+Z45A==
X-Received: by 2002:a05:6000:151:b0:317:5d60:2fea with SMTP id r17-20020a056000015100b003175d602feamr8786735wrx.52.1693841299613;
        Mon, 04 Sep 2023 08:28:19 -0700 (PDT)
Received: from localhost (156.pool92-189-221.dynamic.orange.es. [92.189.221.156])
        by smtp.gmail.com with ESMTPSA id e12-20020adf9bcc000000b0031759e6b43fsm11564376wrc.39.2023.09.04.08.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:28:19 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bernie Thompson <bernie@plugable.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/8] fbdev/udlfb: Use fb_ops helpers for deferred I/O
In-Reply-To: <37906737-5ca3-7f46-af30-85a117875eea@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-3-tzimmermann@suse.de>
 <874jka6qd7.fsf@minerva.mail-host-address-is-not-set>
 <37906737-5ca3-7f46-af30-85a117875eea@suse.de>
Date:   Mon, 04 Sep 2023 17:28:18 +0200
Message-ID: <87y1hm5565.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Am 04.09.23 um 15:05 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>>> Generate callback functions for struct fb_ops with the fbdev macro
>>> FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(). Initialize struct fb_ops to
>>> the generated functions with fbdev initializer macros.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: Bernie Thompson <bernie@plugable.com>
>>> ---
>> 
>> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
>> 
>> [...]
>> 
>>> +static void dlfb_ops_damage_range(struct fb_info *info, off_t off, size_t len)
>>> +{
>>> +	struct dlfb_data *dlfb = info->par;
>>> +	int start = max((int)(off / info->fix.line_length), 0);
>>> +	int lines = min((u32)((len / info->fix.line_length) + 1), (u32)info->var.yres);
>>> +
>>> +	dlfb_handle_damage(dlfb, 0, start, info->var.xres, lines);
>>> +}
>>> +
>>> +static void dlfb_ops_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u32 height)
>>> +{
>>> +	struct dlfb_data *dlfb = info->par;
>>> +
>>> +	dlfb_offload_damage(dlfb, x, y, width, height);
>>> +}
>>> +
>> 
>> These two are very similar to the helpers you added for the smscufx driver
>> in patch #1. I guess there's room for further consolidation as follow-up ?
>
> Maybe. I had patches that take the rectangle computation from [1] and 
> turn it into a helper for these USB drivers. But it's an unrelated 
> change, so I dropped them from this patchset.
>

Great and yes, I meant as separate patch-set, not as a part of this one.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

