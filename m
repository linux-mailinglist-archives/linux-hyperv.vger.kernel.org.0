Return-Path: <linux-hyperv+bounces-2957-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7796CDC3
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD281C22A95
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B63A18893C;
	Thu,  5 Sep 2024 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urdgh20n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE86154439;
	Thu,  5 Sep 2024 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509881; cv=none; b=PXDct0osM9qQYKBE/iL8vqc0y1NHhA/K7ldCZFQG+YVQc3jtr1GQ7cVzBbTOh/w92O64JXtkVmw7o4DrNSTKjUvldtFhnzY9rNOXtb5k/EbjDBeB++65OZ/Jv837wEqSsVeSP8+Rq+Hq2Kri3Q2rKOXpyhoe0AHs55xrLuUDV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509881; c=relaxed/simple;
	bh=19U38uZCXEvKhulVokOxaN0gRvDzLtZltpAHJeXQyMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPxzN1n1TWJkyzCRQGZC8emMwG1n8McPDKc1b3catJ6Ama5Tb/e/21ssCVz3BTiyKI08fVllyWsJtFc9K/6l3M53DB2cbhj3CY0RMUBcDj16HIR3QdrEEdZ70Hg9cq1hOh3UVvbxEeSmTmOESmRJUKf5Z8b7lUFMuq+tAiqHP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Urdgh20n; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7179069d029so85104b3a.2;
        Wed, 04 Sep 2024 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509878; x=1726114678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IVs44o6ciGNOoB3tvSvkl1E7l7ddGpRPi+mMdxWbfc=;
        b=Urdgh20n+x7tD9FwoWeqC8l68BfjfLb9ePTnbd8tnwOzlU14beI8FAzD0tBaMURakN
         7DvV7KMNeRJS5eOzA8uJjHZhEmB9tB3ckoK2qpT2xT4Wx9N5/o/rHh3kqf1CAFldLQh+
         T7JH97RnKmkChPLeq2m7l+BXsAq9yHDHv+13AG5q4Ua5pAjxSRle4/WTEYcI8XvZK77x
         Nq7WBib5+KJ2eEZd4yB1/fJzuS04MdG2ofJPjx1b3rrNZ2/2pYk1dD3geGmbCtuf5VLT
         M8Xa2kZ9bURUav5qF2mksSa1OlfS4OI+FOvYNnXe2bsVsbPxuJEm82UfdTAkNjr++69R
         C9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509878; x=1726114678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IVs44o6ciGNOoB3tvSvkl1E7l7ddGpRPi+mMdxWbfc=;
        b=jU1Y3rQmYnhteKSul5/CEQ2Ou9lKCZ2u+S2nbZdZyJONXoryI778FP7W0Z0eO11T3y
         d6XcGhSoEezr2gNlLAgg6Z0ai2Xqf6ARFILmeB6l+fKnBJF+dHjUn6+ovHVnkSsjUCie
         HZsM1FgBGUnfkk2lgww/Gncr2vOL338DJJO4lF+GEnAZjbMBqVFxPBkzjPhkzrIBJLBU
         jNDUezYIuvzjNoN+0auKcvwHDWr92D0ef6mCgVg1Rll+fn0vS1qac2l978b8mC4gt+tk
         wxkTVhylsWkkMVY2CMch8sy0I6Sh5PZf3k3WIk7/g0ue9jogad+WOhtYCyJaa77InPAP
         m/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW+w/0qWEhaR3epYZJcizYOOThmNJwYXt3WIh7lXILhuJ1o6JJC63nSCj5Jq35qqMqPU0D7lbDv8C0AmznH@vger.kernel.org, AJvYcCXEq0dTy0nrK8d7rITmGa68BuT/yltfQdALqnVShg+34jmcCaGpxyxkk76i6J6m5uCuOL5Nki0E5F20sbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKcLYO9Yvu5z4uVaiQqj2rxkoS000EFUqq0q6lVJRfHLI9sNj
	pYL2quUthiMCt/mH9wqeJz4Jlq4wj2mL6wBZEAOaodQlepM690MwClvb+g==
