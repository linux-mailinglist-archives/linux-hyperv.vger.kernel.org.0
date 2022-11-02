Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B070261612A
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 11:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKBKrf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 06:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKBKrd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 06:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA236205C4
        for <linux-hyperv@vger.kernel.org>; Wed,  2 Nov 2022 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667386007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUJvEUx8gtjx3iaw6xY22YZZMkx+Fxj3A7QQSAUB80Y=;
        b=IdsGxcpc/b9eri3/F2vdOUh/cr0GJaUlcfrvfXm5M1ivFv5rIhWx6/D/pKE538YSPP5rTI
        dnD7I+fjmyuhuvWBoCiKKCvwlRz6YgWk+A/vS3qXmahAei/2tst2AFgeuCYRtXXo0TJL7L
        IuJ/qqE+hcToYJ3azmb4wt9N7PXsAw8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-G2Hsj2oCO3utiSl3_Y5eOg-1; Wed, 02 Nov 2022 06:46:46 -0400
X-MC-Unique: G2Hsj2oCO3utiSl3_Y5eOg-1
Received: by mail-wm1-f72.google.com with SMTP id z15-20020a1c4c0f000000b003cf6f80007cso336706wmf.3
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Nov 2022 03:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUJvEUx8gtjx3iaw6xY22YZZMkx+Fxj3A7QQSAUB80Y=;
        b=QvKKrj4u/tUZnHDD5QQd255O+Rv2/z5ACu0OtltqcIu8Vq6/is/eaCpV0vx6RdI/np
         sh1HqNvilOrYzuxnwo+X4680g9yFkGZNplgfAtA48R7uPgid1f5sotE6p6wsx3sJ1D89
         +TXxO7FadM68XPUyruPDNazaiOYbKPDiUDJEc38ErePjhtz81JxTomJ+QSOaMcoF+qDK
         a1DP6gjGUZekCiGGKhU287qBwfX4a4u4w/WVq6G5iLbflI3SQIW/N+9WgRiL5PJ2oOrb
         iyo9SvY/HwRrnqHKuvNqFnOV2o1rYUErV4Dwo1quG8KOIlUB3rNeUrac+G8CUlWCLtHZ
         hbWg==
X-Gm-Message-State: ACrzQf10puDxAZ6w+K2mqCGwoQKorm4U+oRw/ItXFjbXE02r/o6jfdk3
        MhVKMf7/pEIRdhbZs24xe0PD79ubpHBWU3aBwJbIl+01BvlneX8bnT6xKTgPFPHhJnD2bGQMT5r
        BNHgjq7uHVCWVcD7KYZnvCz1f
X-Received: by 2002:a05:600c:3556:b0:3ca:771d:701a with SMTP id i22-20020a05600c355600b003ca771d701amr14652010wmq.61.1667386004899;
        Wed, 02 Nov 2022 03:46:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5jzv0egtLEIAVaxEN/tayyZgqvKvq+1qzahuWoTfzpPIfJE04AyAO6MvJnCllXJsp0I0J18w==
X-Received: by 2002:a05:600c:3556:b0:3ca:771d:701a with SMTP id i22-20020a05600c355600b003ca771d701amr14651998wmq.61.1667386004691;
        Wed, 02 Nov 2022 03:46:44 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b003b3365b38f9sm1701531wmq.10.2022.11.02.03.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 03:46:44 -0700 (PDT)
Message-ID: <5abf94d6-9a48-525e-c562-605529c5793a@redhat.com>
Date:   Wed, 2 Nov 2022 11:46:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 17/21] drm/fb-helper: Perform all fbdev I/O with the
 same implementation
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, sam@ravnborg.org, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        etnaviv@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-18-tzimmermann@suse.de>
 <3ab32fc3-f2aa-1b42-fd87-557482ab56d5@redhat.com>
 <0ca70b76-c24a-4fdb-cf0d-2647d37379df@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <0ca70b76-c24a-4fdb-cf0d-2647d37379df@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 11/2/22 11:33, Thomas Zimmermann wrote:

[...]

>>
>>> +static ssize_t __drm_fb_helper_write(struct fb_info *info, const char __user *buf, size_t count,
>>> +				     loff_t *ppos, drm_fb_helper_write_screen write_screen)
>>> +{
>>
>> [...]
>>
>>> +	/*
>>> +	 * Copy to framebuffer even if we already logged an error. Emulates
>>> +	 * the behavior of the original fbdev implementation.
>>> +	 */
>>> +	ret = write_screen(info, buf, count, pos);
>>> +	if (ret < 0)
>>> +		return ret; /* return last error, if any */
>>> +	else if (!ret)
>>> +		return err; /* return previous error, if any */
>>> +
>>> +	*ppos += ret;
>>> +
>>
>> Should *ppos be incremented even if the previous error is returned?
> 
> Yes. It emulates the original fbdev code at [1]. Further down in that 
> function, the position is being updated even if an error occured. We 
> only return the initial error if no bytes got written.
> 
> It could happen that some userspace program hits to error, but still 
> relies on the output and position being updated. IIRC I even added 
> validation of this behavior to the IGT fbdev tests.  I agree that this 
> is somewhat bogus behavior, but changing it would change long-standing 
> userspace semantics.
>

Thanks for the explanation, feel free then to also add to this patch:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

