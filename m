Return-Path: <linux-hyperv+bounces-5598-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2072ABF035
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 11:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B4818958EA
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8CF25393D;
	Wed, 21 May 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="KUiYpN7i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424A250BED;
	Wed, 21 May 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820483; cv=pass; b=Wb7bMzC0Bbuu/WOwOOkvo8F20aHpg0mQddHI8LE6sMx3bA67kTOnbEOcEwgA5WOO8QXb8GtJkJO4e6RP/PBaENAyIDuqTRSxnqJl/PN5zUeFKnbWyCSX5PVVbNI05/KwW5dlYLbUbwgY5XjHRP4Ldqtt2Xb19PuRpb9tS/uqMcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820483; c=relaxed/simple;
	bh=HBGeSWhlI0uxxSho24nYevRne57eTZnoS1c8gCFYqn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nngdl4smx+NnoXNO60tc/8dplARViX+Y420anmsWSsETMzRO+yZVz+MkQw+ioqS1jsFfiNQYHGUgdex76cPC2wOABJ0IW+uDbz0tD0CYPp9qcR3j/XLw2JaYUNxKO6euScWn6NG2/KXEoqF05Ze2lgQe1crt8l+f5n09VyypBxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=fail (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=KUiYpN7i reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1747820471; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=agGqAnt3Bc9RFcPTZ0KKHJHUmsmpZfMgKqzqAUcrECb5obxwgVb4Eg8EABux6BLm3kt52wE0XntHtQDdU1iSzogSSCeYjhpKOkRBzUx66aH6pUBQPHvesJOPoxIs+rvwg8Nrzt6LM3FDyKnwInsr6Jq/UJJUxTZRpWQCZURHUGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747820471; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DTWiBkBhS2QuL+xSXWqqij2r9yFJ6qW2raK9TVRAI7Q=; 
	b=NA+0SSKzhL9H0xgLq7m+ZKOSusHuzXi2EB7JslWSlK36AsgggbtPNTD25HiigbM63Ez6gLXU9DSv9zcTYPUchGwrmIpQpOcWyyxUsQ0CtR0eLryZI/T43yXf0m9sKupKxEqUaFGgcPbG5R27/+3sx4+U44Ps38whkT2amcz5FcQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747820471;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=DTWiBkBhS2QuL+xSXWqqij2r9yFJ6qW2raK9TVRAI7Q=;
	b=KUiYpN7i0A9FIjwGvhL8E7tX6SSRdDxx2GwrqhIEkpVVvT113SBHU/KC81lxu7Cf
	ABLN4oRMA1v8jKXMi5RhjNFU4vhWmW4Y9mX5dcuji9S3pde8taQSeCdkBXm5C8jenie
	j0sodbh9w1XMZm/1e96MJJ8TOLn/fWN+W/gR41P0=
Received: by mx.zohomail.com with SMTPS id 1747820468781754.4226643973292;
	Wed, 21 May 2025 02:41:08 -0700 (PDT)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: anirudh@anirudhrb.com,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: smccc: support both conduits for getting hyp UUID
Date: Wed, 21 May 2025 09:40:48 +0000
Message-Id: <20250521094049.960056-1-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

When Linux is running as the root partition under Microsoft Hypervisor
(MSHV) a.k.a Hyper-V, smc is used as the conduit for smc calls.

Extend arm_smccc_hypervisor_has_uuid() to support this usecase. Use
arm_smccc_1_1_invoke to retrieve and use the appropriate conduit instead
of supporting only hvc.

Boot tested on MSHV guest, MSHV root & KVM guest.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/firmware/smccc/smccc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index cd65b434dc6e..bdee057db2fd 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -72,10 +72,7 @@ bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
 	struct arm_smccc_res res = {};
 	uuid_t uuid;
 
-	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
-		return false;
-
-	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
+	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
 	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
 		return false;
 
-- 
2.34.1


