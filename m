Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF8C758A4E
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jul 2023 02:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGSAvR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jul 2023 20:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGSAvB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jul 2023 20:51:01 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851DD19A3
        for <linux-hyperv@vger.kernel.org>; Tue, 18 Jul 2023 17:50:15 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7680e39103bso364058885a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 18 Jul 2023 17:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727814; x=1692319814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5UDtnqRbXOwSk4kv7KpsqiuRSfPeujQxTt7caqoeag=;
        b=Bzc5QYphkJxBJAAVGcKxoftfnIy9ixoapstjfZaDHt+8ignmoEtHuP1QMFfV/NgdZv
         3sj5ZjysfQgDx4p0HKOtFfmPSLhf8q9ZrgG0m5jUcvca0sYjsElAG49iWpsKB4o7xNlw
         uAQ40QIRMt+3ilnWtx70o1O4HaBVrlCrik+wNvo96xyR4+3Q4cUVkFT5sX2tg+JhlBe+
         hSQ//wu9r44PASXmqG6/Xmmv+nIq7JhrBez2ZRRnULIsZkr3/pE+EpOBNqOpyyWWX28B
         g5owX/BThJ1OiSg+ZKlYhgtlbmLJZLHH8juDYc38OwYMTHaeoKsA4gvu2ohtJ4f634Uk
         w1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727814; x=1692319814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5UDtnqRbXOwSk4kv7KpsqiuRSfPeujQxTt7caqoeag=;
        b=DstKavSWYt8g9tupObgboDnb54FS6XHRW7G31ZUKCE0/OWZ84cmcSsHdY5YzrK8hzW
         OtA8/DBkcTjFp0jN1U/8f1jp1U9WLoV3x9eN/OdvjFv23713u6VX5XRJaF3/n9PI7tFr
         rZ5pUt4wasQmTE2giPi/tfYNvHmcUl7ELauIPrwKWghF07OfPScCkG5QoO5Ib/Z0FvYm
         4C/rwIV+/Jduy4m6fWT8mYI31LEApgfBORI0UWls/E8PGWBA+pfsVWQTB0WQk2IU9HfA
         RBaUGjJTxRK1rFOT8/eHItkoqFfG7lXHNWirm/bFUqh/r0ZwsZr4YIIyciJKVk7sMWWq
         7K5w==
X-Gm-Message-State: ABy/qLZAjp9OiY9yKK43RD6hbYRhnL9P/KMdf2fBm4q075ne2KyWSef+
        ob4OQblHUyneLfHPOsI8FgJG6w==
X-Google-Smtp-Source: APBJJlFOmR0fNEyLgJ+viEMpPBQC9+mqSkp+cSt9WdE1XdGyudW5tKRhGwKsNcl1PUOy43fop5oI/w==
X-Received: by 2002:a05:620a:400b:b0:767:2a7e:1dbc with SMTP id h11-20020a05620a400b00b007672a7e1dbcmr1924213qko.17.1689727814453;
        Tue, 18 Jul 2023 17:50:14 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:14 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Wed, 19 Jul 2023 00:50:10 +0000
Subject: [PATCH RFC net-next v5 06/14] virtio/vsock: add
 VIRTIO_VSOCK_TYPE_DGRAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-6-581bd37fdb26@bytedance.com>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
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
        bpf@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This commit adds the datagram packet type for inclusion in virtio vsock
packet headers. It is included here as a standalone commit because
multiple future but distinct commits depend on it.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/uapi/linux/virtio_vsock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 64738838bee5..331be28b1d30 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -69,6 +69,7 @@ struct virtio_vsock_hdr {
 enum virtio_vsock_type {
 	VIRTIO_VSOCK_TYPE_STREAM = 1,
 	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
+	VIRTIO_VSOCK_TYPE_DGRAM = 3,
 };
 
 enum virtio_vsock_op {

-- 
2.30.2

