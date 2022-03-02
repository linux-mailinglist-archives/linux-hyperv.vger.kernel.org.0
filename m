Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFEC4CA5F7
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiCBN0k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 08:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiCBN0j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 08:26:39 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566B2DE7;
        Wed,  2 Mar 2022 05:25:56 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id u10so1157923wra.9;
        Wed, 02 Mar 2022 05:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yfk2Zok3t0Vw4DfsAGuxBuROVgr+WDNIArMCRZveyF4=;
        b=38RULZBLzeLYqBQseMsdtz8ClmrRKdoqGLLgIiTprzgnckHdp4K3LJy6n7VPi0A6fG
         Y09RXooWOc2hACNCqRMGgxeO3QBUie5R5GWxOp7HsPIdj4Fm5TnLjQrkPqXbBaFJPcEc
         N6yOdS6/ot6x0/Edg/1+mg1hvFKU6a0yHCuIas7TEBQAeAU8+xXi4Ji3JvnYLFFLGxtq
         qUBvoJrvrazi1Z044wv7lPpWm3D3j9jIbelttejp1CGcMw0Jl0llbl5/eit8vfl7qRBr
         LChWPRTfx/F9hT+Fh4RgzVK4y+bQCdfrL6AA0IdZPAraE/MJn24WIwCH/ycZp6URqlAm
         KvqA==
X-Gm-Message-State: AOAM531AG4yIpPIT93jxpCc34y3+WP7/jkBdo7uIdz0Gk0/auLMty+P4
        h5f630N/6U9KFcmrBjvTFNF+2Bvq39Q=
X-Google-Smtp-Source: ABdhPJwh+jnexT1ewqtomhIDD5TRreNmf8JL5VMmDuWYmP84nMrp+zK782JTOHJcbL1hSCDEHsRjXg==
X-Received: by 2002:a5d:6488:0:b0:1ea:7ff1:93e with SMTP id o8-20020a5d6488000000b001ea7ff1093emr24307485wri.284.1646227554586;
        Wed, 02 Mar 2022 05:25:54 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d18-20020adff2d2000000b001f025ea3a20sm3657228wrp.0.2022.03.02.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:25:54 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:25:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 10/30] drivers: hv: dxgkrnl: Creation of compute
 device sync objects
Message-ID: <20220302132552.bssianizq25c3fu4@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <438c7537f0b5b8f6f5afc35f968a3cf38047d290.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438c7537f0b5b8f6f5afc35f968a3cf38047d290.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:57AM -0800, Iouri Tarassov wrote:
[...]
> +void dxgadapter_remove_syncobj(struct dxgsyncobject *object)
> +{
> +	down_write(&object->adapter->shared_resource_list_lock);
> +	if (object->syncobj_list_entry.next) {
> +		list_del(&object->syncobj_list_entry);
> +		object->syncobj_list_entry.next = NULL;
> +	}

Just use list_del here.

Thanks,
Wei.
