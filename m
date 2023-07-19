Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A717758A50
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jul 2023 02:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGSAvS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jul 2023 20:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjGSAvB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jul 2023 20:51:01 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2359E171E
        for <linux-hyperv@vger.kernel.org>; Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76571dae5feso589566085a.1
        for <linux-hyperv@vger.kernel.org>; Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727816; x=1692319816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jDdPbzH4onHNW5mQ+nHZzIsBXIDVnlx9OcaE5Mwsjc=;
        b=eepobj0Vc1efSCz7ybajZtwpgJ5AghKHP5/txHgJFHHyY4FHoRmuQTm5LGfIesiqT/
         PD2ZTDjYtuPJ8w+SRAsKlf9SW1Ib1pYpdFc84jBiO4Y0y16uLALHKiYXgvuGWkyfqOw2
         oljI0n/oJhPluX28Ya2d//kILPfh1ZUF/MMYgawk3dKZjJ9oe5nOBGUQyNi8SIIIm7c0
         DTD5w9IYzqxsaAfBozvvoYSNWWlOsx0KjrDpjNiA32/Tivs28ml9xEjAwGuMBfpc3bKv
         z6IhJoR+YcKaXykod/FSL6o2Y+i/IWqmY0UulvwuRxY56EXpN3w9sHfLd323IuK7M8Tu
         AOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727816; x=1692319816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jDdPbzH4onHNW5mQ+nHZzIsBXIDVnlx9OcaE5Mwsjc=;
        b=GVnx5ANCBZQJisagKtxhhD5SVXkELWEbmeV/LCUDI50jbf+FNaH16p/ElEuiWf+QHR
         d/uMdh2xHHynv2DwtaiMP6CIlZ80ULiHjghOFptflsOxlGhQu6ZyR+f8xUSZFRHHtRir
         jwGe+MtjcQNwunBOuO1BhI3AMHdlXN5NzInm6kC/LaZyMEcAVRFHhOoMXr7zF0FOhLH8
         UytEh9MHqZz4Hp5JTru2zPCeJovQR6T5Maev8opWJ6pcEUc7/sBSD77KhD8mtHX5t//g
         Qas5+3wr3SJ82gIuijkvUZMbchcV1WjRdOelDo/PXu5AOp3nc+UiXTi5WADJrUgrfdwt
         AtOg==
X-Gm-Message-State: ABy/qLYB6dPmFgiB3q+r4El9ZSYX4xJsZa08J2m/X9VG7lrrCKRVxZFl
        +X/90gdJ/AIJxE05WO++xKXboQ==
X-Google-Smtp-Source: APBJJlFK4k8p+Ccs+dRT+RZiQ+t53CIizMdNsu9Q4x5KgBks0HqA9n612FswA/1ba47aAoZuL7DUyA==
X-Received: by 2002:a05:620a:3998:b0:767:2f4a:e07a with SMTP id ro24-20020a05620a399800b007672f4ae07amr1182364qkn.68.1689727816119;
        Tue, 18 Jul 2023 17:50:16 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:15 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Wed, 19 Jul 2023 00:50:12 +0000
Subject: [PATCH RFC net-next v5 08/14] af_vsock: add
 vsock_find_bound_dgram_socket()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-8-581bd37fdb26@bytedance.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This commit adds vsock_find_bound_dgram_socket() which allows transports
to find bound dgram sockets in the global dgram bind table. It is
intended to be used for "routing" incoming packets to the correct
sockets if the transport uses the global bind table.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/net/af_vsock.h   |  1 +
 net/vmw_vsock/af_vsock.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index f6a0ca9d7c3e..ae6b6cdf6a4d 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -215,6 +215,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
+struct sock *vsock_find_bound_dgram_socket(struct sockaddr_vm *addr);
 
 /**** TAP ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 0895f4c1d340..e73f3b2c52f1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -264,6 +264,22 @@ static struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
 	return NULL;
 }
 
+struct sock *
+vsock_find_bound_dgram_socket(struct sockaddr_vm *addr)
+{
+	struct sock *sk;
+
+	spin_lock_bh(&vsock_dgram_table_lock);
+	sk = vsock_find_bound_socket_common(addr, vsock_bound_dgram_sockets(addr));
+	if (sk)
+		sock_hold(sk);
+
+	spin_unlock_bh(&vsock_dgram_table_lock);
+
+	return sk;
+}
+EXPORT_SYMBOL_GPL(vsock_find_bound_dgram_socket);
+
 static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
 {
 	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));

-- 
2.30.2

