Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF31B651DDE
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiLTJqg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiLTJqH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9C1172
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=bMNfBpnQ0R4k+ZK8hL0B6FvdIHuE2a82b6uq5TwyVbtjv66Bs6gClwvEX1W6Fp3/8xwXD2
        dqhZCRE0PLbY6sGXEU4B8doc9gx/9iHlNxoiEiwYCKyUlTRJCUDkQO3LpaklI1gpIPUkiz
        d8HmCBKJ4wvs+IM57SvO4ncgFUGRrYA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-pkCXcIGIOqeuNMguDTUBRA-1; Tue, 20 Dec 2022 04:43:56 -0500
X-MC-Unique: pkCXcIGIOqeuNMguDTUBRA-1
Received: by mail-wr1-f70.google.com with SMTP id w11-20020adfbacb000000b002418a90da01so2069338wrg.16
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=pjHFE1ESwqJqKm6zIYDV8RH9hyB60do8rNXVQ733b7u1Ayi90cMRj4cWnkoXvYqtKa
         XykE/svpVnLOIJ+euz2lykhqctd6E2LA/qKATyfoQBiOhF64ea0zSDffz0PnByOuM9Ml
         d9XlDBu5mfRw+kNlmjPtysi3oNz8toTiZqhuHTCc2GuZeqfj/2q0tNgkKSqwny9xiLp8
         fwAKV+YY+3NtJnKiD/3cCjY2W78ekkRtZCz+FljQsg4uqYEs6jLh98F83LdLW+jt6yeJ
         Bgx514ZJcQdTCeVuBO1R85UokwI9NPKUkvLgXXnKBnoa6BbZDWR2Co2Kn2d0YTcHSgkg
         FpBw==
X-Gm-Message-State: AFqh2kqJpNuXXcFjtjDL/Hd28+4Hqk21A9hRR2YXzFz7f06XikeWLlP4
        mYTvVgTT4/mJh45BbKXwltgBdCrL/UlkfpEN5K4pviAnNJFvSZ+Vb4g/UbMNfjqtVNKjbqo++eA
        Pk2gdeAuz4bUgKjHDhwSbupQk
X-Received: by 2002:a05:600c:4311:b0:3d2:3e75:7bb9 with SMTP id p17-20020a05600c431100b003d23e757bb9mr994927wme.34.1671529435452;
        Tue, 20 Dec 2022 01:43:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvfI2fbHCkuQqRJ76jLZpFV0pKFd9I/EWHnHADcWJc2WmgvjMGHFvYEzSGe6w+l7QXDUqu6sg==
X-Received: by 2002:a05:600c:4311:b0:3d2:3e75:7bb9 with SMTP id p17-20020a05600c431100b003d23e757bb9mr994914wme.34.1671529435238;
        Tue, 20 Dec 2022 01:43:55 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003d33ab317dasm17144094wmq.14.2022.12.20.01.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:43:54 -0800 (PST)
Message-ID: <c9a34fd2-3dc5-18d7-20b4-b5c9e69ad039@redhat.com>
Date:   Tue, 20 Dec 2022 10:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 16/18] fbdev/vesafb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-17-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-17-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Acquire ownership of the firmware scanout buffer by calling Linux'
> aperture helpers. Remove the use of struct fb_info.apertures and do
> not set FBINFO_MISC_FIRMWARE; both of which previously configured
> buffer ownership.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

