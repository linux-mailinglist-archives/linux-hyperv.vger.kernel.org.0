Return-Path: <linux-hyperv+bounces-9620-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNGcFuhdvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9620-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:34:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AAC2D2398
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91F2830BCA30
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE64035B2;
	Thu, 19 Mar 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZEEOcey"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43694402437
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951972; cv=none; b=NzOaPmLYqnGUcBURm9p8SylVP20RG1UBNnoPZi3zBzljyqTZ8zX2oyyRAAUTgRAYivxep5qb+CPZShsNs4wDsNkQWoBylsRfwYaBLV0JeVuFyJ1rT0ChRvWSAbILx1pxSTLwOtt8D1ooNfXPYBKUDmbJb7UJ7vWqXIj4HM6eU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951972; c=relaxed/simple;
	bh=BmylmSxYXC5N3jk9/TNR/sEYojyD8Hf/GASHP6Q5wi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyeOyz6CfDmh6Ek6cVz/9qw2kJnnE1BUqAxHecgn3PuoE3fNi9y6AV6xy+4dVjPLWlpv6rs63JsaZ2mSDomjLieeD8E+xy6AdTKEqJ6rrCtyhOy79VCZOI9+NBbis6f7TnOXUJF+J6WKePHhqoz/P1/TntP4wAtWLJFs13e29a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZEEOcey; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso1003315f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951967; x=1774556767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVfSYosL52eK3asK6+0i4KG7DrtDbq3VH+01ZAcM9Cc=;
        b=CZEEOceyiLZBbBuf/kEqJfwRt8jE3+7L1VXL7ms5gdFNa78C67P3GW3usJEd32PP2G
         2ORY3yHlD/JbJp+ud1CVWU4AxP5q869MvEfXK7V55uoMR3obGfSjAWRxnLwTANEcZgPM
         VSpDzUTDnuJDYS3thKbeRShH6ztQlmsPb1IYfvNzbvqLl3kdnyp9/TEcoj7vFT0mQGeg
         GdnfbXxwwjSP4whLMYcRvze9Jzkk2PAdwpPmp7tCpvNOve/JjjKHGsXb8nA3G83ZNMid
         4rBntbxU9cmUjJ0GcGkpIrnlXbw0exYWz9YLjuU4MAmmDS7Qjx9dLzuvqAqTm+uq2sHh
         kQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951967; x=1774556767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kVfSYosL52eK3asK6+0i4KG7DrtDbq3VH+01ZAcM9Cc=;
        b=K5qyWzyVMRUHSPhBEFk9MDU2KwNESeXZBZ0f0GjK0uykDo4ZypXsL57Vs6xSmp75ke
         Rxc0TEo5G17Rcmr+MKy3hSnZFt8puGE+HMYXwN5FCO6km5vkG3ffLIveJ3ZfJNDs5Apv
         kv3ApO+j/GsiLDwAUfyD143/ddv3tzJfEIxRIb7OU1YOeOAdGbNSvawSDtOZC7YBy4rg
         Fs0g3XNtFHjP9F0gABtW9PXq1BldzUHewLgSpOW21jBGwMO1xH94JIeq3PelSllQADYt
         sZFpWiNnZl2Udzaf6fnFMY4avPCDDruLOhmjrXfK2BFint9bwHTUgHGEIDtW5mnzKLs8
         SbAQ==
X-Gm-Message-State: AOJu0Yzxw2t8RSfBvQouWraqYkwgchy69D0fGGkxMwsIS+KbzIxESRqP
	HX62R/zmPTn/ZahvCaEo2Q+cnBVSpnrbGBSYPf5yJ0r7Avrhrz89JVXLe+M8Wb0nOxk=
X-Gm-Gg: ATEYQzy3SPuIrlO66BW2eDADQzWgoQdyEVE2UCMM8ojA0YCnqtQ/T6V/O72piXb5af7
	clL40PjW7mmy3TT4IPMGAuCJWNeuwieHWMaIbhW0durVjrIIVQrT/iyWf15E6EeO/IcVwtkFQnP
	25uhzrFV0zxuOm1UkjTErOqLmxHfwPliPUGvSUNr7WmK7d/kvnltqxM9EvZW5pLREp8/+5R/Phg
	gwvO8tFCuU9k2v9Yvbexo+Dip3JzLSoEE/is4Xuq8gtpqKjvDkhmAvU4CBLuGAAnmcgBPw+3Rav
	vHW3JIxB2EodsOrvomClgpO0rmtkLLIllOAsVAJQPXlz5EoRGdpmnVrR2Z7D1ywd5JE/r9AKPna
	3RIKogAsYY1/SdPFbA4/NLXDyKwzFZPXLQpm2UgKrCdzDC1lCTDMbn/HDerkLVMqr9DRaXBuHY7
	UeGkjiQeeMEPxv3ufo8HysGPmkMsEi3e5u796b8JvbBLH0t5c5
X-Received: by 2002:a5d:5f54:0:b0:43b:3d4f:e17a with SMTP id ffacd0b85a97d-43b6426d59emr1246871f8f.37.1773951967410;
        Thu, 19 Mar 2026 13:26:07 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:07 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 48/55] drivers: hv: dxgkrnl: Add support for locking a shared allocation by not the owner
