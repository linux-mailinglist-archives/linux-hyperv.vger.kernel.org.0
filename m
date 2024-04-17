Return-Path: <linux-hyperv+bounces-1982-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A678A87B3
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 17:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F36282D14
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA721474DA;
	Wed, 17 Apr 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yh08Z7Ry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/OjCaona";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yh08Z7Ry";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/OjCaona"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C09147C6D;
	Wed, 17 Apr 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368024; cv=none; b=NbiU31+cIHQTso6Y9u1Yp5FxwHlNGudUwUME3LP9WqZPyhYZ5zVA8XrwE3welnWyPM1MeSeCVkp83Xm/wgwpv4SQE4i4wfYQyKQDc3Okm/TkXPZiYVeN0l6Tvra2ihNNaUDAzEig4R2DBNZJYpBdDuq76OL8l08FO5f6dJqj6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368024; c=relaxed/simple;
	bh=z4xdnmvSlM4ErphcHTjBQHmq8728znhdZOdtFL1RS9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=kJuztUVUb1DBlSOGgMVqU9LIDdQOYDtBWH0DbgbssQBLlSLZCsmcqSlxTBFz/Ve0EQVRtbIztG+IaThmKeY2qBk0Li+PmVHh3H1XI3VpvkQpDBE62Xp3KKbIdggkyfCj+9KojQBabGydh0iATZ9MOWqwu7+LjZJpqjHTBDJf1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yh08Z7Ry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/OjCaona; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yh08Z7Ry; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/OjCaona; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 822CA33E51;
	Wed, 17 Apr 2024 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713368015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VuKnNaKUeQ9SJ3jWfyd0fdlNcPS7skWvdmgj3sD0E3w=;
	b=yh08Z7RyxeWTfmzuZreHxBUECDczM1rMSJas/xS8LSQa8/hjAsULZYOm0AWBQksb0i2Fvp
	gRoAhn1MAnCe25Ua1cCLCU/0/h4mV3Aczs0MRMuu0EvTtWJVXpcgZJtIjaBT1hFQljyPa2
	FNXTK1er79ADShDGZoKtOsKt1WmdtUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713368015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VuKnNaKUeQ9SJ3jWfyd0fdlNcPS7skWvdmgj3sD0E3w=;
	b=/OjCaona8ocShcErlgs0HFzuIFxMAOlRRtd+kf8/o9Cvmpxg68hyCGFMXe0ijcUVUVbRPX
	Q7aJkzp3+cVNzxBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713368015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VuKnNaKUeQ9SJ3jWfyd0fdlNcPS7skWvdmgj3sD0E3w=;
	b=yh08Z7RyxeWTfmzuZreHxBUECDczM1rMSJas/xS8LSQa8/hjAsULZYOm0AWBQksb0i2Fvp
	gRoAhn1MAnCe25Ua1cCLCU/0/h4mV3Aczs0MRMuu0EvTtWJVXpcgZJtIjaBT1hFQljyPa2
	FNXTK1er79ADShDGZoKtOsKt1WmdtUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713368015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VuKnNaKUeQ9SJ3jWfyd0fdlNcPS7skWvdmgj3sD0E3w=;
	b=/OjCaona8ocShcErlgs0HFzuIFxMAOlRRtd+kf8/o9Cvmpxg68hyCGFMXe0ijcUVUVbRPX
	Q7aJkzp3+cVNzxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEA871384C;
	Wed, 17 Apr 2024 15:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TP+8J87rH2b8ZAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 17 Apr 2024 15:33:34 +0000
Message-ID: <b702b36b90b63b615d41e778570707043ea81551.camel@suse.de>
Subject: [PATCH] firmware: dmi: Stop decoding on broken entry
From: Jean Delvare <jdelvare@suse.de>
To: Michael Schierl <schierlm@gmx.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Kelley <mhklinux@outlook.com>
Date: Wed, 17 Apr 2024 17:33:32 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.18
X-Spam-Level: 
X-Spamd-Result: default: False [-3.18 / 50.00];
	BAYES_HAM(-1.88)[94.33%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de,outlook.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

If a DMI table entry is shorter than 4 bytes, it is invalid. Due to
how DMI table parsing works, it is impossible to safely recover from
such an error, so we have to stop decoding the table.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Link: https://lore.kernel.org/linux-kernel/Zh2K3-HLXOesT_vZ@liuwe-devbox-debian-v2/T/
---
Michael, can you please test this patch and confirm that it prevents
the early oops?

The root cause of the DMI table corruption still needs to be
investigated.

 drivers/firmware/dmi_scan.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux-6.8.orig/drivers/firmware/dmi_scan.c
+++ linux-6.8/drivers/firmware/dmi_scan.c
@@ -102,6 +102,17 @@ static void dmi_decode_table(u8 *buf,
 		const struct dmi_header *dm = (const struct dmi_header *)data;
 
 		/*
+		 * If a short entry is found (less than 4 bytes), not only it
+		 * is invalid, but we cannot reliably locate the next entry.
+		 */
+		if (dm->length < sizeof(struct dmi_header)) {
+			pr_warn(FW_BUG
+				"Corrupted DMI table (only %d entries processed)\n",
+				i);
+			break;
+		}
+
+		/*
 		 *  We want to know the total length (formatted area and
 		 *  strings) before decoding to make sure we won't run off the
 		 *  table in dmi_decode or dmi_string

-- 
Jean Delvare
SUSE L3 Support

