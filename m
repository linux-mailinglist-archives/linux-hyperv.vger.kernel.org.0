Return-Path: <linux-hyperv+bounces-1985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39F98A8A43
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 19:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020FA1C2083D
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A0172777;
	Wed, 17 Apr 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qNq0QV3M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HKSt3yqH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tqaEIGAh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c2+mUOpx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE317166F;
	Wed, 17 Apr 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375234; cv=none; b=q3DEsdgWvRLUchrvPASyFurgZV6QwpjEI+7emxNfLu747wbkdU5aB/AvIuwr2Fz+4SdWLvvegHA1qqacZG0M2lcHVtdb02Tb8jql9qrL7PXpfpeIi18TRr+J9nc2W1FAwbiuwvBtKm39pEW6fwRQasObrgISaF8YolF92EzXjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375234; c=relaxed/simple;
	bh=OM2L3ubKZfupLhceUgtc+iwiytrSfZLD94B+TJO8tcA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aRbp8t6BHNJjs+3KFYgFSaErRbmslV1ZS0+QErv9NLJdASXMBYj4I7GCDmr1T5gjmXwm242/3vgmlCoGkp04ZPH82eznu3a6HiT2vQ9Cu1qTDTZv3/uuE51nNtufj8x3zNLt3MM41K9V4uOi+gPJ6KS8JsgCacUiXPYU3yXDRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qNq0QV3M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HKSt3yqH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tqaEIGAh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c2+mUOpx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB60020CF4;
	Wed, 17 Apr 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713375230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIKW+2HJQaMrcRUTo8Oj9SqYWFpDcK/IIhYfve9qW5k=;
	b=qNq0QV3MNDgLTTMm+e+siNdXLjX+y3bE3UkmW9Dg7DrE9qRhVYTFOkBo52OD5PI7qnTeMW
	+heGmb0xmufd4e0RPsh1QysxVugbBsmhENxQ2NXUIuXjNgwk9Q+urazO5Aw3kVkwv/EaAi
	V4+r54vcZYfJXsbrCT88QyfSdowc1XU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713375230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIKW+2HJQaMrcRUTo8Oj9SqYWFpDcK/IIhYfve9qW5k=;
	b=HKSt3yqHDYLan4w2lTbIET2tbtIxBt9uvrvuSarrqVI7wPuUBFhcxw0HjbbgxUDjJkwtOh
	HJ0uoGDEPLFJ8/CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713375229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIKW+2HJQaMrcRUTo8Oj9SqYWFpDcK/IIhYfve9qW5k=;
	b=tqaEIGAh4hnUmE6cSaw+BQLS70cdW+aj6m0W8WuoXIdisdRVDwUFW5plVoSXdLSpsQmKHQ
	aza16jPGTToxbo23WYkOSCrzSPGCGQn2xuhClTGR/aATHtNIztkqKCbIkJUwpTvERWMsN4
	tmhkfoKhvQNQo6wsBvo5MoW9Ek1vT/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713375229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIKW+2HJQaMrcRUTo8Oj9SqYWFpDcK/IIhYfve9qW5k=;
	b=c2+mUOpxNFlfEra1G/J9zsp9XP6VWV6/UbF5lSjmUjI16tj9B/H2wHvHv1/NCczNpXqStD
	qIOwCOWPERzLWABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CCC41384C;
	Wed, 17 Apr 2024 17:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KBacB/0HIGaFEQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 17 Apr 2024 17:33:49 +0000
Message-ID: <a5cc2ca32f52f3dfce90e0a7e33656e3ee3a1a2e.camel@suse.de>
Subject: Re: [PATCH] firmware: dmi: Stop decoding on broken entry
From: Jean Delvare <jdelvare@suse.de>
To: Michael Kelley <mhklinux@outlook.com>, Michael Schierl <schierlm@gmx.de>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 17 Apr 2024 19:33:47 +0200
In-Reply-To: <SN6PR02MB415755044A025D66B4BC8955D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <b702b36b90b63b615d41e778570707043ea81551.camel@suse.de>
	 <SN6PR02MB415755044A025D66B4BC8955D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de,outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

Hi Michael,

On Wed, 2024-04-17 at 15:43 +0000, Michael Kelley wrote:
> From: Jean Delvare <jdelvare@suse.de> Sent: Wednesday, April 17, 2024 8:34 AM
> > 
> > If a DMI table entry is shorter than 4 bytes, it is invalid. Due to
> > how DMI table parsing works, it is impossible to safely recover from
> > such an error, so we have to stop decoding the table.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Link: https://lore.kernel.org/linux-kernel/Zh2K3-HLXOesT_vZ@liuwe-devbox-debian-v2/T/
> > ---
> > Michael, can you please test this patch and confirm that it prevents
> > the early oops?
> > 
> > The root cause of the DMI table corruption still needs to be
> > investigated.
> > 
> >  drivers/firmware/dmi_scan.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > --- linux-6.8.orig/drivers/firmware/dmi_scan.c
> > +++ linux-6.8/drivers/firmware/dmi_scan.c
> > @@ -102,6 +102,17 @@ static void dmi_decode_table(u8 *buf,
> >                 const struct dmi_header *dm = (const struct dmi_header *)data;
> > 
> >                 /*
> > +                * If a short entry is found (less than 4 bytes), not only it
> > +                * is invalid, but we cannot reliably locate the next entry.
> > +                */
> > +               if (dm->length < sizeof(struct dmi_header)) {
> > +                       pr_warn(FW_BUG
> > +                               "Corrupted DMI table (only %d entries processed)\n",
> > +                               i);
> 
> It would be useful to also output the three header fields: type, handle, and length,

I object. The most likely cause for the length being wrong is memory
corruption. We have no idea what caused it, nor what kind of data was
written over the DMI table, so leaking the information to user-space
doesn't sound like a good idea, even if it's only 4 bytes.

Furthermore, the data in question is essentially useless anyway. It is
likely to lead the person investigating the bug into the wrong
direction by interpreting essentially random data as type, handle and
length.

> and perhaps also the offset of the header in the DMI blob (i.e., "data - buf").

I could do that, as it isn't leaking any information, and this could be
used to compute the memory address at which the corruption was
detected, which is probably more useful than the number of the
corrupted entry. Thanks for the suggestion.

> When looking at the error reported by user space dmidecode, the first thing
> I did was add those fields to the error message.

And this did not give you any further insight, did it?

-- 
Jean Delvare
SUSE L3 Support

