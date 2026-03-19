Return-Path: <linux-hyperv+bounces-9602-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHMbALxcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9602-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:29:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A967D2D2240
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC6D2304AA3A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B653FD143;
	Thu, 19 Mar 2026 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3aOeCss"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20B3FCB04
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951953; cv=none; b=jASoyuSM5v3C9aQklwKW9uqjtvmptRL+Le+5voh82sEvUoQdeK1xbNs955p5zISmZvE7xK7ydVVCNj0zsTdLodKy9N9ebl2IGkeF6vPciajbvKPgtPOvZafRedogqTqMwQMsPuOhv7YpMtqxVUOs49aNgUHpPYKdww4DbrCFeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951953; c=relaxed/simple;
	bh=oKy7K50U4xod7H9n2WA1hO9ZTdC4HWwRfYzOW8vTIGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtCKp++fRdEqXKEJkic89iS/VTnkf/lbpipuU7chk2C1eYOCq5Va03TTb4MW7d8Sx/v558nba4IGgbcFN5hoF5Bbl3GkDtHKKBCvlLGmpEeobOcqvBPlsej1nyjGNwLUlUNOB7Rh7eCaXQ78NZkqx971hBQnDdzxlj5zWR726Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3aOeCss; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso9939445e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951948; x=1774556748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckjfDHMjepp0Dv0WHHzgU1DF+dSRdE5LwZWVFCBJz5A=;
        b=e3aOeCssjX2RslYT1X0q3iwAMw2Un/xTG6FAEragbdFJfsTE/1VLHz6woCCMKHw1bn
         ytDCI3AUpgAyp+ZZ7/t6o4336pfP8aBjtjxM4ZwHE9GDIv7qAfRUfq7NwzCe2+tHGerD
         cLEmIDYnE0TjN+zz4Lu8y9a5VgZHCoSH1khT+EmDWhIRU2P2QRRHg2mwvK7t+DHMl4qk
         8XvrxdUfDDkq2VRABmkRACXbbeQmkH4aZnjWMYdYu6JJwGaqzR+6YNhJsiTUHJPNxIKz
         PoH012wIwcJQxN0ZBumEO7BhmTdXO0Xn6B5N16aZ/XUp9OJt2fPIEUMxd0ES8mhjSzjH
         lF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951948; x=1774556748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckjfDHMjepp0Dv0WHHzgU1DF+dSRdE5LwZWVFCBJz5A=;
        b=FovgxiHvfMiZY8PzY+pvk42FlvijdD4nuUBKR/zAX/HubuSYw3mZam6exdnWNh3jNX
         R+pqjmZ9xiYSDXKLQOWuaQXAiNOU24md7opXkWOBLt8jfzsvbzGIYEQgSxLJteoAK7GS
         NTrGdNUjGiNM21jsHKnhl7XHotPrhktevAw6ROIIg5tSCmYJ0/bZhepKmdEYhy+1q9E1
         ICl7E2jb2FOm7f2ExXy68hSmO9Lv0gUlp2g6aPev9VcRL9DVsaC+OurOvz/G53/XoiZS
         7dcDd35+o3VO1x3PvmMSbuc03wUM9GwiCelcvfAE4gQor4kp8QRk+uIy03K+oegz+Iho
         LuRQ==
X-Gm-Message-State: AOJu0YwsRoBamvsw6NA/FCAiff0hrjJ5H5lmMQNWZ63sBTmlSOyc4Tna
	we4YCV6+rm2Lo1mrC2C0Xxj1vJpBLmUZBO4NY0akKDqsZ1Lr8KZPrQ7S7gKhdtHUY/Q=
X-Gm-Gg: ATEYQzywQ5qbQeR7KQhJhx2L3g+VSzeZtDvjYMKP1YaHtf/yd7qaSPmwcS10Z9QIijb
	V/iygdMeMn1qSkzOpT4tDy+DX4kT9ROy+ZnogalwmZDqkGcCRraAnQziJi/3sOtdQueUAQ0CuIR
	JgrZH6O3Yn/QVhjjwJhOM5dYYEy80DAULR0nwnVjc2T98i08Aa9Iqqtc4+iJVOXfbA6MeUMdmm3
	IRvWuNssJ0h5vlRL/tGfr0KNqdLqd8xbcq4DJerZhP5ubAzZP+EMMp/LnpcJJQ5960HrtZxuyH2
	TuQwpcQTjnt74rgLoC35u9yJ7GraTODb9wzwADJsY8J6/1/mRNp5hnOKYKNNWcnqt1DP1yU+EB8
	ZP08dWodIGAFjmr0mxYug0KpSevcFm4HIt4014C9gjDf90BFfHsqfJh2mErxe+Wnwc9Vbob1xyt
	rIUUvHfu/kPHts0v+Peurl+AmG37wXiw5keEBJ+SNostzVx6MEEGANsToj8/M=
