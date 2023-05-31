Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE2C717293
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 May 2023 02:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjEaAgX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 May 2023 20:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjEaAgS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 May 2023 20:36:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA5123
        for <linux-hyperv@vger.kernel.org>; Tue, 30 May 2023 17:35:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d18d772bdso5888844b3a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 30 May 2023 17:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685493313; x=1688085313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1blZp32leas5kXJi+UOuXoD7JhXTUgNgwlQOmeJG49g=;
        b=a2xdvGEpuMoly584VYJhtJ3a65HlJ4dm4abWKMTkPlSryuRFTN6VQ2nv5O338oXWHn
         JVL8m0YyZifXMedOOTURwPS/LCWOE3crjtMJO0JRBwLl5w4AsGquJ9k/FQafY8LFGiRG
         U98GIjnqV8HTdVBmj7WtYs1GOkcbvBmyyET2Y054EGHAMuhNqo2sFGZ58QrxSP5lWYhx
         CX2AN09+nXB6JTyq+jZUHINYqEMc3eTd14eFqMrRMrmmaaFdpwrs+SqJ0OaFOi2HsjC+
         q7QBsBJsTK0OHXwkjIQc1H69opBqAWxcchcCJbHZYMvd1MBB2E8BEeEpY2EkcJLXvwO2
         RqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493313; x=1688085313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1blZp32leas5kXJi+UOuXoD7JhXTUgNgwlQOmeJG49g=;
        b=DinIcrT482NaukIpYBoXqWeAhraiRJ+/OuNtgrxK0fRcEz/NkRDiT1cwSmvRAUxh6F
         1yC2q2oTotFYPPhJTHm4l5dmPYWKf0nTJv4ln+rbISUDlCn1eZRU9hkQPLsJs0bBpzwy
         FDDlfvxUbCoxjEgt8zSMoUkJ+FDVrt3y8+b+rBiBz4U/1UdEFRhhR4AYBZ2hXdpBI/0K
         7F7v0GnEc77whxxavczWmCpHr7cR/4HhEWsl/T7RY081zfxgdMgBvIqVg5E8SaO9kdi8
         YgmcuPHch5Fim/ZUJfHrvoH54WepNKmZg0W5x8GFgPBVNhRuMMqZci890T3M66H/CzCX
         xGUQ==
X-Gm-Message-State: AC+VfDzSkux20C7UZg4+tG0fMLYK+MhxmCz+UHfrutinMvLhS/MFx0PQ
        il7smNVxdTwd9+D3xIa4Tz48Nw==
X-Google-Smtp-Source: ACHHUZ79OKOSjGHEuXhd8pNAYIHZa+TuLxe8NVpXtmMouX3oLugOyJJlZaxkFdl36qCgczq4EwStFA==
X-Received: by 2002:a05:6a21:339a:b0:10c:9e35:857a with SMTP id yy26-20020a056a21339a00b0010c9e35857amr4322582pzb.49.1685493313118;
        Tue, 30 May 2023 17:35:13 -0700 (PDT)
Received: from [172.17.0.2] (c-67-170-131-147.hsd1.wa.comcast.net. [67.170.131.147])
        by smtp.gmail.com with ESMTPSA id j12-20020a62b60c000000b0064cb0845c77sm2151340pff.122.2023.05.30.17.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:35:12 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Wed, 31 May 2023 00:35:08 +0000
Subject: [PATCH RFC net-next v3 4/8] vsock: make vsock bind reusable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v3-4-c2414413ef6a@bytedance.com>
References: <20230413-b4-vsock-dgram-v3-0-c2414413ef6a@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v3-0-c2414413ef6a@bytedance.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
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
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
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

This commit makes the bind table management functions in vsock usable
for different bind tables. For use by datagrams in a future patch.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 net/vmw_vsock/af_vsock.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 578272a987be..ed02a5592e43 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -230,11 +230,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
 	sock_put(&vsk->sk);
 }
 
-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
+					    struct list_head *bind_table)
 {
 	struct vsock_sock *vsk;
 
-	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
+	list_for_each_entry(vsk, bind_table, bound_table) {
 		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
 			return sk_vsock(vsk);
 
@@ -247,6 +248,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
 	return NULL;
 }
 
+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
+{
+	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
+}
+
 static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
 						  struct sockaddr_vm *dst)
 {
@@ -643,12 +649,17 @@ static void vsock_pending_work(struct work_struct *work)
 
 /**** SOCKET OPERATIONS ****/
 
-static int __vsock_bind_connectible(struct vsock_sock *vsk,
-				    struct sockaddr_vm *addr)
+int vsock_bind_common(struct vsock_sock *vsk,
+		      struct sockaddr_vm *addr,
+		      struct list_head *bind_table,
+		      size_t table_size)
 {
 	static u32 port;
 	struct sockaddr_vm new_addr;
 
+	if (table_size < VSOCK_HASH_SIZE)
+		return -1;
+
 	if (!port)
 		port = get_random_u32_above(LAST_RESERVED_PORT);
 
@@ -664,7 +675,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 
 			new_addr.svm_port = port++;
 
-			if (!__vsock_find_bound_socket(&new_addr)) {
+			if (!vsock_find_bound_socket_common(&new_addr,
+							    &bind_table[VSOCK_HASH(addr)])) {
 				found = true;
 				break;
 			}
@@ -681,7 +693,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 			return -EACCES;
 		}
 
-		if (__vsock_find_bound_socket(&new_addr))
+		if (vsock_find_bound_socket_common(&new_addr,
+						   &bind_table[VSOCK_HASH(addr)]))
 			return -EADDRINUSE;
 	}
 
@@ -693,11 +706,30 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 	 * by AF_UNIX.
 	 */
 	__vsock_remove_bound(vsk);
-	__vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
+	__vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)], vsk);
 
 	return 0;
 }
 
+static int __vsock_bind_connectible(struct vsock_sock *vsk,
+				    struct sockaddr_vm *addr)
+{
+	return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);
+}
+
+int vsock_bind_stream(struct vsock_sock *vsk,
+		      struct sockaddr_vm *addr)
+{
+	int retval;
+
+	spin_lock_bh(&vsock_table_lock);
+	retval = __vsock_bind_connectible(vsk, addr);
+	spin_unlock_bh(&vsock_table_lock);
+
+	return retval;
+}
+EXPORT_SYMBOL(vsock_bind_stream);
+
 static int __vsock_bind_dgram(struct vsock_sock *vsk,
 			      struct sockaddr_vm *addr)
 {

-- 
2.30.2

