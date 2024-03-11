Return-Path: <linux-hyperv+bounces-1709-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B638784C4
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 17:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A8C28465F
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F00F4EB23;
	Mon, 11 Mar 2024 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elzEZk7Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A24207B;
	Mon, 11 Mar 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173791; cv=none; b=lxXVK2Xr+Iet9pY6Z9WaTV7LbHcMBvQzIATiaq/+zShMNfrg3Xb0zEvuwWYWt436x0lqGhkXSQFNmJvMOuSi7UcE3l8ieSxv4QDEOy4AHJT9+J/+kGSHCgu8XHXQbPlEvbVf1p2akmerbOVyG5sdKfOVhQ6wa1yF6zM7zudlxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173791; c=relaxed/simple;
	bh=stJGWSegiQhc7Ody3a64Zh+xIaryAD6Z92WIxHEheKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9Lax0k0qE0422BA0Z9iME4mRszAYDG4Om78YFsXjEzR2Uh970zA18W0YTSErx/t0m3JSo65kQY8t02Ereo2OGUrhvVPdG6JSudlYgQDUuRs+3xqjPrNAhGQajt6uaYcZ88nsLPRCDer/Z+5Y9avdFjPJTRR8PEacB2Q2bisVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elzEZk7Y; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso3250921b3a.1;
        Mon, 11 Mar 2024 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173789; x=1710778589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NIwRgw8kRdMYFrUfI8kD4ryRzVUpHboxNK6cHHvDbvA=;
        b=elzEZk7YxSPtFSSO/0CnH8PZMyRaFmF88vb81M1Ri24jMq0s+DmfGc9LGhYUEOt9hn
         fUa1QSzJYR12jWbC+emTB1yX0SW7Hp6UPNsGviscHdOXOUYo4UhxLilZJOR2oh8t0Bsz
         GJbs9FK7RgbGeZLqXfRHveFXnz8loE56gVSMRzaxMY7FoE5D8eObyUH+6W8FVPgmER+s
         nGLvASnIno/DffmVpuzrN9sUTm2c9c59PW+WRUvRnGhjZiMEkKerLnFISvpLwTTAUf77
         FFsaRdsfWXDq3JEfA+yy7ws5Mttkw7OXjX010mvAOoP2IZ7T3s9zPwORgUSEVi5z3gC8
         0RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173789; x=1710778589;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIwRgw8kRdMYFrUfI8kD4ryRzVUpHboxNK6cHHvDbvA=;
        b=GoImruHRHgJCNTRo9pM8Y4bsHmrd/NGlo3JMNNkvQwVc4pg/dG7NV9zxGwpT8zzimF
         LByfyoyc52HmpV/LeCOvoyVBt+t5wOYtqLcvH84tzPyN3aPu/z6QiSW/hG9HiL/6Q3yQ
         eUZOswnSvzRj7iC2yecqDwNXBsS1hU4Pa/kiMEh7mAVjMII5/8nOgXayqc9dgC8o3yas
         NwCNKTIM0Kdw05Ne2ym4Y13aiz0U7wf7aUljH5nyWccm7xlpL2kQVt6EAt/fOgeAgd+G
         yRuccngwWk8v/TprdDf4bhq50UgTgbTCel1miEDWI+V8cSsJPzlS684OUHNsQUwlteaP
         ZBfg==
X-Forwarded-Encrypted: i=1; AJvYcCUd7FGchRZ6sNEFMBjxzL5B7EmFFDJvQ1Tv5IVqRkj5PyWZNkdo9vUkFmIJoH6BKHoXCEs8E/bYpddRZtEVXJvaJ96qh9uaFHS+FJLQ+ZQh+vuyXB83LGfBTr/kSuG2X6lT/9Uk7ccKUKtkY+I97Law/dC5I7DnPmj+iOVcBE1h+lE1
X-Gm-Message-State: AOJu0YytdNDCwb/j9Jdd1ApUhUID1+2nglZ6sljrGzlMqKy4IxCIXmZ5
	+Yf9FAXWrHOdCX5451hrMxvwd7eeMCjD6+w/JpBU2r1MVXNeRCtU
X-Google-Smtp-Source: AGHT+IHJXkyc8/rW8os/YonzW2lIIoxEg+dw8CwCQc3gKfPn2zBsjIBZ5quHxjxhCcbXMpD+u4DtBg==
X-Received: by 2002:a05:6a21:6da2:b0:1a1:4fce:8ee1 with SMTP id wl34-20020a056a216da200b001a14fce8ee1mr8357364pzb.8.1710173788984;
        Mon, 11 Mar 2024 09:16:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id m22-20020a056a00081600b006e52ce4ee2fsm4576325pfk.20.2024.03.11.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:16:28 -0700 (PDT)
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
Subject: [PATCH v2 4/5] uio_hv_generic: Don't free decrypted memory
Date: Mon, 11 Mar 2024 09:15:57 -0700
Message-Id: <20240311161558.1310-5-mhklinux@outlook.com>
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

The VMBus device UIO driver could free decrypted/shared pages if
set_memory_decrypted() fails. Check the decrypted field in the gpadl
to decide whether to free the memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/uio/uio_hv_generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 20d9762331bd..6be3462b109f 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -181,12 +181,14 @@ hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
 {
 	if (pdata->send_gpadl.gpadl_handle) {
 		vmbus_teardown_gpadl(dev->channel, &pdata->send_gpadl);
-		vfree(pdata->send_buf);
+		if (!pdata->send_gpadl.decrypted)
+			vfree(pdata->send_buf);
 	}
 
 	if (pdata->recv_gpadl.gpadl_handle) {
 		vmbus_teardown_gpadl(dev->channel, &pdata->recv_gpadl);
-		vfree(pdata->recv_buf);
+		if (!pdata->recv_gpadl.decrypted)
+			vfree(pdata->recv_buf);
 	}
 }
 
@@ -295,7 +297,8 @@ hv_uio_probe(struct hv_device *dev,
 	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
 				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
 	if (ret) {
-		vfree(pdata->recv_buf);
+		if (!pdata->recv_gpadl.decrypted)
+			vfree(pdata->recv_buf);
 		goto fail_close;
 	}
 
@@ -317,7 +320,8 @@ hv_uio_probe(struct hv_device *dev,
 	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
 				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
 	if (ret) {
-		vfree(pdata->send_buf);
+		if (!pdata->send_gpadl.decrypted)
+			vfree(pdata->send_buf);
 		goto fail_close;
 	}
 
-- 
2.25.1


