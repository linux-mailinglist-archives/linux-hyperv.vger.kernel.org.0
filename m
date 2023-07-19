Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45176758A30
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jul 2023 02:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjGSAuP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jul 2023 20:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGSAuO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jul 2023 20:50:14 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EEA139
        for <linux-hyperv@vger.kernel.org>; Tue, 18 Jul 2023 17:50:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-768197bad1cso350603385a.1
        for <linux-hyperv@vger.kernel.org>; Tue, 18 Jul 2023 17:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727811; x=1692319811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRgj32iUYcRPQa7+gTgJIjnpPYuGFjIY/Kz/A8nTowk=;
        b=IXZ5R7IWCdcvitOGSq8k/EIMLrqwPMUB9D/Zi9EE+9sSo9Ibqe7l8BTzzztEfZzLWg
         B2G5CHGlUkVio9Re3XZr0aX1lfiEfU0+n5TSJiykLg5DMsjUemmLr97vWvbzPEH6VBPf
         wc6K6mPxmMC4VBezVPhsbsTL8crTwuA9GenLAUs2GbzMEAAnTjBwClQX40kOCEfno/vD
         rcs9gwkb9hLLHvZt5yWNJZejItpccGsrQ1MfVasQA+l2WX9ZDxvzqyQ5U2gycVRfZwT+
         kyaQKcjHLuSQxTbn52xpRG8wpj3PWrLi+kBY7lEhlwtPa+rBSATIlhwiR2U+jI7y9txa
         7ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727811; x=1692319811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRgj32iUYcRPQa7+gTgJIjnpPYuGFjIY/Kz/A8nTowk=;
        b=SE6w5fJbTfX2zbY96vBZSb/Cxsrf8U9+5biq1VdXmYUd+OZ8ZI8Nvz22fvYNC+deoA
         tKv82y8NPGq4Ka5gezgYfeRqphzRX2jqpyQiCbVjUiSVN5n9atP1q6UaIPVCvK51aWNE
         YFMlaeBt2/f8yVVKQydS0iYwkENfukR+BIhEh1Y0WgnTJ4pX7trShvn5TtP/4PSsCbOo
         I7YY8DsYiasC6+5szQ3jdIMFBFn8LuSRyAhLA9ZvadSvY/irHPW/jeJvi2kK6DiRp14Q
         6LAxg/b0rjCAqOB6qI2cPbWm2NN0hVNYwOtu7hFFMq5Po6S8ize/imdec2BLfbzTgVNV
         SUkQ==
X-Gm-Message-State: ABy/qLbTbF36Ot4dWIkjS8dpHY6kVVVC5JatiEB9x9BQNvDGwGnXrLrk
        3aZVkyQIv+nhJX1ANJ4V4hzJNg==
X-Google-Smtp-Source: APBJJlEvlJmvRIDDpwkEKw4v7KpoikRir4zJOvvCYnu6BF16D2MR0pWE+MFE6NgcilOwhqBSSBZ3nA==
X-Received: by 2002:a05:622a:1788:b0:403:fe96:7af2 with SMTP id s8-20020a05622a178800b00403fe967af2mr2544945qtk.41.1689727811113;
        Tue, 18 Jul 2023 17:50:11 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:10 -0700 (PDT)
From:   Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Wed, 19 Jul 2023 00:50:06 +0000
Subject: [PATCH RFC net-next v5 02/14] af_vsock: refactor transport lookup
 code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-2-581bd37fdb26@bytedance.com>
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

Introduce new reusable function vsock_connectible_lookup_transport()
that performs the transport lookup logic.

No functional change intended.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 net/vmw_vsock/af_vsock.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ad71e084bf2f..ae5ac5531d96 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -423,6 +423,22 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
 	vsk->transport = NULL;
 }
 
+static const struct vsock_transport *
+vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
+{
+	const struct vsock_transport *transport;
+
+	if (vsock_use_local_transport(cid))
+		transport = transport_local;
+	else if (cid <= VMADDR_CID_HOST || !transport_h2g ||
+		 (flags & VMADDR_FLAG_TO_HOST))
+		transport = transport_g2h;
+	else
+		transport = transport_h2g;
+
+	return transport;
+}
+
 /* Assign a transport to a socket and call the .init transport callback.
  *
  * Note: for connection oriented socket this must be called when vsk->remote_addr
@@ -463,13 +479,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		break;
 	case SOCK_STREAM:
 	case SOCK_SEQPACKET:
-		if (vsock_use_local_transport(remote_cid))
-			new_transport = transport_local;
-		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
-			 (remote_flags & VMADDR_FLAG_TO_HOST))
-			new_transport = transport_g2h;
-		else
-			new_transport = transport_h2g;
+		new_transport = vsock_connectible_lookup_transport(remote_cid,
+								   remote_flags);
 		break;
 	default:
 		return -ESOCKTNOSUPPORT;

-- 
2.30.2

