Return-Path: <linux-hyperv+bounces-3143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531F99E3A3
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2024 12:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967941C2217F
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2024 10:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CCC1E3765;
	Tue, 15 Oct 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xq7ZBlNQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8611DAC89
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Oct 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987557; cv=none; b=um9tkaLLzuO2eQEBpjJWkH5bAp6fZnkATc0d0hcrVVcT+b8JBU2eViqDylIPspwY9dRQayk/Asyn/mcLF8HTNaGWmicBN5AEHZkLLv69Is/F5KhmBR/Qz/HQrjEMfkR544mrm12pUgzC3ZFRFQk3qgXDmdEfn+vh9JDs7XqPqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987557; c=relaxed/simple;
	bh=9kxCMO+ZKfdLpSe3ykZ9428rS0DuSJXVQQ17j+vf3bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4mrXjHjdWRuNPyuZy5mE3P1qeKFi+XbChEeB4V0eMeSCqDJmkz5VBVY6UyTdjkLjBkrX+1MapFPl0mBtSl7R3ZnukVKyGQ9xeGuS/X6pxPuVAa7VG0kVWWz3RynQuFDdTizxJRQD4B27G82y5B5UtlqTBE158F0zEabl5OW3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xq7ZBlNQ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728987551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pOwhazTNXJq9la23bs9AQS6qvy6I2WjnVd+IS9JBBEo=;
	b=Xq7ZBlNQnUigAHx8FZkA722SNh81nb3PNNCW4C0yWvWmKHPUgMNxAa0YsqbE8Omq1gd2FQ
	ukl0M0jVK2vyEklpEoDa2G2o9Wo8FidMd3smQb5H4DDUGWnuuL8qzo6gLFFo9OM2xnHAz1
	EXPPTqk5mWwTmcJwI6Uu1jmtzGhbPtQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] hv: hyperv.h: Annotate vmbus_channel_gpadl_header with __counted_by()
Date: Tue, 15 Oct 2024 12:18:29 +0200
Message-ID: <20241015101829.94876-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
range to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/hyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 22c22fb91042..ec62d625c439 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -643,7 +643,7 @@ struct vmbus_channel_gpadl_header {
 	u32 gpadl;
 	u16 range_buflen;
 	u16 rangecount;
-	struct gpa_range range[];
+	struct gpa_range range[] __counted_by(rangecount);
 } __packed;
 
 /* This is the followup packet that contains more PFNs. */
-- 
2.47.0


