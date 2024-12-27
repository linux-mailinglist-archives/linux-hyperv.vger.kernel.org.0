Return-Path: <linux-hyperv+bounces-3542-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48C59FD6F3
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 19:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701D018838A6
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6F81F8ADB;
	Fri, 27 Dec 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JlR/IeFf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA213BAEE;
	Fri, 27 Dec 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735324319; cv=none; b=r6UHcsBEw33MJuZjO6BnZh0AInOzmGVrHSVPOqdMf/7CeW3tGZI5HYcMO9roC0sGiiAiWUwRDWd7rk8A99M8ZZhD4uGuCsK56oVvLVKq8Gq534a+hdRFDox7GlZGFSEtKAbVKBJJpdF4bFpBRGLsbUX0cV6RqudKHS2RMDB1N5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735324319; c=relaxed/simple;
	bh=zBviSLS9kQ/mVfxhHrN0UYzdLgDlBknZGPuabwGuqt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTY+eblUOmNSac0GsX+xiGQoTATwfNDOm9X8rQVR+xVS5qy05f+fcJ26vusfVh0IKKNbRjm7qzcYU8eff8tKHmrBOjJPAU5X9G1unou1+ujnklDomNhsAg4pAg3pMqGtCYlqUFq0RbjyFazMYF+cQS54gPahRtAySY7GbzPLPT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JlR/IeFf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 777E1203EC3F;
	Fri, 27 Dec 2024 10:31:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 777E1203EC3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735324317;
	bh=ciyKd7rGPt5CsHeucplU1xQpzjYtFfnwDF7tcKA0qZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlR/IeFfzQvscg53Mtf1iQLxmzWMfW+YkW76C/jz/uUiHlyJcc+SwiEqcDvzmjXES
	 RAVyoAGzHgLxfrpbkp2S28Uydtq6Lw6PIOKrvSFzAuzoIavQ47ZlGIhx4d0zopaxAG
	 uRMRYquRTln4+vSln4U9qutBaKgtIh3PFP7PkBpw=
From: Roman Kisel <romank@linux.microsoft.com>
To: hpa@zytor.com,
	kys@microsoft.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	eahariha@linux.microsoft.com,
	haiyangz@microsoft.com,
	mingo@redhat.com,
	mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com,
	tglx@linutronix.de,
	tiala@microsoft.com,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v4 4/5] hyperv: Do not overlap the hvcall IO areas in get_vtl()
Date: Fri, 27 Dec 2024 10:31:54 -0800
Message-Id: <20241227183155.122827-5-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227183155.122827-1-romank@linux.microsoft.com>
References: <20241227183155.122827-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
disallows overlapping of the input and output hypercall areas, and
get_vtl(void) does overlap them.

Use the output hypercall page of the current vCPU for the hypercall.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs

Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f82d1aefaa8a..173005e6a95d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
 
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = (struct hv_output_get_vp_registers *)input;
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
 
 	memset(input, 0, struct_size(input, names, 1));
 	input->partition_id = HV_PARTITION_ID_SELF;
-- 
2.34.1


