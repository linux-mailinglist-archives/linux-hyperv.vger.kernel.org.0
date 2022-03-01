Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1A84C97D6
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 22:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiCAVh6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 16:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiCAVh6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 16:37:58 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502F25D1B4;
        Tue,  1 Mar 2022 13:37:16 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id b5so22617158wrr.2;
        Tue, 01 Mar 2022 13:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/w1GQElBIdjDui0GoCVyPwQsU2/20BSfZsDyLFegPDg=;
        b=L3mDJ/MuBxoh+/W81y8zWVglwpmfqZDTsk04qKbCWTidJH4b/mcc0poj5fxAzb6Py6
         6kajIjDj8XnjtdvuB1aVV3vxHCmFb+/+2sdJWiJN2OsrjTQ+m8EOLek+Q5TGr4RjTX0a
         9VNfs5EleXiiLlfzc/pqDXnndmCTWL4nxxn4YnjZVxUev6+HRK0+yk/9DNnmg0892xAk
         zLVYvwH+WJHdv+3K5TMWLpJAxT2wRZ+3nVU97vt0KBzANxOaKDSlBgVT3cPRW8s/MQyc
         O+RHfgdLGxUqMqXzi6BN7gmoTU/OiTn2teDx2HwAhRS8JmECmGOaZzZhhr+wZym4XHr4
         D3vQ==
X-Gm-Message-State: AOAM530ONPJyB/Dfx+ckR+qr7DdJcYYK8Jt3A1lc1eYjLBqWc+Xed+rN
        XVqk1LUigRsvZEypyZwov/5y3NRfnnI=
X-Google-Smtp-Source: ABdhPJyRRhMB/FheguBh2ZA1LIlTAuojWJrN1til+hsKuEoKh5t4W7UwsYXSppaKHQKf2EcrbSbdfw==
X-Received: by 2002:a05:6000:ce:b0:1ef:189b:e31e with SMTP id q14-20020a05600000ce00b001ef189be31emr18995917wrx.538.1646170634804;
        Tue, 01 Mar 2022 13:37:14 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm3649715wmc.22.2022.03.01.13.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:37:14 -0800 (PST)
Date:   Tue, 1 Mar 2022 21:37:12 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 01/30] drivers: hv: dxgkrnl: Add virtual compute
 device VM bus channel guids
Message-ID: <20220301213712.ljpanrc65wx7k54b@liuwe-devbox-debian-v2>
References: <cover.1646161341.git.iourit@linux.microsoft.com>
 <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:48AM -0800, Iouri Tarassov wrote:
> Add VM bus channel guids, which are used by hyper-v virtual

"VMBus"

> compute device driver.

"Hyper-V"

> 
> Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>

This patch is trivially correct so with the names fixed.

Acked-by: Wei Liu <wei.liu@kernel.org>

> ---
>  include/linux/hyperv.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index b823311eac79..9d21055b003d 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1414,6 +1414,22 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
>  	.guid = GUID_INIT(0xda0a7802, 0xe377, 0x4aac, 0x8e, 0x77, \
>  			  0x05, 0x58, 0xeb, 0x10, 0x73, 0xf8)
>  
> +/*
> + * GPU paravirtualization global DXGK channel
> + * {DDE9CBC0-5060-4436-9448-EA1254A5D177}
> + */
> +#define HV_GPUP_DXGK_GLOBAL_GUID \
> +	.guid = GUID_INIT(0xdde9cbc0, 0x5060, 0x4436, 0x94, 0x48, \
> +			  0xea, 0x12, 0x54, 0xa5, 0xd1, 0x77)
> +
> +/*
> + * GPU paravirtualization per virtual GPU DXGK channel
> + * {6E382D18-3336-4F4B-ACC4-2B7703D4DF4A}
> + */
> +#define HV_GPUP_DXGK_VGPU_GUID \
> +	.guid = GUID_INIT(0x6e382d18, 0x3336, 0x4f4b, 0xac, 0xc4, \
> +			  0x2b, 0x77, 0x3, 0xd4, 0xdf, 0x4a)
> +
>  /*
>   * Synthetic FC GUID
>   * {2f9bcc4a-0069-4af3-b76b-6fd0be528cda}
> -- 
> 2.35.1
> 
