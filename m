Return-Path: <linux-hyperv+bounces-9934-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ57GnzRzmmUqQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9934-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 22:28:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2D38DF7A
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E8853021D29
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9438A28F;
	Thu,  2 Apr 2026 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="LxRjB6ge"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4338B130;
	Thu,  2 Apr 2026 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161493; cv=pass; b=NMa5ikLzDWi7WS5XaNxmlOTS48/5WapQsb2Mw1+tC5UHomMi7L8t4BXDP+inHBVwuE7krTlSDg0V40A4TIFXQXkNo4vSRWv4bSNVtpdp6Vwh6DcyaJ7tC9RN6nKhtv/yCWxX9ivTrKHIPUuBsCZLvPDTQIjKmE0/dBcHVhpabAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161493; c=relaxed/simple;
	bh=03RF4KeQ/xnblDJhLUZtHEu4Op7r7ubllEHEOV5X2Yg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QSM+UDcVDEgpwNviQ84x5iQfVO8cfoRs3CDC969wZOujMR+tu5nJ+3F2xT00q5B/NaNg+6Xi2KMJkVQXjQKIYWhKnudWJUsln3ddwIVsoCHoW4njwXQOqbs7p8bDI+I03SFRFLAYUdB6pq/mQs023HOeVefj9Xl+BiB8blSXFnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=LxRjB6ge; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1775161456; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fmPEdTfYum23L4/XMkr7ny63aE1Wy/qZav2TyP5A55r5QSSqDPCRNrwxyQL8C0qSytkTXJqfARcUFzmXiDKKJNlwWiBoyPABGZ6ZDKgeFhZ+q7f5C233byOCv1OPilnoflfUqcOAxEdsCYD5mQDlrWYevrVT/IoZXpiENRHVHGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775161456; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=Yx2LAQiBJWfTpQIDMVRndHir67rfUq+ingH4MsENbpo=; 
	b=I+QeEeo/7z+xcjRT0XzVBH77B3CXarJ+nAezeev92WALRjXTfjrmmrsjrPaF8FSxPxi9FXCliOp0mX44f7h22h0obwTYUKwQ08s0qrZt/akhDZE/JBbSzzUpJzirQNX/71oBoTKJZvjiULh2ywFLstXGx9xtGSVhFGxxApaHVuM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775161456;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Cc;
	bh=Yx2LAQiBJWfTpQIDMVRndHir67rfUq+ingH4MsENbpo=;
	b=LxRjB6gem/VcajRwacErUqSH25C/zy+gOcaO28a39AyelR14l9KOUNzTw8G41P5k
	g34TsoEOfNUQZ0Njzhlq220bGvQ9kWNreRsTrU1ap4JvmqEZGn/9n3g1MMBVHwq15NU
	4na7lB/pCu88Rf+BzICiQfpYeMOrKFXnZgKw4v9w=
Received: by mx.zohomail.com with SMTPS id 1775161452619292.11831640902676;
	Thu, 2 Apr 2026 13:24:12 -0700 (PDT)
From: Michael Kelley <mhklkml@zohomail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	maz@kernel.org,
	bigeasy@linutronix.de,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 0/2] genirq and Hyper-V: Clean up handling of add_interrupt_randomness()
Date: Thu,  2 Apr 2026 13:23:58 -0700
Message-Id: <20260402202400.1707-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227f0e4149f05ef255093bd9abd0000cda5f05ce408d220dc3aa07a3ebf9ee3a8f1c86421a775dddf:zu08011227cedaeabdc532e74d7eb828e200000241a25521f4c979cc514025ff92cf8bd0a6089f278edaa249:rf0801122ca11b5ffb0b618a82f410ddd0000024137e52f1015226ed8d011ee68d38769903caac4c558d8876b45cc508e7:ZohoMail
X-ZohoMailClient: External
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9934-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:replyto,zohomail.com:dkim,zohomail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8F2D38DF7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Kelley <mhklinux@outlook.com>

The Hyper-V ISRs are calling add_interrupt_randomness() as a
primary source of entropy in VMs, since the VMs don't have another
good source. The call is currently in the ISRs as a common place to
handle both x86/x64 and arm64. On x86/x64, hypervisor interrupts come
through a custom sysvec entry, and on arm64 they come through an
emulated GICv3. GICv3 uses the generic handler handle_percpu_devid_irq(),
which does not do add_interrupt_randomness(), unlike its counterpart
handle_percpu_irq().

Cleanup this somewhat confusing situation by doing the
add_interrupt_randomness() in handle_percpu_devid_irq(), and remove
it from the Hyper-V ISRs. Then only the Hyper-V custom sysvec path,
which plays the role of a generic interrupt handler, needs to do
add_interrupt_randomness(). As a result of this change, no
device drivers are calling add_interrupt_randomness(), which is
appropriate.

The change is broken into two patches since it spans generic
interrupt handling code and Hyper-V specific code. But the two
patches should be taken together through the same tree. It's
OK to have a bisect window where add_interrupt_randomness() is
done in both places, but taking the Hyper-V patch first could leave
a bisect window where add_interrupt_randomness() is not done in
either place.

Michael Kelley (2):
  genirq/chip: Do add_interrupt_randomness() in
    handle_percpu_devid_irq()
  Drivers: hv: Move add_interrupt_randomness() to hypervisor callback
    sysvec

 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 drivers/hv/mshv_synic.c        | 3 ---
 drivers/hv/vmbus_drv.c         | 3 ---
 kernel/irq/chip.c              | 3 +++
 4 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.25.1


