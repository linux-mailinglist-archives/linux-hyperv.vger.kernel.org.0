Return-Path: <linux-hyperv+bounces-1994-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D718A99BE
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 14:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C8A28251D
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE615F411;
	Thu, 18 Apr 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c+frCZT7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hohUDKmb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c+frCZT7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hohUDKmb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C215F405;
	Thu, 18 Apr 2024 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443262; cv=none; b=YQcWyDH0d1G8kYbsWnnhheQfwnuYfDgaJL1sYb6J74Iz7bxTP3livlgthPfPPCB23U/ENzd2hHTMlakaSiwMsgB5lS5pyCX5Mqtj+xha9qTfIB2C/pOSLWD22Lbte5ZNjRMJIpQUhJBZqtJansIbCT2kXTilnKn4+Y6sEEQOr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443262; c=relaxed/simple;
	bh=pATeS5SPR6X8cLAtFccaCt0+DXe5ZptNwFh+l7hFbzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bK7SlSWLagmjf34jzuaY4W6LEs55Bw8sP9wAUV0HKRIPLDlj6AOgajn1lsy+NhNhlq05V/h3eWnGnwqOVnnJY6KEy8l7JYn6KKfKhq1kbreYOkw2VSq6VQCVMfN2XElvgw3PmwBM5xhH0AsD8bT99mcDZMIBfNdoKoYFp3cB5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c+frCZT7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hohUDKmb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c+frCZT7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hohUDKmb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 939EA5CA72;
	Thu, 18 Apr 2024 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713443258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iacDreTbLiNlUPYvwqy/30EORNDWG1S3S2E0kuUcCNE=;
	b=c+frCZT7hbNPKmkRaTVa+XlOe1+FcDcaRSIGfpEIWLG0f3/FguLbbsWrOA6Ythm6x1AcDR
	Do0xmHuYQL9cyRqQsDihzRKAxag0BnhJZYZR1HMAjlCj4/3EcJqNKkYyXW0xRWDPDaX577
	IogtWDi1/wU9ZqRxIOzhJkjaDyhR+hQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713443258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iacDreTbLiNlUPYvwqy/30EORNDWG1S3S2E0kuUcCNE=;
	b=hohUDKmb2sC4HKhlB15tjpKVe69ZXufxX7ytFpa2CLdUrxVa+y46FACYMoTbrGpLXyAquc
	Rh1EdRZYn+G6MEDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c+frCZT7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hohUDKmb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713443258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iacDreTbLiNlUPYvwqy/30EORNDWG1S3S2E0kuUcCNE=;
	b=c+frCZT7hbNPKmkRaTVa+XlOe1+FcDcaRSIGfpEIWLG0f3/FguLbbsWrOA6Ythm6x1AcDR
	Do0xmHuYQL9cyRqQsDihzRKAxag0BnhJZYZR1HMAjlCj4/3EcJqNKkYyXW0xRWDPDaX577
	IogtWDi1/wU9ZqRxIOzhJkjaDyhR+hQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713443258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iacDreTbLiNlUPYvwqy/30EORNDWG1S3S2E0kuUcCNE=;
	b=hohUDKmb2sC4HKhlB15tjpKVe69ZXufxX7ytFpa2CLdUrxVa+y46FACYMoTbrGpLXyAquc
	Rh1EdRZYn+G6MEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB7F613687;
	Thu, 18 Apr 2024 12:27:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T67NLrkRIWYeeAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 18 Apr 2024 12:27:37 +0000
Date: Thu, 18 Apr 2024 14:27:34 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Michael Schierl <schierlm@gmx.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, Michael 
 Kelley <mhklinux@outlook.com>
Subject: [PATCH v2] firmware: dmi: Stop decoding on broken entry
Message-ID: <20240418142734.56e1db4b@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de,outlook.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 939EA5CA72
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

If a DMI table entry is shorter than 4 bytes, it is invalid. Due to
how DMI table parsing works, it is impossible to safely recover from
such an error, so we have to stop decoding the table.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reported-by: Michael Schierl <schierlm@gmx.de>
Link: https://lore.kernel.org/linux-kernel/Zh2K3-HLXOesT_vZ@liuwe-devbox-debian-v2/T/
Tested-by: Michael Schierl <schierlm@gmx.de>
---
Changes since v1:
 * Also log the offset of the corrupted entry (suggested by Michael Kelley)

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
+				"Corrupted DMI table, offset %ld (only %d entries processed)\n",
+				data - buf, i);
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

