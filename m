Return-Path: <linux-hyperv+bounces-8313-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0112D22DF8
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CC5830A1A89
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D75A328B63;
	Thu, 15 Jan 2026 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsiFZqv3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LESULiCJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1B31578F;
	Thu, 15 Jan 2026 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462564; cv=none; b=sBkpTn/NgqaBbUiIX1e0EQAgqGsLQmhyhkCdzKGEI7ux5KHUFS87GPZ62HkJZKVLwcVmghntgrPsaBPOm5/4mlH8yBO5GfimBxtchI+tii1bawSCP3SQPpPjTxUfWbVbh2dhHcZZpdG7Zy7cK6Db/Od8W7I7oGRRCSLXySxlL3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462564; c=relaxed/simple;
	bh=Uf4LnRBelGVyDvh256L7550y1T4VRuzh8TwYPxjXxWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MNHyojIbtmwKxuCiuT/sK9UaxxvcPBRNUxtfd9ACYU/1nfaOLRaG7IfO81RDYViMLU9yvXtfzCP5Tf3cmIW6H944bDR4s9yR3YI5M1QPuw0kYO/+HoZ0lnneVpIynKN1h93UM5O50/Vcchr84q15hipoiv82I7FPkJV3No0zSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsiFZqv3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LESULiCJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmJfbgsi5ZQog2/tvaxio1e94jEe7ryoDan67NooQFU=;
	b=rsiFZqv34iH7cqVI5zlA0ZsX5brXxKxkZv5NHg/roCNR4COcMx0rwulyevzYMS3oJqEaml
	62pELoOvg1yExFEYAmBKLXXNh0RO5/oJxdlNGUZCzQav+UebPfmwEs4042Ptlve8M9xtpC
	2hLBWmKfZDY17vRCwA5m0RIIgsKINAzUi9gjs93al1BbrBFgatiCisYnkyvD5FMpCZc6iE
	Z8hAGpsi/9h+rjLg6cIxLVO3e/L83my5waE/0PmuUiHStxuHdYNDMH37XA8C2Gdb6i8dFm
	CqoQpkA5JRoP/duCRSmMTyBaIxsRKKMW+7m/qwz2M7idw5enJp8p44qFK2dhnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmJfbgsi5ZQog2/tvaxio1e94jEe7ryoDan67NooQFU=;
	b=LESULiCJlpZ5X+Z6LNcgrw/nSUW6xEXYvqeNuo2AZv1t3DZBwpuO/6ubTvnHYKsvVRvxXb
	AVS3AzpfXTrYXJBQ==
Date: Thu, 15 Jan 2026 08:35:45 +0100
Subject: [PATCH 2/2] virt: vbox: uapi: Mark inner unions in packed structs
 as packed
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-kbuild-alignment-vbox-v1-2-076aed1623ff@linutronix.de>
References: <20260115-kbuild-alignment-vbox-v1-0-076aed1623ff@linutronix.de>
In-Reply-To: <20260115-kbuild-alignment-vbox-v1-0-076aed1623ff@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768462556; l=2576;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Uf4LnRBelGVyDvh256L7550y1T4VRuzh8TwYPxjXxWE=;
 b=lNuIsxK9kyAW4nia9it1+N+6Jv4CmihW70V0JoQD+pak81IehyJF6TLWmzvPrCduaYm3I7hUX
 bfz/a8mBwO5BHP/sqVrHQoVqJb7DHhSYlMsihjoW/4SehIUBtuhzPPT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The unpacked unions within a packed struct generates alignment warnings
on clang for 32-bit ARM:

./usr/include/linux/vbox_vmmdev_types.h:239:4: error: field u within 'struct vmmdev_hgcm_function_parameter32'
  is less aligned than 'union (unnamed union at ./usr/include/linux/vbox_vmmdev_types.h:223:2)'
  and is usually due to 'struct vmmdev_hgcm_function_parameter32' being packed,
  which can lead to unaligned accesses [-Werror,-Wunaligned-access]
     239 |         } u;
         |           ^

./usr/include/linux/vbox_vmmdev_types.h:254:6: error: field u within
  'struct vmmdev_hgcm_function_parameter64::(anonymous union)::(unnamed at ./usr/include/linux/vbox_vmmdev_types.h:249:3)'
  is less aligned than 'union (unnamed union at ./usr/include/linux/vbox_vmmdev_types.h:251:4)' and is usually due to
  'struct vmmdev_hgcm_function_parameter64::(anonymous union)::(unnamed at ./usr/include/linux/vbox_vmmdev_types.h:249:3)'
  being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]

With the recent changes to compile-test the UAPI headers in more cases,
these warning in combination with CONFIG_WERROR breaks the build.

Fix the warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512140314.DzDxpIVn-lkp@intel.com/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/linux-kbuild/20260110-uapi-test-disable-headers-arm-clang-unaligned-access-v1-1-b7b0fa541daa@kernel.org/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-kbuild/29b2e736-d462-45b7-a0a9-85f8d8a3de56@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/vbox_vmmdev_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/vbox_vmmdev_types.h b/include/uapi/linux/vbox_vmmdev_types.h
index 6073858d52a2..11f3627c3729 100644
--- a/include/uapi/linux/vbox_vmmdev_types.h
+++ b/include/uapi/linux/vbox_vmmdev_types.h
@@ -236,7 +236,7 @@ struct vmmdev_hgcm_function_parameter32 {
 			/** Relative to the request header. */
 			__u32 offset;
 		} page_list;
-	} u;
+	} __packed u;
 } __packed;
 VMMDEV_ASSERT_SIZE(vmmdev_hgcm_function_parameter32, 4 + 8);
 
@@ -251,7 +251,7 @@ struct vmmdev_hgcm_function_parameter64 {
 			union {
 				__u64 phys_addr;
 				__u64 linear_addr;
-			} u;
+			} __packed u;
 		} __packed pointer;
 		struct {
 			/** Size of the buffer described by the page list. */

-- 
2.52.0


