Return-Path: <linux-hyperv+bounces-9375-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHaPHEcis2m5SQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9375-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:29:59 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E4A27929C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 21:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B7E32069BA
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795FF390229;
	Thu, 12 Mar 2026 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsS71PUH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB638C2AB;
	Thu, 12 Mar 2026 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347276; cv=none; b=D71LUD/yEzbWNt7Z2dMEXdSeyjnTcbBmXcKwoX/mBwbCQeN9lT7u3os1La3Vj31m/+oVT3oiYtWh2CDlH6jo8wvRkewt1kBp3V2XkYp/fTpyzQXOLkz0u6hR0viweJkSpXaCA2yaEtwa9Jd6uPx5rDSE6xYLlnx3YTCPsvAPndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347276; c=relaxed/simple;
	bh=i54y1Tun/I2Qyiaxccl3VCrf2xJ8vhDj89GLGQXebTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDIP+DEnZY6Rzd9ZUUtFHUZH/3SnePDXyX9/F31Mbe3PV/HrmitXfsWdKMWPhmJBVDbgSfFlPDjeYh5g/x6eZ5INxMp799Ki3r6W3OAON0mGV592htJ5J7o5OiYJFrx30niWhjWsj2m9FgXsjTv5Bkrmuk5avQExxYCECY2ql+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsS71PUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98623C19425;
	Thu, 12 Mar 2026 20:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773347276;
	bh=i54y1Tun/I2Qyiaxccl3VCrf2xJ8vhDj89GLGQXebTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsS71PUHhRME0/Uaazil3ddVQ6x1Nb+tS7PiTgEVD3BJWwzqK8TUuX/9qhmUpPZrw
	 Lg4mKIQkhpz4fU4hbDMTO9EUrAQT4wlbcLoCZKdOcCz+NZfjl8Q+mOJ+dIvGxVyjeu
	 ZS2is9c15J1TzVd2xFPIwYoozs+M9rRtHBaugZoVSZxArBJOvWnx8P1BE7Qyzx+NPC
	 d+nTISxjbSWvliCR1dzZZaWzKZ98G6sVj1YraiW2aZeukEi5vBTj0TkAo5/yilEylN
	 4qu8Q9EjngqPWWnJPTITewHgtWG6cFZT4G6UhH8g4Litr+0pJtyuOinB8M16lsR4oN
	 HvVHEGxDVmvjg==
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
Subject: [PATCH 03/15] mm: document vm_operations_struct->open the same as close()
Date: Thu, 12 Mar 2026 20:27:18 +0000
Message-ID: <52a7b9a003ea51521ab3c0baf30337a7800a3af7.1773346620.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773346620.git.ljs@kernel.org>
References: <cover.1773346620.git.ljs@kernel.org>
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
	FREEMAIL_CC(0.00)[lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_FROM(0.00)[bounces-9375-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9E4A27929C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Describe when the operation is invoked and the context in which it is
invoked, matching the description already added for vm_op->close().

While we're here, update all outdated references to an 'area' field for
VMAs to the more consistent 'vma'.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc5960a84382..12a0b4c63736 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -748,15 +748,20 @@ struct vm_uffd_ops;
  * to the functions called when a no-page or a wp-page exception occurs.
  */
 struct vm_operations_struct {
-	void (*open)(struct vm_area_struct * area);
+	/**
+	 * @open: Called when a VMA is remapped or split. Not called upon first
+	 * mapping a VMA.
+	 * Context: User context.  May sleep.  Caller holds mmap_lock.
+	 */
+	void (*open)(struct vm_area_struct *vma);
 	/**
 	 * @close: Called when the VMA is being removed from the MM.
 	 * Context: User context.  May sleep.  Caller holds mmap_lock.
 	 */
-	void (*close)(struct vm_area_struct * area);
+	void (*close)(struct vm_area_struct *vma);
 	/* Called any time before splitting to check if it's allowed */
-	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
-	int (*mremap)(struct vm_area_struct *area);
+	int (*may_split)(struct vm_area_struct *vma, unsigned long addr);
+	int (*mremap)(struct vm_area_struct *vma);
 	/*
 	 * Called by mprotect() to make driver-specific permission
 	 * checks before mprotect() is finalised.   The VMA must not
@@ -768,7 +773,7 @@ struct vm_operations_struct {
 	vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order);
 	vm_fault_t (*map_pages)(struct vm_fault *vmf,
 			pgoff_t start_pgoff, pgoff_t end_pgoff);
-	unsigned long (*pagesize)(struct vm_area_struct * area);
+	unsigned long (*pagesize)(struct vm_area_struct *vma);
 
 	/* notification that a previously read-only page is about to become
 	 * writable, if an error is returned it will cause a SIGBUS */
-- 
2.53.0


