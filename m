Return-Path: <linux-hyperv+bounces-9604-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF65GuhcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9604-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 192C92D2266
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A496C3087C30
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431063FE37C;
	Thu, 19 Mar 2026 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REBlThlY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45A3FCB3E
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951955; cv=none; b=sdXqqNseKN8MWfp0gYbFLLJcLOe8hKSrJwD5DCrmBjvKXOniTahb2vVPx8VwtlmVMMxCDg/3kbjSb+9lJwTqk1n4/XjLGAoh9JqldInWlpQRFvis6G0BpoAkLyMEOSrT/Sr3nHc3JjqCLBfnGVnv96qvrqjNXO+pm56aTc+Fi1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951955; c=relaxed/simple;
	bh=YihQqAQ6+ZY8Dpxrl7tuuvKiO3QB5rOIAUJNhWwtaTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEiERDxqvXcQ/HE//e3aS59X6WlAyMxB0i+5TqxKVQI05ADNRuC7OWhHHcK6qZ7svgA7bayNQ8Sl3hObquyTJGh5B+Ln1ms38vatULY7TNBQhqH5Kyec8PRqAqbWoStCsq/I6diCqVMkPSif0eDX6MsmTjZEFP/MXHnIQgzRTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REBlThlY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so12261455e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951950; x=1774556750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5vGN3ll6taZ+ENdbw5uI+egqygk+hNP+j3J7qDiLXs=;
        b=REBlThlYoXa33aaVy8DZpdN2tHCNFp7AN4eQHoeygTqUs4vJWGCiRNhwduciEMgjTM
         12oBkh8wuoiD/o1luN57IFFceg4KgLTuLjSNv9h25Tjy/ay+ueTxv6AgdCmlUThvtxKh
         E3ulRvBsn+J5hX55h/LOXXem8qtCngQ0Dg/FEjosfEOYhG29FtfDXGDNmqycS96uRFko
         /Sj+ARVWtA7HSdvWrgIxialerqfmc0tuDJ8xleh0RLj7YAVz8B0uMFaVCTDxb1OjWDX8
         memOTi19L6nUkJoIerKfhhDP73rRGys4XG0KJFlm8DDNCzHmwygOg8Odb6LmmsUr4+c9
         mb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951950; x=1774556750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5vGN3ll6taZ+ENdbw5uI+egqygk+hNP+j3J7qDiLXs=;
        b=quVcnKTUXedzoI7p1NdPAZxhaddlaUjPFXjuLNYVgVX3sk0/+Iz5Sxj+C9IW8C5EfP
         Dh6WyZ5AKft5Ocl9G52w5hJmplCvWRY5E3Ya2/+Erjcbm+j/LFNG8w0c2g3WLnv+ub1U
         vg/CEBtNicdQSqOEOEadehSUpNV1pDRnzw5e7dQvK9plWdLkWJYCTkPbJIyJ7vxesW6s
         FfKx0ukcUSYlf5t9Z1HmfsXNCKvK8qLNnLteGBMol+GUMxm0Eu9259ZX15fjMzH5Lgy3
         7MP8TMyRFmZAaKFN+9knN+DSHUxF1Brd/adWfXJ0JndW+KdSpr9jeCyO9fuDX86OeXye
         cRTw==
X-Gm-Message-State: AOJu0YzWhRBqrJUFOQSQnAjD2xgRjKIkgg5zDbP5wzl6qEUwLqTrfp+u
	DLfGzv8i3cMG5QLkhJCiliGDy2pGfq/PSD0TGNdrxuU5DHZ6eZaIx04aaYnG1a047TY=
