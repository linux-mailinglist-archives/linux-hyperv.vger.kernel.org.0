Return-Path: <linux-hyperv+bounces-9609-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULq7KpFdvGnLxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9609-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:33:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1374B2D2347
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 830183172467
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9A43F99ED;
	Thu, 19 Mar 2026 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOjZCh+2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7193FEB06
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951962; cv=none; b=Ju3RPqet7HZP4EYUQebVdpv1rvXRXHqD8Ct2ZuFHqUrYjPgsZ+cQ7TiJhH3q3Hnp0kqj6ecb/zu3xQb0p99CPWIx3NfaVRSNzBa9cJ4GA7LlzuqsGo/nT5lqY892tatwgkQETW+OrJZeuMAPf/dCAjCeMMUywqyVvD/CjRUObzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951962; c=relaxed/simple;
	bh=DuJ8GPWtRYe59JyQ0xpsGX/NM7LsTLaRAKg6Jd0tfj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2Hn5vQw9OfeiztzG3fiy1ZL5oDU87Y+4E6uJ5RuvthWL7+Mbf6bOLqRykUVdYRTUJbHQM6FSZegP93d9mepaTaKqdsVY9pai+Wc13giPQC1OOMt6/jE/V5QI/wTquIiioc4uJHnQW+ntKelWRszCFn4Kre9zba5OKXKEfHAObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOjZCh+2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b2965d4bso1015508f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951957; x=1774556757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5xlpp3seHS2jHJVmRJ+q5QD0+MRQpYSw44Wf7oGTOI=;
        b=eOjZCh+2K+msWjeGh2booTgTbAHpUkkfPbRIy81aoWIWDkcjzFhDzkhFfQOY26nckt
         XQxiwSRYfcOyus2c5/8uVxCQWgX69MJCr1GVXWU4gjJZMDHt+UqD4vNCgllyp8GmPlAX
         cI6i07L/okZky9hpemkoc3whHNw2T8eCMw2P2hxVaA6j+3wphKVTVJlFLoDBrioWP3MG
         blXrUA7A0HKul6NPYHLlBLKbgQqJYYgghhjunA3jZ4jL9LM2M+06suHGQLe3x61r8GY7
         pMknyYSD8Uc/UhrFr9Mhs9KU49S054++ozRnGkLdVewYCjN37RF7+ArNo9NwRifnfuK5
         4yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951957; x=1774556757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5xlpp3seHS2jHJVmRJ+q5QD0+MRQpYSw44Wf7oGTOI=;
        b=MAwgyio4kgqq2yp+5Yc1Boo53X3UZTFZB5z+faC+Mk1CXzRuVNdlyeWV1tF4U9AxZ5
         h8M7/qw+yoAklH8y1eBh3BQEJ9ivH2cT1BROpWhOXIMwcF1Lx7N6RvZPghkyTgFyH87s
         kDY7n4ASiNUKA6baK1gzXpoRcqInhm6NPYnt9PhVrD7TAPcZZP1iwR+KHoSEcZ5WANrg
         ha38ekEP3Qjh2NCcEFR7knweddr9O6zOniIdu0Xd6Uz47Sf5ed3QVtX3kOfKmV5iI6yN
         1edfSENCGFWHfQd4LGPzI4yrKqfieK1+cVyZcc1qAUYKULl54bAZlJr7uPQGdk3tYuYw
         8MJA==
X-Gm-Message-State: AOJu0Yz27iOTFiuhGWejb4QpjKqOHvLBO2oFqtRbNWXqSMo2psvLIHGe
	GdxilmAI6kd2K1qQNLA3DIdkx7uopdxoSWzYMpwyOxe9fJSQwdmCu7iya7Xlc435gKo=
