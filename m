Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69631651D1B
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiLTJUZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLTJUY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:20:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB7EDE94
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671527977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABmxoLEyhLmWYUbBrwSAozB1mTvmA41c/n7InFI0eTk=;
        b=O2K0Ua3EupgTR5aTIvAUmgq1TB3dT7T/zVTwVrQJ1u8LUbh30xQptwVtt6Qs6AKLfvY5IT
        mY04EeRwBKBroD26WFbDLR/gKMhIPbHxEvg8iIZWRnCC0T7wyicfzNrqKDbTbkonPTFqLs
        UErXd8UwOoz9w507mflFT5t2+jIYfL4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-440-iam_3tPlM6KN82WvHuDQCA-1; Tue, 20 Dec 2022 04:19:35 -0500
X-MC-Unique: iam_3tPlM6KN82WvHuDQCA-1
Received: by mail-wr1-f72.google.com with SMTP id a7-20020adfbc47000000b002421f817287so2067565wrh.4
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABmxoLEyhLmWYUbBrwSAozB1mTvmA41c/n7InFI0eTk=;
        b=rn09QWqIIEhmFgLePnOUjcJ9/uAXQCKSld8pVRjgoC/FlNsuy0WNokQKgipKVc1Z/Q
         n87r5hK/2XQ1UQYtHB20GwY5SYfJX9zCCfhoUp95N+6NRZKqQVGyP7S+L+rfVjlYJeJb
         nDLwgPQc6TlV+yUWacnEQNZjusrVFxUeN/xJfSGkTZihVIzAbAF+wccQ8PK0dYA42Ykn
         FnmKQReiHFzS8Mte/+siqwP9RMFaUh8FLm/jsYPST7yE3DoGLzxNdH6/zebSZEi49rGY
         rWCxwou7DttcqP8/w0/lOxkFFf2OXJEUP2GhL4qk2FpfE7K9CLVyvPWxlCRrTrgClHid
         OcFA==
X-Gm-Message-State: AFqh2kpHT8yFtgWihsKZ8MlHiWYACNQvlHee4vGmCWkf2P4m/cx/1BMl
        Eaiq2qGS5LWHPmCZRR3KvL/WJDv39lggjde54aqNUIQSCkSl9gEDCb+Wzeg+L/ovN30G/T1qCgw
        LUZW+FmtKAh2DFzKSUt6VtUHC
X-Received: by 2002:a5d:5752:0:b0:244:48b3:d13f with SMTP id q18-20020a5d5752000000b0024448b3d13fmr814494wrw.41.1671527974608;
        Tue, 20 Dec 2022 01:19:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtLG6B6o+Iq76Uq1s7q/P5T3qehN9lnU31N4pqMHcN5FUQ5i4K5iNalaLBn7T7/AoIpv82Xvg==
X-Received: by 2002:a5d:5752:0:b0:244:48b3:d13f with SMTP id q18-20020a5d5752000000b0024448b3d13fmr814479wrw.41.1671527974427;
        Tue, 20 Dec 2022 01:19:34 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bj19-20020a0560001e1300b002238ea5750csm14570460wrb.72.2022.12.20.01.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:19:34 -0800 (PST)
Message-ID: <d9fa03ac-4e71-dcd4-2d79-698410c9c444@redhat.com>
Date:   Tue, 20 Dec 2022 10:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 04/18] drm/i915: Do not set struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-5-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Generic fbdev drivers use the apertures field in struct fb_info to
> control ownership of the framebuffer memory and graphics device. Do
> not set the values in i915.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

