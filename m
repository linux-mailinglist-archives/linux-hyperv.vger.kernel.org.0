Return-Path: <linux-hyperv+bounces-7383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71931C23D47
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 09:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A7B1A261D4
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C22BE646;
	Fri, 31 Oct 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LtKcqfq9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F412C027C;
	Fri, 31 Oct 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899647; cv=none; b=HqYlTLm4Btp5m8CaDdIJyqEbL9xteYYdjGbxWxfx1iWba2gxnIHjYBkcSegG7i+mZJAUoOFUeQlSbP5dOt1UPV6nooxvBNvJNqFqCaUEA43pIDWqUEPkRmdKcwHtdpooJEoP0bHUJLSqT8mo6UijjdmXrz6rvfolhE6BRxzLPYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899647; c=relaxed/simple;
	bh=8fc1CYRuvMV/op3GcqQv0nuYNwMICElMmVKDirrUN1M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sUmEMq60WiU483gFtZL1X0l2YjnZRw1RfCTje9UoMATTbDtDCk0mppccJNDqxBmkWi7Q9GOM/2gxnyJGH3pyDJjVeGlLP9B7rJaPEtwDJqKoDkTJ0vJ4w/RbISKhYUxvAYXrKVyQV/DnkdWtz83ZZE6G/TWlzdtz2cEOeZDpa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LtKcqfq9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761899600; x=1762504400; i=markus.elfring@web.de;
	bh=uPCQ1N0hW4Pf0FulsunW1Gh5gBlwYVXBTnopmQ41LN8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LtKcqfq9t4qF6D3U2YkTFxAh18DgCdUKZs0Rali3J7b74zftTnP0M+J+yPEdIvAW
	 N+IFGsFX33/8uspwMKczMaVOYBskEoavKzDK9FPOZokK4t3b4uNCYKVFpfN/a5FnC
	 NbeXDlGuBJWpUE9A9k56aujJipOxSePFVmBSj1UNndX4qhX5lfhfYljzmGlh0MuF+
	 AJvLbB8VFb4WgsyriwycHSpIeJky1CLlj9x6F23W0T2GRAR0oASC1Cb6eL6BYLN6G
	 PIdF/0hHpHjhvtpRIkjCyn8m9iqJZIp58ZgQwAYO72jClVb5jn+JFqtpioFff5hdL
	 Qmkqc/5Gf80/m1ZkqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqTE-1vghYs0rq2-00KcLo; Fri, 31
 Oct 2025 09:33:20 +0100
Message-ID: <d209991b-5aee-4222-aec3-cb662ccb7433@web.de>
Date: Fri, 31 Oct 2025 09:33:17 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-hyperv@vger.kernel.org, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Long Li <longli@microsoft.com>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] x86/hyperv: Use pointer from memcpy() call for assignment in
 hv_crash_setup_trampdata()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/tLMazNDgoSvgpqPR+hxh+VIwram1duEYbjtVq8uhlqFa3CixEd
 O2lZaaOGdSLZZ3OIN7yTqCLzfrNt9bqHPv1UUpiVMDsphdIWpDjGFDzBccaoK8hUOg2ZAqW
 48Tgq4VIjEtYVGbA1X/oK/bUwEMaE4kEhEU0WQZgHV7Y2+NvSCHYoNxuIKggPjaP10ChGkL
 hPKUtTTL9f3AjZFTG7OWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7l2Av0ufUkQ=;YQR2EaOYvmMmT6qWwOCctdxqUUF
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 31 Oct 2025 09:24:31 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/x86/hyperv/hv_crash.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index c0e22921ace1..745d02066308 100644
=2D-- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -464,9 +464,7 @@ static int hv_crash_setup_trampdata(u64 trampoline_va)
 		return -1;
 	}
=20
-	dest =3D (void *)trampoline_va;
-	memcpy(dest, &hv_crash_asm32, size);
-
+	dest =3D memcpy((void *)trampoline_va, &hv_crash_asm32, size);
 	dest +=3D size;
 	dest =3D (void *)round_up((ulong)dest, 16);
 	tramp =3D (struct hv_crash_tramp_data *)dest;
=2D-=20
2.51.1


