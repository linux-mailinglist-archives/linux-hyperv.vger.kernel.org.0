Return-Path: <linux-hyperv+bounces-654-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A973C7DF259
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 13:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94661C20F67
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE1318E25;
	Thu,  2 Nov 2023 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="OFoPDU7x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075818E1A
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Nov 2023 12:27:43 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 05:27:34 PDT
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC9D112;
	Thu,  2 Nov 2023 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1698928055;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=SOa8sX/Ie2qKItHbC8xOcneJFIOfk23Ogyua++a0w4w=;
  b=OFoPDU7xzZyj/MvOWi3+d+lpirnYnG0h31b7D+cOG8C7jt4iels+ETEL
   IV1oJKWK0Hr1Un12GyMHqwXv3y+7Gh8ZNbsMp9mkltbLVos5bpQi0NVji
   W8TbdRY6ncdH86YPtr0sSiRnzuRqsme9w3Upn9xo/Gmi824yDchRkSGKz
   k=;
X-CSE-ConnectionGUID: pNIzOpSTTbaXx/hvRfdv1w==
X-CSE-MsgGUID: BpbD5vabTnSNIjuRbaZWVQ==
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 126596381
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.159.70
X-Policy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:gJjK3qp7QmFwiY0gQfooSElf0/teBmJ/YxIvgKrLsJaIsI4StFCzt
 garIBnXMq2CNjPyet1zPoqx8EoPvsTQyNdmSQVlpSk2Qn8RpZuZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbOCYmYpA1Y8FE/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GhwUmAWP6gR5waHzyNNUPrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXACgrTwKkn9mK/LiyevkrhtoZIsX1ZZxK7xmMzRmBZRonaZXKQqGM7t5ExjYgwMtJGJ4yZ
 eJAN2ApNk6ZJUQSaxFIUPrSn8/x7pX7WxRepEiYuuwc5G/LwRYq+LPsLMDUapqBQsA9ckOw/
 ziYojWnWUFDXDCZ4RCd+F7xmObFoSXAfqMQCYey/8xVvmTGkwT/DzVJDADm8JFVkHWWWM13L
 00S5zpopq83nGSxSdP9dx61uniJulgbQdU4O+ki6QyXw67V+AexBWUeSDNFLts8u6ceRTUrx
 1aPkMHBAD1kqrqOTnyBsLyTqFuaOjkOBWoDbjUDVgwL/5/op4Rbph7CRctiOKu0hcfyAjb+3
 3aBqy1Wr64PgNAGkbqy/VTvgyqh4JPOS2Yd5RTTUySg4xJ0fqalf4Hu4l/ehd5MLYOYUkOA+
 mMFhcGY7esOJZGVmWqGR+BlNKu0/O3DOTvQjER0GJ8J9yygvXWkeOh44ixlOEZvdMsefyT1S
 E/LtEVa45o7FGv6M4d0bpi3BsBsyrLvffz9UvnIYN1UZ919bg6Z8TsrdR7O937inVJqkqwlP
 5qfN8G2Ah4yDaVh0SrzX+wc+aEkyzp4xm7JQ53/iRO93tK2YH+TVKdAMEqWY/onxL2LrR+T8
 NtFMcaOjRJFX4XWaDH/+IoSIFZaa3Q2bbj6otJaMO6KJBFrHkklCvnM0fUgfZBom+JekeKg1
 nGlU2dK2Ub4nzvMLgDiQnVibrzodYxyoXIyIWonOlPA83IjbIKg5a4EX5QwerYj+apoyvscZ
 +UKf9WoBvVJVyjd/DIcfd/xoeRKeAqrjBiSFyujbiI2c5NpS0rO4NCMVgLp+DgmDyy5r8Iyr
 rSskATBTvIrQwVkEdaTa/+1yV61lWYSlfg0XEbSJNRXPkL2/+BCNCHwyPs2PukPJA/Fyz/c0
 ByZaSr0vsGU/dVzqoOQw/nZ/sH2S4OSA3a2AUHDy5ekEjHhwlapyL9QF+aWRz7RSjrrrfDKi
 fpu8x3sDBEWtA8U4tosQug3kP5WC8jH/eEAklo+dJnfRxH7Uuk+fyPuMdxn7/UVntdkVR2Kt
 lVjEzWwEZ6OIsrhWGUJPgsjYf/rORo8wWKKsq1dzKkX/kZKEFu7vaZ6ZULkZNR1ducdDW/c6
 b5JVDQqwwK+kAE2Fd2NkzpZ8W+BRlRZDfR35s9BXtG12lN7or2nXXA7InaoiKxjlv0VbxJ0S
 tNqrPGqa0tgKrrqLCNoSCmlMRt1jpUSohFapGI/y6CysoOd3JcfhUQBmQnbuywJln2rJcovY
 Dk0X6C0TI3SlwpVaD9rBjD1QVkYWk3DpCQcCTIhzQXkcqVhbUSVREVVBApH1BlxH750FtSDw
 Iyl9Q==
