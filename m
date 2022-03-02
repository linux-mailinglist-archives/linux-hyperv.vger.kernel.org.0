Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268224CA564
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbiCBNAI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 08:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiCBNAI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 08:00:08 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613DCB91D8;
        Wed,  2 Mar 2022 04:59:25 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id r65so1088917wma.2;
        Wed, 02 Mar 2022 04:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z3SBnBsWmEFDQGmZ5b7CEI2YNsuIbEYxHeROS2OrNro=;
        b=KEb+jtJeYI5nj+Jy7jZUHl+0ImClrNaPRg7gxhv/nihRSr7acYulAOEl62psCkfxtZ
         v7Ls9aswpQoDl4KGT2gvZcVGrid12Qy52NDWu99r4oVhOM3In0b5FzHmMzcVpOzbkx4n
         sodwuTEXfwjCQAynWnqVc+esfw4no97oaCNo9EHvcnltNgPVleEqMxI+fplPhgA6c1AN
         1cBEmSmVcEHampIg023DUTNhaFJ2FBArdQxt2q//B6AJMU6mprempVpY8dRYQlWYJCg8
         nysl5ciwz26PNNVCibO9Uc2B5sowtcho6XZNNRQo6yiG0VBMaiQdcVZw9BiE6rReBhIt
         mI0A==
X-Gm-Message-State: AOAM533B99x5ImngUCGLOjy70omt5+ZVVfEc+eucBW6GolhCDDCfNtkJ
        Zb+HVrKm5v+G+1/M1hM/XoNjMSdYBgo=
X-Google-Smtp-Source: ABdhPJwnUY9Ip2RPcN9VbWPfAW6L0fZv18fPncZIRaqCkvjngqlBDIEIN28wyNmzENY9aieOQ2738A==
X-Received: by 2002:a05:600c:3512:b0:382:ee82:b3d1 with SMTP id h18-20020a05600c351200b00382ee82b3d1mr3182173wmq.126.1646225963956;
        Wed, 02 Mar 2022 04:59:23 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b003817ab146e9sm7786441wms.44.2022.03.02.04.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:59:23 -0800 (PST)
Date:   Wed, 2 Mar 2022 12:59:22 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 08/30] drivers: hv: dxgkrnl: Creation of dxgcontext
 objects
Message-ID: <20220302125922.xigz7wg6w2y7rufp@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <aabd5033766fe4751a5042e7a8c3ce82c2e83c17.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabd5033766fe4751a5042e7a8c3ce82c2e83c17.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:55AM -0800, Iouri Tarassov wrote:
[...]
> +static int
> +dxgk_create_context_virtual(struct dxgprocess *process, void *__user inargs)
> +{
> +	struct d3dkmt_createcontextvirtual args;
> +	int ret;
> +	struct dxgadapter *adapter = NULL;
> +	struct dxgdevice *device = NULL;
> +	struct dxgcontext *context = NULL;
> +	struct d3dkmthandle host_context_handle = {};
> +	bool device_lock_acquired = false;
> +
> +	pr_debug("ioctl: %s", __func__);
> +
> +	ret = copy_from_user(&args, inargs, sizeof(args));
> +	if (ret) {
> +		pr_err("%s failed to copy input args", __func__);
> +		ret = -EINVAL;

This should be -EFAULT. This goes for other copy_from_user calls too. You can also
drop the pr_err above.

Thanks,
Wei.
