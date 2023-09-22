Return-Path: <linux-hyperv+bounces-163-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC37AB759
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 19:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 515CD2824EB
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB34043681;
	Fri, 22 Sep 2023 17:29:17 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4F43695
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 17:29:12 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F91A2
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:29:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso2212603b3a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403747; x=1696008547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr7VMeXLJH8XwB+zD35GqBQrsMI4YcQcUPdvZ9TWxzo=;
        b=ETuYqYjpeAxjrAEL1zRFWt/PP3eZI9SgqafdsGPe0j/d0XtACtcZDgyPnDXrcT9zpg
         SRLDJsQMgIu0JAf9ZzHaEFFQcg3D365AXbC8M+qMbbwRlzYFNz7JaxM09Eqa6sXf848/
         PKgIcPnFEOyPaZzEsqh5JXlQ5MB3W96RKtJm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403747; x=1696008547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cr7VMeXLJH8XwB+zD35GqBQrsMI4YcQcUPdvZ9TWxzo=;
        b=bFBtF2/xzfqnWHM5DdPRmug8foOtkeNQ7LWNxzKoDb0Wp6Ah55o0gqXO0gcNtSCV1a
         fRcCi7kSHzd8Jla3KPmUnGHE4hggECraF9mWBoF4VeRkLCTEVQxjGG0e+pmjnZubxD8X
         iglHVF3vBYDt8zXFH5mOqi4WXVtl7N2EmiqiFkoSyqZt+D1EwOLqDR6Ftdkrdfr+LTUP
         7s9xte84c8OXqbwH9bkEnmzweZ2jgjjqZnGfoSNrUdnDCRBnK5vfi0cJVy74QIn8KRFI
         9QinhdKdaFtQ2Dn2LFcuhaRo1TeDT96Ne9+9JNk6gZF8kZv9JAlHitciBkXv4JFhek+8
         k1+Q==
X-Gm-Message-State: AOJu0Yz9xt/a+1AHAYF0RVFgbOg5kl2xFnTBhCQwcTckvHeMfCF42kqY
	8giiy78EcWEgkn5TWxeU2SwljA==
X-Google-Smtp-Source: AGHT+IE0d9nBIyFO0yR0ORoUWZ7+c+aEOlGAafPRRZOxGS/XkTVczyefdXfk1dF4abqqKQnNPwhUbA==
X-Received: by 2002:a05:6a20:1049:b0:155:1a5a:9e31 with SMTP id gt9-20020a056a20104900b001551a5a9e31mr230381pzc.16.1695403747014;
        Fri, 22 Sep 2023 10:29:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020aa78d05000000b0068fe7e07190sm3461673pfe.3.2023.09.22.10.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:29:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
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
	dev@openvswitch.org,
	linux-parisc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 09/14] net: mana: Annotate struct hwc_dma_buf with __counted_by
Date: Fri, 22 Sep 2023 10:28:51 -0700
Message-Id: <20230922172858.3822653-9-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
References: <20230922172449.work.906-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=keescook@chromium.org;
 h=from:subject; bh=jNN2Wh5TqbkzFZoQFHMYTzfDn0UF7zrm9adldOZuxp8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc7XoLVZdYuePM97S+7MA9i5iH3sxyTfQSS08
 LJB65B+ZZSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3O1wAKCRCJcvTf3G3A
 JrxWEACNSgzg8Ycl9Qe1Mp2gIHHXFmJMIrT0z4cUhu6hZZXHD244HpZ8X+SYVMS9HS5syB/r5ZI
 2kNn5pZePHECZBA8CM4/TjgpQPlFRdgxHFFqBbfsYgAQnBkEMCTkFfCaKwzzmXVjLJfnpfOortM
 FaMeXJbItFRrX0Jwcv9cj9UC0k0zGIxwDvhCTpWO0IfrCOoDrV1VzDNtTUJ+XVL78kI1f2l75Ay
 34ksMU9kJrH5ASYCmmlwAZNT7ObZi26q0SKJgrSLWhqtq9swbQKnxy3Ask714ZdqhUI+l79qL6z
 eVDkoz7xmTG/GwFi1Gm0f3aQ4nmQiaJS/EKoN/Moy4R9Pj4PcoP9A6a9JAnbXFsCyfcURk+Xeiu
 7d8SiKimBQYQu1t6iC0rdtnDx9AUg+PH6cO3/7ARrrFcYoi21yLy5erMFvLZ/GdTEGrwiQFoiQ+
 gGAv4IONo4YXXQlC/z8es5uxwPk+UXJ+bvwe+PL8WnXGdKs8QMRXslYTUSIaEP+9YNvPuIawQRM
 erGitteR+N7KlsLaWaaq/z9LavLhnOua7sOCJQ7cDMa/pNWZDzckInyzoUg8Skf4gmjH2fNF9O7
 3+n1k69unddP2rtknBF6q49u18qdd9qXinwaYwqeXq9tyopeLUrF/KsAn9ZP752xrkkWBf6pYiW ZuZJGJuFzQpQdlQ==
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

As found with Coccinelle[1], add __counted_by for struct hwc_dma_buf.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Long Li <longli@microsoft.com>
Cc: Ajay Sharma <sharmaajay@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/mana/hw_channel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mana/hw_channel.h b/include/net/mana/hw_channel.h
index 3d3b5c881bc1..158b125692c2 100644
--- a/include/net/mana/hw_channel.h
+++ b/include/net/mana/hw_channel.h
@@ -121,7 +121,7 @@ struct hwc_dma_buf {
 	u32 gpa_mkey;
 
 	u32 num_reqs;
-	struct hwc_work_request reqs[];
+	struct hwc_work_request reqs[] __counted_by(num_reqs);
 };
 
 typedef void hwc_rx_event_handler_t(void *ctx, u32 gdma_rxq_id,
-- 
2.34.1


