Return-Path: <linux-hyperv+bounces-5962-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2608EADFCEC
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 07:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA6B3B570B
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C75242D61;
	Thu, 19 Jun 2025 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TO4mwk4U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2124167E;
	Thu, 19 Jun 2025 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750310767; cv=none; b=fdtuY4YHK6mDRoRt/8l3VDfELqg8ZTf6MMSEtIQtYa6toSimst970mBpPwsMkwDDmNmesxTqgoc2EH0vlT4dG7UAGSlIHI6QZZMQsqwiF0qowjJtN+1P0ddlYIaBP+s1Op+uzkQsn12Gzd1AW703EZz+Mqlh+w1cOD5xOpRIcIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750310767; c=relaxed/simple;
	bh=enZMCHV6rYdmjk4yDDDjouDtx9GFZEOZXuVdGmaGa3g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dJ4w7KruhTKLGZ9GIfgH42+93CvVgxY2Zg9DBR3mQhLGseBefYNhz/UpodwjvxFl4AfX255Ir94gGTMEhac9zOghI2fH5G7U61PoF9mQAev6sLxcryfResz8dLwPYQFuDeHRjVuGO56/nroAGqCuGRWeU/K42Te1+OKUWOgAPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TO4mwk4U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id EBFEF211937B; Wed, 18 Jun 2025 22:26:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EBFEF211937B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750310762;
	bh=19k6UZE0i+w0d0VDsgObHi/4QLbX04CSELitWB6Ome4=;
	h=From:To:Cc:Subject:Date:From;
	b=TO4mwk4U5/LDamnjfp/HiGd0wgFmKJUhi4L+QZcXV+K3FsmW9MWAQQbCYZyF0OOKR
	 Nb+3jFwWoONYLA7DzDAs6ZMBO0vBpPSbigGp1anqxcj1VmqpGKzjmFmJsMJVjgD97B
	 dkrO9SqiMhqTXM77gVFwUq5ojt9ltTgBtDutdiBM=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH] hv/hv_kvp_daemon: Prevent similar logs in kvp_key_add_or_modify()
Date: Wed, 18 Jun 2025 22:26:01 -0700
Message-Id: <1750310761-13302-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

When hv_kvp_daemon is started in debug mode, in function
kvp_key_add_or_modify() too many similar logs are logged for
key/value being too long.

Restructured the logs to prevent this extra logging

Suggested-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 tools/hv/hv_kvp_daemon.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 1f64c680be13..91a708282358 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -352,21 +352,17 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 	int num_blocks;
 	int i;
 
-	if (debug)
-		syslog(LOG_DEBUG, "%s: got a KVP: pool=%d key=%s val=%s",
-		       __func__, pool, key, value);
-
 	if ((key_size > HV_KVP_EXCHANGE_MAX_KEY_SIZE) ||
 		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)) {
-		syslog(LOG_ERR, "%s: Too long key or value: key=%s, val=%s",
-		       __func__, key, value);
-
-		if (debug)
-			syslog(LOG_DEBUG, "%s: Too long key or value: pool=%d, key=%s, val=%s",
-			       __func__, pool, key, value);
+		syslog(LOG_ERR, "%s: Too long key or value: pool=%d key=%s, val=%s",
+		       __func__, pool, key, value);
 		return 1;
 	}
 
+	if (debug)
+		syslog(LOG_DEBUG, "%s: got a KVP: pool=%d key=%s val=%s",
+		       __func__, pool, key, value);
+
 	/*
 	 * First update the in-memory state.
 	 */

base-commit: 4325743c7e209ae7845293679a4de94b969f2bef
-- 
2.34.1


