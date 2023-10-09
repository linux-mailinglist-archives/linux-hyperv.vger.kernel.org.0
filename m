Return-Path: <linux-hyperv+bounces-485-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20967BECC3
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Oct 2023 23:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF4B1C209A6
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Oct 2023 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3774123C;
	Mon,  9 Oct 2023 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc6mgFQ7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C978A37C8C;
	Mon,  9 Oct 2023 21:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA836C43395;
	Mon,  9 Oct 2023 21:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696886359;
	bh=0oKwSWjQM05Ao/uQ0wsIA8Wzs9vAdnSky5PBtFIwvT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cc6mgFQ7201CW0jtgb8bIADXktMt8MRMT5x+zQw138I5XhtRj2Z1lwGZhhPijjyLd
	 kTwWA2c0xvwB5JiFtFlNwyF/2A1exupq+bHGHDWWtDRa+RvKY9VqTvDSMn5AeL+XSl
	 yGEkvMDkhhWs5RmkDmAujwJhUssc5rFx4IJ6CqRFoUa/PIJIHBcZiNfYy4TdgmWMRg
	 g/HUVfC3sFvxoDEj4LccmDA703CvrYglGO7CgRuySaLENAMMyCvJ/4Sw/IDMD0JjgG
	 lXVfBLeNZaf41n+P4kVSO/kwBuSJQEbPztE0iTf6JqGSv44j1av9O3KWNhgiyM7vfm
	 xaQYicgV0L0lg==
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
Subject: [PATCH v3 1/9] vgacon: rework Kconfig dependencies
Date: Mon,  9 Oct 2023 23:18:37 +0200
Message-Id: <20231009211845.3136536-2-arnd@kernel.org>
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

The list of dependencies here is phrased as an opt-out, but this is missing
a lot of architectures that don't actually support VGA consoles, and some
of the entries are stale:

 - powerpc used to support VGA consoles in the old arch/ppc codebase, but
   the merged arch/powerpc never did

 - arm lists footbridge, integrator and netwinder, but netwinder is actually
   part of footbridge, and integrator does not appear to have an actual
   VGA hardware, or list it in its ATAG or DT.

 - mips has a few platforms (malta, sibyte, and sni) that initialize
   screen_info, on everything else the console is selected but cannot
   actually work.

 - csky, hexgagon, loongarch, nios2, riscv and xtensa are not listed
   in the opt-out table and declare a screen_info to allow building
   vga_con, but this cannot work because the console is never selected.

Replace this with an opt-in table that lists only the platforms that
remain. This is effectively x86, plus a couple of historic workstation
and server machines that reused parts of the x86 system architecture.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Khalid Aziz <khalid@gonehiking.org>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/console/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 30577b1d3de59..cbf303d76d39b 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -7,9 +7,9 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
-	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
-		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390 && !UML
+	depends on ALPHA || IA64 || X86 || \
+		(ARM && ARCH_FOOTBRIDGE) || \
+		(MIPS && (MIPS_MALTA || SIBYTE_BCM112X || SIBYTE_SB1250 || SIBYTE_BCM1x80 || SNI_RM))
 	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI_CORE)
 	default y
 	help
-- 
2.39.2


