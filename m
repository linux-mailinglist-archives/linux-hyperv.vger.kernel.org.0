Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8C4C9948
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 00:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiCAX0H (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 18:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiCAX0G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 18:26:06 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CF32071;
        Tue,  1 Mar 2022 15:25:24 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so200452wms.4;
        Tue, 01 Mar 2022 15:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhdQMX9lSVJESfzj40t/VjwrSkjRlYETq/8QRNqEZlQ=;
        b=XAaZP12v/DPVmZCOAtpctIG4kIeB6SxTN9ZA3+qdENbH303o3epg2ZriGSyv07irjd
         MRvzQlAcgo0x8bdXaFbND+0z16xwTJ5kMKSDWP3nEi63/+RbTjAdXhkY6ocIf69d7Lll
         sEHH24Bq2IeNgp9Hu7vEk0X5g2l67dHr4EHHlG3dI/SqQPBaIm8ZmFJlm73sgkRP2zKv
         KuIqhvbC6Z0F68EjJ3eUu6/zQlhdcbg2DIGKg0aX6geh2DiEELpzsjR7hdXBN6xFgaqs
         hwqrV9e2OQ5kctitLC4ThcPUgGX6L+/kZx3jCaTp1myHzKS5Z07K2ATclHIvdb4EceK3
         XLDA==
X-Gm-Message-State: AOAM533ztQ87fCx1H9LLq5K9t9bilBccD5kKAB6uDY6W97mJDyx63WtB
        A+A17Qy8EDnXfara1Kf9xB0=
X-Google-Smtp-Source: ABdhPJwmMtEzfPNdwOooZC2wf8A5bG/k7/4cOFDA4GsOuK+fySnMmsVg/aKO7lV23W/H+JvKF7jWdA==
X-Received: by 2002:a05:600c:a0d:b0:381:774b:4439 with SMTP id z13-20020a05600c0a0d00b00381774b4439mr7274565wmp.48.1646177122835;
        Tue, 01 Mar 2022 15:25:22 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c15c500b003810188b6basm3515288wmf.28.2022.03.01.15.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 15:25:22 -0800 (PST)
Date:   Tue, 1 Mar 2022 23:25:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 04/30] drivers: hv: dxgkrnl: Creation of dxgadapter
 object
Message-ID: <20220301232521.74utynmxngknd7qy@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <03e9d393c08a348ca60539bb5f8d2dd6b5afaf0f.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e9d393c08a348ca60539bb5f8d2dd6b5afaf0f.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:51AM -0800, Iouri Tarassov wrote:
[...]
> +int dxgadapter_set_vmbus(struct dxgadapter *adapter, struct hv_device *hdev)
> +{
> +	int ret;
> +
> +	guid_to_luid(&hdev->channel->offermsg.offer.if_instance,
> +		     &adapter->luid);
> +	pr_debug("%s: %x:%x %p %pUb\n",
> +		    __func__, adapter->luid.b, adapter->luid.a, hdev->channel,
> +		    &hdev->channel->offermsg.offer.if_instance);
> +
> +	ret = dxgvmbuschannel_init(&adapter->channel, hdev);
> +	if (ret)
> +		goto cleanup;
> +
> +	adapter->channel.adapter = adapter;
> +	adapter->hv_dev = hdev;
> +
> +	ret = dxgvmb_send_open_adapter(adapter);
> +	if (ret < 0) {

if (ret) is simpler?

Please be consistent regarding how you check for errors.

> +		pr_err("dxgvmb_send_open_adapter failed: %d\n", ret);
> +		goto cleanup;
> +	}
> +
> +	ret = dxgvmb_send_get_internal_adapter_info(adapter);
> +	if (ret < 0)
> +		pr_err("get_internal_adapter_info failed: %d", ret);
> +
> +cleanup:
> +	if (ret)
> +		pr_debug("err: %s %d", __func__, ret);
> +	return ret;
> +}
> +
> +void dxgadapter_start(struct dxgadapter *adapter)
> +{
> +	struct dxgvgpuchannel *ch = NULL;
> +	struct dxgvgpuchannel *entry;
> +	int ret;
> +
> +	pr_debug("%s %x-%x",
> +		__func__, adapter->luid.a, adapter->luid.b);
> +
> +	/* Find the corresponding vGPU vm bus channel */
> +	list_for_each_entry(entry, &dxgglobal->vgpu_ch_list_head,
> +			    vgpu_ch_list_entry) {

The mutex is not acquired in this function.

I have not checked if this function is used elsewhere. But this is a
non-static function, it should have at least a comment on the locking
requirement?

If it is not needed elsewhere, please make it static or named it
dxgadapter_start_locked.


[...]
> +}
> +
> +void dxgadapter_stop(struct dxgadapter *adapter)

Same comment applies to this function as well.

Thanks,
Wei.
