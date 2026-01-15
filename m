Return-Path: <linux-hyperv+bounces-8311-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C18D22DE0
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB49C3030FD0
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39C7223708;
	Thu, 15 Jan 2026 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Z7qyqsv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4iX2Hk8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E02749C1;
	Thu, 15 Jan 2026 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462562; cv=none; b=Dqw+Cw8JdzzE8HBrAAnUICke+t9TMEypkrIKehkbIuGZ6aowiYrZl7dt1LpjdHOfGEcBlhMglcp7qHZRPVSB12gsUY7bd1W3U0FHzSUNLSTD5XsS7UwfLIwzxT6vtwCMgfuWLboMm6sHrega7u8TY3yWjGzE3A2GwTJdR/BkQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462562; c=relaxed/simple;
	bh=xSQrENMvTf6b9ThXFTgPHxAcI4c/NoVt1Mf+iRCU0UY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WKUDHLUcpV5Z0HpWVFeYzkXRBSb2neVAFzhbeWDYOsYZZ3BHptrZnZmCsFz7wx4hIsATr8u8OP/7xpik7l86cp08pTZ4YdduySXJFbll15RxERiqFrDDt6aLuYI9IyAfB0nnv9euXMo2TJgkJLESSbdA95TQKAaxGI71LiS9wmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Z7qyqsv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4iX2Hk8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768462558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yfItQ88zI/umVs0bHSlohMlDtNI1ProqVRKim2s0a1U=;
	b=0Z7qyqsv2sC0m/uaL6xo7iMRd6vAu7mvKicqJ2ImCuQOKwtNF0l030kHixd9Zrc0yfbKKw
	7yl2XmB+OHZpSHxXW83ox4Pjs6dal6q+smUzV3OxmhF8/8aL+OM6PPHnaBbRS8g+WCd7NF
	T9zTq6Cpawpj04R1nKry8l2PTEDSGRuIqgFKHjz5LFaHEf/htXrQ+npkq1c+axEirdZHkX
	Ox/hQ9QGFSjrPHh69X5/vIEqO3gs5/J+SYh7Fh6PVy2pJ9/Z6WGRbkHwT/i+nKm29DjMcK
	m4ZbojCGYn3h7Ly5FUWKNUFH6bjy/XGAlTFC3qNliYwI1esTTU8iPj+rviE/YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768462558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yfItQ88zI/umVs0bHSlohMlDtNI1ProqVRKim2s0a1U=;
	b=M4iX2Hk8eA7RWjy4Dar9V+1/186VAaia4CLhqNVsZw79LuS3ivb6UUi1uLOaLXOBEN08NK
	YUd7/4DcAWfGfzCQ==
Subject: [PATCH 0/2] kbuild, uapi: Mark inner unions in packed structs as
 packed
Date: Thu, 15 Jan 2026 08:35:43 +0100
Message-Id: <20260115-kbuild-alignment-vbox-v1-0-076aed1623ff@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM+YaGkC/x3MQQ5AMBBA0avIrE3Sqkq4iliUDiYoaZEm4u4ay
 7f4/4FAnilAkz3g6ebAu0uQeQbDbNxEyDYZClFUQkqNS3/xatGsPLmN3Il3v0e0ohS1VKVVSkN
 qD08jx//bdu/7AYQOXPJnAAAA
X-Change-ID: 20260115-kbuild-alignment-vbox-d0409134d335
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Hans de Goede <hansg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <lkp@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768462556; l=876;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xSQrENMvTf6b9ThXFTgPHxAcI4c/NoVt1Mf+iRCU0UY=;
 b=rDzhxsNfCUeqLHHdwI6mKudiIl7BxWLmKjM2T8nsHThSwnWifa46R2rYISCPQSDmtp/+zwuV7
 4iY6qfLT6lLCWjIbbHwYCN/rzmsFWr1HBv90qbpq7XcBNKwJ8RNp2Ea
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The unpacked unions within a packed struct generates alignment warnings
on clang for 32-bit ARM.

With the recent changes to compile-test the UAPI headers in more cases,
these warning in combination with CONFIG_WERROR breaks the build.

Fix the warnings.

Intended for the kbuild tree.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      hyper-v: Mark inner union in hv_kvp_exchg_msg_value as packed
      virt: vbox: uapi: Mark inner unions in packed structs as packed

 include/uapi/linux/hyperv.h            | 2 +-
 include/uapi/linux/vbox_vmmdev_types.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: e3970d77ec504e54c3f91a48b2125775c16ba4c0
change-id: 20260115-kbuild-alignment-vbox-d0409134d335

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