X-Gm-Gg: ATEYQzwPTkea8Xw3v+CTcpDS6/9W04UTz8XSzL0jwB5UGtqzyOy4g+Zjg2HKFGtJPIq
	muZwbjy0LziFMeM58W/LcP55MS+kz4T0ROfZQAc/9QigYvgS74EVaExGabhwv2BcJbVhP9kAEhS
	gU4kNi8ESDDKvOcJfv/ckjORKpMWkOu0L4P25HJlP3Krnywv4wlNAmFN3oshRbaw9JPw0oPDcSB
	PMpBf7X8JG+UFIHk6eX80GMKJ/+lZTyrSN41Ca9kB/oCOtpqo1B+fEvuyjWG+COX/CSebdjBCPS
	zlXU3Wmyn4Vx3JCZsBXEFEjTo12riGmtXsBCBAP5f20DoGAHWmcgf2EV+nVKX934OZxFAA59GwJ
	qyiZ/MOu/jZGT0/2uVczIXBkNWDdM2r8vkVzdVDUo/IK5eoyOMDXAii6p2lDn4rrvti5mTflR8p
	Ie0dBk3/KFRBBOs53KVWx0a41s2iSLAQP7XmjQD629M/yiJDSp
X-Received: by 2002:a05:600c:5250:b0:485:9a50:338d with SMTP id 5b1f17b1804b1-486fedab419mr7310045e9.3.1773951950003;
        Thu, 19 Mar 2026 13:25:50 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:49 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 32/55] drivers: hv: dxgkrnl: Use tracing instead of dev_dbg
