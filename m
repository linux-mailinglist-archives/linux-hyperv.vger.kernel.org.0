Return-Path: <linux-hyperv+bounces-2959-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA896CDCA
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD451F21AE8
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC00189518;
	Thu,  5 Sep 2024 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKyppWd2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FF188A19;
	Thu,  5 Sep 2024 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509884; cv=none; b=f1Nd0UD4YsMT9T+uQAeZ0TNrPqyTfJE7rcLwMcMvWEGmR9LBv9va+Lf47Y+F4bAWL5rR5eao4VxowjUWk0+4eXGTcSglMO8v3ysFTIR35hqO480vbJOavpBOpY2Vq/R4T/RyhiByKv5rYa1Lz9rNczPW7jUXGixNYqOPLpvrBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509884; c=relaxed/simple;
	bh=TuG6oHmVqngpDPeAfcj+CxwUpX/mVzV+qPba3GW+Jtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfGo9UTihJZgLtTuBB30VFiihhAx05vLHI2Rq4MQOy56sOKBIjxbylK+LoWghBgcA9Z8fj7qH2P6f5BWIDF3JuWL8nUcenDtTAIPDXcDJaGqsM/+jS6zRg8ydM7le+mhqxYzreBd4Jr1HrGQiKDQDyBl25IYBCLP/EBMUOK7/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKyppWd2; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70f645a30dcso287366a34.3;
        Wed, 04 Sep 2024 21:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509881; x=1726114681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJ0f2V5xQlnWNK4EvLWQUiJbt0aWje4MjkaawAE2fXI=;
        b=HKyppWd2LW2FcAfwwqfdecQ/VkXwgMRLKCKSDmRopGiasUqRBacT4hGfRZOXSReesM
         btVLv2xX/QkX+QJoTVfK2UywbqCLqiCyGOFwCdw1ozMeso5kIYST0tlhS3ZD/rUH4jDH
         gTBywGvyDSFu1Ql9p3BrnGiAxCHROuoOHreniZPE2EqFAo7LjPxbp/c4KGq4+InAlkyJ
         Vdt0I5n+cTAyAx9W69lSjiDwWd/m7dxIds9YoedILmtsk+8TDKtF3IOEtlBWoEYoR1vo
         CyeHIyn4oF/Ztz4knxWfwQ9ti3SgoXohs+E8VNWci6IU3nqnvecdafurY4yu+dWH52oj
         OZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509881; x=1726114681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJ0f2V5xQlnWNK4EvLWQUiJbt0aWje4MjkaawAE2fXI=;
        b=uXmAmJ0UTBcf0um/DukV9D2He24acwyIkC4HWBAccKer75zCZNHHxWq8OQ2+CmmXLy
         l7tUBxjy4iR9ogMiabSSFZNsCgkptR7LyLrKMWk9VAj3gT73Oqfd8RiCjzMLYfydtcrY
         TQGmcU7Cko7UE6ar960dtmlv6/DES/QTUKwt9M+dq56e6+HWSpfu85wskhDigPrLnfZH
         gi/4S4KdWuH6aJr9RwE2zDB3vgfb1N5Fk7wdL5Recy4SX2KmdLzkNPKIfMQQvmIau1RH
         dZWfWaM3A5hfSUvypSKtKJCNOUBCFyqYgnmy1cDv2Th1cXGQlrvJpIH73efSKmFHE+eg
         +f+A==
X-Forwarded-Encrypted: i=1; AJvYcCUj92OtztnEVIiDuwLh/CMYLwiNbMqWX0vj988rGR0CebeugJtfNgEYMMGi9H4UfOmesFEcVbAuZ8IqDFNe@vger.kernel.org, AJvYcCVFH1U67ba+gnf0YaQoV2lGd+A66vS/d5h+PLDgdrofHtq/coTIe6EHadGTWtygc2PaIW3jCvt5IEUWW+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ThQlxaT6frQqzK6jmwuT4MJbN+yF0ODLq/nVgsP4KtMHHiVC
	UX7sICfV5J68l4ejSQ5LbY+ovLqSI6Bo0EH/6p3lSDywAcMSVj7GwZyriA==
