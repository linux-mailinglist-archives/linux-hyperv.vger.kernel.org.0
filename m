Return-Path: <linux-hyperv+bounces-165-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AA47AB75A
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 36DE8282963
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 17:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95834368A;
	Fri, 22 Sep 2023 17:29:18 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9943A9B
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 17:29:14 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787D1B5
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:29:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso2274810b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403746; x=1696008546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsPm5p8OVWWQhvwQRnJAR5En1I13+6E+l5lagSHHfoE=;
        b=PlSIN8FmnOTcSZTQ//UJdOk4CJQWcDW9wR3D+7xBohFxAFQZziU3sDcxUmvfCLG5Jr
         VrBV+Xvm6mD89RlsQrWlk6cwYGPFjk1QK9o3W0kvaLHD0V6BCs8CcucKgqSAW3rlu1cv
         v9CitUGc5ZX7lcvprHSEzRHkd8YcDaye8qf00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403746; x=1696008546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsPm5p8OVWWQhvwQRnJAR5En1I13+6E+l5lagSHHfoE=;
        b=AtP7HkJmN4bIFtulM5vhGchugjP+armrmaeH+EQGhPC7GOfV+7sGuT6i3etL0cfeWu
         RAE1J1sIDLzBXS+24BfR7knuEh6R7RZAxomyB10Mxc+M3pjhqUKr1VFw2zUL9f+gvdEi
         aqfN4Qr5OGG3smMJXGEsUOnLibjwWpE6Ridi+eDX//7OhEqYL9ShhJghRTxunqgYU7Y0
         9yZ07myUx5ay0EgKAUZ9nhO0I8zHIo1cg0ycXjtYVvIDaTw9NbEmhx/4Z6lznO15OZLy
         5ucQuAMuNiVQhuagGaNvnUuaiBU+ajJMpxtGkQOc4fyLwS1kEj7r/rEGjPYAV9hCtgH3
         7Bnw==
X-Gm-Message-State: AOJu0Yxnj4FmcquhErFkP7p9D9MzJntw4yDyrabHQtH4EM90FaE0UU8n
	4WXo/e21jeKwCpMYk6OfI+uNZQ==
X-Google-Smtp-Source: AGHT+IFhNOh9g/WXdqswrmGr0TKvoPB0737xQYMJJhDHZ7Y+VorzevCDjiJpuL21VUW6bsODv6GaNA==
X-Received: by 2002:a17:90a:1197:b0:268:18e:9dfa with SMTP id e23-20020a17090a119700b00268018e9dfamr351769pja.5.1695403746060;
        Fri, 22 Sep 2023 10:29:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090abc4600b00276bde3b8cesm5199670pjv.15.2023.09.22.10.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Alex Elder <elder@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Shaokun Zhang <zhangshaokun@hisilicon.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	dev@openvswitch.org,
	linux-parisc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 05/14] net: enetc: Annotate struct enetc_int_vector with __counted_by
Date: Fri, 22 Sep 2023 10:28:47 -0700
Message-Id: <20230922172858.3822653-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=keescook@chromium.org;
 h=from:subject; bh=NFekoCD1Jndm5KHIwVT2SInoZJX6zogZTm9dOrowHzQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7W8CYHJBq+iZChIknbZLiTR3vO/ABrVlFx0
 5vu41SusMWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1gAKCRCJcvTf3G3A
 JmMYD/9COcX3uXskEKki372umoZXpS81TFgyqr1SaYIobu+5/nsnHubNj4XIFIxtkKLQ9x9iJNr
 IGdgXYn2Ne+XjjnR2+5XdpYSVYBhpwMps87h8MkXg3FgVtutsJSrhDEKlalntK4k8P9/tEqbe5V
 s6/2BskuqXGJHZntea0S9oGq10CGovJ5oyy4N1B2ipZQ14jv2qyZJ/lL/L7Q1aceJAE0WCEhhlO
 ewuaoB4Iaj1WVPn8GmFZWHflwlLoeFYnDxWVtW/H9p1oAJbaNHvU5uaKdOs4wZmZtVealaxZifp
 DQvaHczxdEA/tAnbrF6p4+WcJlKt3/9Icc0gj7E9oH5U6B+L15s9vqreUMO7oLmuL8aZvODffmt
 Ij1zFTVn4YdJS/plXhp20WXehVFBbKACLxaSMDoZzAKtEyPU6PXeaNxRbhcgJbShgddSkKTUYWP
 eokdZ178LoIMhSB2zIB02vsPNIewOqKwQ9sJb3K+8fgUVP1PNSUJtgPxYmcO/8Rgb69FwD+w/YW
 U4BvwhJZ4C/8DUXSM7dMugskhUaorg2i0VNx/i8UMKoL19+6vpEdmgzWJAmKG0fzPbZPtx0/pQh
 6PJff6pa1RRmV9QDJQuRueIM2N4jPj2I500uPYvFks3+UgRgZI5TlteIopHrUU9XbzdtZlI1afV Qrj7qVw0gAScGlA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct enetc_int_vector.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 7439739cd81a..a9c2ff22431c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -297,7 +297,7 @@ struct enetc_int_vector {
 	char name[ENETC_INT_NAME_MAX];
 
 	struct enetc_bdr rx_ring;
-	struct enetc_bdr tx_ring[];
+	struct enetc_bdr tx_ring[] __counted_by(count_tx_rings);
 } ____cacheline_aligned_in_smp;
 
 struct enetc_cls_rule {
-- 
2.34.1


