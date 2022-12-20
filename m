Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89615651DBD
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiLTJmz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiLTJmL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:42:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49714D33
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LveyBWJYAPbiyv73TUAfukc6OJNlBtbiuo6YSIh6FLQ=;
        b=Q7jkLfxfQyiVWjzUv3393IF/8mCrQ9TZ9s6dwDLyZ99VDb/GAZq6bIz8xyEPDG3NfOk4zs
        6/tDcV8bymcDeSxlbBstDpqqalm+ZXDxIn2xET0fmscdXAXR2+BokOLmmIS0oUTHYV6ac2
        guSt9PWz6+DI0yefZJgGvsWaldavAaw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-82-kGEf3byYP5qouIuh-cqtTQ-1; Tue, 20 Dec 2022 04:40:59 -0500
X-MC-Unique: kGEf3byYP5qouIuh-cqtTQ-1
Received: by mail-wr1-f69.google.com with SMTP id d6-20020adfa346000000b0024211c0f988so2067575wrb.9
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LveyBWJYAPbiyv73TUAfukc6OJNlBtbiuo6YSIh6FLQ=;
        b=DtvVw0m/Y+I/ARbSzLFfrQQ28lMbWROEKRdJPoYA7gS8C46ubEf1hzn/1REdKy/HaL
         F8sNs+14WFIubMw+7XOq18bePIGXRFC6ESwjQiV7d5rlPW5zrqm51m7rIQfE7d34hage
         rUcR6mpZFqf548WyU2ALhYaUxfPOp740pQV3eLJXasQHFNGLuS0hvV/T0tHUSXslbNlU
         s4WXRx2EbP4speS2sZjYip6HCMZ6KJ7ztcVM2dgsSPYoJ4b6PpwFqnpGqWICejAeUqM6
         l9TMe54+8HQMUJvyEOK0bbIyxa6HErCgPqUp/b/KmvztjMGHkMxqemVfeR92NdHmqB8v
         S/tQ==
X-Gm-Message-State: ANoB5pkqnbkndiQeOROlxeI/8af58iEv3k+FO1MU6spI4iiPOGb2WBeu
        /Qn8ybLUI4lBgWNhSnhLQAK+lv3U5LeHRHpXu4Y87DDDASni/+RCqLI+E2iSAETv5d44BMmkmYm
        R8WGny02FRdSdNoMRV7vd1hnS
X-Received: by 2002:a05:600c:1c23:b0:3d2:3376:6f2e with SMTP id j35-20020a05600c1c2300b003d233766f2emr22381399wms.9.1671529257841;
        Tue, 20 Dec 2022 01:40:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7eSfSzTvRvhDpxH502Pk0KEhQEu8qDdlhID/m63O9KppBhxg3tASNRV4SrXUiQOLpYrNpaag==
X-Received: by 2002:a05:600c:1c23:b0:3d2:3376:6f2e with SMTP id j35-20020a05600c1c2300b003d233766f2emr22381388wms.9.1671529257649;
        Tue, 20 Dec 2022 01:40:57 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id by3-20020a056000098300b002366c3eefccsm12187201wrb.109.2022.12.20.01.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:40:57 -0800 (PST)
Message-ID: <6b3825fc-e149-9096-0438-0fb2c717f3d6@redhat.com>
Date:   Tue, 20 Dec 2022 10:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 15/18] fbdev/vesafb: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-16-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-16-tzimmermann@suse.de>
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
> Fix coding style. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