Date: Thu, 19 Mar 2026 20:24:46 +0000
Message-ID: <20260319202509.63802-33-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9604-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 192C92D2266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  4 ++--
 drivers/hv/dxgkrnl/dxgmodule.c  |  5 ++++-
 drivers/hv/dxgkrnl/dxgprocess.c |  6 +++---
 drivers/hv/dxgkrnl/dxgvmbus.c   |  4 ++--
 drivers/hv/dxgkrnl/hmgr.c       | 16 ++++++++--------
 drivers/hv/dxgkrnl/ioctl.c      |  8 ++++----
 drivers/hv/dxgkrnl/misc.c       |  4 ++--
 7 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 236febbc6fca..3d8bec295b87 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -18,8 +18,8 @@
 
 #include "dxgkrnl.h"
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"dxgk: " fmt
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
 
 int dxgadapter_set_vmbus(struct dxgadapter *adapter, struct hv_device *hdev)
 {
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index af51fcd35697..08feae97e845 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -24,6 +24,9 @@
 #undef pr_fmt
 #define pr_fmt(fmt)	"dxgk: " fmt
 
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
+
 /*
  * Interface from dxgglobal
  */
@@ -442,7 +445,7 @@ const struct file_operations dxgk_fops = {
 #define DXGK_VMBUS_HOSTCAPS_OFFSET	(DXGK_VMBUS_VGPU_LUID_OFFSET + \
 					sizeof(struct winluid))
 
-/* The guest writes its capavilities to this adderss */
+/* The guest writes its capabilities to this address */
 #define DXGK_VMBUS_GUESTCAPS_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
 					sizeof(u32))
 
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index 5de3f8ccb448..afef196c0588 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -13,8 +13,8 @@
 
 #include "dxgkrnl.h"
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"dxgk: " fmt
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
 
 /*
  * Creates a new dxgprocess object
@@ -248,7 +248,7 @@ struct dxgadapter *dxgprocess_adapter_by_handle(struct dxgprocess *process,
 					       HMGRENTRY_TYPE_DXGADAPTER,
 					       handle);
 	if (adapter == NULL)
-		DXG_ERR("adapter_by_handle failed %x", handle.v);
+		DXG_TRACE("adapter_by_handle failed %x", handle.v);
 	else if (kref_get_unless_zero(&adapter->adapter_kref) == 0) {
 		DXG_ERR("failed to acquire adapter reference");
 		adapter = NULL;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 913ea3cabb31..d53d4254be63 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -22,8 +22,8 @@
 #include "dxgkrnl.h"
 #include "dxgvmbus.h"
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"dxgk: " fmt
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
 
 #define RING_BUFSIZE (256 * 1024)
 
diff --git a/drivers/hv/dxgkrnl/hmgr.c b/drivers/hv/dxgkrnl/hmgr.c
index 526b50f46d96..24101d0091ab 100644
--- a/drivers/hv/dxgkrnl/hmgr.c
+++ b/drivers/hv/dxgkrnl/hmgr.c
@@ -19,8 +19,8 @@
 #include "dxgkrnl.h"
 #include "hmgr.h"
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"dxgk: " fmt
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
 
 const struct d3dkmthandle zerohandle;
 
@@ -90,29 +90,29 @@ static bool is_handle_valid(struct hmgrtable *table, struct d3dkmthandle h,
 	struct hmgrentry *entry;
 
 	if (index >= table->table_size) {
-		DXG_ERR("Invalid index %x %d", h.v, index);
+		DXG_TRACE("Invalid index %x %d", h.v, index);
 		return false;
 	}
 
 	entry = &table->entry_table[index];
 	if (unique != entry->unique) {
-		DXG_ERR("Invalid unique %x %d %d %d %p",
+		DXG_TRACE("Invalid unique %x %d %d %d %p",
 			h.v, unique, entry->unique, index, entry->object);
 		return false;
 	}
 
 	if (entry->destroyed && !ignore_destroyed) {
-		DXG_ERR("Invalid destroyed value");
+		DXG_TRACE("Invalid destroyed value");
 		return false;
 	}
 
 	if (entry->type == HMGRENTRY_TYPE_FREE) {
-		DXG_ERR("Entry is freed %x %d", h.v, index);
+		DXG_TRACE("Entry is freed %x %d", h.v, index);
 		return false;
 	}
 
 	if (t != HMGRENTRY_TYPE_FREE && t != entry->type) {
-		DXG_ERR("type mismatch %x %d %d", h.v, t, entry->type);
+		DXG_TRACE("type mismatch %x %d %d", h.v, t, entry->type);
 		return false;
 	}
 
@@ -500,7 +500,7 @@ void *hmgrtable_get_object_by_type(struct hmgrtable *table,
 				   struct d3dkmthandle h)
 {
 	if (!is_handle_valid(table, h, false, type)) {
-		DXG_ERR("Invalid handle %x", h.v);
+		DXG_TRACE("Invalid handle %x", h.v);
 		return NULL;
 	}
 	return table->entry_table[get_index(h)].object;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 6c26aafb0619..4db23cd55b24 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -21,8 +21,8 @@
 #include "dxgvmbus.h"
 #include "dxgsyncfile.h"
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"dxgk: " fmt
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
 
 struct ioctl_desc {
 	int (*ioctl_callback)(struct dxgprocess *p, void __user *arg);
@@ -556,7 +556,7 @@ dxgkio_enum_adapters3(struct dxgprocess *process, void *__user inargs)
 
 cleanup:
 
-	DXG_TRACE("ioctl: %s %d", errorstr(ret), ret);
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
 	return ret;
 }
 
@@ -5242,7 +5242,7 @@ static int dxgk_ioctl(struct file *f, unsigned int p1, unsigned long p2)
 	int status;
 	struct dxgprocess *process;
 
-	if (code < 1 ||  code >= ARRAY_SIZE(ioctls)) {
+	if (code < 1 || code >= ARRAY_SIZE(ioctls)) {
 		DXG_ERR("bad ioctl %x %x %x %x",
 			code, _IOC_TYPE(p1), _IOC_SIZE(p1), _IOC_DIR(p1));
 		return -ENOTTY;
diff --git a/drivers/hv/dxgkrnl/misc.c b/drivers/hv/dxgkrnl/misc.c
index 4a1309d80ee5..4bf6fe80d22a 100644
--- a/drivers/hv/dxgkrnl/misc.c
+++ b/drivers/hv/dxgkrnl/misc.c
@@ -18,8 +18,8 @@
 #include "dxgkrnl.h"
 #include "misc.h"
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"dxgk: " fmt
+#undef dev_fmt
+#define dev_fmt(fmt)	"dxgk: " fmt
 
 u16 *wcsncpy(u16 *dest, const u16 *src, size_t n)
 {

