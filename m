Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A250A169
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Apr 2022 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387084AbiDUOBo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Apr 2022 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbiDUOBk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Apr 2022 10:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77B3D37AAE
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Apr 2022 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650549529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCDdTtfh+cTEbBhGHl6TDA/w0vVS1GSM5e8sY5ZehTw=;
        b=NFxtqG+ent5tyig8uUSSYtm2Yw+WwGApBjD7cjJzdT827tVMrRK8AxhiX9wk7An5SkSk4p
        5eBePbASd5aDooNfV/ZpyHFAsqD8bdpTqu/224aiob5lRN7KZuDE0W/O1qfnjkY8pNyIQI
        YVvEjJygnazrcbQOCyohM1Qa0yKM6aw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-6bh5edTxNPGZEWR25MfVDA-1; Thu, 21 Apr 2022 09:58:46 -0400
X-MC-Unique: 6bh5edTxNPGZEWR25MfVDA-1
Received: by mail-ej1-f72.google.com with SMTP id mp18-20020a1709071b1200b006e7f314ecb3so2539303ejc.23
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Apr 2022 06:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FCDdTtfh+cTEbBhGHl6TDA/w0vVS1GSM5e8sY5ZehTw=;
        b=qXgtIa0/UsLBdzxO0SRcTKX4a/Od3gwgvj17qILJgg72WqkAG/JFtNTxAbxcE7FsN0
         HxcbRb0+/GII9haiFCTmDaw4UDooI9iIL4egvaHVE6fg3urLYk/tNPDDDxdJZysn5xZd
         bmO/OL3Fl62amZloJNcCDXvV0/Gjz35YO3670dwpdRL6kQFf6mkTIOpWfrG88VIlmWaT
         DAtgBCvBpKT8zooIIw9lRYH67+112SyjAQKAi9KF/KcKFpwdaGVzTJp/OBHCgnRacbyN
         PzXjBvzSfhk/zbMnL+SV5CYvlRXO4/+tHO8S5OHy3dRLZSnmjYQK+cJMBJjoX8WrjkHZ
         IKVg==
X-Gm-Message-State: AOAM531OgED8VQWdQylTyI+sA5rN2J/qz4BsXa634oS2m2RY2ULiNIec
        6Aq4tMgwiignti/net4guELL1zPWhJGn52kUXBbrV5ex6hnHgTVLl+uOMLYFkPU9cmr3s7enSE4
        gXZHjDGie99B0ohGpAlCMner+
X-Received: by 2002:a05:6402:50d1:b0:423:f4a2:95c7 with SMTP id h17-20020a05640250d100b00423f4a295c7mr18677813edb.91.1650549525253;
        Thu, 21 Apr 2022 06:58:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4JGn8p7OAUTHSbJC7sBsOiSljB3wcQ48NL5S76jPutkqPECOtv4rN6ZvZhqHRw9AZzzPQ5Q==
X-Received: by 2002:a05:6402:50d1:b0:423:f4a2:95c7 with SMTP id h17-20020a05640250d100b00423f4a295c7mr18677794edb.91.1650549525081;
        Thu, 21 Apr 2022 06:58:45 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.75.76])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402036100b004240a3fc6b4sm3043298edw.82.2022.04.21.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:58:44 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:58:39 +0200
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
Subject: Re: [PATCH 2/5] hv_sock: Copy packets sent by Hyper-V out of the
 ring buffer
Message-ID: <20220421135839.2fj6fk6bvlrau73o@sgarzare-redhat>
References: <20220420200720.434717-1-parri.andrea@gmail.com>
 <20220420200720.434717-3-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220420200720.434717-3-parri.andrea@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 20, 2022 at 10:07:17PM +0200, Andrea Parri (Microsoft) wrote:
>Pointers to VMbus packets sent by Hyper-V are used by the hv_sock driver
>within the guest VM.  Hyper-V can send packets with erroneous values or
>modify packet fields after they are processed by the guest.  To defend
>against these scenarios, copy the incoming packet after validating its
>length and offset fields using hv_pkt_iter_{first,next}().  In this way,
>the packet can no longer be modified by the host.
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>---
> net/vmw_vsock/hyperv_transport.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 943352530936e..8c37d07017fc4 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -78,6 +78,9 @@ struct hvs_send_buf {
> 					 ALIGN((payload_len), 8) + \
> 					 VMBUS_PKT_TRAILER_SIZE)
>
>+/* Upper bound on the size of a VMbus packet for hv_sock */
>+#define HVS_MAX_PKT_SIZE	HVS_PKT_LEN(HVS_MTU_SIZE)
>+
> union hvs_service_id {
> 	guid_t	srv_id;
>
>@@ -378,6 +381,8 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
> 	}
>
>+	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
>+

premise, I don't know HyperV channels :-(

Is this change necessary to use hv_pkt_iter_first() instead of 
hv_pkt_iter_first_raw()?

If yes, then please mention that you set this value in the commit 
message, otherwise maybe better to have a separate patch.

Thanks,
Stefano

> 	ret = vmbus_open(chan, sndbuf, rcvbuf, NULL, 0, hvs_channel_cb,
> 			 conn_from_host ? new : sk);
> 	if (ret != 0) {
>@@ -602,7 +607,7 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
> 		return -EOPNOTSUPP;
>
> 	if (need_refill) {
>-		hvs->recv_desc = hv_pkt_iter_first_raw(hvs->chan);
>+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
> 		if (!hvs->recv_desc)
> 			return -ENOBUFS;
> 		ret = hvs_update_recv_data(hvs);
>@@ -618,7 +623,7 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
>
> 	hvs->recv_data_len -= to_read;
> 	if (hvs->recv_data_len == 0) {
>-		hvs->recv_desc = hv_pkt_iter_next_raw(hvs->chan, hvs->recv_desc);
>+		hvs->recv_desc = hv_pkt_iter_next(hvs->chan, hvs->recv_desc);
> 		if (hvs->recv_desc) {
> 			ret = hvs_update_recv_data(hvs);
> 			if (ret)
>-- 
>2.25.1
>

