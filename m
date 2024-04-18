Return-Path: <linux-hyperv+bounces-1993-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B038A9979
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40F31F222DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487AD15FA7A;
	Thu, 18 Apr 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8dciqX0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1707B15F3E1
	for <linux-hyperv@vger.kernel.org>; Thu, 18 Apr 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441967; cv=none; b=TpFuJBGDICFm8WyDKUiRAWTABcNf8shX/uTZ5Gs3R+asSO9N8UBCh+Yl6j/MWLgyZlhhd1WzVraBnU1uK04hlKOACPeWg/5F2npWuHw30W2VJatMMctTWT7FHvWmACoDNXyivO3Nfc7lQF3cgCPX8qtSt1wg2yMjKGgwrfUX+gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441967; c=relaxed/simple;
	bh=wV1q09azHgzZ3Yre/HZZew17vHq85B77RfcsujVrHlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cwXCzq0P6QFdPB860uWXQD6qzdco8KXf78MHhcunUIWBfClYyKy4GQDaR+6TAI7E989mgNySdRk96A20hIZ2gma70szgdYlINjDOw9EzsLbamsWGHsA7hFfeEpVyn9tCLMZegmci5vW0UwhACNYdzIs5Z+SH4xRs3prbcOXHu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8dciqX0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713441964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oxCCv+GY90eEUwoIFbKmjfk3gXJKwVh094KBVsL50+w=;
	b=A8dciqX0vZobJ282dthU79nwTwue3KRE9CG6dRRasrn6TpRLh9Uy4Vs3CkPPVamU9WrPjz
	qE2LEjo+muM/cMO1gRVMiMPVaqBepyaycH/hdjlYG249ynnA8neyLDS/AUDy/nzujiAInc
	RSNGOi5tKzvQD54McPOHuAZgczjo5kI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Ti97iLwNOCm2OwzWyF_6yQ-1; Thu, 18 Apr 2024 08:06:00 -0400
X-MC-Unique: Ti97iLwNOCm2OwzWyF_6yQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a2fe3c35a1so964718a91.0
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Apr 2024 05:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441959; x=1714046759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxCCv+GY90eEUwoIFbKmjfk3gXJKwVh094KBVsL50+w=;
        b=Ss3/LiBh9F15iWUp9MeHqte39I4u84AZ700NG/oLrisRJ3/9JrZlmuiNpGrwhM0w7x
         lPbCg+MrjroVhTtmblV4EidQ+LZxw+6BzYiyfKUCgAlaJfaMgjAxxm08VXLoVw/GaDHF
         JtiBTx8jmflkpwilf9gt1LIYqjjapkI+J+WnLegRKdN0ogewR0ZylUwvFZ/A09M4D7uw
         RDzdLKp9et9jrRsSLBKfc9OUzUZ0jd8OglxBZH2sJ7MvC1iEPNTS5/TYm8aW4pfYUxlT
         HOM4GI51NcXYqxnII6Cx25+/xHSjLM70VuHAL+EajZmgZVcRnWGIks7KoWojfkqYitym
         Ohgg==
X-Forwarded-Encrypted: i=1; AJvYcCVqcP/ugLym3HfCWlsZpYDdfQtB+6H3q4CawMnzvcIrVzmFkqGVP4F/0GAedJMP85up5FO8M2SnJQ2o3VT3fuOHgY99kTV5+vXEfYl3
X-Gm-Message-State: AOJu0YwppFnSdYt0gbJZmuVdylyYKOJ14rSA0nhkSYhQnttTdCXdh3vM
	wbjyHKPCe3Dm0ZqMUDhMStR/9n9U14X4pyoMq58Q1X1SI2A8hlRGgrGM70rTZvfu9d1ym+zkBue
	WNtR7XNA0RPubzMYSXwrxUeBCZFnxCfGiyKUOdErWw1zQIf+BcjW6NPU8UZIHuA==
X-Received: by 2002:a17:90a:ea8c:b0:2a6:e5d0:d42b with SMTP id h12-20020a17090aea8c00b002a6e5d0d42bmr2356066pjz.2.1713441958966;
        Thu, 18 Apr 2024 05:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFabCbK8j7WqSqyOEIhDwAd5yXN/ORmENxfb2k0++RkIZ1ey0r4T8exz9+3edB3aS8OXfSnqQ==
X-Received: by 2002:a17:90a:ea8c:b0:2a6:e5d0:d42b with SMTP id h12-20020a17090aea8c00b002a6e5d0d42bmr2356036pjz.2.1713441958430;
        Thu, 18 Apr 2024 05:05:58 -0700 (PDT)
Received: from localhost.localdomain ([116.73.134.11])
        by smtp.googlemail.com with ESMTPSA id s4-20020a17090aa10400b002a54632931bsm3006491pjp.23.2024.04.18.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:05:58 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	shradhagupta@linux.microsoft.com,
	eahariha@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Add a header in ifcfg and nm keyfiles describing the owner of the files
Date: Thu, 18 Apr 2024 17:35:49 +0530
Message-ID: <20240418120549.59018-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment describing the source of writing the contents of the ifcfg and
network manager keyfiles (hyperv kvp daemon) is useful. It is valuable both
for debugging as well as for preventing users from modifying them.

CC: shradhagupta@linux.microsoft.com
CC: eahariha@linux.microsoft.com
CC: wei.liu@kernel.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tools/hv/hv_kvp_daemon.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

changelog:
v2: simplify and fix issues with error handling.

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index ae57bf69ad4a..014e45be6981 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -94,6 +94,8 @@ static char *lic_version = "Unknown version";
 static char full_domain_name[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
 static struct utsname uts_buf;
 
+#define CFG_HEADER "# Generated by hyperv key-value pair daemon. Please do not modify.\n"
+
 /*
  * The location of the interface configuration file.
  */
@@ -1435,6 +1437,18 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 		return HV_E_FAIL;
 	}
 
+	/* Write the config file headers */
+	error = fprintf(ifcfg_file, CFG_HEADER);
+	if (error < 0) {
+		error = HV_E_FAIL;
+		goto setval_error;
+	}
+	error = fprintf(nmfile, CFG_HEADER);
+	if (error < 0) {
+		error = HV_E_FAIL;
+		goto setval_error;
+	}
+
 	/*
 	 * First write out the MAC address.
 	 */
-- 
2.42.0


