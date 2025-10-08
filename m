Return-Path: <linux-hyperv+bounces-7145-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2721CBC6CDE
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 00:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB30A3C3706
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D812C21D0;
	Wed,  8 Oct 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pevA0W1z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B31E25F9;
	Wed,  8 Oct 2025 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759963335; cv=none; b=fK3x4FA4ZwouLQFHaNerMbOehnbR6gBns1gCXpPKBOMvoM4H5+QfplyYRMmlj6IgLR3p2Ly0yOY10VuE4QtzRmzT3kznZsDeeQdsg5hSTRpZskgX9brgb7E2vP727LiBf1QIeLaT0vE+nA8XfIawVjAQuPrvcF5Ms2iGN4CbXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759963335; c=relaxed/simple;
	bh=4FrMUDcGUMvsqwXazXahedVwFjEFXGbW1XJeTBDqcUE=;
	h=Subject:From:Cc:Date:Message-ID:MIME-Version:Content-Type; b=RLrlLKWRRcKjSHw81HRp69ezlsjkPc/oe9sfFdQ5cV2M6KkEvl0j0J5ESD7FeRqKUrDbjg2ZC9C8rWVBzLO+7/YblWKsacABTOk9u7HcMyjZKaiHyYZ31T/Ba3lzUbcMklA8SmIFi+51AzrtRsuQ1FyIxsIx504wUmrDQZgg79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pevA0W1z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id E2B472078630;
	Wed,  8 Oct 2025 15:42:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2B472078630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759963333;
	bh=LErNskLjh4BZ+2o5s0bJXU/v5paXrsipcOc4cy6keb4=;
	h=Subject:From:Cc:Date:From;
	b=pevA0W1zklh746AmazmUN3cDxs9i27cYfasLTyY+61GrbJEx6rhe/GJ/RhfhnA/tN
	 XKmyvnWnCRK982P2550h88JREk38aKx0WMwUz1JbXWnSl1K1BhdsjScwsgaaE4lPuM
	 YNAOu3BbvNY5Ou882MNkPTXXOw4gSy7KSTphRsag=
Subject: [RFC PATCH
 --to=kys@microsoft.com,haiyangz@microsoft.com,wei.liu@kernel.org,decui@microsoft.com]
 Drivers: hv: Resolve ambiguity in hypervisor version log
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 08 Oct 2025 22:42:13 +0000
Message-ID: 
 <175996333379.107949.887881974668560955.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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



