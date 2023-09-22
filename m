Return-Path: <linux-hyperv+bounces-162-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D865C7AB757
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 19:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 17771282497
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D3243698;
	Fri, 22 Sep 2023 17:29:17 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967843681
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 17:29:11 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4071AB
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:29:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c576d35feso2221902b3a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403745; x=1696008545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZheShKBMXsJafSBhUem9NUmco8TlRbxuPgRJhrYLuF4=;
        b=mu+50WzRPb9bbl0T3bxpkUbT0QWHF28QLLRdjKAqoxTUvyL8dLakRT9mSMy8lklS0G
         SZCcmYbRKmIRKqXI/PoNdd33PDM4nBOXc2Uk66KQpQPVK/WcrYEb0rtxrEERka1HXJ9I
         xABIWUdNXMizKp5cTzCu6E7/2r1DaXyKNacTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403745; x=1696008545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZheShKBMXsJafSBhUem9NUmco8TlRbxuPgRJhrYLuF4=;
        b=JDiAc/PKNoRxdWUPHH2JJurVTaHKENEAU4XgHeFIXDWC3JIg9ZcmJXHEjdiNBlYfMn
         7C2Ol3HLF37vgWFWBGkz5IutSmxxFlPEottyQzeSkcL/cwGcIJl0c7/EDtJ8EB1NaEfN
         c44XYcjl8nDsgUYEVQ10jGWyHNiuUqTFC84GIvQZbMOQlBXf3yvf0IPLgHiyGvu2vyWd
         aHls6YAczTUuPbErVljpqKQV+phYE3GtDdblxgIyTT6u3g17Gc5NsYi2RTLFAs1knpIf
         IyvMCS6m2X6sqNmJpogc+7DzRLzfr2RFUBmHkzwNjg8wDGyEFUhhEgTQYG4kaMDrJJXE
         SHpw==
X-Gm-Message-State: AOJu0YxiKS5tbFg+VotVJizN6shXqKB7Z1VJUZ2OMUbrPh/0vxWFJOfm
	71I5ZaAL12CAXfz/6wmuVvR6Mg==
X-Google-Smtp-Source: AGHT+IHBD+XOqFGuVt7zhAgqg1fo+3BmPSo/pC8XNv6BsKuDlMg0uaN9Oe1iY9oPKLd/9z1fhn6ftQ==
X-Received: by 2002:a05:6a20:3cac:b0:158:17e6:7a6 with SMTP id b44-20020a056a203cac00b0015817e607a6mr221373pzj.42.1695403745651;
        Fri, 22 Sep 2023 10:29:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b6-20020aa78706000000b0068e12e6954csm3458358pfo.36.2023.09.22.10.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Alex Elder <elder@kernel.org>,
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
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
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
Subject: [PATCH 08/14] net: ipa: Annotate struct ipa_power with __counted_by
Date: Fri, 22 Sep 2023 10:28:50 -0700
Message-Id: <20230922172858.3822653-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=keescook@chromium.org;
 h=from:subject; bh=ZVNa42RINhV0v/Ht3T7iUT3nE/j+aJWcJU1ourfEiHs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7Xrsd3u3GIIaa0RoAqhrB+eBWXpaTGMEQ/u
 44xb3Uo6V+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1wAKCRCJcvTf3G3A
 Ju/8D/sG14Nl2om0NTcT3T/FMCMrw5caewzWYYZZA5qGbOQyUerx5rGQueGAkyPPzVCA3z1X5Ei
 RAGkC4MQg8U6DuG+B6Y1GivTSRwcfrgH0NCU6rCO6TCwfwx3GMsNvAVp1J0YiNbBKcGq0C1Pwn3
 tOg+us9yQCjqWWxhOxxt+uFv25NxnxjZjDDqxtYh6SYPQRwSw49hCykEDOott+K24NhX8NPAYaz
 jcD8tBJDS2QTRtd56RnyfIIeDq7ekRHm7ECmBw7eXdLbD1D1jzGncRJuupIgENxJO55A1F/abO2
 rp7ZAzuNHsSIezVTtETCcKaGUBAx7qAE2T5yIZT+yed0mwppMzZm79vOzVq9N6hVgyw3lKWllRx
 42WAgbPQ4Etr9HIBG3IkmYAyAvxu6db3KV9eDsWJ+49A2sbLor6jbJmppVskRGaBKsq1jm54hAK
 DtyjOKF2noGlhzLtQU3xpPVLiyizpXlHiGphYq+WC+nuXS7ILP2asn0W0c2Ip9uX1sml99XYNbj
 L9MR+41qLcYAX5yN6Jd+WAlhJO2SVaZHdWsr5FDN80BNIQO3kRKYVc4rzv4J4ZiBpukNZ7gqU2H
 tmh0agc3IN/G2PWAx2O6+YIDCIdoGDabLbVvGpLrI2tAQfg5cIYqgJoQMkstH5cn9Zy8t+JEv2d c8jebhrkUEu4ufQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ipa_power.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alex Elder <elder@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ipa/ipa_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 0eaa7a7f3343..e223886123ce 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -67,7 +67,7 @@ struct ipa_power {
 	spinlock_t spinlock;	/* used with STOPPED/STARTED power flags */
 	DECLARE_BITMAP(flags, IPA_POWER_FLAG_COUNT);
 	u32 interconnect_count;
-	struct icc_bulk_data interconnect[];
+	struct icc_bulk_data interconnect[] __counted_by(interconnect_count);
 };
 
 /* Initialize interconnects required for IPA operation */
-- 
2.34.1