X-Google-Smtp-Source: AGHT+IHw/pyP6EniZwd1+0N9t+8Gq3aDd7Fq8D4lnLSFHwaJBTj9phdK/nCIOoeA80+G8TcVQfUhXg==
X-Received: by 2002:a05:6a00:2da8:b0:70e:8070:f9d0 with SMTP id d2e1a72fcca58-7173fa40bcfmr14087981b3a.9.1725509878530;
        Wed, 04 Sep 2024 21:17:58 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:58 -0700 (PDT)
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
Subject: [PATCH 10/24] Input: gscps2 - use guard notation when acquiring spinlock
Date: Wed,  4 Sep 2024 21:17:15 -0700
Message-ID: <20240905041732.2034348-11-dmitry.torokhov@gmail.com>
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

Using guard notation makes the code more compact and error handling
more robust by ensuring that locks are released in all code paths
when control leaves critical section.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/gscps2.c | 114 +++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 52 deletions(-)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index d94c01eb3fc9..cf0603d1a113 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -145,7 +145,6 @@ static void gscps2_flush(struct gscps2port *ps2port)
 
 static inline int gscps2_writeb_output(struct gscps2port *ps2port, u8 data)
 {
-	unsigned long flags;
 	char __iomem *addr = ps2port->addr;
 
 	if (!wait_TBE(addr)) {
@@ -156,9 +155,8 @@ static inline int gscps2_writeb_output(struct gscps2port *ps2port, u8 data)
 	while (gscps2_readb_status(addr) & GSC_STAT_RBNE)
 		/* wait */;
 
-	spin_lock_irqsave(&ps2port->lock, flags);
-	writeb(data, addr+GSC_XMTDATA);
-	spin_unlock_irqrestore(&ps2port->lock, flags);
+	scoped_guard(spinlock_irqsave, &ps2port->lock)
+		writeb(data, addr+GSC_XMTDATA);
 
 	/* this is ugly, but due to timing of the port it seems to be necessary. */
 	mdelay(6);
@@ -177,19 +175,19 @@ static inline int gscps2_writeb_output(struct gscps2port *ps2port, u8 data)
 
 static void gscps2_enable(struct gscps2port *ps2port, int enable)
 {
-	unsigned long flags;
 	u8 data;
 
 	/* now enable/disable the port */
-	spin_lock_irqsave(&ps2port->lock, flags);
-	gscps2_flush(ps2port);
-	data = gscps2_readb_control(ps2port->addr);
-	if (enable)
-		data |= GSC_CTRL_ENBL;
-	else
-		data &= ~GSC_CTRL_ENBL;
-	gscps2_writeb_control(data, ps2port->addr);
-	spin_unlock_irqrestore(&ps2port->lock, flags);
+	scoped_guard(spinlock_irqsave, &ps2port->lock) {
+		gscps2_flush(ps2port);
+		data = gscps2_readb_control(ps2port->addr);
+		if (enable)
+			data |= GSC_CTRL_ENBL;
+		else
+			data &= ~GSC_CTRL_ENBL;
+		gscps2_writeb_control(data, ps2port->addr);
+	}
+
 	wait_TBE(ps2port->addr);
 	gscps2_flush(ps2port);
 }
@@ -203,15 +201,56 @@ static void gscps2_reset(struct gscps2port *ps2port)
 	unsigned long flags;
 
 	/* reset the interface */
-	spin_lock_irqsave(&ps2port->lock, flags);
+	guard(spinlock_irqsave)(&ps2port->lock);
 	gscps2_flush(ps2port);
 	writeb(0xff, ps2port->addr + GSC_RESET);
 	gscps2_flush(ps2port);
-	spin_unlock_irqrestore(&ps2port->lock, flags);
 }
 
 static LIST_HEAD(ps2port_list);
 
+static void gscps2_read_data(struct gscps2port *ps2port)
+{
+	u8 status;
+
+	do {
+		status = gscps2_readb_status(ps2port->addr);
+		if (!(status & GSC_STAT_RBNE))
+			break;
+
+		ps2port->buffer[ps2port->append].ste = status;
+		ps2port->buffer[ps2port->append].data =
+				gscps2_readb_input(ps2port->addr);
+	} while (true);
+}
+
+static bool gscps2_report_data(struct gscps2port *ps2port)
+{
+	unsigned int rxflags;
+	u8 data, status;
+
+	while (ps2port->act != ps2port->append) {
+		/*
+		 * Did new data arrived while we read existing data ?
+		 * If yes, exit now and let the new irq handler start
+		 * over again.
+		 */
+		if (gscps2_readb_status(ps2port->addr) & GSC_STAT_CMPINTR)
+			return true;
+
+		status = ps2port->buffer[ps2port->act].str;
+		data   = ps2port->buffer[ps2port->act].data;
+
+		ps2port->act = (ps2port->act + 1) & BUFFER_SIZE;
+		rxflags = ((status & GSC_STAT_TERR) ? SERIO_TIMEOUT : 0 ) |
+			  ((status & GSC_STAT_PERR) ? SERIO_PARITY  : 0 );
+
+		serio_interrupt(ps2port->port, data, rxflags);
+	}
+
+	return false;
+}
+
 /**
  * gscps2_interrupt() - Interruption service routine
  *
@@ -229,47 +268,18 @@ static irqreturn_t gscps2_interrupt(int irq, void *dev)
 	struct gscps2port *ps2port;
 
 	list_for_each_entry(ps2port, &ps2port_list, node) {
+		guard(spinlock_irqsave)(&ps2port->lock);
 
-	  unsigned long flags;
-	  spin_lock_irqsave(&ps2port->lock, flags);
-
-	  while ( (ps2port->buffer[ps2port->append].str =
-		   gscps2_readb_status(ps2port->addr)) & GSC_STAT_RBNE ) {
-		ps2port->buffer[ps2port->append].data =
-				gscps2_readb_input(ps2port->addr);
-		ps2port->append = ((ps2port->append+1) & BUFFER_SIZE);
-	  }
-
-	  spin_unlock_irqrestore(&ps2port->lock, flags);
-
+		gscps2_read_data(ps2port);
 	} /* list_for_each_entry */
 
 	/* all data was read from the ports - now report the data to upper layer */
-
 	list_for_each_entry(ps2port, &ps2port_list, node) {
-
-	  while (ps2port->act != ps2port->append) {
-
-	    unsigned int rxflags;
-	    u8 data, status;
-
-	    /* Did new data arrived while we read existing data ?
-	       If yes, exit now and let the new irq handler start over again */
-	    if (gscps2_readb_status(ps2port->addr) & GSC_STAT_CMPINTR)
-		return IRQ_HANDLED;
-
-	    status = ps2port->buffer[ps2port->act].str;
-	    data   = ps2port->buffer[ps2port->act].data;
-
-	    ps2port->act = ((ps2port->act+1) & BUFFER_SIZE);
-	    rxflags =	((status & GSC_STAT_TERR) ? SERIO_TIMEOUT : 0 ) |
-			((status & GSC_STAT_PERR) ? SERIO_PARITY  : 0 );
-
-	    serio_interrupt(ps2port->port, data, rxflags);
-
-	  } /* while() */
-
-	} /* list_for_each_entry */
+		if (gscps2_report_data(ps2port)) {
+			/* More data ready - break early to restart interrupt */
+			break;
+		}
+	}
 
 	return IRQ_HANDLED;
 }
-- 
2.46.0.469.g59c65b2a67-goog


