Return-Path: <linux-hyperv+bounces-1708-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2148784C0
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 17:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3281F223EF
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4144D13F;
	Mon, 11 Mar 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZctwDME"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6561482F6;
	Mon, 11 Mar 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173790; cv=none; b=lL4jE6/6A5ORoWFEpHq2cfNcz2CJd9Nzwk7rNXpgHkIntf14Ls4x5xSUH3oWzpeFqkyOTGPr2BankSgwSACvh2zbMwGnwiAwPZjbqPqY6bQ2im407+BYLnpEqAmvMJRcM+JeQnJzznpLipUwQVSyyQplEzshBBkR3ZgpzUCs2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173790; c=relaxed/simple;
	bh=+2KIvQZzubEuGFm8VhvXKT8vwofQa29dh7mcoeFR1GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDXIzi9wnvpQq4U+VNKtBFthDWmQ2VXuCpP27+1HPm6Y0LegoJiczs3MT3KN84a1nh6yryoC58q/Iuft3uwsMT4NngkkyBTsuXht5V1cXUqjWlh1gq5N/xpld6earjaKyyHZ/EnFKs2FttAU4y+cUwGiehnS6bHyMwGAmvPTRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZctwDME; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da202aa138so2910015b3a.2;
        Mon, 11 Mar 2024 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173788; x=1710778588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kId0KpnR3Bb1OkqKYK5w5Z53gK8zkbuePvbtyjE183w=;
        b=IZctwDMElFynF6ZzvF1tlJtCgi0BarWW0TnQvRjKa6Ju2H0ObP5+4uCf0uNS5jTQVP
         +Ajue+hCdc29GaXunurtZxqIgWjxyQWZqxOnetxGO0obce6DPcgUTHHI8jau66TU4eYZ
         +1Vy0qj0+IYXwV+lDwdIS4sPHzIxiNlh/socppc1mcxcdBhPyzOsynslelSwPeWLy/cg
         j0c77Z3NFrHUH8JPmZeGDS7R/g/z/QRIZQg+9+hLnX6a0FQE4FrS7NXE03b+tj7bBjly
         XMtAXrpL1crhO/pAg/BS70/kRoDEP55Xh8CKMYcC2ivQgAbb46XN2hqjvj/48HG1oSVY
         eSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173788; x=1710778588;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kId0KpnR3Bb1OkqKYK5w5Z53gK8zkbuePvbtyjE183w=;
        b=Ct8QPCtfnATIcBCQQoaaaGJJDenuNDuxwUxfBvnBgWnTG+xO6EOa0T9HImrNcxlm9e
         I7VsI8eCJSxdMRowrgS3FDYlSMNWwVnk50PxjSBuDO9KmQ0jHVsl3Yqsgp29F1r91KyX
         6j8LaSGE5+RExS7+DdCYF3/YKJjqHD/vGD0R8jvbtgr6UG/PwL4/YXFyYpYIL/52tDoF
         CeyJqQoTZwtscCoYRdMg0FFEMPidW7F2BRXL9TbSqm025U0a68Jlh++teSxmPvHK69BE
         wWshzewckUeH0j2XOwwYflR3MW3KkiNjHedLbpUFVRx8ECCtKKueP2lKQChYzSwm7hUT
         NH8w==
X-Forwarded-Encrypted: i=1; AJvYcCXj8DLxf1el++z7TwkFf2QjTGRqIWZi8ZLwarDw4dqlaJmmC2kywK+YhF2U8TNln+ECybXL/6/jUaTmkoK9JmOR+CoS4igJ1/FWY0/VheEyNG0ya/82ft0Q4gn8N36EwNzhSx1gIKo27uT3dD0ul97QtJKUM3m8aDeLOKqWL6DgY7ps
X-Gm-Message-State: AOJu0YzZZIZ7p9x+8iANGwQUb6epdfqu23I15qc5oy4Ub90qr9+FFzjL
	CJwggD43r7CJ6niECUmVYlBH4m3UUDJXo5qoNIPhAP3OoXMnNd+U
X-Google-Smtp-Source: AGHT+IFXwmvMu8mIEtQPLNF4LE9yE+Q2fMuFXOwJM8gp5UVU39VY1u8SaVJxQRqEQgy8EyINe4adPw==
X-Received: by 2002:a05:6a20:3d01:b0:1a3:1129:9b2 with SMTP id y1-20020a056a203d0100b001a3112909b2mr6139316pzi.46.1710173788046;
        Mon, 11 Mar 2024 09:16:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id m22-20020a056a00081600b006e52ce4ee2fsm4576325pfk.20.2024.03.11.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:16:27 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: rick.p.edgecombe@intel.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	elena.reshetova@intel.com
Subject: [PATCH v2 3/5] hv_netvsc: Don't free decrypted memory
Date: Mon, 11 Mar 2024 09:15:56 -0700
Message-Id: <20240311161558.1310-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311161558.1310-1-mhklinux@outlook.com>
References: <20240311161558.1310-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

The netvsc driver could free decrypted/shared pages if
set_memory_decrypted() fails. Check the decrypted field in the gpadl
to decide whether to free the memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/netvsc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 82e9796c8f5e..70b7f91fb96b 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -154,8 +154,11 @@ static void free_netvsc_device(struct rcu_head *head)
 	int i;
 
 	kfree(nvdev->extension);
-	vfree(nvdev->recv_buf);
-	vfree(nvdev->send_buf);
+
+	if (!nvdev->recv_buf_gpadl_handle.decrypted)
+		vfree(nvdev->recv_buf);
+	if (!nvdev->send_buf_gpadl_handle.decrypted)
+		vfree(nvdev->send_buf);
 	bitmap_free(nvdev->send_section_map);
 
 	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {
-- 
2.25.1


