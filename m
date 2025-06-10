Return-Path: <linux-hyperv+bounces-5821-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B1DAD31B2
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444167A8CA1
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05C28C028;
	Tue, 10 Jun 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rclxL8S2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005C28BABC;
	Tue, 10 Jun 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547095; cv=none; b=gw13kDTaPt98mtgR6iIl/aikgyrOtQWVZdRiw1oC6weprxU9JXYSUxzIvklYujgB4ERbfj9SxNYq03H2atvOXg6129Nbyr1QoLcT/EcZdsPDhLPioPVhAaadzEuwNY0SlYB8xZcpoMGQJRRiIL9fsh9v2hQGHO0smmnVY0RoBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547095; c=relaxed/simple;
	bh=BstjmGpVoIuTOS5rrh7KkyDXx3rNFJ8Yoa4ULE+LI/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PADVb3s85TM/4M6wnR9ZemqVGExWCrgZptnCmtOKTLoB7DBfuIHZUxdtt1VtLb03FUW6CBv5w2v0iL2uBU8sjoPiscQF1av+eVbiXQ4j2XPj35ALZ4jKjkBDRgMFm189u5bbYX5czlqFHdIU84g04pTXtJJGM/wnURcyCQ8Ftr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rclxL8S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9C9C4CEED;
	Tue, 10 Jun 2025 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749547095;
	bh=BstjmGpVoIuTOS5rrh7KkyDXx3rNFJ8Yoa4ULE+LI/s=;
	h=From:To:Cc:Subject:Date:From;
	b=rclxL8S2Bmg4evg2AxxCnktq+e1WczO78FObtMabrjTmj0teZ9rZjmSdmoJc495Th
	 67jrtzex6fpwHb/rp+h2K62InbFBjho+SqINNvS/h/rYzmhv04dAMbvp1UArKj7hdr
	 JvtSMilx4QCr8cT1z72Uo/eTlV2QnxvC4qcXEiyFjJQWKMoLW35Sztb8A5zw28zHDl
	 jsOLeavmWWucqCebSWXRdOXByB3SrRxS0HjZCF6NRlnn/mMuO++qEYvxH4UjwWo0ak
	 zrnK0IwZnpHao06mWqXmn6n9W+Ncp6+226AuCmTkPm9OZ2NSEdAiCwNqKaaILMzXan
	 L8OMWV5pH7Dkw==
From: Arnd Bergmann <arnd@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hv: add CONFIG_EFI dependency
Date: Tue, 10 Jun 2025 11:18:01 +0200
Message-Id: <20250610091810.2638058-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Selecting SYSFB causes a link failure on arm64 kernels with EFI disabled:

ld.lld-21: error: undefined symbol: screen_info
>>> referenced by sysfb.c
>>>               drivers/firmware/sysfb.o:(sysfb_parent_dev) in archive vmlinux.a
>>> referenced by sysfb.c

The problem is that sysfb works on the global 'screen_info' structure, which
is provided by the firmware interface, either the generic EFI code or the
x86 BIOS startup.

Assuming that HV always boots Linux using UEFI, the dependency also makes
logical sense, since otherwise it is impossible to boot a guest.

Fixes: 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 8622d0733723..07db5e9a00f9 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -6,6 +6,7 @@ config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
 		|| (ARM64 && !CPU_BIG_ENDIAN && HAVE_ARM_SMCCC_DISCOVERY)
+	depends on EFI
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
-- 
2.39.5


