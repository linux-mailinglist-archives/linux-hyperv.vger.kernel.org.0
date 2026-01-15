Return-Path: <linux-hyperv+bounces-8312-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D9D22DE3
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B715304BE42
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677F325709;
	Thu, 15 Jan 2026 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rON4D/uq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IzWc++SX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C52DF12F;
	Thu, 15 Jan 2026 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462562; cv=none; b=lZxd75o/IP0nbwzhzKVXv72eqi0HgyKt5NcEIaFfhN3CWa3kakx+C0cmckNnr3Ljtct1het16nUeWaZXpkIIf8JZZ9XuacTN0LnKUOfPEchmuJepFeoE7ewRESyNLclsQIEqvTjl7JbO/Yzni+32S42VqSiMSXGsmGrru6iLpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462562; c=relaxed/simple;
	bh=gQlXs4q19xMLM8Wc0CIfifmCM1u8xor1ADjg8gkJ/Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubR848okkoKyEVp85wIwngOsrX3ITXb7ULOnOfUiVllEihF8l3LdmA/MuKvw3xxagozyr9XPmPtzgCix0DIHzwJvE3eeEnhbLD2GbLcSfATj8gYipkn3dOhxpQFI1Oc79Pd6SSZsLiS9ILSTyOCdn6hJlMbdweITlDS2Ir87xOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rON4D/uq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IzWc++SX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuFTyZHzQGk2QqDXdX5OISfkQ27KHUy/T6UHqgFncd4=;
	b=rON4D/uqufLb7MBQX7MP9+157kpnGJfYzYe693nFE0CfGwYJqMsg6c1qiF9tj9lYct82+1
	Q5WEarD5jWgy0/rsFEA3vAZlK6CpgNWfTRvvMDVPSByFuOmkp5REJlXa4U27nqcgt7/IA4
	JEUi6zCP8Nl1P6tzcdg9nBo0m6Dxh826ha2VOdmKkLhET9Taz5PvNvZK7puuwD734Z2bgL
	SyLkE0kiMwKUagONYKFDX0I34gQUhl+IEKvH2mejMLgGEOY5MybB7vmTUTFEGm9DRqrQUY
	oAD9MTXEqR3lE/90PtkfCDKYDMyh2Q+EaoAw6bS5vEPTK/JaweMqpxIMCN8XeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuFTyZHzQGk2QqDXdX5OISfkQ27KHUy/T6UHqgFncd4=;
	b=IzWc++SXQVXqyTI6SLJupr/3UgPlHEDDdzHpCHUjM0XhXA1tkcyxgTJvlbqw1lB0XNH6aW
	18FPsH7CsUWBP/Dg==
Date: Thu, 15 Jan 2026 08:35:44 +0100
Subject: [PATCH 1/2] hyper-v: Mark inner union in hv_kvp_exchg_msg_value as
 packed
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-kbuild-alignment-vbox-v1-1-076aed1623ff@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768462556; l=1716;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gQlXs4q19xMLM8Wc0CIfifmCM1u8xor1ADjg8gkJ/Mk=;
 b=SIoPm7+F/yGCU03lpF4m0kxUTlX7Bb+SOZO7DxAscLIoTmLE0klPAVbhDlHusnht1D/WG98ND
 q/0fZdrq4gnDQSjppUjJXcfn92bIN6mKVkogvcWF+E+xoranVUtvIPg
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The unpacked union within a packed struct generates alignment warnings
on clang for 32-bit ARM:

./usr/include/linux/hyperv.h:361:2: error: field  within 'struct hv_kvp_exchg_msg_value'
  is less aligned than 'union hv_kvp_exchg_msg_value::(anonymous at ./usr/include/linux/hyperv.h:361:2)'
  and is usually due to 'struct hv_kvp_exchg_msg_value' being packed,
  which can lead to unaligned accesses [-Werror,-Wunaligned-access]
     361 |         union {
         |         ^

With the recent changes to compile-test the UAPI headers in more cases,
this warning in combination with CONFIG_WERROR breaks the build.

Fix the warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512140314.DzDxpIVn-lkp@intel.com/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/linux-kbuild/20260110-uapi-test-disable-headers-arm-clang-unaligned-access-v1-1-b7b0fa541daa@kernel.org/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-kbuild/29b2e736-d462-45b7-a0a9-85f8d8a3de56@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/hyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
index aaa502a7bff4..1749b35ab2c2 100644
--- a/include/uapi/linux/hyperv.h
+++ b/include/uapi/linux/hyperv.h
@@ -362,7 +362,7 @@ struct hv_kvp_exchg_msg_value {
 		__u8 value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
 		__u32 value_u32;
 		__u64 value_u64;
-	};
+	} __attribute__((packed));
 } __attribute__((packed));
 
 struct hv_kvp_msg_enumerate {

-- 
2.52.0