X-Google-Smtp-Source: AGHT+IFfwqWs2Krwm9FKRLXZTcp8pEOgI1FCBF6/QQpcb7fZKh+2/hIYDHYeoNIAXonuZwb4W4JP/Q==
X-Received: by 2002:a05:6830:2d8b:b0:710:b588:2552 with SMTP id 46e09a7af769-710b5882e6bmr5386695a34.12.1725509881402;
        Wed, 04 Sep 2024 21:18:01 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:00 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Helge Deller <deller@gmx.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Samuel Holland <samuel@sholland.org>,
	Lyude Paul <thatslyude@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 12/24] Input: i8042 - tease apart interrupt handler
Date: Wed,  4 Sep 2024 21:17:17 -0700
Message-ID: <20240905041732.2034348-13-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905041732.2034348-1-dmitry.torokhov@gmail.com>
References: <20240905041732.2034348-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to using guard notation when acquiring mutexes and
spinlocks factor out handling of active multiplexing mode from
i8042_interrupt().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/i8042.c | 139 +++++++++++++++++++++---------------
 1 file changed, 83 insertions(+), 56 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 8ec4872b4471..674cd155ec8f 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -178,7 +178,7 @@ static unsigned char i8042_suppress_kbd_ack;
 static struct platform_device *i8042_platform_device;
 static struct notifier_block i8042_kbd_bind_notifier_block;
 
-static irqreturn_t i8042_interrupt(int irq, void *dev_id);
+static bool i8042_handle_data(int irq);
 static bool (*i8042_platform_filter)(unsigned char data, unsigned char str,
 				     struct serio *serio);
 
@@ -434,7 +434,7 @@ static void i8042_port_close(struct serio *serio)
 	 * See if there is any data appeared while we were messing with
 	 * port state.
 	 */
-	i8042_interrupt(0, NULL);
+	i8042_handle_data(0);
 }
 
 /*
@@ -518,12 +518,68 @@ static bool i8042_filter(unsigned char data, unsigned char str,
 }
 
 /*
- * i8042_interrupt() is the most important function in this driver -
- * it handles the interrupts from the i8042, and sends incoming bytes
- * to the upper layers.
+ * i8042_handle_mux() handles case when data is coming from one of
+ * the multiplexed ports. It would be simple if not for quirks with
+ * handling errors:
+ *
+ * When MUXERR condition is signalled the data register can only contain
+ * 0xfd, 0xfe or 0xff if implementation follows the spec. Unfortunately
+ * it is not always the case. Some KBCs also report 0xfc when there is
+ * nothing connected to the port while others sometimes get confused which
+ * port the data came from and signal error leaving the data intact. They
+ * _do not_ revert to legacy mode (actually I've never seen KBC reverting
+ * to legacy mode yet, when we see one we'll add proper handling).
+ * Anyway, we process 0xfc, 0xfd, 0xfe and 0xff as timeouts, and for the
+ * rest assume that the data came from the same serio last byte
+ * was transmitted (if transmission happened not too long ago).
  */
