Return-Path: <linux-hyperv+bounces-1710-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D928784C7
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 17:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE61282209
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9A51C23;
	Mon, 11 Mar 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkbp4KIk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F073AC01;
	Mon, 11 Mar 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173792; cv=none; b=PRe+bg422+GbOin8bSBzX7AphefWK6naJpVUnbo/btwhYifwQuVFFBL9qAJQH3TjE1XFNUzz0n9041JeVl5YFtCWaOm8gyX7ocnLge/pYhJq6n7+DtZTCGHnGhLwRMU6AALThOUf1JXRh8b5Waohy5U2aRRnDCA5Pqx3N5emIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173792; c=relaxed/simple;
	bh=NygHFgsfK9/f07Xn51o7Jdn2t0u6vgatLn5MNtO4zD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPky9wFWTPMyZJBSmu+vNeyf+Jd1tN1+uZvXj/uwn9xANNek9aXkGytLIjNDm8+iTuYUMau129JHSvDfnm8tnIkSYh2Eicb/5GbkpD6XEQqx/qF1/jJTM2dgg2+GJoSQxOFftN0yJ/HorlFBfhn0lsJzSkFENr8L1lfFW9F4G8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vkbp4KIk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e5c0be115aso2957299b3a.3;
        Mon, 11 Mar 2024 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173790; x=1710778590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wigfq/6aRq72xOj/aIlxvJ6fFfc6HnyBCglftePM4e4=;
        b=Vkbp4KIkBADE3+iAjfcgU4BTgvmKzl4WPEixmExZlMIo9VncixUW9ApacJCeiHnmyX
         Wqqju846KUQ7zlWTb5OdmWDm6Q6kIee9E78WCXj2m8aoWIm0rgtWRANx55x9jag0z8lv
         Gjip16FD6UkBC1iavnE9v2Jt55auExDhCC8oMuS4z7A5DdsngN/54MBfCFdY6hb8b6Bf
         1Aby54HmxHeaAJfhnXHQVpHVYCldNNR0GOAUF261iIBEI6p1jF9+PTJa3HC/9XGhQneR
         XQGHncZyxVOyU50MQFcbiL/UgWQkuQ6XB3tfs8wKcd0kHD+bnxkX8tCbH/bOKR1NhPWy
         84+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173790; x=1710778590;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wigfq/6aRq72xOj/aIlxvJ6fFfc6HnyBCglftePM4e4=;
        b=W9G2ZE2NPikrO+dP+w3QKfEBi7jxLRRSLTIYSjQt2Tq1jNL/NGddFwefhDfoJQOf43
         WrvrMbc/Gf1KQN2EeDzcYPJW6XpsXaJjQAIfteYvZwz5YUiIDukcwpC++0F14LF3eWFK
         X3bgftMOmaHEf6lBQtSIY6ymCa8cjRlYMJ5v2f9Y8DSj4XGxJM2ICjbcHyyCsMzdn18y
         2IDVQaHGrGiclIl3SiZKdi19GG2Qkn0FgKlSQZCj/kp/zj82BlD/HTVfOywbHMg3bpQA
         FAarxh5o+ZY7oKiOkMeLANflHxTAbARmnWbzpjJ6A2IbXNWpkJwxCWlolLIyRwWYRWM6
         M3BA==
X-Forwarded-Encrypted: i=1; AJvYcCX3pOYpBSvagUfvjJ6pN+IL+JhqOynySDj2s8SHU96dtWyirBPyTDt1JXXYt9Tcmf8OLMWJb5oa3tdti0c1ECq7PJQ3pWxTbogwEcHmtd2mgYL98JwmflhIDYQJNqeQbKjL72J+rIA5A7znSp00rUE7+dWnVowfzjLt4I+xxKNmmjrj
X-Gm-Message-State: AOJu0Yz6Awex5O/zcfxVneC12tjcjhLHCuW7sbtPdkHEd4Qu4ClOGf+M
	xjbmNXukf2ytXdJoDAZ32f+1K0ETsC3fhIrfQY/R5uPUXRwn4Epp
X-Google-Smtp-Source: AGHT+IGYeEcPUzCbQFJrHGPuOeb50x9Z9GqcTz5epYFi2KgNUbGR2sGlA+8oJcaOvFdPFMhABQHcYQ==
X-Received: by 2002:a05:6a20:3d87:b0:1a1:4848:98af with SMTP id s7-20020a056a203d8700b001a1484898afmr5407838pzi.1.1710173789816;
        Mon, 11 Mar 2024 09:16:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id m22-20020a056a00081600b006e52ce4ee2fsm4576325pfk.20.2024.03.11.09.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:16:29 -0700 (PDT)
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
Subject: [PATCH v2 5/5] Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encrypted
Date: Mon, 11 Mar 2024 09:15:58 -0700
Message-Id: <20240311161558.1310-6-mhklinux@outlook.com>
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

From: Michael Kelley <mhklinux@outlook.com>

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

The VMBus ring buffer code could free decrypted/shared pages if
set_memory_decrypted() fails. Check the decrypted field in the struct
vmbus_gpadl for the ring buffers to decide whether to free the memory.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index bb5abdcda18f..47e1bd8de9fc 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -153,7 +153,9 @@ void vmbus_free_ring(struct vmbus_channel *channel)
 	hv_ringbuffer_cleanup(&channel->inbound);
 
 	if (channel->ringbuffer_page) {
-		__free_pages(channel->ringbuffer_page,
+		/* In a CoCo VM leak the memory if it didn't get re-encrypted */
+		if (!channel->ringbuffer_gpadlhandle.decrypted)
+			__free_pages(channel->ringbuffer_page,
 			     get_order(channel->ringbuffer_pagecount
 				       << PAGE_SHIFT));
 		channel->ringbuffer_page = NULL;
-- 
2.25.1


