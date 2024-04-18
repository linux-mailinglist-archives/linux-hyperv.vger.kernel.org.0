Return-Path: <linux-hyperv+bounces-1992-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B7C8A9923
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 13:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237C9B22B4E
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8BF15F322;
	Thu, 18 Apr 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Be855yZU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49415EFBB
	for <linux-hyperv@vger.kernel.org>; Thu, 18 Apr 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441396; cv=none; b=krzMK5ren5lV6k/NAtYyhRR06wF//HtU106VJTtYfTZctJemxfp9vf+qGyvKhmDwbtgjT4Z2AtrEdlrSFuby3itkHk8rNEH/ySVOKsOBzxd+ryDUi0IY3Zcz0Vgng313l1S2rx2xON/kdWtfyZmHVjhshS3AxzZWOQ2NjdFvEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441396; c=relaxed/simple;
	bh=3yHTimohmBYHD9xPmoEFceULvLGWUXVYoRvacg8EH5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3++sQgBd53lyMn75m76prLJhWvILBbplRu7VyG16HASUCNt+70WfIesPX9NkwnmfWXQpB8v/FJBd10V68sdXPJFDbSOApJ30fnTisxlh+g6qEIGdghssU6ri+bBZpXRQNpOFAgxUx5uB0gYBbjEWuq20k0PnaySAmzdPG6DZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Be855yZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713441394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zpn/+s8/qKx2VMhweSXvGNcJ/PhsEX+1bPMtRIf6i6c=;
	b=Be855yZU7uyMMWG+mYxRECSrui6h1Z6Ne/roiqZf4JSMkWz0P9nhNamfgUuu3CfDElV+qK
	JUsamnPlNDbsQWLlYYFpGkENrn5/cGAb6dZYXb1pWwSuAeJDxAvC6U52FD6fqPGGb/dpdS
	h90m7+eeMpIwFf76QnW8Tzy022yeGdE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-D8X-EzxSOIuTfVdGbPzm4g-1; Thu, 18 Apr 2024 07:56:32 -0400
X-MC-Unique: D8X-EzxSOIuTfVdGbPzm4g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a4a2cace80so935575a91.3
        for <linux-hyperv@vger.kernel.org>; Thu, 18 Apr 2024 04:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441390; x=1714046190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpn/+s8/qKx2VMhweSXvGNcJ/PhsEX+1bPMtRIf6i6c=;
        b=CQIyB8AX+lsACizIun3+ds0oRfPx9gXMffn0dixGS7vdUDJOo+YPZpJMQ788eGyvEo
         on1yIEeuMze5oSDmjLoRSCSEC7Y+JwlmR77r1n+EI+E2uYaKbToEQnr+zWc7q7cF/NJo
         S6y93UVBmh78roPddZjnWVYfB4NcSVoj/8Z11BhtoPIL/fwByNfjujRhL/PNl2PGKdqU
         rUFSF8wtvQU/9UZDVfIvvaNF2SDxlmmJVjsYhqDo+cwWhsfkCGRwjqn/YETWu9ZCEApJ
         DD8HgLQaEZzv2epo9iWX+o4RRxSJTfnRti4NfeB5FchrYurFXix33D6tCFA2iUKB5Ryk
         TzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/V5lN2MhXhIkI9eSn/S0DS8leDDsqAae0Tk92vONaRPo6YoQTF3nAaMwsFmkdELcBw2hL7PoTJkB8V16Ui7Vp0t5bAN7pZkdwkjKE
X-Gm-Message-State: AOJu0YzVvDG/n5simRfYqW47Le63xNj7EuDI3ixfd7x0rPZIkxwlRSft
	WomeYGy1uZkaTcHswk/PN8evOtMg/yIdo7d/YW3SEspT7NAz8nVQ8eiu2w03UZg1BJkfRBJcRdb
	oVoHXtj5/MtkYaiZWw5HHRyIxKxy59JdC4JlRsZ67n8P54g0bOCCkE3yfQGq0BA==
X-Received: by 2002:a17:902:d48d:b0:1e3:e246:2cd1 with SMTP id c13-20020a170902d48d00b001e3e2462cd1mr2911931plg.62.1713441390361;
        Thu, 18 Apr 2024 04:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/yLCW+FuBgIVPDlCIsrQILrWY/8CCRWVBXPYZrovMCGdlh/2eHFOnHA3UVI6oJznOCZVKdw==
X-Received: by 2002:a17:902:d48d:b0:1e3:e246:2cd1 with SMTP id c13-20020a170902d48d00b001e3e2462cd1mr2911911plg.62.1713441390043;
        Thu, 18 Apr 2024 04:56:30 -0700 (PDT)
Received: from localhost.localdomain ([116.73.134.11])
        by smtp.googlemail.com with ESMTPSA id o8-20020a170902d4c800b001e4458831afsm1342875plg.227.2024.04.18.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:56:29 -0700 (PDT)
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
Subject: [PATCH] Add a header in ifcfg and nm keyfiles describing the owner of the files
Date: Thu, 18 Apr 2024 17:26:15 +0530
Message-ID: <20240418115616.58682-1-anisinha@redhat.com>
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

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index ae57bf69ad4a..63e2080298d7 100644
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
+		fclose(ifcfg_file);
+		return HV_E_FAIL;
+	}
+	error = fprintf(nmfile, CFG_HEADER);
+	if (error < 0) {
+		fclose(nmfile);
+		return HV_E_FAIL;
+	}
+
 	/*
 	 * First write out the MAC address.
 	 */
-- 
2.42.0


