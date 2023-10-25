Return-Path: <linux-hyperv+bounces-583-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF647D78C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 01:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA861C20ECE
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 23:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB057381C2;
	Wed, 25 Oct 2023 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvTPg8qL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207F37CAC
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 23:40:37 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385E4189
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 16:40:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ae5b12227fso2911767b3.0
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698277235; x=1698882035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNMGb9FVii3IGjmd6icxEZoz/qRHnqOvKwptGS/KQfw=;
        b=YvTPg8qLj2PMxvR4OQNkkFdiBq0OM+3Yy7ycaAXjudp5OSwAfhdnWdbPRg6O+lAHwB
         BLCayyImCoL4xrmMqiCkuYqLNB/bTnFdr0q8xyfVHvOrGnVnZ9v+y9fW/d2oKK0T3+ep
         9byl8cd/YDvxM46neGsGlf+kynYKdHegkrAz1aY1EG1iJE3N4d6rSxH9eOHTcFy5F5D4
         1AXyUPBL75eb5xfU0JkKvcvICakkqPF3BL1Bmee5Vv3cvf83BbkrKoL2aPmUrnqWKIbw
         vr12FtWTWadJ5uNqPmECReHcI3/v98mnR3oPRsFTWIwsbvDkvNp0fUFhaeQ4CteYYMFy
         sm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698277235; x=1698882035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNMGb9FVii3IGjmd6icxEZoz/qRHnqOvKwptGS/KQfw=;
        b=Z0Y1lmS+08HYpqHjUqTlpQPR6ycDmPRYvJS+161tFcvvsPyxoYlp/sKr+yn0rxbz1T
         9HstE/NKE1X8UYriD2g4BOH1dIziXUuBhERHEF8EgrhF2s7mFYQbiUOL2GCQ9+vraDSJ
         6qtjZR4fICogt+mL89YvZR2sDEHu6WUd/+3Pu+4CiSu+z1Fc26WTN6mQACOB5gV673/j
         ZQ5MaL0gdhkPxM5alruGe8A0SaMkWEvtOXD7VtSTQYHso7j3/DCiiNkziiFGFGBTQet8
         IYLg3kpOuMpHljZJ1YJYCl50Y8dJnGp4sIPBoUlahhXZX7b74/ziEvcQDPtBa+GQRWKV
         yWQA==
X-Gm-Message-State: AOJu0Yw5zTYUvJHK4F3N3Ldbsd3qs3s2Ep+ozFyzUwjJklvl6dqpyHGQ
	w2QkTWOERmlxb6T8gFSTx49IArJKstoKhQQRJw==
X-Google-Smtp-Source: AGHT+IFJIK76hUmK9IMs6QqAzA9uOFIFG/qocsEdNxKZvGSrcgX5hg8Q1Z7MU31OebIcNGSSzaWsrnXdem0jyNbySA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:a08c:0:b0:57a:e0b:f63 with SMTP id
 x134-20020a81a08c000000b0057a0e0b0f63mr380188ywg.7.1698277235043; Wed, 25 Oct
 2023 16:40:35 -0700 (PDT)
Date: Wed, 25 Oct 2023 23:40:32 +0000
In-Reply-To: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698277232; l=1734;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Q2b3CrzFCZg2hyLmS5X7LihvuuU/XPSccLiVK8DkHC8=; b=RTzd6uTUtmb8/kblStBypVrgGEsj0nKal14coZdooyBDEQzz7JbHzkUsxY+9+36UkzwkB1uJD
 FhNgS/gDVBpB4j8vHHp5tVTFvTU+oud2hDTmH8UYyz0X9J+PtSrHqTO
X-Mailer: b4 0.12.3
Message-ID: <20231025-ethtool_puts_impl-v1-1-6a53a93d3b72@google.com>
Subject: [PATCH 1/3] ethtool: Implement ethtool_puts()
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org, 
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Use strscpy() to implement ethtool_puts().

Functionally the same as ethtool_sprintf() when it's used with two
arguments or with just "%s" format specifier.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 include/linux/ethtool.h | 13 +++++++++++++
 net/ethtool/ioctl.c     |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..fdd65050bf1b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1052,4 +1052,17 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
  * next string.
  */
 extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
+
+/**
+ * ethtool_puts - Write string to ethtool string data
+ * @data: Pointer to start of string to update
+ * @str: String to write
+ *
+ * Write string to data. Update data to point at start of next
+ * string.
+ *
+ * Prefer this function to ethtool_sprintf() when given only
+ * two arguments or if @fmt is just "%s".
+ */
+extern void ethtool_puts(u8 **data, const char *str);
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..abdf05edf804 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1991,6 +1991,13 @@ __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...)
 }
 EXPORT_SYMBOL(ethtool_sprintf);
 
+void ethtool_puts(u8 **data, const char *str)
+{
+	strscpy(*data, str, ETH_GSTRING_LEN);
+	*data += ETH_GSTRING_LEN;
+}
+EXPORT_SYMBOL(ethtool_puts);
+
 static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_value id;

-- 
2.42.0.758.gaed0368e0e-goog


