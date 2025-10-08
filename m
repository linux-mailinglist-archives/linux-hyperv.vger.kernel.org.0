Return-Path: <linux-hyperv+bounces-7146-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D263BC6CE6
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 00:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4168334B230
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683A12C21CF;
	Wed,  8 Oct 2025 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TxefJhlQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9791E25F9;
	Wed,  8 Oct 2025 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759963411; cv=none; b=BhmbP8a1FUOYNBLRLRRAdAij9sxNSX5Trge1FxiYEH6hLpctgHVuMCTOkdLSEgCzrBJl/5am6xPJDg7dJU3PXk1InjlFKKyCacya3E+RiBt9VpsTZmF4FAmI5stL3GeKeo3YEqgMylC7BNlWyjp/lXDSCdTg2asB24G5v5iRlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759963411; c=relaxed/simple;
	bh=4FrMUDcGUMvsqwXazXahedVwFjEFXGbW1XJeTBDqcUE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=nTsgZ0UKpzPvKEIEZo3sds5a++RUjuqvrtOJrV2FUzD4YWJxwYOR10DqaER3Cy7plBjig4njl6KlIRE57JCQ2OB5Gb57Nkj9GzOo8j6LI5uAbBXIV/oN3bnUUN/AMq71LL8fs5Mh8eweoi+4+j9keigRNvpOf3H8JcJPlU1J2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TxefJhlQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5DCF12038B7E;
	Wed,  8 Oct 2025 15:43:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DCF12038B7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759963409;
	bh=LErNskLjh4BZ+2o5s0bJXU/v5paXrsipcOc4cy6keb4=;
	h=Subject:From:To:Cc:Date:From;
	b=TxefJhlQ0iIUOwb0h+BwMU69pfxKyiNIT5/k2iUNuTXaTlHOG82Rf88wydZRtV3fb
	 u8C8D4fjtK8Qs4nygs4zH492hVaEizZsuMrrmvlI+KHxSbyHSTJQtIwhCbj5RFakC3
	 pV08+/zTT/iaJiTtYpBGYZ5BHi1L5tZSbXWavpW4=
Subject: [RFC PATCH] Drivers: hv: Resolve ambiguity in hypervisor version log
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 08 Oct 2025 22:43:29 +0000
Message-ID: 
 <175996340003.108050.17652201410306711595.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Update the log message in hv_common_init to explicitly state that the
reported version is for the Microsoft Hypervisor, not the host OS.

Previously, this message was accurate for guests running on Windows
hosts, where the host and hypervisor versions matched. With support for
Linux hosts running the Hyper-V hypervisor, the host OS and hypervisor
versions may differ.

This change avoids confusion by making it clear that the version refers to
the Microsoft Hypervisor regardless of the host operating system.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e109a620c83fc..0289ee4ed5ebf 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -315,9 +315,9 @@ int __init hv_common_init(void)
 	int i;
 	union hv_hypervisor_version_info version;
 
-	/* Get information about the Hyper-V host version */
+	/* Get information about the Microsoft Hypervisor version */
 	if (!hv_get_hypervisor_version(&version))
-		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
+		pr_info("Hyper-V: Hypervisor Build %d.%d.%d.%d-%d-%d\n",
 			version.major_version, version.minor_version,
 			version.build_number, version.service_number,
 			version.service_pack, version.service_branch);



