Return-Path: <linux-hyperv+bounces-8585-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPYQMIWCe2mvFAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8585-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 16:53:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D52B1AE7
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5D62300638B
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1121A444;
	Thu, 29 Jan 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGGgOVh4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA214E2F2
	for <linux-hyperv@vger.kernel.org>; Thu, 29 Jan 2026 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701922; cv=none; b=unhV5cPduI9EiMWe7ddKGQaXIofsQujehrhKS30x8ixsnvw2aU+SMXMPiR9HsTVeCfvwvaA65w0XJHpj7kb2o1rIdSDrJBjWKGzDrJBb9LiKPWTP+4bO8KAvcJCfNc6Rsfr+e821fBb1zn27zJ4Orfw18fp7gt/H/PVtcYopv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701922; c=relaxed/simple;
	bh=NO+fiRumn7KoZ7PSTAeJV87vt5PU1U9wXLeYYEWzSto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tvk7L783Ia7pbRbn0NJkEz3qSxZVSjICkCkmf5CvCSt7p2gFJ15FtI4s8oZAeUzRh/fznJ+6r3N7IvAA/DR3dQ0/U6w7L6iwJEyK5DOfkYaCr0KwI9uZl4zZvcIgePT9p1Ng0C6ekwK0Bz715JUr4ExBFNMyBv3AWbg8CLG/UOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGGgOVh4; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0d67f1877so7049595ad.2
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Jan 2026 07:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769701920; x=1770306720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJlzyqmv4WLBf0ez9Dt+WeFT8QaTCnpA0lcmS7CpNIo=;
        b=dGGgOVh4vvj36tKxL+/bOVHpmVViMiVGg6URqy6UDxYnvDs3drcqPZ8YK53OfFsWFC
         eShN0nr5PH6xlG+HMLYOH4Jyb5kfENn+87xWhLG7daLdaEDo7AJRkSKRJ7ou9ezPqGWy
         UfYwS9/INrxFZJFWcFSGzkx36f9+qXXW1eOQsRWsVjS2Twn+4emP7ki814plvfGXJ7ZS
         tahI585SjW8vmnFkB71bR1BbfLqp0fcEW34dz9s9de6ylS8gY6EcvnVhx3MxdjPWdx9k
         KhrCTnVF4Zl5L2ZT8x/v3hogTYMF8IV51iRsii61s6y/QFNDVqe+LVGFPjY6rYcYqvxA
         X3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769701920; x=1770306720;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJlzyqmv4WLBf0ez9Dt+WeFT8QaTCnpA0lcmS7CpNIo=;
        b=we7H/wst7ZtflMNgoLtqnKcl3X4DHq9YclE80FNOE1r9DNYgyizyJcdTqG0nx+gFd+
         MlreLq25h+zYe+NqChm7e5E+yWalKU35XCzr6fYsnW6SfdEhH47X0rgZUds2828kOb8Z
         V7/bIc+JfyvBJ53nFj9Ydg7gsaGBfroIzCUporHdFXiu4353Mb6cVPRfxjZ96pPDKsAH
         YLznDnaFrJPx38H4qiJAruiPLdOAyxozv4sBs33wG7xBnSD+YyydLsR45Uy4v5GdAS+3
         ouDrBfQx9/Osy3GNGimbSgx+9zC3rSfGpTFxfZjv0V0IioG4iZMRhHhiAMo5lWcrkHJL
         nWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrfHqZj/EgiMSz5a/RrrxYAH6hbZc3EKEWY5QRX+MH2mbwgPzaTsoRGInlRbri+f7UvVcLPzxCiKsrNcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4p/uKzpVVcS5dRkgfj9agAvbwge06q8bwJN/tfyD00WrjGYK
	bH7olMvuWEFT3uM6PStigMnlR2BjxaD1hvr17BA+9vEgWZNxd6Pi3Vdc
