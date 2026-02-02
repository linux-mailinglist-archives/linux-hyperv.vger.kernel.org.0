Return-Path: <linux-hyperv+bounces-8641-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PtFOoPVgGmFBwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8641-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:49:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE9CF24F
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B7963004CB6
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7E537F729;
	Mon,  2 Feb 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpoM0kp4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D336D503
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Feb 2026 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050925; cv=none; b=S3L+F8W7WgajQ15CJSGqK1QB+l/Gtn80mZ+DFNWVoMAN2qMaQQb4WPohoSMeg1fmRkZOLjAnFoLGIl5L16u70zxWpoSHEIB9AESQeLyWkQWuHd6UVXARCPwaI4cb2V/G/L3ZzDRKt5poHi1yl4oUWHAW6a5bWlgKt7Z4I7ksKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050925; c=relaxed/simple;
	bh=YZpYzr3von3OP0WHTI8MlCB59T1dhP/Et0EJVS7EqYo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tC+bgX2rp7rjuDteNNvEBxlhrr18j0VZ8B4a24RM5U7peFGxgd7yOT1LdRth8vJRMtL3mHlhWrDZzDZ9wsCIp307zzHeLOY/FHBtS5egh8F16ss5OiPwzXAt4GflNVEUMgSL27467AgtFTxZ8ZJQjvkhtLCsn/ve1Jq6WR31Aoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpoM0kp4; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-82318702afbso3925608b3a.1
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Feb 2026 08:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770050923; x=1770655723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSkt8Z+PMTqFG74uJb+GYoFmGk1VZAsFykf4JCeNoR4=;
        b=KpoM0kp4L2x0/jhbTtezO7CtHor2I9lvhk3HdeTJLxbNVINTnGuhY1X7AKhTY18Dg5
         i/YopGfhRHapiw9qVLopUIqz/HDPAaR1AUS5JhKtCYCIaj1FH8h6mq+AdeXNfxBNE+JX
         TouwRSodTdDbK5rN3b1RJd76xCfqcA3CASlSF9Fv+AzRWIGy8FkMA3vQfygRlWoxBpVx
         boU9ljfxW1OIbhX+CjZFpX2MB38AOM2fejUpAYWm7erRbcWqWzI2TJ5zcvuJqZFQE7EC
         qp2J0w81mrQzNY0NVxcAdMRff70d94kA+dMifR6wFo//8G7N8pOjUQB4DcZX4YHY+nCO
         j+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050923; x=1770655723;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSkt8Z+PMTqFG74uJb+GYoFmGk1VZAsFykf4JCeNoR4=;
        b=MQp4kXu+KCj0+k6CSSU22GY15leu5mgtKjPyl20nX77wIfYcyDlco/v2FLmgsnpuva
         hGTV6SZy4wZT7bTdDuBwvbtXH90FB8vkVMW1knDy+gYQ/WNgjLQQlBBqiYmPoiOPiLTk
         TzukwvvpqfAJK4xFY4tEv3LY0Yyjep2HhWr9VgOxPB1/ppjvLPd4sbS2OGeoVgwYL2tG
         jgALLxALrUuDoDqEpHSPqiYnApN2HftHUtVmDlF0/lQzGHV1o7bPptj10rspV7JOcGGX
         wcm2gI8o8bLWbMmz8t1c87BhnqiMYW3dDT1Wlp7mc6C8imgYpKfE+5eU1La5EGNkStfv
         q+1g==
X-Forwarded-Encrypted: i=1; AJvYcCVF3Xjk0MceZf+IJIJ9uUhRv2vsjjj4FYqU9F1XbfD+Ajcol3R/yCYlNZ0Fh7WkXrxSFMUJdteDhgpXPFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLThf5pp3MGY6AhN2c4B/q7k8WQMTHT/p8WAcwP2tWW9UuR0i
	ZGAPzE8AbgdzNWt+zFJd/pLo0jEB+GQ/4JbiOF1HaVsUvgEImqqDcIdE
X-Gm-Gg: AZuq6aJMBHzLlJDi4/F0MSc6Vgwza9Rc8yO5c79+70BbvjNYWon/4fmienLmhSqLJn2
	bVoobau4GAoL9eSs3mqJVw4+rm9DKD4jbdPReRIjvziYRe7RMDPh7YCEFDVljUusueGLthBbrex
	nCGXTxGm+Fb8QKMhHAfNJOYho5l/dTN68MWtE9JqN8TeqQ3hnW/HM4wfL5WQjQKCIwhU3HJaeDf
	7BPP4ze/UtVghcm7HILAWjKzUrwvaWiyOtINl67KqpZw27+D1deREOptc/YwSJQgfAbbnr16gEM
	PxUJ31oLrf5fuplebtFCrNfCoU5XGVoE8afhTW7FCnP9W1sEZ4UjBfL2XJurqRWoKdBsiI8767f
	zlCflSb65xGa5oRzcU6KqtK4tApGM9Rqw3bjTRIaonZxUgWmhUEJQRJgC/yJHTFae8poXKsBIFN
	PMhnjovnxxnCEVt5+L7UVJK5PZ2ThR5DGFwuAb+gHWQ2htBPvLnnhK5xE9zGPcrtHugQ==
X-Received: by 2002:a05:6a21:6f89:b0:35e:5a46:2d6b with SMTP id adf61e73a8af0-392dfff5a20mr12436011637.8.1770050923485;
        Mon, 02 Feb 2026 08:48:43 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3356a6sm15737502a12.18.2026.02.02.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:48:43 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/hyperv: Update comment in hyperv_cleanup()
Date: Mon,  2 Feb 2026 08:48:39 -0800
Message-Id: <20260202164839.1691-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM_DOM(3.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8641-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhkelley58@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:replyto,outlook.com:email,outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18EE9CF24F
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com>

The comment in hyperv_cleanup() became out-of-date as a result of
commit c8ed0812646e ("x86/hyperv: Use direct call to hypercall-page").

Update the comment. No code or functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_init.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 14de43f4bc6c..a777e43a5de1 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -633,9 +633,13 @@ void hyperv_cleanup(void)
 	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 
 	/*
-	 * Reset hypercall page reference before reset the page,
-	 * let hypercall operations fail safely rather than
-	 * panic the kernel for using invalid hypercall page
+	 * Reset hv_hypercall_pg before resetting it in the hypervisor.
+	 * hv_set_hypercall_pg(NULL) is not used because at this point in the
+	 * panic path other CPUs have been stopped, causing static_call_update()
+	 * to hang. So resetting hv_hypercall_pg to cause hypercalls to fail
+	 * cleanly is only operative on 32-bit builds. But this is OK as it is
+	 * just a preventative measure to ease detecting a hypercall being made
+	 * after this point, which shouldn't be happening anyway.
 	 */
 	hv_hypercall_pg = NULL;
 
-- 
2.25.1


