Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3574CA82A
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 15:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbiCBObT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 09:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbiCBOaX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 09:30:23 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF586C7E64;
        Wed,  2 Mar 2022 06:29:03 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so522922wmf.0;
        Wed, 02 Mar 2022 06:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u1uRIjELuAIT1ZdKPoFbKLM6B7n19acx/Ml5oN1/Sgo=;
        b=J6V9rf3W5QcP/b7nmKxXt/bgdCFDa/Mwhlo6ktS40eaYWRMpibbdzP3cymGyp5F6LO
         PJW2W4WVJHgPZYOLGDk7AF5zo1r1XS2viIxgwJiWrzZm8yF/s1YkrmDrCDDa3iSzjQ1q
         J+o4W0DMC/SNcma+T0/0h/HiUBbsb27/nwEp8pyew1YgztlRn/u5gEfFjqVI5yoBh0CL
         iGUZgbH6x8Du4uVwZHShT42H/jN78oYDbKseLnO9PUsUCra0O2DyUYK4TXmyrwF9w8aU
         z2bcGVep4cbFkccq1SQvbucJemVleNmnsw+ltgjNyn9JGgyHbyeJbL7VxcT9FDy6zQB4
         oRyw==
X-Gm-Message-State: AOAM531OZ5DggP3DZFwWc47p3NUJeCMYq7mfbOT3kPcJEYTn5Moi9RZn
        gK5xzo5a171m5JKXsihc1js=
X-Google-Smtp-Source: ABdhPJwjvW/iEsr/yoeBUz+tCiWoRjuXWWG5bQtcXTgbZ3ykMPh1U73cqUPXi286lwjvjWuwofwCyQ==
X-Received: by 2002:a05:600c:1e84:b0:381:6c56:ebcc with SMTP id be4-20020a05600c1e8400b003816c56ebccmr63096wmb.28.1646231342063;
        Wed, 02 Mar 2022 06:29:02 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b001e2628b6490sm16865278wrv.17.2022.03.02.06.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:29:01 -0800 (PST)
Date:   Wed, 2 Mar 2022 14:29:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 30/30] drivers: hv: dxgkrnl: Add support to map guest
 pages by host
Message-ID: <20220302142900.6ziddzoes2oovhzi@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <7e303134ccd13b25080f7ebde5dc57f302972d55.1646163379.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e303134ccd13b25080f7ebde5dc57f302972d55.1646163379.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:46:17AM -0800, Iouri Tarassov wrote:
[...]
> @@ -1393,6 +1396,7 @@ int create_existing_sysmem(struct dxgdevice *device,
>  	pr_debug("   Alloc size: %lld", alloc_size);
>  
>  	dxgalloc->cpu_address = (void *)sysmem;
> +

Well this is just adding a blank line. Please avoid changes like this...

Thanks,
Wei.