X-Gm-Gg: AZuq6aKvtRAWboO0ukNFr12dIiWmgC8vIwM0Nxu8tKJ70XKUnVlb+lPB534Z3LSZ5Hr
	9teTq10O8UpYO6SZOmY//eH2JMcImFCF94Asyv7j3MTIBhCX8VggRGuXeUnuGax52Rh5CtQxUxa
	PoWsZrSoEr9gYWXvUu/1+sUPJcEwP81eraStJDN7ZoPwSvfsP9fGq6izC3XlxrLr0ENxFFvbcEF
	qmKR1lxL36eekyTINSraj2dA27PGZWhRkTYF8SuXBMSYwkTZe4J2wzcS08pAmZjgNxJ5rMvTXXa
	IY+r6YKJ5uiTZAVHVvg6x/veqWNQaqYoAhHnIwsoLw+3e4C8AKW2hlriBdoiLETM9nrbtYRdXPv
	EmKGBX1MzhFBWeGKoiz00Q7qlrS9uoWSJnSnNkLdRkbJhVV6DFAPQYZndP7B9VUDw+V2CsiGQum
	hjbErDKWq0Tx5zlE7WSDcHjVdyaa9oMFNbp4zxA38gZc2WvT+qFxvJ2ZMLdOmiFWRCL7J04Tp64
	fqh
X-Received: by 2002:a17:902:db0d:b0:2a7:cf3e:506d with SMTP id d9443c01a7336-2a870eb4350mr85777575ad.60.1769701920193;
        Thu, 29 Jan 2026 07:52:00 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d985asm53878735ad.73.2026.01.29.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:51:59 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mshv: Use EPOLLIN and EPOLLHUP instead of POLLIN and POLLHUP
Date: Thu, 29 Jan 2026 07:51:54 -0800
Message-Id: <20260129155154.484671-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM_DOM(3.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8585-lists,linux-hyperv=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhkelley58@gmail.com,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,outlook.com:replyto,outlook.com:email,outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24D52B1AE7
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com>

mshv code currently uses the POLLIN and POLLHUP flags. Starting with
commit a9a08845e9acb ("vfs: do bulk POLL* -> EPOLL* replacement") the
intent is to use the EPOLL* versions throughout the kernel.

The comment at the top of mshv_eventfd.c describes it as being inspired
by the KVM implementation, which was changed by the above mentioned
commit in 2018 to use EPOLL*. mshv_eventfd.c is much newer than 2018
and there's no statement as to why it must use the POLL* versions.
So change it to use the EPOLL* versions. This change also resolves
a 'sparse' warning.

No functional change, and the generated code is the same.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601220948.MUTO60W4-lkp@intel.com/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/mshv_eventfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 0b75ff1edb73..dfc8b1092c02 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -295,13 +295,13 @@ static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
 {
 	struct mshv_irqfd *irqfd = container_of(wait, struct mshv_irqfd,
 						irqfd_wait);
-	unsigned long flags = (unsigned long)key;
+	__poll_t flags = key_to_poll(key);
 	int idx;
 	unsigned int seq;
 	struct mshv_partition *pt = irqfd->irqfd_partn;
 	int ret = 0;
 
-	if (flags & POLLIN) {
+	if (flags & EPOLLIN) {
 		u64 cnt;
 
 		eventfd_ctx_do_read(irqfd->irqfd_eventfd_ctx, &cnt);
@@ -320,7 +320,7 @@ static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
 		ret = 1;
 	}
 
-	if (flags & POLLHUP) {
+	if (flags & EPOLLHUP) {
 		/* The eventfd is closing, detach from the partition */
 		unsigned long flags;
 
@@ -506,7 +506,7 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	 */
 	events = vfs_poll(fd_file(f), &irqfd->irqfd_polltbl);
 
-	if (events & POLLIN)
+	if (events & EPOLLIN)
 		mshv_assert_irq_slow(irqfd);
 
 	srcu_read_unlock(&pt->pt_irq_srcu, idx);
-- 
2.25.1