IronPort-HdrOrdr: A9a23:t96daaPaoXi8YsBcTmyjsMiBIKoaSvp037Dk7SFMoHtuA6qlfq
 GV7ZMmPHrP4gr5N0tMpTntAsW9qDbnhP1ICWd4B8bfYOCkghrUEGlahbGSvAEIYheOiNK1t5
 0BT0EOMqyVMbEgt7eC3ODQKb9Jq+VvsprY59s2qU0DcegAUdAE0+4WMGim+2RNNXh7LKt8Op
 qAx9ZN4wGtcW4Qaa2AdwM4dtmGid3XtY7sJSULDR4/6AWIkFqTmcXHOind8BcCci9FhYwv+2
 jdkwD/++GKvvyhxgXHvlWjnKh+qZ/OysZjGMfJsMQTJzn24zzYHLhJVrGZoTAzqPyu7lEx+e
 O80ysdAw==
X-Talos-CUID: 9a23:PQz+v20pJbdTWQTsAXS8ZLxfAuYEYFrF90vsKUaIGSFpVoebRUHJ5/Yx
X-Talos-MUID: 9a23:tEDSUQsAOipBZjk9982nriloGJp26q6SDnsrsJcbgcONBxNOAmLI
X-IronPort-AV: E=Sophos;i="6.03,271,1694750400"; 
   d="scan'208";a="126596381"
From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH 0/3] x86/apic: Misc pruning
Date: Thu, 2 Nov 2023 12:26:18 +0000
Message-ID: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGqVQ2UC/x3MQQqAIBBA0avIrBvQEUK6SrQQnWo2JgohiHdPW
 j74/A6Vi3CFTXUo/EqVJ02YRUG4fboYJU4DabLGaMLmVvRZAjoXg2XPVluCmefCp7R/tR9jfBw
 p+fhaAAAA
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Steve Wahl
	<steve.wahl@hpe.com>, Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer
	<kyle.meyer@hpe.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, "Russ
 Anderson" <russ.anderson@hpe.com>, Darren Hart <dvhart@infradead.org>, "Andy
 Shevchenko" <andy@infradead.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "Dexuan
 Cui" <decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>
X-Mailer: b4 0.12.4

Seriously, this work started out trying to fix a buggy comment.  It
escalated somewhat...  Perform some simple tidying.

P.S. I'm trialing `b4 prep` to send this series.  I've got some notes
already; others welcome too.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
Andrew Cooper (3):
      x86/apic: Drop apic::delivery_mode
      x86/apic: Drop enum apic_delivery_modes
      x86/apic: Drop struct local_apic

 arch/x86/include/asm/apic.h           |   2 -
 arch/x86/include/asm/apicdef.h        | 276 +---------------------------------
 arch/x86/kernel/apic/apic_flat_64.c   |   2 -
 arch/x86/kernel/apic/apic_noop.c      |   1 -
 arch/x86/kernel/apic/apic_numachip.c  |   2 -
 arch/x86/kernel/apic/bigsmp_32.c      |   1 -
 arch/x86/kernel/apic/probe_32.c       |   1 -
 arch/x86/kernel/apic/x2apic_cluster.c |   1 -
 arch/x86/kernel/apic/x2apic_phys.c    |   1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |   1 -
 arch/x86/platform/uv/uv_irq.c         |   2 +-
 drivers/pci/controller/pci-hyperv.c   |   7 -
 12 files changed, 8 insertions(+), 289 deletions(-)
---
base-commit: b56ebe7c896dc78b5865ec2c4b1dae3c93537517
change-id: 20231102-x86-apic-88dc3eae3032

Best regards,
-- 
Andrew Cooper <andrew.cooper3@citrix.com>