X-Received: by 2002:a05:600c:8508:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-486fedab7dbmr7342275e9.2.1773951947822;
        Thu, 19 Mar 2026 13:25:47 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:47 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 30/55] drivers: hv: dxgkrnl: Remove dxgk_init_ioctls
Date: Thu, 19 Mar 2026 20:24:44 +0000
Message-ID: <20260319202509.63802-31-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9602-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A967D2D2240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

The array of ioctls is initialized statically to remove the unnecessary
function.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgmodule.c |  2 +-
 drivers/hv/dxgkrnl/ioctl.c     | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index b1b612b90fc1..f1245a9d8826 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -300,7 +300,7 @@ static void dxgglobal_start_adapters(void)
 }
 
 /*
- * Stopsthe active dxgadapter objects.
+ * Stop the active dxgadapter objects.
  */
 static void dxgglobal_stop_adapters(void)
 {
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index f6700e974f25..8732a66040a0 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -26,7 +26,6 @@
 struct ioctl_desc {
 	int (*ioctl_callback)(struct dxgprocess *p, void __user *arg);
 	u32 ioctl;
-	u32 arg_size;
 };
 
 #ifdef DEBUG
@@ -91,7 +90,7 @@ static const struct file_operations dxg_resource_fops = {
 };
 
 static int dxgkio_open_adapter_from_luid(struct dxgprocess *process,
-						   void *__user inargs)
+					void *__user inargs)
 {
 	struct d3dkmt_openadapterfromluid args;
 	int ret;
@@ -1002,7 +1001,7 @@ dxgkio_create_hwqueue(struct dxgprocess *process, void *__user inargs)
 }
 
 static int dxgkio_destroy_hwqueue(struct dxgprocess *process,
-					    void *__user inargs)
+				void *__user inargs)
 {
 	struct d3dkmt_destroyhwqueue args;
 	int ret;
@@ -2280,7 +2279,8 @@ dxgkio_submit_command(struct dxgprocess *process, void *__user inargs)
 }
 
 static int
-dxgkio_submit_command_to_hwqueue(struct dxgprocess *process, void *__user inargs)
+dxgkio_submit_command_to_hwqueue(struct dxgprocess *process,
+				void *__user inargs)
 {
 	int ret;
 	struct d3dkmt_submitcommandtohwqueue args;
@@ -5087,8 +5087,7 @@ open_resource(struct dxgprocess *process,
 }
 
 static int
-dxgkio_open_resource_nt(struct dxgprocess *process,
-				      void *__user inargs)
+dxgkio_open_resource_nt(struct dxgprocess *process, void *__user inargs)
 {
 	struct d3dkmt_openresourcefromnthandle args;
 	struct d3dkmt_openresourcefromnthandle *__user args_user = inargs;
@@ -5166,7 +5165,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x14 */	{dxgkio_enum_adapters, LX_DXENUMADAPTERS2},
 /* 0x15 */	{dxgkio_close_adapter, LX_DXCLOSEADAPTER},
 /* 0x16 */	{dxgkio_change_vidmem_reservation,
-		  LX_DXCHANGEVIDEOMEMORYRESERVATION},
+		 LX_DXCHANGEVIDEOMEMORYRESERVATION},
 /* 0x17 */	{},
 /* 0x18 */	{dxgkio_create_hwqueue, LX_DXCREATEHWQUEUE},
 /* 0x19 */	{dxgkio_destroy_device, LX_DXDESTROYDEVICE},
@@ -5205,7 +5204,7 @@ static struct ioctl_desc ioctls[] = {
 		 LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2},
 /* 0x34 */	{dxgkio_submit_command_to_hwqueue, LX_DXSUBMITCOMMANDTOHWQUEUE},
 /* 0x35 */	{dxgkio_submit_signal_to_hwqueue,
-		  LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE},
+		 LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE},
 /* 0x36 */	{dxgkio_submit_wait_to_hwqueue,
 		 LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE},
 /* 0x37 */	{dxgkio_unlock2, LX_DXUNLOCK2},

