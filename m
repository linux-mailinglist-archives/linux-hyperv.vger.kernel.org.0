Return-Path: <linux-hyperv+bounces-2966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7017696CDDE
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2845B284AAD
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0037C1925A9;
	Thu,  5 Sep 2024 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G88cEEzu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50E155393;
	Thu,  5 Sep 2024 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509895; cv=none; b=JTU3vn6W673uvgTkN28z7WHyx7Qf6e3ipIdKE+fVWc3Wc646tzLatyvYxrnrYCoCuEOInIOM4wx9a3dVxdabswOUZeR/VNgI5j3GQYJDnV4uQfVJDhweivaqqtiRPb2a3Cp/XuA3ObfropoNdqfXsIBZNTQeErEjoLDmGOdKw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509895; c=relaxed/simple;
	bh=cJYWxYF5OhQ8taYCVKZbQ3/a9KN9ESKsltEQmoM54CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y17GHb2Xu/LtNy+qAFJXqgm1LJBCuZbTgfPnWk8JR4ERueYNG+537nLPXPVjwXk81w1J1HLb6nOf8qX3xldom80tlW0mi5Hlo7X1U+HGhJ3FI5uSGwJ9rVP0hvCguqYZ+FNACS76h7uxqf8+3SOM5dwG9J03jkrFv+R4dc/pFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G88cEEzu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-715cdc7a153so246256b3a.0;
        Wed, 04 Sep 2024 21:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509893; x=1726114693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j96TxrzClXBkhwjMJZl6JNr36upS20Gw21hZhz5UEQc=;
        b=G88cEEzuTfHbOGDMiZtix5KnsuD5JHZeJV54m49kbPyeKOQGwd1MOiiggNgEiHPW6c
         2KfS7StYAQW2pwr3UVxlOPY1JmZ60XpKb0G8wy7nwF597GV8L7u2nUhoOA897FRj46s4
         M12tOGVGl0EVFui2GN3x9ClKtTeFU1Fq3r5JUDd+QTvZ1Ybb4TF+WzlEInuac6PHnVxJ
         /elmEU/Hu0wN/vvhk0/Js+tp8ibYn3L1q4yBvjoljPCFslcIrG6+QTkBCNkFJTiCp04h
         E7haNGRkOY6/5+O5jybfxk3GR4IVqmeRI6tZ0ZE/feb2YVasEipuZ3Ay3TvAfUoOJpux
         wmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509893; x=1726114693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j96TxrzClXBkhwjMJZl6JNr36upS20Gw21hZhz5UEQc=;
        b=OF6yW0l6t0cK/xkY3gaxsji7rd8fLCDH/jjRYByvgqZZ2AR2/94yxv+6NDTlk8nJpd
         iAGx4gQAAsap6VqYxG5i+VYcN1x1Zsmnsa+5QAuxfjZ91kKodxxi7plZcLwKQUSQvwQw
         Il+9/PO3yPFAYD0Ohto/h6a2pK9GscUZs2cPntD09KfohZJsqPyWlL0voqXvCR0HWKcC
         mtatpr9I9CxVx5WCl5hnlVNwk9O35FdWxzhaq58WLo/7KfrJtsHNLZbjjMySQAnkzN2c
         w/l8L8a0716FP3y7jxEDP7KDwTTGY+UZI7dcHVoXYmOZhJTgDUpw4oAkrAPcj3OmscZy
         nLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPol0KTULhLqJjdY1dpAAPrMp16zmu1Htkt2+lBfsWZKi74i6NX/3Jal4Fbrunpq4zeOqfykbsQdyor8o1@vger.kernel.org, AJvYcCVD1nw2JMeEXWMNnn/IbiaOxQRwsvUTM3tFO7uf8s5yvAJveSxxoFeo9nivRCI9+INslsJieySUg8V3QTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOv7UGt7u0gQCjQ4hnGziAA9lSekFvjmIaBRLIjjAtlZcp0aWQ
	fm7PymWAXSCGATyGupAxA370qPYYIvTauPrHLHymXXkhTn60Ec2A/wt0uw==
X-Google-Smtp-Source: AGHT+IEtbS6Hh36TyocrzyvtNt8382uDa9MHZZCYVlpcXz+bDRK1U/OJOVBLjLQwYZ/02bwTa26XXA==
X-Received: by 2002:a05:6a20:4c10:b0:1cc:d5d1:fe64 with SMTP id adf61e73a8af0-1cf0803a591mr6663245637.14.1725509893151;
        Wed, 04 Sep 2024 21:18:13 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:12 -0700 (PDT)
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
Subject: [PATCH 20/24] Input: serio_raw - use guard notation for locks and other resources
Date: Wed,  4 Sep 2024 21:17:25 -0700
Message-ID: <20240905041732.2034348-21-dmitry.torokhov@gmail.com>
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

Use guard notation when acquiring mutexes and spinlocks, and when
pausing and resuming serio port. Such guard notation makes the code
more compact and error handling more robust by ensuring that locks
are released in all code paths when control leaves critical section.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/serio_raw.c | 121 +++++++++++++-------------------
 1 file changed, 49 insertions(+), 72 deletions(-)

diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 0186d1b38f49..aef8301313b2 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -75,41 +75,31 @@ static int serio_raw_open(struct inode *inode, struct file *file)
 {
 	struct serio_raw *serio_raw;
 	struct serio_raw_client *client;
-	int retval;
 
-	retval = mutex_lock_interruptible(&serio_raw_mutex);
-	if (retval)
-		return retval;
+	scoped_guard(mutex_intr, &serio_raw_mutex) {
+		serio_raw = serio_raw_locate(iminor(inode));
+		if (!serio_raw)
+			return -ENODEV;
 
-	serio_raw = serio_raw_locate(iminor(inode));
-	if (!serio_raw) {
-		retval = -ENODEV;
-		goto out;
-	}
+		if (serio_raw->dead)
+			return -ENODEV;
 
-	if (serio_raw->dead) {
-		retval = -ENODEV;
-		goto out;
-	}
+		client = kzalloc(sizeof(*client), GFP_KERNEL);
+		if (!client)
+			return -ENOMEM;
 
-	client = kzalloc(sizeof(*client), GFP_KERNEL);
-	if (!client) {
-		retval = -ENOMEM;
-		goto out;
-	}
+		client->serio_raw = serio_raw;
+		file->private_data = client;
 
-	client->serio_raw = serio_raw;
-	file->private_data = client;
+		kref_get(&serio_raw->kref);
 
-	kref_get(&serio_raw->kref);
+		scoped_guard(serio_pause_rx, serio_raw->serio)
+			list_add_tail(&client->node, &serio_raw->client_list);
 
-	serio_pause_rx(serio_raw->serio);
-	list_add_tail(&client->node, &serio_raw->client_list);
-	serio_continue_rx(serio_raw->serio);
+		return 0;
+	}
 
-out:
-	mutex_unlock(&serio_raw_mutex);
-	return retval;
+	return -EINTR;
 }
 
 static void serio_raw_free(struct kref *kref)
@@ -126,9 +116,8 @@ static int serio_raw_release(struct inode *inode, struct file *file)
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
 
-	serio_pause_rx(serio_raw->serio);
-	list_del(&client->node);
-	serio_continue_rx(serio_raw->serio);
+	scoped_guard(serio_pause_rx, serio_raw->serio)
+		list_del(&client->node);
 
 	kfree(client);
 
@@ -139,19 +128,15 @@ static int serio_raw_release(struct inode *inode, struct file *file)
 
 static bool serio_raw_fetch_byte(struct serio_raw *serio_raw, char *c)
 {
-	bool empty;
+	guard(serio_pause_rx)(serio_raw->serio);
 
-	serio_pause_rx(serio_raw->serio);
-
-	empty = serio_raw->head == serio_raw->tail;
-	if (!empty) {
-		*c = serio_raw->queue[serio_raw->tail];
-		serio_raw->tail = (serio_raw->tail + 1) % SERIO_RAW_QUEUE_LEN;
-	}
+	if (serio_raw->head == serio_raw->tail)
+		return false; /* queue is empty */
 
-	serio_continue_rx(serio_raw->serio);
+	*c = serio_raw->queue[serio_raw->tail];
+	serio_raw->tail = (serio_raw->tail + 1) % SERIO_RAW_QUEUE_LEN;
 
-	return !empty;
+	return true;
 }
 
 static ssize_t serio_raw_read(struct file *file, char __user *buffer,
@@ -200,40 +185,32 @@ static ssize_t serio_raw_write(struct file *file, const char __user *buffer,
 {
 	struct serio_raw_client *client = file->private_data;
 	struct serio_raw *serio_raw = client->serio_raw;
-	int retval = 0;
+	int written;
 	unsigned char c;
 
-	retval = mutex_lock_interruptible(&serio_raw_mutex);
-	if (retval)
-		return retval;
+	scoped_guard(mutex_intr, &serio_raw_mutex) {
+		if (serio_raw->dead)
+			return -ENODEV;
 
-	if (serio_raw->dead) {
-		retval = -ENODEV;
-		goto out;
-	}
+		if (count > 32)
+			count = 32;
 
-	if (count > 32)
-		count = 32;
+		while (count--) {
+			if (get_user(c, buffer++))
+				return -EFAULT;
 
-	while (count--) {
-		if (get_user(c, buffer++)) {
-			retval = -EFAULT;
-			goto out;
-		}
+			if (serio_write(serio_raw->serio, c)) {
+				/* Either signal error or partial write */
+				return written ?: -EIO;
+			}
 
-		if (serio_write(serio_raw->serio, c)) {
-			/* Either signal error or partial write */
-			if (retval == 0)
-				retval = -EIO;
-			goto out;
+			written++;
 		}
 
-		retval++;
+		return written;
 	}
 
-out:
-	mutex_unlock(&serio_raw_mutex);
-	return retval;
+	return -EINTR;
 }
 
 static __poll_t serio_raw_poll(struct file *file, poll_table *wait)
@@ -379,10 +356,10 @@ static void serio_raw_hangup(struct serio_raw *serio_raw)
 {
 	struct serio_raw_client *client;
 
-	serio_pause_rx(serio_raw->serio);
-	list_for_each_entry(client, &serio_raw->client_list, node)
-		kill_fasync(&client->fasync, SIGIO, POLL_HUP);
-	serio_continue_rx(serio_raw->serio);
+	scoped_guard(serio_pause_rx, serio_raw->serio) {
+		list_for_each_entry(client, &serio_raw->client_list, node)
+			kill_fasync(&client->fasync, SIGIO, POLL_HUP);
+	}
 
 	wake_up_interruptible(&serio_raw->wait);
 }
@@ -394,10 +371,10 @@ static void serio_raw_disconnect(struct serio *serio)
 
 	misc_deregister(&serio_raw->dev);
 
-	mutex_lock(&serio_raw_mutex);
-	serio_raw->dead = true;
-	list_del_init(&serio_raw->node);
-	mutex_unlock(&serio_raw_mutex);
+	scoped_guard(mutex, &serio_raw_mutex) {
+		serio_raw->dead = true;
+		list_del_init(&serio_raw->node);
+	}
 
 	serio_raw_hangup(serio_raw);
 
-- 
2.46.0.469.g59c65b2a67-goog


