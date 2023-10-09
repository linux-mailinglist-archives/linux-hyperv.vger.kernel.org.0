Return-Path: <linux-hyperv+bounces-487-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9CF7BECD2
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Oct 2023 23:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2C1C20A12
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Oct 2023 21:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A434174A;
	Mon,  9 Oct 2023 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5PakbMN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E537C8C;
	Mon,  9 Oct 2023 21:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3F9C43395;
	Mon,  9 Oct 2023 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696886380;
	bh=uv5PTEar9IGaTmZ+Pn40pjQ09jkhWdf7PdXGXIEpx7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5PakbMNLhHZDv7DV3348t2Fbm4wnh46+GGLfgibxgl8s1+tQjFDsWVu/yC42x/+f
	 p4V3KHJTUqxTWptLv89U/Zu3V1znVY1VRG2vR6Ef+IY0mBUXh5FvOEthG+TT+tfint
	 XGoJO8ORRNT0qHLajaPszCk8aa+1/deONGsbBMwMm37pMhUAnqhW6uFMFOP52D26bj
	 K8jjFrhNqQI/vxUdoNzYa+rpM2JxUKDh9hbSqBKAid2MpFRphHgkXHfhSSfuwJYtkV
	 1aEl+NwsoRuuceAjOAdxrPDdaJsdVQ/pFJrlFRgU5iKXsO/qjTsDIjjOiKB2+EXL5/
	 PURJydjgM7lcw==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Deepak Rawat <drawat.floss@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guo Ren <guoren@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Khalid Aziz <khalid@gonehiking.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	WANG Xuerui <kernel@xen0n.name>,
	Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v3 3/9] dummycon: limit Arm console size hack to footbridge
Date: Mon,  9 Oct 2023 23:18:39 +0200
Message-Id: <20231009211845.3136536-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009211845.3136536-1-arnd@kernel.org>
References: <20231009211845.3136536-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The dummycon default console size used to be determined by architecture,
but now this is a Kconfig setting on everything except ARM. Tracing this
back in the historic git trees, this was used to match the size of VGA
console or VGA framebuffer on early machines, but nowadays that code is
no longer used, except probably on the old footbridge/netwinder since
that is the only one that supports vgacon.

On machines with a framebuffer, booting with DT so far results in always
using the hardcoded 80x30 size in dummycon, while on ATAGS the setting
can come from a bootloader specific override. Both seem to be worse
choices than the Kconfig setting, since the actual text size for fbcon
also depends on the selected font.

Make this work the same way as everywhere else and use the normal
Kconfig setting, except for the footbridge with vgacon, which keeps
using the traditional code. If vgacon is disabled, footbridge can
also ignore the setting. This means the screen_info only has to be
provided when either vgacon or EFI are enabled now.

To limit the amount of surprises on Arm, change the Kconfig default
to the previously used 80x30 setting instead of the usual 80x25.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/atags_parse.c    | 2 +-
 arch/arm/kernel/setup.c          | 3 +--
 drivers/video/console/Kconfig    | 5 +++--
 drivers/video/console/dummycon.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 33f6eb5213a5a..4c815da3b77b0 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -69,7 +69,7 @@ static int __init parse_tag_mem32(const struct tag *tag)
 
 __tagtable(ATAG_MEM, parse_tag_mem32);
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
+#if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_VGA_CONSOLE)
 static int __init parse_tag_videotext(const struct tag *tag)
 {
 	screen_info.orig_x            = tag->u.videotext.x;
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index f474e7dbbe053..5e965cb94dd66 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -928,8 +928,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 		request_resource(&ioport_resource, &lp2);
 }
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE) || \
-    defined(CONFIG_EFI)
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_EFI)
 struct screen_info screen_info = {
  .orig_video_lines	= 30,
  .orig_video_cols	= 80,
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index cbf303d76d39b..83c2d7329ca58 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -52,7 +52,7 @@ config DUMMY_CONSOLE
 
 config DUMMY_CONSOLE_COLUMNS
 	int "Initial number of console screen columns"
-	depends on DUMMY_CONSOLE && !ARM
+	depends on DUMMY_CONSOLE && !ARCH_FOOTBRIDGE
 	default 160 if PARISC
 	default 80
 	help
@@ -62,8 +62,9 @@ config DUMMY_CONSOLE_COLUMNS
 
 config DUMMY_CONSOLE_ROWS
 	int "Initial number of console screen rows"
-	depends on DUMMY_CONSOLE && !ARM
+	depends on DUMMY_CONSOLE && !ARCH_FOOTBRIDGE
 	default 64 if PARISC
+	default 30 if ARM
 	default 25
 	help
 	  On PA-RISC, the default value is 64, which should fit a 1280x1024
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index f1711b2f9ff05..70549fecee12c 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -18,7 +18,7 @@
  *  Dummy console driver
  */
 
-#if defined(__arm__)
+#if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_VGA_CONSOLE)
 #define DUMMY_COLUMNS	screen_info.orig_video_cols
 #define DUMMY_ROWS	screen_info.orig_video_lines
 #else
-- 
2.39.2


