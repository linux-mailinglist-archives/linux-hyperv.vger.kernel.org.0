Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AAC50A136
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Apr 2022 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384863AbiDUNx5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Apr 2022 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387645AbiDUNx4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Apr 2022 09:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01CB713F97
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Apr 2022 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650549065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9X5WXrysF88Ouj/slnEAN9ILrlD7gwjjZO9fEL4BbEQ=;
        b=GTSRfaAYaznYDSI/X9hE5BSC/oHMz9Mb02073TIcuR9Kk+ZHZ396fbTW+h1qW+BXJE+h1+
        QOk7JvSD0z0aLKEq1lvlJhq+9dzHjMoyGNHlkAru5thKNOL8YzOOKQJtHeqaqc4deDRwjs
        ogyr/tkr6PWKMoqyeHWbe6FRgYFYTyY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-DzuHkyoVOCG0u2YNH8XEAg-1; Thu, 21 Apr 2022 09:51:03 -0400
X-MC-Unique: DzuHkyoVOCG0u2YNH8XEAg-1
Received: by mail-ej1-f69.google.com with SMTP id sa27-20020a1709076d1b00b006e8b357a2e7so2522467ejc.14
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Apr 2022 06:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9X5WXrysF88Ouj/slnEAN9ILrlD7gwjjZO9fEL4BbEQ=;
        b=DTlF1GrsJUB89eu/1CUN3/pURJEWZZnsFYQF+MfGqveZ6YQBUdjqTb9Ziutx7lEE/U
         9kZcq8DRYo58hcEjyvHq8hoDrea9CUO8O7XyLWqlAc7YenpjVqcMQp/oHhRr2sk1qtB1
         nbj8+xCF4SVE2NYLnJqH6zAmGtxf3WSNQGVDIn7fAJ09zPcom3k+9FZZzBig0pgijyBV
         DBk2PNjbFF6+Nw6iaidp2/+bErXWlGhF41GbDesXeKSE5Hx4/bbCB/W3QmjUSkp+48Qc
         8x2qdDrFHHxnWfXfPdvAZ24Uk1JDPoYWDqhE+chXf6mERTzJ7U7uar8hNd7VTdSjHPom
         d7ag==
X-Gm-Message-State: AOAM533ozB4aK5MqQkOfVFHRdbUv+UlR/jwEGKLIlRY2CL68mAVxTFIK
        1moihXfkPPEG2an8YPXIoAMgLJeJFichqmTIIc8XKAYvCNOtqecD+ClMPkEu5mAhNLcEIZgeC2W
        yPZvUIXznbnB+raxwKIzqhTW7
X-Received: by 2002:a05:6402:26cd:b0:423:b43d:8b09 with SMTP id x13-20020a05640226cd00b00423b43d8b09mr28005749edd.400.1650549062687;
        Thu, 21 Apr 2022 06:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTS+Y4ILLrJT3QP2BpwpnOM5BPXge8ufksj1+vy8uCme6m2CyXJ309d3wnCuvShf6eaPoQKg==
X-Received: by 2002:a05:6402:26cd:b0:423:b43d:8b09 with SMTP id x13-20020a05640226cd00b00423b43d8b09mr28005722edd.400.1650549062455;
        Thu, 21 Apr 2022 06:51:02 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.75.76])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906174700b006e80a7e3111sm8096281eje.17.2022.04.21.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:51:01 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:50:57 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] hv_sock: Check hv_pkt_iter_first_raw()'s return value
Message-ID: <20220421135057.57whrntjdv25jqpl@sgarzare-redhat>
References: <20220420200720.434717-1-parri.andrea@gmail.com>
 <20220420200720.434717-2-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220420200720.434717-2-parri.andrea@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 20, 2022 at 10:07:16PM +0200, Andrea Parri (Microsoft) wrote:
>The function returns NULL if the ring buffer doesn't contain enough
>readable bytes to constitute a packet descriptor.  The ring buffer's
>write_index is in memory which is shared with the Hyper-V host, an
>erroneous or malicious host could thus change its value and overturn
>the result of hvs_stream_has_data().
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>---
> net/vmw_vsock/hyperv_transport.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index e111e13b66604..943352530936e 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -603,6 +603,8 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
>
> 	if (need_refill) {
> 		hvs->recv_desc = hv_pkt_iter_first_raw(hvs->chan);
>+		if (!hvs->recv_desc)
>+			return -ENOBUFS;
> 		ret = hvs_update_recv_data(hvs);
> 		if (ret)
> 			return ret;
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

