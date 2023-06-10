Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7503472A740
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Jun 2023 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjFJBAE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jun 2023 21:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjFJA7f (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jun 2023 20:59:35 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEADC30F4
        for <linux-hyperv@vger.kernel.org>; Fri,  9 Jun 2023 17:58:49 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6261a8bbe5fso18275956d6.0
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Jun 2023 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686358729; x=1688950729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFrleghhHqJGwyApjTc8QCRKulATYWQc6gIOZoAbxyw=;
        b=ksml6xPtDkxvZbOyeBnygyfCAoLKD9q0OoR5ThMAuqNWqOyORqD7ip9kezP4rUQ1pn
         cA3456UR+nvIFDtB4hQkAr9+dKLyOoB0Y8uha3LGNU+M+xhPkSTa7bIVvcuZnFwYP2GC
         ZeEHzPd5W/3KKUl1LXXn+R864cg8cuPoU6ZDfrh/NKSNdEOSPjKHYDVyE/yjCGrqIXdt
         7HK2d+ygZZUKxpNeMasEJZ/ytDuYXAYFMacasr+ggsr8KojjvAWg1zXjYgoOPbiETiNr
         JtnJfhnbIucaihsxy/lQGs/DMMKT+Q9ovj9LdzJEIqHug2Ab3Rtgf2TouE1snzEnh4xG
         IFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358729; x=1688950729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFrleghhHqJGwyApjTc8QCRKulATYWQc6gIOZoAbxyw=;
        b=JEM9GrSOOihdwIJnZZcw3572v38CqFXbVvo9WE7t4t969YuB19Iqm1T1BPISfUvtsZ
         9eSeiNP154ubI37MDwE8np34qTfSQ+ALKo2g+L+Zlb4FjPS8ntfN+K5zHhtcLGtCwhFz
         JROukoYuUC9wKPBcd2FGkOkde0H8VD9BHZ1B/G8DqGLYY03AMM5lvIlwLrLSfCyoA39z
         qUpmGBKzVfKZ7o+uNu3ITTPvqrQfafhnAnQjeQ7k1Y8EbEB9HwHaKxhRxUNQopqwAOoH
         LzHRQCIyhsTO76eyn0CJnElEnRnXVk4NLs3mQiNClJj2IIQwyaMiTjQ7/fF7E98ZM8q/
         rPYg==
X-Gm-Message-State: AC+VfDxeY9sV/S0R9V/uMmaxwAfLQSM/MffkK63xh6ZE8GkZ9COQx4MB
        rWbytHDzX0ZKVC52yViWOO/nzQ==
X-Google-Smtp-Source: ACHHUZ5uIEySsxiEOpSX4l8ibj9bXDfnI2ZPrwbwx9nWGpkZhEBWPI0FhN3HTH4aTic7c7flSU8gzw==
X-Received: by 2002:a05:6214:e87:b0:626:2b44:40c with SMTP id hf7-20020a0562140e8700b006262b44040cmr3491456qvb.59.1686358729039;
        Fri, 09 Jun 2023 17:58:49 -0700 (PDT)
Received: from [172.17.0.4] ([130.44.212.126])
        by smtp.gmail.com with ESMTPSA id x17-20020a0ce251000000b00606750abaf9sm1504075qvl.136.2023.06.09.17.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 17:58:48 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Sat, 10 Jun 2023 00:58:32 +0000
Subject: [PATCH RFC net-next v4 5/8] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM
 feature bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v4-5-0cebbb2ae899@bytedance.com>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
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
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        bpf@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This commit adds a feature bit for virtio vsock to support datagrams.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/uapi/linux/virtio_vsock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 64738838bee5..9c25f267bbc0 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -40,6 +40,7 @@
 
 /* The feature bitmap for virtio vsock */
 #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
 
 struct virtio_vsock_config {
 	__le64 guest_cid;

-- 
2.30.2