Date: Thu, 19 Mar 2026 20:25:02 +0000
Message-ID: <20260319202509.63802-49-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9620-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: E8AAC2D2398
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

WDDM has a restriction that an allocation of a shared resource can be
locked for CPU access only by the resource creator (the owner). This
restriction is removed for system memory only allocations. This change
adds support for this feature.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  4 ++--
 drivers/hv/dxgkrnl/dxgkrnl.h    | 13 ++++++++++++-
 drivers/hv/dxgkrnl/ioctl.c      | 25 +++++++++++++++++--------
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index b8ae8099847b..cf946e476411 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -559,8 +559,8 @@ void dxgsharedresource_destroy(struct kref *refcount)
 		vfree(resource->runtime_private_data);
 	if (resource->resource_private_data)
 		vfree(resource->resource_private_data);
-	if (resource->alloc_private_data_sizes)
-		vfree(resource->alloc_private_data_sizes);
+	if (resource->alloc_info)
+		vfree(resource->alloc_info);
 	if (resource->alloc_private_data)
 		vfree(resource->alloc_private_data);
 	kfree(resource);
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index a4d0c504668b..d816a875d5ab 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -613,6 +613,17 @@ struct dxghwqueue *dxghwqueue_create(struct dxgcontext *ctx);
 void dxghwqueue_destroy(struct dxgprocess *pr, struct dxghwqueue *hq);
 void dxghwqueue_release(struct kref *refcount);
 
+/*
+ * When a shared resource is created this structure provides information
+ * about every allocation in the resource. It is used when someone opens the
+ * resource and locks its allocation.
+ */
+struct dxgsharedallocdata {
+	u32	private_data_size;	/* Size of private data */
+	u32	num_pages;	/* Allocation size in pages */
+	bool	cached;		/* True is the alloc memory is cached */
+};
+
 /*
  * A shared resource object is created to track the list of dxgresource objects,
  * which are opened for the same underlying shared resource.
@@ -658,7 +669,7 @@ struct dxgsharedresource {
 		};
 		long		flags;
 	};
-	u32			*alloc_private_data_sizes;
+	struct dxgsharedallocdata *alloc_info;
 	u8			*alloc_private_data;
 	u8			*runtime_private_data;
 	u8			*resource_private_data;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index d91af2e176e9..f8f116a7f87f 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -369,6 +369,7 @@ static int dxgsharedresource_seal(struct dxgsharedresource *shared_resource)
 	u32 data_size;
 	struct dxgresource *resource;
 	struct dxgallocation *alloc;
+	struct dxgsharedallocdata *alloc_info;
 
 	DXG_TRACE("Sealing resource: %p", shared_resource);
 
@@ -409,9 +410,10 @@ static int dxgsharedresource_seal(struct dxgsharedresource *shared_resource)
 			ret = -EINVAL;
 			goto cleanup1;
 		}
-		shared_resource->alloc_private_data_sizes =
-			vzalloc(sizeof(u32)*shared_resource->allocation_count);
-		if (shared_resource->alloc_private_data_sizes == NULL) {
+		shared_resource->alloc_info =
+			vzalloc(sizeof(struct dxgsharedallocdata) *
+				shared_resource->allocation_count);
+		if (shared_resource->alloc_info == NULL) {
 			ret = -EINVAL;
 			goto cleanup1;
 		}
@@ -429,8 +431,10 @@ static int dxgsharedresource_seal(struct dxgsharedresource *shared_resource)
 					ret = -EINVAL;
 					goto cleanup1;
 				}
-				shared_resource->alloc_private_data_sizes[i] =
-				    alloc_data_size;
+				alloc_info = &shared_resource->alloc_info[i];
+				alloc_info->private_data_size = alloc_data_size;
+				alloc_info->num_pages = alloc->num_pages;
+				alloc_info->cached = alloc->cached;
 				memcpy(private_data,
 				       alloc->priv_drv_data->data,
 				       alloc_data_size);
@@ -5031,6 +5035,7 @@ assign_resource_handles(struct dxgprocess *process,
 	u8 *cur_priv_data;
 	u32 total_priv_data_size = 0;
 	struct d3dddi_openallocationinfo2 open_alloc_info = { };
+	struct dxgsharedallocdata *alloc_info;
 
 	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
 	ret = hmgrtable_assign_handle(&process->handle_table, resource,
@@ -5050,11 +5055,15 @@ assign_resource_handles(struct dxgprocess *process,
 		allocs[i]->alloc_handle = handles[i];
 		allocs[i]->handle_valid = 1;
 		open_alloc_info.allocation = handles[i];
-		if (shared_resource->alloc_private_data_sizes)
+		if (shared_resource->alloc_info) {
+			alloc_info = &shared_resource->alloc_info[i];
 			open_alloc_info.priv_drv_data_size =
-			    shared_resource->alloc_private_data_sizes[i];
-		else
+			    alloc_info->private_data_size;
+			allocs[i]->num_pages = alloc_info->num_pages;
+			allocs[i]->cached  = alloc_info->cached;
+		} else {
 			open_alloc_info.priv_drv_data_size = 0;
+		}
 
 		total_priv_data_size += open_alloc_info.priv_drv_data_size;
 		open_alloc_info.priv_drv_data = cur_priv_data;

