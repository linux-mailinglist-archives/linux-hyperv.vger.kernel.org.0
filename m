Return-Path: <linux-hyperv+bounces-8853-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJAHJtrKj2nMTgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8853-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 02:07:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C53513A7E8
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 02:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C368C30D3124
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Feb 2026 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F25221F24;
	Sat, 14 Feb 2026 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDtqghO5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19CA1DE8AE;
	Sat, 14 Feb 2026 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771031098; cv=none; b=RH4gm9b3IianVWbCBrA7tJQFqCNwAOIIY+EaSNGIRkiHhz6n6b5Oy34exSyTYSn2RUTMbFcxGBef6XgOYL5OiAjxhOJKl4JGRX315e8JCjWQOFVHIsXfkhmDyqg9xcI4SfvpXvfIGR1jtBSJaHySK60eSj2VLN5o0BAwNehRhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771031098; c=relaxed/simple;
	bh=kfGiNrANRnBYtgOBeJSOMxXO363Ln0ivOKg4cDzVqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6DNeBco0Z6zRopDDLG9Tpijs32X/VfeTXnMlyn/IDLe55FqXRRfHA/rq2ooMwxLf8VP6pc1NCl6PSEaNJJ+1HB2Wae8FaNeBNGd4cJRWSEBzALJFsSMUtKhpXx7WrJ0poM8uEb1/1lpR3FPH+a+B4lYqVzW39/YIqHem8OSfNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDtqghO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1799FC19424;
	Sat, 14 Feb 2026 01:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771031098;
	bh=kfGiNrANRnBYtgOBeJSOMxXO363Ln0ivOKg4cDzVqTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDtqghO5vxu1i1bPRzm20R2oZYY/QRRSMwxa+olkuX0y4VIG4nDLgN9lFXGPqOpHL
	 KPOzBz5wNn0cmCwy2/nlKN3fHXWWQ/TmCtxCmjeByEtw8MR4UeaFak4ib+0VqMdMX1
	 acuOYtHsBSaGeKeDRBU2awDVjhP/ngBnQfPKxm/SsMEF6tJxolW2vczeed8cQsywpX
	 PEakKzhZO7K+Qn/V4yW/i4j0b1ii1miRuGvfCD7VEcVL3RCxvFOdZ7DMcVGgRlprO1
	 /9fG/EhB0tyK4AA5sTV2qAyd8s78IiBpMab5D70OaFVTv3fB/RD17OKJNHAW0fpYex
	 xobtURPGx6e4Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Wei Liu (Microsoft)" <wei.liu@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.19-5.10] hyper-v: Mark inner union in hv_kvp_exchg_msg_value as packed
Date: Fri, 13 Feb 2026 19:59:01 -0500
Message-ID: <20260214010245.3671907-61-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214010245.3671907-1-sashal@kernel.org>
References: <20260214010245.3671907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8853-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,intel.com:email,msgid.link:url,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 3C53513A7E8
X-Rspamd-Action: no action

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 1e5271393d777f6159d896943b4c44c4f3ecff52 ]

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
Acked-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
Tested-by: Nicolas Schier <nsc@kernel.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20260115-kbuild-alignment-vbox-v1-1-076aed1623ff@linutronix.de
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

This commit fixes a build error caused by an unpacked union within a
packed struct in a UAPI header (`include/uapi/linux/hyperv.h`). The
issue manifests as a `-Werror,-Wunaligned-access` error on clang for
32-bit ARM, which **breaks the build** when `CONFIG_WERROR` is enabled.

Key signals:
- **Two separate "Reported-by:" tags** — kernel test robot and Nathan
  Chancellor (a prominent kernel build/clang developer)
- **Multiple "Closes:" links** to actual build failure reports
- **Tested-by** and **Reviewed-by** from Nicolas Schier
- **Acked-by** from subsystem maintainer (Wei Liu) and Greg Kroah-
  Hartman himself
- Commit message explicitly says "breaks the build"

### Code Change Analysis

The change is a single-line modification:

```c
- };
+       } __attribute__((packed));
```

This adds the `packed` attribute to an anonymous union inside the
already-packed struct `hv_kvp_exchg_msg_value`. The outer struct is
already `__attribute__((packed))`, so adding `packed` to the inner union
aligns it with the containing struct's packing requirement, silencing
the clang warning.

**Functional impact**: This union contains `__u8 value[...]`, `__u32
value_u32`, and `__u64 value_u64`. Since the union is inside a packed
struct, the compiler should already be treating accesses as potentially
unaligned. Adding `packed` to the union itself makes this explicit and
resolves the inconsistency that triggers the warning. There is **no
change to the actual memory layout** — the struct was already packed,
and the union within it was already at whatever offset the packing
dictated. This just makes the annotation consistent.

### Classification

This is a **build fix** — one of the explicitly allowed categories for
stable backporting. It prevents compilation failure on a specific (and
common) configuration: clang + 32-bit ARM + CONFIG_WERROR.

### Scope and Risk Assessment

- **Lines changed**: 1 (literally changing `};` to `}
  __attribute__((packed));`)
- **Files changed**: 1 UAPI header
- **Risk**: Extremely low. The packed attribute on the inner union is
  semantically correct (the outer struct is already packed), and this
  doesn't change the ABI or memory layout
- **Subsystem**: Hyper-V UAPI header, but the fix is really about build
  correctness

### User Impact

- **Who is affected**: Anyone building the kernel with clang on 32-bit
  ARM (or potentially other architectures in the future) with
  `CONFIG_WERROR=y`
- **Severity**: Build breakage — users literally cannot compile the
  kernel in this configuration
- **Frequency**: 100% reproducible in the affected configuration

### Stability Indicators

- Acked by Greg Kroah-Hartman (stable tree maintainer)
- Acked by Wei Liu (Hyper-V maintainer)
- Tested and reviewed by Nicolas Schier
- The fix is trivially correct — adding packed to a union inside a
  packed struct

### Dependency Check

This commit is self-contained. It references "recent changes to compile-
test the UAPI headers in more cases" as the trigger that exposed this
warning, but the fix itself (adding packed to the union) is valid
regardless of whether those compile-test changes are present. The
underlying warning condition exists in any version of this header
compiled with clang on ARM.

However, I should check if the struct in question exists in older stable
trees.

The struct `hv_kvp_exchg_msg_value` with this union has been in
`include/uapi/linux/hyperv.h` for a very long time (it's part of the
Hyper-V KVP userspace interface). The fix would apply cleanly to any
stable tree that has this header.

### Conclusion

This is a textbook stable backport candidate:
- **Fixes a real build breakage** (not just a warning — it errors out
  with CONFIG_WERROR)
- **Trivially small and obviously correct** — one attribute addition
- **Zero risk of regression** — no behavioral change, no ABI change
- **Well-reviewed** — acked by GKH, subsystem maintainer, tested and
  reviewed
- **Multiple reporters** — real-world problem encountered by kernel test
  infrastructure and developers
- Build fixes are explicitly listed as appropriate stable material

**YES**

 include/uapi/linux/hyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
index aaa502a7bff46..1749b35ab2c21 100644
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
2.51.0


