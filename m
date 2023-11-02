Return-Path: <linux-hyperv+bounces-656-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183A7DF25C
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 13:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E19B20E45
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Nov 2023 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9A18E01;
	Thu,  2 Nov 2023 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="VcWBK2XV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05B18E1A
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Nov 2023 12:27:47 +0000 (UTC)
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E64128;
	Thu,  2 Nov 2023 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1698928063;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oTEJNTw+CTtmPiz/F/xqvE9BcwMN5UZXmBpn9qQJTOg=;
  b=VcWBK2XVNV0MCfjhmfAPDYIOe+qcx0sbq57WdYHvSpF6k0ixUUYPf4Fd
   qQRy/8nl4F8EGXDuePy7ANR6upJyu99mQLmf0UXfr5YauEGJKU6LnCIax
   /Lvz8v8VwVz0pClIM3QMkXRJifZ98UZzm8p47uB5ZFUAU/ta4g3IMM9Nn
   M=;
X-CSE-ConnectionGUID: pNIzOpSTTbaXx/hvRfdv1w==
X-CSE-MsgGUID: mov3QMmaRyiW6eu7Auk/bw==
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 126596387
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.159.70
X-Policy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:IFospKCQ+WgIuBVW/07lw5YqxClBgxIJ4kV8jS/XYbTApD10hD1Tz
 2UcDz/VP/yLYWr1cohwa42//UoP75WHn4VqQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48D8kk/nOH+KgYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMsMpvlDs15K6p4WpA5ARiDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw4sBWE0ZWz
 sAkIjk9fleDmdi4zKziVbw57igjBJGD0II3v3hhyXfSDOo8QICFSKLPjTNa9G5u3IYUR6+YP
 pdIL2U3BPjDS0Qn1lM/IZQyhuq3wFL4dCVVsgm9rqsr+WnDigd21dABNfKMIILXFJsOzhnwS
 mTu+mPnWSg/MdWl2Du6rH+x2cbSnmTxR9dHfFG/3qEz2wDCroAJMzUVSnO/oP+kmgi1XNc3A
 1YT8CoGrqUo8kGvCN7nUHWQpGaFswQVX9tLEsU55RuLx66S5ByWbkAERz9QYdoppuczRDcw0
 USOkc+vDjtq2JWWWGm187aftzSpPiYJa2QFYEcsQQYO/tjLpYA4lBXUSdh/VqWyi7XdAi393
 T3MsyE+g50TlcNN3KK+lXjEkjah4J3EXwMvzgXPUySu6QYRTIKkYo2081md9vdeJYCYRVmpv
 GAJ3cOZ6YgmF4yWj2qERukABqqu4d6FKDCaillqd7Ej6i+x+njlcJpW+y1WJF9kdM0DfFfBc
 B+NkQBc/pleOD2td6AfS5q1AtgkyrLlUNj/V+7ZdJ9eMsZZagCK5mdtaFSW0mSrl1Ij+Yk7O
 JGGYYO0BncyF6tq1ny1Sv0b3LttwToxrUvXRJbm31GnwKKTfmC9V7gIKh2NY/o/4afCpx/am
 /5VL+ODzxRSVr24biS/2YIaM11MLXE9Hp3wg8hWcPOTZAtgBGwlTfTWxNsJe5Rst7ZEiuDSu
 Hq6XydwzVv5inrvMwiGanl/LrjoWP5Xp3I2OSMlNE2A1H8kboKiqqwYcvMfYbYj5MRnzPhpU
 +MCfcSQRPhCIhzL5TQUd4XVrYpsbh2niAuCeS2/b1AXdphsViTI/NH+dwfi/SVICTC43eM6o
 ru9xkbYTIAFSgBKEsnbcrSswkm3sHxbn/h9N2PXL9gVfETx2ItnMSr8irkwOc5kFPnY7mLEj
 UDMW05e/LSc5dBtmDXUuUyah5+PMvlZBnFmI2PS3abxNTfg8Ga9mJAVBY5kYgvhuHPIFLSKP
 LsEn6GtbqFawD6moKImTew3k/hWC8/H4u8ClFo5Rh0nenzyUus4SkRqy/WjoUGkKlVxkgysU
 0bHwcFAOLOGI6sJ+3ZKf1J6N4xvORwO8wQ+DMjZw22gv0ebBJLdDS1v0+Ck0USx1oddPoI/2
 vsGs8UL8QG5gRdCGo/Y33AEqT/ScCJQCvVPWnQm7GjD01RD972/ScWBUXGeDG+nML2gzXXG0
 hfL3fGf1tywN2LJcmYpFGil4Nexca8m4UgQpHdbfgThpzYwrqNvtPGn2WhtH1s9I9Qu+74bB
 1WHwGUsdfzUp2421JIdN41ucikYbCCkFoXK4wNhvAXko4OADwQh8EVV1T6xwX0k
