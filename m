Return-Path: <linux-hyperv+bounces-9607-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLH8NRtfvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9607-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:39:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB162D24A0
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06E4A31769D6
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F803FF89D;
	Thu, 19 Mar 2026 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH+DWh/D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553DC3FB06D
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951962; cv=none; b=D0wJmXrlfDL14AIabJ59BvRBxkwAMUooDj6qoXwQU5TZeulIxYKXw8k9S+tUF684/Nl2C+Httxsnf7j0BY1VRvRKQCK/iSYOnJTgf2EeF11QReblH0qft0i4LxnEqnBrKVjpntP0Prt0+BQwnqVozF9qbAa7FS9/23IXNbSmCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951962; c=relaxed/simple;
	bh=B3ORidiU2v9AzqT4cH2PTBIt+A1SulhfgRZFmSe97F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6qb9yWSrey4NOMsUZj6uIvEsUgI12V72hU9z5BQvSesRKatkXvw/Ck2FqsS0GDvuHby+4uNryZApTGii+4s8hSG1RFyqc4w8EpUF4QaZwTsPO0GuVHvskBZFKT4QkooMr9362DQnGqRpTzCBpHv2bfnT3IK1Kv9jgxyXfBDa1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH+DWh/D; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b611274bso598529f8f.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951954; x=1774556754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMNmHW+JNOctOziyTOkJlkQy7QxdzykzDBZ9+fN3rRY=;
        b=fH+DWh/DBuMLkSoiDiviPi0McnmyMgpFDF3r3IrBisy8fqn7EELbcInqgOD/Uy/4qp
         HeM05e5VzMuArZAGqZtiO5QRRFX2fGz+bUz2MnNYC+0ceSdGWpqfcSxiA/zC9Y1qn0jO
         kSUQzp6DLtbeIySXSWEhYPvtTJSmvxpwI49zD9U5+tIc9Q0oSdA0z5bHSfkLw1gPk/Vq
         +OVzkjD2srYHPEAuK7ZyPtHGv6dTyG97op7WMccDh6cPyTjH/ULdMbz5/EVxT7d7+5gz
         8a7B+6Iek/GDMu40aWE4tkObcNEWGdxBWqZpaZk56POzTP4pSIXZwf+HW30g+jLSsVMN
         XNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951954; x=1774556754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PMNmHW+JNOctOziyTOkJlkQy7QxdzykzDBZ9+fN3rRY=;
        b=AolUswJpbQM6qVu34197/L6lUSx5IrIk+8RIzZQfGh1X0WZGlRto0XA3wNA8/LevbY
         q3IYy8p+bV/IVydfPV3L3I9io3LMUeeL2hhFgzFHxgcZxa7hy6XUGDyEueMwe+ZAfEOg
         rlZ+KAXIhqe7nc0A74do2mRg/Sll0qxK+gRvKKTB2nxCnkIIzE0qRi7n7taBL6FlNrDx
         Nd8XLdLJ9yDL52Z3kYnTOgcIYnva226SgUuKP/n0cbE4jvHuCSNZSG4jgF8/Gh8intMI
         t9IGYUQ5jMqlHUsA5f+ZTUvhUj/uf/bPqu8MPNiiGTlk8WiNQWeUDbG2FgY2rdQ2uOEX
         swdw==
X-Gm-Message-State: AOJu0YzkulZvu/JXJRy2hixTq6auQvMqqYzEeR7OhyzbGMFXZLzI6mnp
	jj/SK7jpGgevre4xFQ1BGlsGnugZhOal0nnE7ROrwBje3rqxZbaJ+zs4WjejRISUiXo=
X-Gm-Gg: ATEYQzyWelSlLJPipfLGsY1j1haICKE/T3BiduDrWvGGM7PXEonaQZ0j7tVmy1X0Anm
	TRp72/9iC1FY/lXci/W4fGk0sG0ZDyruDk0DSmP4MEpAdlME2S8X9YVLhJVhU6dRLARQw+UsoqS
	9EBDXvUaTLjHU+NU2VYoCogYH5zaPxIzFZZfLGE8njQ5/2mbakq3zIQMkzZBsw+mXH/feuvriys
	p7LAnS6PbRVffdc92kXEmGMEDsPnoCYt+OOqM+jlaembw8uWwHFanSz2lZMqHHzuAbx56rxaeki
	gXjYTJGVEaFonNMlZs/dWPXYizt1DiiX4RtIhXSchjQV5zZVAf5YwF3B8vZheNctNZzsdY9IKvN
	zPkzvXp25IvI/NuGAKcYaWNJU+MnsEcfsXxGETAVd0ikUoH55yGZlBed159uNtLvK8cKtQyIbfH
	ndjMdPUd0xoomStn5Yy2J0N52xO/8OfRB2BKpxmym+6P6qUzjO
X-Received: by 2002:a05:6000:18a6:b0:439:beee:43b5 with SMTP id ffacd0b85a97d-43b6423d90bmr1327203f8f.3.1773951954471;
        Thu, 19 Mar 2026 13:25:54 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:54 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 36/55] drivers: hv: dxgkrnl: Close shared file objects in case of a failure
Date: Thu, 19 Mar 2026 20:24:50 +0000
Message-ID: <20260319202509.63802-37-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9607-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 3CB162D24A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/ioctl.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 7c72790f917f..69324510c9e2 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -4536,7 +4536,7 @@ enum dxg_sharedobject_type {
 };
 
 static int get_object_fd(enum dxg_sharedobject_type type,
-				     void *object, int *fdout)
+			void *object, int *fdout, struct file **filp)
 {
 	struct file *file;
 	int fd;
@@ -4565,8 +4565,8 @@ static int get_object_fd(enum dxg_sharedobject_type type,
 		return -ENOTRECOVERABLE;
 	}
 
-	fd_install(fd, file);
 	*fdout = fd;
+	*filp = file;
 	return 0;
 }
 
@@ -4581,6 +4581,7 @@ dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
 	struct dxgsharedresource *shared_resource = NULL;
 	struct d3dkmthandle *handles = NULL;
 	int object_fd = -1;
+	struct file *filp = NULL;
 	void *obj = NULL;
 	u32 handle_size;
 	int ret;
@@ -4660,7 +4661,7 @@ dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
 	switch (object_type) {
 	case HMGRENTRY_TYPE_DXGSYNCOBJECT:
 		ret = get_object_fd(DXG_SHARED_SYNCOBJECT, shared_syncobj,
-				    &object_fd);
+				    &object_fd, &filp);
 		if (ret < 0) {
 			DXG_ERR("get_object_fd failed for sync object");
 			goto cleanup;
@@ -4675,7 +4676,7 @@ dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
 		break;
 	case HMGRENTRY_TYPE_DXGRESOURCE:
 		ret = get_object_fd(DXG_SHARED_RESOURCE, shared_resource,
-				    &object_fd);
+				    &object_fd, &filp);
 		if (ret < 0) {
 			DXG_ERR("get_object_fd failed for resource");
 			goto cleanup;
@@ -4708,10 +4709,15 @@ dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
 	if (ret) {
 		DXG_ERR("failed to copy shared handle");
 		ret = -EFAULT;
+		goto cleanup;
 	}
 
+	fd_install(object_fd, filp);
+
 cleanup:
 	if (ret < 0) {
+		if (filp)
+			fput(filp);
 		if (object_fd >= 0)
 			put_unused_fd(object_fd);
 	}

