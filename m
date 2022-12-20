Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ECD651D92
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiLTJi0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTJiZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1087ED86
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4bHxLfE6qRmbmJ9vfsWvWUlnwpkYhHXJKMmhBNnZCVw=;
        b=O4uiPRVdmJJmTz/6KPACxML25gNN0W6jpL9NjhEUTBE8SM7hPXGVdtfFe+3Vaaa23YEKoY
        VzXkhaHZyH9ufULAc1n21jp0yoYFjJ4HXo1GpNIxInjtLqUlIgfLC33Wz/781UmaAj+olS
        cAmE8b4362vTH/3vvGEuKqu/4et0Gkk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-283-pa4YnemVMMiUeSbo-R0jgA-1; Tue, 20 Dec 2022 04:37:36 -0500
X-MC-Unique: pa4YnemVMMiUeSbo-R0jgA-1
Received: by mail-wm1-f72.google.com with SMTP id f1-20020a1cc901000000b003cf703a4f08so2407206wmb.2
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bHxLfE6qRmbmJ9vfsWvWUlnwpkYhHXJKMmhBNnZCVw=;
        b=delf6n5phgUyX5U75FMQk3+iBtXKeoAgpqg74r78t4tfsr+mQ8fWV14G06rtMYvVkY
         heV/o96NBmgyJ7YXkSmY8xPihkqeJjgyb071cO3bMw+j8A14Tx6oZMY2WAy4frLW/ohE
         yd16/EDjQbhhVBQ8nEYJ+8FLGkGir1Px7sju5u7jaCOJaYQVFChvUW6+3lY3cZj6WutF
         0xoXcHmzai8zPLOoH4jb4V/cpHFb41G10QK9/EwNVTuPG5aFwLcNVkVG/eqAboEfa3VS
         ksMm3KTcuJyQ1MUEpU/yVSYHcUENlynxKjZ5tlJHe8e2oulV0OADLXlt6K/YsTbosCVB
         bA8A==
X-Gm-Message-State: ANoB5pkDpuhjH3QzNFrJKcgHjXettfpP0ykPhHQ5TQOrnfuIk5tvmwMG
        k5+CcLolBRuo2MDhppMNIyDppmLfrzOqCQ8bsgYu+Rx8IDoWRecsZwTugiZxzxASLAaeAJUu3HZ
        WtSoQrCgvhwH2IkUTbg/Rt6c5
X-Received: by 2002:a5d:6f11:0:b0:242:70f0:9196 with SMTP id ay17-20020a5d6f11000000b0024270f09196mr33065567wrb.45.1671529055090;
        Tue, 20 Dec 2022 01:37:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5A94U6u6cGzamMmT1GgT+wuXQtFEvsTtiTSWk5LQnUafJiCwGKhccUzi3oD1XqGmcmR4z97A==
X-Received: by 2002:a5d:6f11:0:b0:242:70f0:9196 with SMTP id ay17-20020a5d6f11000000b0024270f09196mr33065558wrb.45.1671529054902;
        Tue, 20 Dec 2022 01:37:34 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id az17-20020adfe191000000b00241bd7a7165sm12231930wrb.82.2022.12.20.01.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:37:34 -0800 (PST)
Message-ID: <6a6e3bfb-d320-8ccf-f047-55999552c8fc@redhat.com>
Date:   Tue, 20 Dec 2022 10:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 12/18] fbdev/offb: Allocate struct offb_par with
 framebuffer_alloc()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-13-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-13-tzimmermann@suse.de>
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
> Move the palette array into struct offb_par and allocate both via
> framebuffer_alloc(), as intended by fbdev. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

