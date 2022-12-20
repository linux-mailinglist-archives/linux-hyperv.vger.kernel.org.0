Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F4651D7E
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLTJe7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTJe5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:34:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF75918699
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVZMgP3yXzrzjDhtvsp+tMbNXy6x5UaaSyaJJzd0B0g=;
        b=e9TRzOd1GM9BZy7nwUeFTzI2fs+3M19xRDSziQ7diozTs1U+dG32FnVeAxrndE+2rscfhV
        6sZIO//1MHH0nEQuphwpdWDT0gBLnOIcHFvZ+SFr87IT8IcNP5ab2G/BsS2RWSaCKvsWYp
        tTh9xmVYGQ0Qy2zAiARa2HEbY71FJ/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-eAPHhXftPZSqTj82o1pY1w-1; Tue, 20 Dec 2022 04:33:55 -0500
X-MC-Unique: eAPHhXftPZSqTj82o1pY1w-1
Received: by mail-wr1-f71.google.com with SMTP id g12-20020adfbc8c000000b0024cdcc92637so1272096wrh.0
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVZMgP3yXzrzjDhtvsp+tMbNXy6x5UaaSyaJJzd0B0g=;
        b=veXm7vaAGtcINHFSs/oElIyvufsIRSpMlJiCFAmonCWmRQhWNbQQEzcpQoGFQ5uiFd
         A4XOqgyujPdUGzFw/Hqh70w0yazdWGjQlGsEWD/56UQDHMCSQm4OXF7o4LsZYlG9R3sI
         R1v4vx448kr7vPgc4v3xdCikiLmKhauP9q0nq5sLOHICuZJeLPKHbblQ7ytUfrDTIcEh
         PveUhasf+4HzmgqYRA0VOKuEIaUwr1cIBInozyUnmvtVxa3suBUBP1AC8Lv9E0kj6wJc
         HHzVI2DWisOAsWy82K4rgJtsmfyU7pn7lDE3R4xD9Y/qXmlzHsCvnQn7NcoUXkuvxMGV
         3CpA==
X-Gm-Message-State: AFqh2kqQiga6v35rgzmr0vH+HnnrJddjeKC9UEQYtG9JQMkonDAeZi1I
        w12WMdPdLolc1Q1C3sWpNKb2xb9h7VjjMrm2oZLXqLIMLBnPrrGVUBvcKBr3WBXGnoSsmy9hpzh
        RWBChrr50TO8IHXC1cRpmoSKs
X-Received: by 2002:a05:600c:b59:b0:3d6:4ba9:c111 with SMTP id k25-20020a05600c0b5900b003d64ba9c111mr241654wmr.40.1671528834238;
        Tue, 20 Dec 2022 01:33:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsPd0UOZgaV2usn9FHot5yPumcQTQ0WuQ30V9fRvNh8brfS+c9839HDYnoS7vxUK6doBa1czQ==
X-Received: by 2002:a05:600c:b59:b0:3d6:4ba9:c111 with SMTP id k25-20020a05600c0b5900b003d64ba9c111mr241645wmr.40.1671528834044;
        Tue, 20 Dec 2022 01:33:54 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05600c1f1a00b003d070e45574sm15319946wmb.11.2022.12.20.01.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:33:53 -0800 (PST)
Message-ID: <8f63bb10-e1e4-0111-5032-dca1b4a2f437@redhat.com>
Date:   Tue, 20 Dec 2022 10:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 10/18] fbdev/efifb: Add struct efifb_par for driver data
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-11-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> The efifb_par structure holds the palette for efifb. It will also
> be useful for storing the device's aperture range.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

