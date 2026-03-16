Return-Path: <linux-hyperv+bounces-9469-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jHjwIud0uGk7egEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9469-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 22:23:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 093332A0DB7
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 22:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DFAC30AF590
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2C377EDB;
	Mon, 16 Mar 2026 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSQBK1iL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269E377ECD;
	Mon, 16 Mar 2026 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695663; cv=none; b=o/ICjAuiyoHgmubf82AJ15It2CgdDQsYb78FmdMBAG2qA23katJwNoUo0R4xg+BSluCTlr/otmB/w8qXSY+2fk040Drm1AAFq6CTETFSWclsTx6Li1wR4O4ZlH7sQSlCaiKs7gMPeOy5QYGVgKlQj/YC8l6Cyn+GM0IlvJsLj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695663; c=relaxed/simple;
	bh=dElPd1/2yYuQnbmBxFem9K254mqoyGxI5ua35pg5dJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ3uvhZZ95OPE6nu/yZA/Qtg7dJNs1fLVJZ8UWYIgAVQ87BnEmACJ3PqYFDuRuOrsQ2JVKZBBylUYHb63xmc5xG4MwfpbUICDe2P0zzjh9DYyOs/UnyBVefHWq/hRp5cSvOluD7Qh5NINHxd9MxbHgjDkp6/slGGM3SAupmfW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSQBK1iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9A6C2BCB1;
	Mon, 16 Mar 2026 21:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773695662;
	bh=dElPd1/2yYuQnbmBxFem9K254mqoyGxI5ua35pg5dJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WSQBK1iLku67+ML1WmdG5gvZLWS7LBzAh+jY1gRa2yWEDslVldYCYBTPugdDPtK3i
	 CJUPJvXQZ/W8O2eLGawpJj4z7/Gc/0AG/4/vE6vYrREysTXhDw+AehDa8KdJrBOSlC
	 XhH22ZMH6c73yrZxTi5u16TG0R08vkR0Hg/N25ka99GCvGxJVINDVuFd31W7b8egcK
	 vue6N3UbG8dGv7WpxgZ343wv1BtFDUqGFbAbGk7WlXYTrbd+eiSrkAi0pp+So15ggU
	 sTJ2YQNiWnWZSMjPaxJ+T1mbsuo+/9JntOuw+gRsL+gTD6u/BCWW3CJwONZsgLHGWx
	 bcXTswhvf3Pkw==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bodo Stroesser <bostroesser@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v2 16/16] mm: on remap assert that input range within the proposed VMA
Date: Mon, 16 Mar 2026 21:12:12 +0000
Message-ID: <4e152e7b8e1a93baf0777628eef9409d031cf8f6.1773695307.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773695307.git.ljs@kernel.org>
References: <cover.1773695307.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9469-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 093332A0DB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now we have range_in_vma_desc(), update remap_pfn_range_prepare() to check
whether the input range in contained within the specified VMA, so we can
fail at prepare time if an invalid range is specified.

This covers the I/O remap mmap actions also which ultimately call into this
function, and other mmap action types either already span the full VMA or
check this already.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 849d5d9eeb83..de0dd17759e2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3142,6 +3142,9 @@ int remap_pfn_range_prepare(struct vm_area_desc *desc)
 	const bool is_cow = vma_desc_is_cow_mapping(desc);
 	int err;
 
+	if (!range_in_vma_desc(desc, start, end))
+		return -EFAULT;
+
 	err = get_remap_pgoff(is_cow, start, end, desc->start, desc->end, pfn,
 			      &desc->pgoff);
 	if (err)
-- 
2.53.0


