Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4148361353E
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Oct 2022 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJaMAq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Oct 2022 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiJaMAn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Oct 2022 08:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564A62BEA
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 04:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667217582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypYZqoZTsptEoKYiFoPm/p19rfXtb3oU3pAWnCNe+WI=;
        b=Zel6PBGAujtQpGJ25eDXz5NQdvYWshkubNX9u3WZEPYjHpT05ywtxEVsS2Z0eB6wjuR2pi
        H7i9o2M/x2b+VxJvBtMb1f33qJRlLs93/Uxkmn98tA+1/3EhJww4ZSWo9FAtatGJD+rIFk
        zHymXrw1o2hY8hPf2MbfOBT0FpCY82I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-x3Y4CCFvPfqAprw4e_NteA-1; Mon, 31 Oct 2022 07:59:41 -0400
X-MC-Unique: x3Y4CCFvPfqAprw4e_NteA-1
Received: by mail-wr1-f71.google.com with SMTP id e13-20020adf9bcd000000b00236b36cd8cbso1499863wrc.0
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 04:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypYZqoZTsptEoKYiFoPm/p19rfXtb3oU3pAWnCNe+WI=;
        b=fq1A+KZstJvva1myxfQHatco+FbjLlmxa2xP2IM9q1nOr0nXGwyWF5tFmK5hgd84cE
         Y0oIEVW1DSS4vPrOCML+jENPyEyc3npFtMa4bTnA18j1rXRZWQpUdf8H1z5vyinLgQce
         JR6HSUXdTKFXnVLbjIRKi8dxvgrdPQ5a1m9T2jy+9mZYI2X4QXDQ66dcn9cSUX8DrQX8
         HiVS+YX4xDmvZwCXOLkNI1X0DSJVnl3BG42Jr9cboXKdq4hLCnbHacqnNfEbiisUowx8
         sG0AaB0QDdO+n1ztnALxWbSAyUrCM9XfIJXdtGvRVNyEG32UdXh/K6HWBHgbovS4L16a
         hrJQ==
X-Gm-Message-State: ACrzQf2Pj2i2zTxVSZ5GL1M3MVaTyuqP4D1sk8OAEReY09ReMe7hmmtG
        kQh04Saf0mi5XMq79vIEJ6q1ZJJUFi3X9dThSIbqvwXRtTymbc6llDnYRJzOGmmWzmyZwS28Ml2
        SxV8n+EbQlx73cy1+mxld1YCS
X-Received: by 2002:a05:600c:468e:b0:3c6:f510:735c with SMTP id p14-20020a05600c468e00b003c6f510735cmr7602957wmo.179.1667217577167;
        Mon, 31 Oct 2022 04:59:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6EBETLSD4MBJxdnzTxR3FGu4hBbX2SQFUCrJloOPK1q2LF0w1HzUkYOXWVOI9w84+cugepvA==
X-Received: by 2002:a05:600c:468e:b0:3c6:f510:735c with SMTP id p14-20020a05600c468e00b003c6f510735cmr7602924wmo.179.1667217576945;
        Mon, 31 Oct 2022 04:59:36 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c182bef9sm7774720wmz.36.2022.10.31.04.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 04:59:36 -0700 (PDT)
Message-ID: <ae69e0c5-05ee-f0ef-a333-53bbaff5c3e8@redhat.com>
Date:   Mon, 31 Oct 2022 12:59:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 02/21] drm/mcde: Don't set struct drm_driver.lastclose
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
 <20221024111953.24307-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221024111953.24307-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Don't set struct drm_driver.lastclose. It's used to restore the
> fbdev console. But as mcde uses generic fbdev emulation, the
> console is being restored by the DRM client helpers already. See
> the call to drm_client_dev_restore() in drm_lastclose().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