IronPort-HdrOrdr: A9a23:mvDfKaDez8/EmdTlHekB55DYdb4zR+YMi2TDGXoRdfUzSL3/qy
 nOpoV96faQslwssR4b9OxoVJPtfZqYz+8X3WH+VY3SIDUO+1HYUb2L1OPZskLd8lTFh5BgPM
 VbE5SWeeeAaWSS1vyKmTVQeuxIqLK6GeKT9IXjJhFWIj2CAJsQijuRZDz0LqRefng2ObMJUL
 Sd++tarH6adXwMaMPTPAh+Y8Hz4/PKibP7alo8CxQm8QmDii7A0s+ALzGomjkfThJSyvMY/W
 LEigz04bjmm/y30RPHzQbonudrseqk5NtfJdCGzvIYLTjhkW+TFfxccrCPpi00p+mz6FAsir
 D30mcdA/g=
X-Talos-CUID: 9a23:oB45um9KxWZ1/MXqPMqVv1YyO9ICakbh8H3ZE1//CXhTRrGLEEDFrQ==
X-Talos-MUID: 9a23:xxZ64Aa7/su0CuBTsjjy3whHMc5S8qWRVk0QzrwbuI6OKnkl
X-IronPort-AV: E=Sophos;i="6.03,271,1694750400"; 
   d="scan'208";a="126596387"
From: Andrew Cooper <andrew.cooper3@citrix.com>
Date: Thu, 2 Nov 2023 12:26:20 +0000
Subject: [PATCH 2/3] x86/apic: Drop enum apic_delivery_modes
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231102-x86-apic-v1-2-bf049a2a0ed6@citrix.com>
References: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
In-Reply-To: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
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

The type is not used any more.

Replace the constants with plain defines so they can live outside of an
__ASSEMBLY__ block, allowing for more cleanup in subsequent changes.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
 arch/x86/include/asm/apicdef.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 4b125e5b3187..ddcbf00db19d 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -20,6 +20,13 @@
  */
 #define IO_APIC_SLOT_SIZE		1024
 
+#define APIC_DELIVERY_MODE_FIXED	0
+#define APIC_DELIVERY_MODE_LOWESTPRIO	1
+#define APIC_DELIVERY_MODE_SMI		2
+#define APIC_DELIVERY_MODE_NMI		4
+#define APIC_DELIVERY_MODE_INIT		5
+#define APIC_DELIVERY_MODE_EXTINT	7
+
 #define	APIC_ID		0x20
 
 #define	APIC_LVR	0x30
@@ -430,14 +437,5 @@ struct local_apic {
  #define BAD_APICID 0xFFFFu
 #endif
 
-enum apic_delivery_modes {
-	APIC_DELIVERY_MODE_FIXED	= 0,
-	APIC_DELIVERY_MODE_LOWESTPRIO   = 1,
-	APIC_DELIVERY_MODE_SMI		= 2,
-	APIC_DELIVERY_MODE_NMI		= 4,
-	APIC_DELIVERY_MODE_INIT		= 5,
-	APIC_DELIVERY_MODE_EXTINT	= 7,
-};
-
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_APICDEF_H */

-- 
2.30.2


