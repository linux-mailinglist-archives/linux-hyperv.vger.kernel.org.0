Return-Path: <linux-hyperv+bounces-11959-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZFaCKasOVWrjjQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11959-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 18:13:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63274D774
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 18:13:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=XZeBtsqO;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11959-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11959-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACADB30059B6
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3EC3396EE;
	Mon, 13 Jul 2026 16:13:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2325B0AA;
	Mon, 13 Jul 2026 16:13:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959209; cv=none; b=ApyZ1Zuz6Aj07gAnHKfXBV1T7eyRbDPRAGjpPO5ya7VeUJ0BJ8+S83dWtzUv0gUoeOQpFrYLZk1x79/2KnLrsnVQ2oVLzqYBku/1fKhgYA0laYuT9NnWSP0dmu5Upla+ogf65Q5L43IBRffyRD2zYx5C8pVCoTqyLzq+9ewJ6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959209; c=relaxed/simple;
	bh=87+DyGXvAKm5IXJiKbRVm11dCASshYHur0HdtyBZK18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoGrscXX/fTdHG+F1G+arMORYtBuvBoBHuNOGXYjJiqQ15ye7RGf4PUnxT9xiT/21nphXYm1FwXm+zujMdz1C2jQ3B1fC5MaAPZmmsLH3hEUR8dbZYVX8jp51MGhairHiFJzb7sUzt7Azq1DkI83zAKXTyp3C3nRotrStAvwkqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XZeBtsqO; arc=none smtp.client-ip=13.77.154.182
Received: from localhost (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id DEA4520B716F;
	Mon, 13 Jul 2026 09:13:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEA4520B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783959199;
	bh=eeKOrgOt+xXm+V5IRef1lDOmRNhHqtuxeaF/QYex0Kk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZeBtsqOdJFY4BYYsLd+wm1yi+LZ8NbE8VsdAstHLGM5iSE3p7geCt0pHWkLfZOXI
	 DMBuxTymJLCT1F5m8zAUPQOJ5YsfC1h79HtjvhjMM7+Kf0Lwx9KCdlWDfKJW/W8voN
	 HSbtdm71FNrpf0fRvLi11OcwBg0H17iZziutadVw=
Date: Mon, 13 Jul 2026 09:13:28 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
 <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
 <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
 "easwar.hariharan@linux.microsoft.com"
 <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
 <mrathor@linux.microsoft.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260713091328.00004fc9@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
	<20260702160518.311234-4-zhangyu1@linux.microsoft.com>
	<SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<enpkphavwmqrkded73c43vprczslvei4755lkxuedof4z2k3kk@y2jtklbk4efz>
	<SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:zhangyu1@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,m:jacob.pan@linux.microsoft.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11959-lists,linux-hyperv=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D63274D774

Hi Michael,

On Sat, 11 Jul 2026 18:31:15 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> One new thought:  Have you considered the hibernate/resume
> cycle? Does anything need to be done with the pvIOMMU to
> make it functional again after resume? I see that the Intel and
> AMD IOMMU drivers have suspend and resume functions. I
> don't know enough about the Hyper-V pvIOMMU to know if it
> might also need suspend and resume functions.

I don't think the Hyper-V pvIOMMU guest driver needs the same kind of
suspend/resume handling as a hardware IOMMU driver. Unlike VT-d or AMD
IOMMU, the guest driver does not own physical IOMMU registers, root
tables, command queues, or translation enable state that must be saved
and reprogrammed on resume.

For nested translation, the guest does own the stage-1 I/O page tables,
but those are normal guest memory. They survive S3 as system RAM. The
guest driver still needs to issue the normal pvIOMMU invalidations when
it changes S1 mappings, but suspend/resume by itself does not modify
the S1 page tables and should not require a special flush.

The important contract is on the Hyper-V side: Hyper-V owns translation
enable/disable and must prevent device DMA while translation state is
not valid.

Thanks,

Jacob

