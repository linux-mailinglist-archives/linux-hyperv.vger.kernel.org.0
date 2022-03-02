Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F594CA7B3
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 15:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbiCBONw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 09:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiCBONu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 09:13:50 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628604D9C4;
        Wed,  2 Mar 2022 06:13:07 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id p4so1219097wmg.1;
        Wed, 02 Mar 2022 06:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nHT4MCptZeetE8qKmuW/VFqnqQaER7KL4kP3Z8juT8o=;
        b=12PQ56Cmb7T38mv4K3I6UEHy39UUZ+YXY+lJTFTa5dKCoD/g/cDbxyfvKZnJt/7FGn
         okSQc6KxS/YLinZ11uZ83PK8GFJWr+LDead1/74zU4vjyClvPCWu0YWyqcmq+RA3ttKL
         4FqBmppiFS4XKLJL/PBV3ZyEwEODvf1kKOLg9PpJ8a1oZqy2tB1/riRcVS1BQouB76pM
         sxToDp2LWHl8FX1ED4aLvTe+EOMuSFJ9DqrwVs9tIYf1vx0Uww7YhS7961T8PmRGAJ1L
         S35Y49MQjLE1Qtq6nRY5lsuD+mIuUOwiPxBeqzerzvQIOKaHayA1htPuk420zZe+lcpI
         m12w==
X-Gm-Message-State: AOAM531ijO5XQy2XSf6hFVZ8yBUqcIuBTwEekMWaOrt879exgBDSFA/P
        V43cD31yBM/jdpQ+CF6oCZo=
X-Google-Smtp-Source: ABdhPJz7JUHHz+PVcCY4DWGmSp64i2vRGZuA7dwuqAaz0dVrVu7DOS7leOXUmlQGqqESCNO8W2v6tA==
X-Received: by 2002:a1c:2b41:0:b0:380:e379:b8b0 with SMTP id r62-20020a1c2b41000000b00380e379b8b0mr21207811wmr.87.1646230385884;
        Wed, 02 Mar 2022 06:13:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l7-20020adfa387000000b001f02f5d5f76sm2127283wrb.109.2022.03.02.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:13:04 -0800 (PST)
Date:   Wed, 2 Mar 2022 14:13:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 12/30] drivers: hv: dxgkrnl: Sharing of dxgresource
 objects
Message-ID: <20220302141303.ck4zopvsiuykjqv4@liuwe-devbox-debian-v2>
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
>  
> +static int dxgsharedresource_seal(struct dxgsharedresource *shared_resource)
> +{
> +	int ret = 0;
> +	int i = 0;
> +	u8 *private_data;
> +	u32 data_size;
> +	struct dxgresource *resource;
> +	struct dxgallocation *alloc;
> +
> +	pr_debug("Sealing resource: %p", shared_resource);
> +
> +	down_write(&shared_resource->adapter->shared_resource_list_lock);
> +	if (shared_resource->sealed) {
> +		pr_debug("Resource already sealed");
> +		goto cleanup;
> +	}
> +	shared_resource->sealed = 1;
> +	if (!list_empty(&shared_resource->resource_list_head)) {
[...]
> +		}
> +cleanup1:

Please just name it unlock ... 

> +		mutex_unlock(&resource->resource_mutex);
> +	}
> +cleanup:

... and rename this to done because you are not cleaning up anything.

> +	up_write(&shared_resource->adapter->shared_resource_list_lock);
> +	return ret;
> +}
> +

Thanks,
Wei.