X-Gm-Gg: ATEYQzyy+i17h3CBqNg65dhPNZdConNSRm4XNmroGge0MEtjFTiqoTPj69qupIDpkuY
	qioHIIgLV/omExpCMDh6nftFXEEssRNzDIHnErHlX/P83I/+tXfo/iZ6MGvFV0UwdNwGSw6mjwN
	hSqYttibzY7zGmuYBBViG9CZ97plUKmN1N3FaIB+p05Ysol4BR4XRMtbcWLHVXqvhbqOu1kWUgC
	cLHFKNHIowVijqynvWj9sndMG++Lf34iQro3M7JigP4TsQfvYMkAbl+GIFyvulUYeOwgXEtQti5
	8++S4X4uDt8FwHC3VUKaLAfez442SckMaPaUlc3PSzcUbJwdBI0V7rF3/cPeJ1A3xZFuLi7YxXS
	vbzIJQhiWtSqMGa+5CfxxWgr6cZ2HqjD4CK0ZGc2SqG24hSka7qqZgH88CF+r8CZptluhvx+vTY
	vU46AhemmfDUn+yIoCWsijuQm269JPyRpkmvd8FjnL7/EjjP5Z
X-Received: by 2002:a05:6000:26c4:b0:43b:4ef0:e13 with SMTP id ffacd0b85a97d-43b6424e18emr1338932f8f.12.1773951956581;
        Thu, 19 Mar 2026 13:25:56 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:56 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 38/55] drivers: hv: dxgkrnl: Fixed dxgkrnl to build for the 6.1 kernel
Date: Thu, 19 Mar 2026 20:24:52 +0000
Message-ID: <20260319202509.63802-39-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9609-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.981];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1374B2D2347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Definition for GPADL was changed from u32 to struct vmbus_gpadl.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 8 --------
 drivers/hv/dxgkrnl/dxgkrnl.h    | 4 ----
 drivers/hv/dxgkrnl/dxgvmbus.c   | 8 --------
 3 files changed, 20 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index d9d45bd4a31e..bcd19b7267d1 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -927,19 +927,11 @@ void dxgallocation_destroy(struct dxgallocation *alloc)
 					       alloc->owner.device,
 					       &args, &alloc->alloc_handle);
 	}
-#ifdef _MAIN_KERNEL_
 	if (alloc->gpadl.gpadl_handle) {
 		DXG_TRACE("Teardown gpadl %d", alloc->gpadl.gpadl_handle);
 		vmbus_teardown_gpadl(dxgglobal_get_vmbus(), &alloc->gpadl);
 		alloc->gpadl.gpadl_handle = 0;
 	}
-#else
-	if (alloc->gpadl) {
-		DXG_TRACE("Teardown gpadl %d", alloc->gpadl);
-		vmbus_teardown_gpadl(dxgglobal_get_vmbus(), alloc->gpadl);
-		alloc->gpadl = 0;
-	}
-#endif
 	if (alloc->priv_drv_data)
 		vfree(alloc->priv_drv_data);
 	if (alloc->cpu_address_mapped)
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 1b40d6e39085..c5ed23cb90df 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -728,11 +728,7 @@ struct dxgallocation {
 	u32				cached:1;
 	u32				handle_valid:1;
 	/* GPADL address list for existing sysmem allocations */
-#ifdef _MAIN_KERNEL_
 	struct vmbus_gpadl		gpadl;
-#else
-	u32				gpadl;
-#endif
 	/* Number of pages in the 'pages' array */
 	u32				num_pages;
 	/*
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 8c99f141482e..eb3f4c5153a6 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1493,22 +1493,14 @@ int create_existing_sysmem(struct dxgdevice *device,
 			ret = -ENOMEM;
 			goto cleanup;
 		}
-#ifdef _MAIN_KERNEL_
 		DXG_TRACE("New gpadl %d", dxgalloc->gpadl.gpadl_handle);
-#else
-		DXG_TRACE("New gpadl %d", dxgalloc->gpadl);
-#endif
 
 		command_vgpu_to_host_init2(&set_store_command->hdr,
 					DXGK_VMBCOMMAND_SETEXISTINGSYSMEMSTORE,
 					device->process->host_handle);
 		set_store_command->device = device->handle;
 		set_store_command->allocation = host_alloc->allocation;
-#ifdef _MAIN_KERNEL_
 		set_store_command->gpadl = dxgalloc->gpadl.gpadl_handle;
-#else
-		set_store_command->gpadl = dxgalloc->gpadl;
-#endif
 		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
 						    msg.size);
 		if (ret < 0)

