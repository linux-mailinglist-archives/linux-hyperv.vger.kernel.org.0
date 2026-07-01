Return-Path: <linux-hyperv+bounces-11722-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NVtvEUZJRWpa+AoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11722-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:07:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 186B26F028F
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:07:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=SSG7T1zW;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11722-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11722-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 696553034F20
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06F23890E5;
	Wed,  1 Jul 2026 17:05:41 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B23859D3
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 17:05:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925541; cv=none; b=pRqjBwkvZRds/qk6vUeE5HUX1/mgAfqe3v9QG6fKroyZGFl1UgRvItHDJCeMULfITy3nO9iyBbawoqScVH/fzk2JYBHniUFWLl2R/2VK5XsJrORCShLXHn/QFSnLnvMayFINQWkUlRKZ6nKHtepCzgRSIhaAAhO02OZhM0gkYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925541; c=relaxed/simple;
	bh=v/yH1n/HDX+2d9l00KBsbf8zLWh3O2lf6A71bneiqvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ch20j7+a3Fl73s4pz93Rx0BcbvlGB2sQQhW93kqAyXcIuZlA+h03cx77SoKgfEhEaZpKg0sp1EThNuTGrzRN9QmcNSkmRiFvbfOEhavro0FO6ANo8z4427grBjfBJdABMpsJU34QvZn0DYyDkAAmYHuKkrnVI2zpSLXVCQZOyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SSG7T1zW; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso872207f8f.0
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782925538; x=1783530338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFKScLlM0EIeDGkHczxDlJgqlt4gTY+6Wm9Zxks25pI=;
        b=SSG7T1zW0ZXsoVfe6cY5u1MkcOgUEi8LIx2Zu2pLgl33JOvOIEL/8xzdBH/BzSwOmL
         J2bdiEnv9PUv0pLCO3igh97XijymjbpgfBbdOvtslfPRZOtJ4ug3QtVpTzUL3/qFk6My
         IfJ+31I6IxdcJQhlAOT88pvqPOTrZk/zBL9K8rldCvYaLSKQXzKqPEZa2xyczBo85jvL
         9tCr3xcfXJ5CJ6qpvNdk3yjZYzxAJaJ1Bfu9uZbl8ptrO6nzf11S0AkZYPqLQLAct4yF
         8kcTIxQhCPL1kaCcCw0m4sRWb0/JRqUpv6Y/W5WKuWK+RE+fesyK6R240eEny5A/F7ev
         0AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925538; x=1783530338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MFKScLlM0EIeDGkHczxDlJgqlt4gTY+6Wm9Zxks25pI=;
        b=hmLETbPgYbPvStzNw+ggbTOdMMeopCG02LcJIdQpDiw0GHLVMMta4EsfX2t0tXd9yv
         mpbherB4n+akopvRTkcqByzSlMNcatP3Jd3H6UcW6H7yFf7T5pf2615Qp5woXTYkcmPh
         6JMEtNqGYIldsNKspN4IgGqf7P9V8SvVeqJpbPybLVf9h8J+0jgafEsZ1MvjwT2++aCP
         fz4zGfd4n3KmYRGsBsV7ZYJ3OoMmkgCzt/nayX2ztWPYD9H7HvIYSRANlx1R20fyiw1S
         QEeNPJkuzk/bfgD968y/ga/Wq2wxeKAj1X462lHXJOOMSBV7crL7OoRr6SiH8/No0ESm
         Nong==
X-Gm-Message-State: AOJu0YyvERzvHc269coz3X5hnX6acxQtYTPz20TwkALwRC+UmqpckwDz
	PJBL6WIpRT6rOUqUlocL6EY55v/VmTxF4HI3Fa54ws5Vt/IEIFEKIzh4+0GUdIKY/Es=
X-Gm-Gg: AfdE7cnjVLWP2SkIHug6dfoqueOtEzHZmjfdRow+Qs+EC1cQgpavOnYxW79TO4V66Nv
	lNL0XMEk6M+G9ErxIzztmWlsjcAvqaSxHRN9yN7ttxJXswUVid3MYB550PAlby1xMb9T7NJDgBx
	hLPaqtd3GHhEg1/VogHw09As6kbAMjNjGebtqWPH6qmzvDMZb99HDbKD998plB2qUWazfUbIJCN
	E8BWWnkq+YuJarlDlH/ivKB67HgjrVFgr9HEqndFmI6tcKsmRx9lcn/wDz0Ddeju3flBb3ExM/z
	ckfzTza9o326wmekrxlYscP3Kf4+JXVF68+m/ES8sgv2w0Z/Cxgg2bwHglS2lWOWG1fLtSRi3HP
	MYT7u0o/oRqr3wunqrGnR8SQCsC79wHW6TYvcPF14XOBPAbzRVDq1qbCKD4ZrANhbR1f6nAuCns
	8l3xUqHepWLQvv9vOQyH0VY8UAIIYVQM61RUn/NL0jrxaHToC53Vp8jL8M/8JI7zRAkz3TCR1rK
	2I4
X-Received: by 2002:a05:600c:8715:b0:493:bed7:6d7c with SMTP id 5b1f17b1804b1-493c2b8943dmr36997375e9.25.1782925538055;
        Wed, 01 Jul 2026 10:05:38 -0700 (PDT)
Received: from localhost (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de. [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-477de3dd0b1sm1205357f8f.35.2026.07.01.10.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:05:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Deepak Rawat <drawat.floss@gmail.com>
Cc: linux-hyperv@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] drm/hyperv: Unregister pci driver in error path before module unload
Date: Wed,  1 Jul 2026 19:05:19 +0200
Message-ID:  <4b7dbf00ce4ff664b7d5dd74b2f39d8d87c1ade9.1782925276.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=v/yH1n/HDX+2d9l00KBsbf8zLWh3O2lf6A71bneiqvY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqRUjRj7fAruikQOdl4/UoTdt8wwXniHBJuknaa WzXEG04KxKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakVI0QAKCRCPgPtYfRL+ Tjs0CACxUT4WY9YoaXx0ruBhzpUNkISAvGOj92mNYvd8ovA3nMPRJBz20DZW240WRsJi5UFVkJY ixPDFhGYCtKl77PofmtiJ8Z52HKWovLU2hQTaar416FasDwJZUs3NOpo2/qs8j9Au0IwGggs7Cd /NQgiyJQoD8V9mUF3g3y3YaMtXVlXnil5a1qSAtdJpBcd8V6GVyeo9UhBIkrsGe/blyoDTbqbGz 1bG8K3HgvHX9LUPVxwHWEnarO4HpcfU6FJLmS4CFKuu3+OHgprLd+ySp/oq0acVwM9x5RqCPI9r zX8Si5KWjXJPl4uUR3kjPuV1UDCN0cJNqjgLUnVaeqQFgOuY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:drawat.floss@gmail.com,m:linux-hyperv@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:drawatfloss@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11722-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 186B26F028F

The pci driver must not kept registered if the module is unloaded after
vmbus_driver_register() fails. So check the return value of
vmbus_driver_register() and unregister the pci driver on failure.

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 20f35c48c0b8..2e75fb793495 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -249,7 +249,11 @@ static int __init hv_drm_init(void)
 	if (ret != 0)
 		return ret;
 
-	return vmbus_driver_register(&hv_drm_hv_driver);
+	ret = vmbus_driver_register(&hv_drm_hv_driver);
+	if (ret)
+		pci_unregister_driver(&hv_drm_pci_driver);
+
+	return ret;
 }
 
 static void __exit hv_drm_exit(void)
-- 
2.55.0.11.g153666a7d9bb


