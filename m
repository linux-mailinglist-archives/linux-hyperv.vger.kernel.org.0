Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508E94CA7BA
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiCBOQH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 09:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBOQG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 09:16:06 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC44B0D38;
        Wed,  2 Mar 2022 06:15:23 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id u1so2987328wrg.11;
        Wed, 02 Mar 2022 06:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WZLlspd1IFItSt2hx0XQFDBBY2mneSMTaZqSqiCm9CM=;
        b=H06a+bkBBSQI+/sB8MX6ln3eHq8mLb32zeCZ2Z4V/sHFuJqoYJSYlDRICKhKjhiE9H
         +dS7tfMItg3j7llRBlzD0mZx38n1XSMInRxrevN2xALvDzUyM3kYPd7MJc2hMWNKSf+y
         4ThKpzclwpZo5vEV3wSccLqKwcg/n4W8nyR/LOJhJ+nRxh+761mRsFWn3C7JpNGNDbi9
         LOlgsHiArNtVYFY+irj68dUvDUs46lLeIa76KTpRYukjGGlVXUp+9c2QnhMsbbFknUIE
         IBiVFg4KJyrH0CY+eIG8j0C94TB1myL/RIL0x8UIi+BduXVf44pXS669CDNx4zrLZmLW
         kJaw==
X-Gm-Message-State: AOAM5308zAE0LU+NyNB5ZLvSqeNe/yZHLMwpvYFSHelUfq6NaUBJV9gj
        cIKeC92GKugG/DX2y91mVuo=
X-Google-Smtp-Source: ABdhPJxH8iX7RgoJUuBBEAeyar4MPfytu/E9sqGG01hzh5UC5drWqV/AAogPxjT2RT87pUQkOz1RTw==
X-Received: by 2002:adf:fcce:0:b0:1f0:2250:65aa with SMTP id f14-20020adffcce000000b001f0225065aamr4511040wrs.628.1646230522482;
        Wed, 02 Mar 2022 06:15:22 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm23724559wrt.63.2022.03.02.06.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:15:22 -0800 (PST)
Date:   Wed, 2 Mar 2022 14:15:20 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 12/30] drivers: hv: dxgkrnl: Sharing of dxgresource
 objects
Message-ID: <20220302141520.27bln2azikbay6px@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <8955113c37ad73748fac3cf9666f0e4f08d9f9be.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8955113c37ad73748fac3cf9666f0e4f08d9f9be.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:59AM -0800, Iouri Tarassov wrote:
[...]
> +void dxgadapter_remove_shared_resource(struct dxgadapter *adapter,
> +				       struct dxgsharedresource *object)
> +{
> +	down_write(&adapter->shared_resource_list_lock);
> +	if (object->shared_resource_list_entry.next) {
> +		list_del(&object->shared_resource_list_entry);
> +		object->shared_resource_list_entry.next = NULL;
> +	}

Again, just list_del please. I will skip pointing out this in
later patches.

Thanks,
Wei.