+static int i8042_handle_mux(u8 str, u8 *data, unsigned int *dfl)
+{
+	static unsigned long last_transmit;
+	static unsigned long last_port;
+	unsigned int mux_port;
+
+	mux_port = (str >> 6) & 3;
+	*dfl = 0;
+
+	if (str & I8042_STR_MUXERR) {
+		dbg("MUX error, status is %02x, data is %02x\n",
+		    str, *data);
+
+		switch (*data) {
+		default:
+			if (time_before(jiffies, last_transmit + HZ/10)) {
+				mux_port = last_port;
+				break;
+			}
+			fallthrough;	/* report timeout */
+		case 0xfc:
+		case 0xfd:
+		case 0xfe:
+			*dfl = SERIO_TIMEOUT;
+			*data = 0xfe;
+			break;
+		case 0xff:
+			*dfl = SERIO_PARITY;
+			*data = 0xfe;
+			break;
+		}
+	}
 
-static irqreturn_t i8042_interrupt(int irq, void *dev_id)
+	last_port = mux_port;
+	last_transmit = jiffies;
+
+	return I8042_MUX_PORT_NO + mux_port;
+}
+
+/*
+ * i8042_handle_data() is the most important function in this driver -
+ * it reads the data from the i8042, determines its destination serio
+ * port, and sends received byte to the upper layers.
+ *
+ * Returns true if there was data waiting, false otherwise.
+ */
+static bool i8042_handle_data(int irq)
 {
 	struct i8042_port *port;
 	struct serio *serio;
@@ -532,63 +588,24 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	unsigned int dfl;
 	unsigned int port_no;
 	bool filtered;
-	int ret = 1;
 
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	str = i8042_read_status();
 	if (unlikely(~str & I8042_STR_OBF)) {
 		spin_unlock_irqrestore(&i8042_lock, flags);
-		if (irq)
-			dbg("Interrupt %d, without any data\n", irq);
-		ret = 0;
-		goto out;
+		return false;
 	}
 
 	data = i8042_read_data();
 
 	if (i8042_mux_present && (str & I8042_STR_AUXDATA)) {
-		static unsigned long last_transmit;
-		static unsigned char last_str;
-
-		dfl = 0;
-		if (str & I8042_STR_MUXERR) {
-			dbg("MUX error, status is %02x, data is %02x\n",
-			    str, data);
-/*
- * When MUXERR condition is signalled the data register can only contain
- * 0xfd, 0xfe or 0xff if implementation follows the spec. Unfortunately
- * it is not always the case. Some KBCs also report 0xfc when there is
- * nothing connected to the port while others sometimes get confused which
- * port the data came from and signal error leaving the data intact. They
- * _do not_ revert to legacy mode (actually I've never seen KBC reverting
- * to legacy mode yet, when we see one we'll add proper handling).
- * Anyway, we process 0xfc, 0xfd, 0xfe and 0xff as timeouts, and for the
- * rest assume that the data came from the same serio last byte
- * was transmitted (if transmission happened not too long ago).
- */
-
-			switch (data) {
-				default:
-					if (time_before(jiffies, last_transmit + HZ/10)) {
-						str = last_str;
-						break;
-					}
-					fallthrough;	/* report timeout */
-				case 0xfc:
-				case 0xfd:
-				case 0xfe: dfl = SERIO_TIMEOUT; data = 0xfe; break;
-				case 0xff: dfl = SERIO_PARITY;  data = 0xfe; break;
-			}
-		}
-
-		port_no = I8042_MUX_PORT_NO + ((str >> 6) & 3);
-		last_str = str;
-		last_transmit = jiffies;
+		port_no = i8042_handle_mux(str, &data, &dfl);
 	} else {
 
-		dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
-		      ((str & I8042_STR_TIMEOUT && !i8042_notimeout) ? SERIO_TIMEOUT : 0);
+		dfl = (str & I8042_STR_PARITY) ? SERIO_PARITY : 0;
+		if ((str & I8042_STR_TIMEOUT) && !i8042_notimeout)
+			dfl |= SERIO_TIMEOUT;
 
 		port_no = (str & I8042_STR_AUXDATA) ?
 				I8042_AUX_PORT_NO : I8042_KBD_PORT_NO;
@@ -609,8 +626,17 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	if (likely(serio && !filtered))
 		serio_interrupt(serio, data, dfl);
 
- out:
-	return IRQ_RETVAL(ret);
+	return true;
+}
+
+static irqreturn_t i8042_interrupt(int irq, void *dev_id)
+{
+	if (unlikely(!i8042_handle_data(irq))) {
+		dbg("Interrupt %d, without any data\n", irq);
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
 }
 
 /*
@@ -1216,13 +1242,14 @@ static int i8042_controller_resume(bool s2r_wants_reset)
 	if (i8042_mux_present) {
 		if (i8042_set_mux_mode(true, NULL) || i8042_enable_mux_ports())
 			pr_warn("failed to resume active multiplexor, mouse won't work\n");
-	} else if (i8042_ports[I8042_AUX_PORT_NO].serio)
+	} else if (i8042_ports[I8042_AUX_PORT_NO].serio) {
 		i8042_enable_aux_port();
+	}
 
 	if (i8042_ports[I8042_KBD_PORT_NO].serio)
 		i8042_enable_kbd_port();
 
-	i8042_interrupt(0, NULL);
+	i8042_handle_data(0);
 
 	return 0;
 }
@@ -1253,7 +1280,7 @@ static int i8042_pm_suspend(struct device *dev)
 static int i8042_pm_resume_noirq(struct device *dev)
 {
 	if (i8042_forcenorestore || !pm_resume_via_firmware())
-		i8042_interrupt(0, NULL);
+		i8042_handle_data(0);
 
 	return 0;
 }
@@ -1290,7 +1317,7 @@ static int i8042_pm_resume(struct device *dev)
 
 static int i8042_pm_thaw(struct device *dev)
 {
-	i8042_interrupt(0, NULL);
+	i8042_handle_data(0);
 
 	return 0;
 }
-- 
2.46.0.469.g59c65b2a67-goog


