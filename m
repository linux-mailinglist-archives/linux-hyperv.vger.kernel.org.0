Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F78073A511
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jun 2023 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjFVPc0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jun 2023 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjFVPcE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jun 2023 11:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875BA3A87
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Jun 2023 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687447768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LHj7B9f0CgOb6vLBDwdZy7CybIY89mtFfpP8ghtMr90=;
        b=JvmIJ8c2uegz9fuPrzIqCkliK2egf7cOoUqaJl95xUNEkRshtSov4HAGFPALMGShIX7dAN
        LQ4Bh+mUMNJa36xH7oaJ8uPhHQnVOUJQCXvIZzjRWdFdMe7yylgTvKgc1K6Oj79wx4ckFc
        E5pC7YY7Gd5wV1YtJVcVIXVSpxvUDck=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-41tn9_KmOjezJE0nYiYTGw-1; Thu, 22 Jun 2023 11:29:23 -0400
X-MC-Unique: 41tn9_KmOjezJE0nYiYTGw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31114af5e45so3372346f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Jun 2023 08:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447753; x=1690039753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHj7B9f0CgOb6vLBDwdZy7CybIY89mtFfpP8ghtMr90=;
        b=OZCEOC1aTeGlJ/t2WdjwIv/0RxN0XS5JjuW+v3+lIeA4At/36BFBwoEie8y19+HB6/
         uJeYf5PZWP9GW12Nb0kis1ifoz2Wpf1ElXioi2OoC/VKdE7MLzcXeARJG6nPEGx2+qWR
         TWuQxiH1s/ZDfHWzQaSNLv44m6VjQcieSIS9a+cebxW+2VnlpOi00F4cIfVYOGIL4P49
         JlSrVdvtzKPODTqPZDqQ6PUM6+wsK0tbs1WIOmOJil6GO9zP+I2FvlXW1klP+86dfUvU
         2rrHwjtlx/IHvIWeQg6c7QrRfvxx8ptdBji7hQ4gKTLO702dmQrQyXUM3jMurkUv1dTF
         +m8A==
X-Gm-Message-State: AC+VfDy3s60nG5pIf3FpWrpWC5car4TLv9K/di9+2dZh28wja+64h8cq
        Y4KWlL8sykiljES7ncumqHswTQOeAIy+NmWOPQ8Y0wOIKJDav7T01qj9oIgQJEpqGJ8yEbXcWkq
        xVTaI38oyOtbTKza0MqNCakYv
X-Received: by 2002:a5d:4a45:0:b0:30f:b9a2:92c5 with SMTP id v5-20020a5d4a45000000b0030fb9a292c5mr16230761wrs.49.1687447752863;
        Thu, 22 Jun 2023 08:29:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wJek32JccOCrkY+bAzshAWmkfVijJZJwTebxPvorEXZQJ+vqataOybeRtTQvOfMVty8q+6Q==
X-Received: by 2002:a5d:4a45:0:b0:30f:b9a2:92c5 with SMTP id v5-20020a5d4a45000000b0030fb9a292c5mr16230739wrs.49.1687447752542;
        Thu, 22 Jun 2023 08:29:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b00307acec258esm7389420wro.3.2023.06.22.08.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:29:12 -0700 (PDT)
Date:   Thu, 22 Jun 2023 17:29:08 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        bpf@vger.kernel.org, Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [PATCH RFC net-next v4 5/8] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <med476cdkdhkylddqa5wbhjpgyw2yiqfthvup2kics3zbb5vpb@ovzg57adewfw>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-5-0cebbb2ae899@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230413-b4-vsock-dgram-v4-5-0cebbb2ae899@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jun 10, 2023 at 12:58:32AM +0000, Bobby Eshleman wrote:
>This commit adds a feature bit for virtio vsock to support datagrams.
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> include/uapi/linux/virtio_vsock.h | 1 +
> 1 file changed, 1 insertion(+)

LGTM, but I'll give the R-b when we merge the virtio-spec.

Stefano

>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 64738838bee5..9c25f267bbc0 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -40,6 +40,7 @@
>
> /* The feature bitmap for virtio vsock */
> #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>
> struct virtio_vsock_config {
> 	__le64 guest_cid;
>
>-- 
>2.30.2
>

