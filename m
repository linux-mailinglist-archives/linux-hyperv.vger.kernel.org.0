Return-Path: <linux-hyperv+bounces-19-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863767985D4
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Sep 2023 12:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131962819B2
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Sep 2023 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3C442C;
	Fri,  8 Sep 2023 10:27:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2842210F
	for <linux-hyperv@vger.kernel.org>; Fri,  8 Sep 2023 10:27:34 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517B31BFF
	for <linux-hyperv@vger.kernel.org>; Fri,  8 Sep 2023 03:27:04 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bf6b37859eso7152511fa.0
        for <linux-hyperv@vger.kernel.org>; Fri, 08 Sep 2023 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1694168774; x=1694773574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GzirF41rnUqKpCrHpf0iIc8MJPJsNa+V/TRO9JKyJ8w=;
        b=jvjXqpM7+1aqsRGtMdThWHuTMTyU3BLTxLVASo6Z0ZyDIqzWpamao4ee65bRkngrNH
         iN+8PT2m0btikOqsGnE9/iwLrEPxfwcc/WNuS4ScJJWlMPXSl5EA3y+ef+jMo7PuIKnr
         Q4slLWWztE1dLODASduVuC81Yosigh0rzeVQYFjRjG2rckuNwmKU8v+UuzutlAPIZNrD
         90cIEnWLEwIC9wK0DFW/ldGdJ8t67W83ZvbKywNeAAAJvrLnaEJmb2kZp7dGxxL0nveZ
         egV46pKq1Vshf9DC4+U7h9iNOP1SDkpsuwJa2GbgCRG+/+SAhE4gzcGMwmYdlzcGMrJ6
         TkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694168774; x=1694773574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzirF41rnUqKpCrHpf0iIc8MJPJsNa+V/TRO9JKyJ8w=;
        b=ey5KoROi9JiStuX1bdyiuvhALpEiFU+I/JmIkeakvTe8s+TdoFUuek+uTJ9uL/wNhN
         Ez0yceIWBAs0848X6pgEZu8XVBcD4C+iFvtq1opd2QkMLdr45WWkQEw8oFp9/uRONoLK
         kUlhjveL8LBMfuzHnnTAhxgo4M4H77MEJMe2kIg/bBbNM/BUC8Ou43gxF0oMYRDPRPWu
         3zOdTQ27Cdwm3VEZEX/DqYZJSzDF1QkO+1EXVxHtj+wPpqaYnpJtr63zHB9owvjZ9D7d
         sZ5n3Ny+ZV+aUsuIUBD+Q5xFdes4mABYE+W5S8xD1R0wACbYPYDh6R+4xDqOlVdOYvXh
         PGPw==
X-Gm-Message-State: AOJu0Yz2kZEiYmWMTA3cqn1Cy+Q22XTjRy7I7qwV5vFT+gKNn1B+Cg+n
	3kElsNAT+eInduuX5rhSQ9JMxND8SZ3zys3Q/PI=
X-Google-Smtp-Source: AGHT+IEcb6V0yih75oVWWeDE9YCVheVESKk0yVeRdT2afa8x9RlbRO0O7uqXrN4UesergTgOWUMvRw==
X-Received: by 2002:a2e:9ace:0:b0:2bd:ddf:8aa6 with SMTP id p14-20020a2e9ace000000b002bd0ddf8aa6mr1383716ljj.23.1694168773889;
        Fri, 08 Sep 2023 03:26:13 -0700 (PDT)
Received: from bell.fritz.box (p200300f6af456100ee66353b07eac200.dip0.t-ipconnect.de. [2003:f6:af45:6100:ee66:353b:7ea:c200])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709064c8800b0098963eb0c3dsm844056eju.26.2023.09.08.03.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 03:26:13 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: linux-hyperv@vger.kernel.org
Cc: Mathias Krause <minipli@grsecurity.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	stable@kernel.org
Subject: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under Hyper-V
Date: Fri,  8 Sep 2023 12:26:10 +0200
Message-Id: <20230908102610.1039767-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
non-Hyper-V hypervisor leads to serve memory corruption as
hv_vtl_early_init() will run even though hv_vtl_init_platform() did not.
This skips no-oping the 'realmode_reserve' and 'realmode_init' platform
hooks, making init_real_mode() -> setup_real_mode() try to copy
'real_mode_blob' over 'real_mode_header' which we set to the stub
'hv_vtl_real_mode_header'. However, as 'real_mode_blob' isn't just a
'struct real_mode_header' -- it's the complete code! -- copying it over
'hv_vtl_real_mode_header' will corrupt quite some memory following it.

The real cause for this erroneous behaviour is that hv_vtl_early_init()
blindly assumes the kernel is running on Hyper-V, which it may not.

Fix this by making sure the code only replaces the real mode header with
the stub one iff the kernel is running under Hyper-V.

Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: stable@kernel.org
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 arch/x86/hyperv/hv_vtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 57df7821d66c..54c06f4b8b4c 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -12,6 +12,7 @@
 #include <asm/desc.h>
 #include <asm/i8259.h>
 #include <asm/mshyperv.h>
+#include <asm/hypervisor.h>
 #include <asm/realmode.h>
 
 extern struct boot_params boot_params;
@@ -214,6 +215,9 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
 
 static int __init hv_vtl_early_init(void)
 {
+	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
+		return 0;
+
 	/*
 	 * `boot_cpu_has` returns the runtime feature support,
 	 * and here is the earliest it can be used.
-- 
2.30.2


