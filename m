Return-Path: <linux-hyperv+bounces-11551-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MHkAFTP+J2pC6wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11551-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 13:51:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B8165FA9F
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 13:51:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=JgSJ4sWT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11551-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11551-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86559305BDE2
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D02403EBA;
	Tue,  9 Jun 2026 11:49:32 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9A40242D
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 11:49:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005772; cv=none; b=PHvsqXmM0smQAj0QduOYSh6BcGN4/mS8l8bH5cj/AqhQSukdsxEaEh2I7HlquYHg77lXWVs5XAbnWo653GhuXM2ae5jVye/OXxXNfV8zDsbiHx6Rhzi/7SNJ1aHd7Yaz5DpbtubLfRElAevusAO4h7JP7Dfo80BOXHyKDO4UnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005772; c=relaxed/simple;
	bh=AQlTHCAUcnJdv1m+pmGag6GQApfhe6eyzN3aJK86Vsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFqx1dcp+z69BEjRS7HCSHm1HTW86P6t1o5ZEUgdgGsQEJU1TSTEmvLXF/kOqiPibemROlymGcVUBBZttgVvS7EotYlDS498o1vWQU1fHUQzGGIYTvKkpmUlAvgCIhzeWxTous4YkKZD/sDCl9pHvvlZKAcvrJQHr85a2Jla5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JgSJ4sWT; arc=none smtp.client-ip=74.125.224.97
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-66077c46c5cso4823063d50.1
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 04:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005765; x=1781610565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsTwEeomyHcAOr+L7DgyHdHnlX/mi1ZTCxvWJGVdGKg=;
        b=JmDB4phs1saDwqNOKSfyDJakx9V5lEQOJmtRxjPpJ3C+n8L5VFvZe3h/anEQdIsQCd
         0zrPDBufybgUNKdB+VLxArrBPo46z7C1B1i2xLEdXqxONDguD5MYrkcE+eEHGohpbQtg
         CFBKeGgzPC6UWg3njJ1Iwigg3cWkd0vunXkiiZauW7P8BWX/ABPyskvg72FymjG2ybsC
         LkSqrGQKDpnCldQi8RjMkFIGLTnp0zc6edQsIFJlEvIQ5/QmHeCCHjlx6JzaBLikJ08S
         jemJNoKlw4lr6p6I4HdMJSDQ8j5AByDn6J311oiMIv5GX5DsBVSqdJhOP2xcvjIvy0Nk
         PAFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Fl/Xi4xGVbinGC8HCWploGrrRuVvdiBxC2B+cT/MYdrpwjh8Wft6gLVjzDKlAKFShENKoGSig0lSvuTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsymFrgcRzdhBIqHmLYiFq+v91ZWL/8mKY4kPc/MQVDTTRElVS
	+3nTnioM6TqUGR9rD0UwCLKfghNY2xGvJL0CmkQjhL1XLYEW0vHMq39VFUejJQlsO1WU3oSYfgj
	a/5LmbN14c7mPWh4j7QSh0TqaUtU5EMrCoImUCyIYFBhiyZSEuix0/tPYo+nL6Vxu1V0MVetR2M
	XN1vXOg74hrg3mXZn+VeWfeUnyxHiq9wsufBCGbCLLaEZmTEEAE89/FcYE1ADbOZkuYsJajEkvW
	jZZAKCij86I9doYDtw=
X-Gm-Gg: Acq92OGtsGYlx6A7HvqPMNNSLh5YdHYllRGjcOf6FoDmekP/OTLp129QJYGbhKtCJPi
	wT2rvwyK4XLRjljCBP7IL0fmXanBSOAQWEfLb+0lUkb6vPz4RciHXbH+w+RqSw/qzoSHZfJpwK3
	Y1FUtQK0oljU0GVo7XTUBx5KjsrTmwDmXUeFppzdBwQT1/HA1VEgVludy6B1C/JAgSJG0K5moVo
	DXcWoA7Gu/q3ys5C4m12ltPSeAO26iroe1tndIUi/eYUdTI2XAMwhODqo6dK37a6fxm+7AtNS2h
	TAYbYODCXASSGm4/j4pPxH0eRO5V9t/VOt/n0NQDuXAp6iL2XuLbjcnMneFgEjOo80OwEvyGh5d
	N5BIC/9dDbU2pjBpVfjPflgMPGu3EwGJKrEvxRmGnXPKse4G9YYD1bcBZhMod5yL8dzpVY67a3D
	H8TOzqljg3Q3VQjo8=
X-Received: by 2002:a05:690e:1248:b0:651:c20e:a43 with SMTP id 956f58d0204a3-66106dd60aemr16909963d50.6.1781005765330;
        Tue, 09 Jun 2026 04:49:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-661473db812sm260872d50.11.2026.06.09.04.49.23
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:49:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36bb6c41341so6076439a91.3
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781005763; x=1781610563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsTwEeomyHcAOr+L7DgyHdHnlX/mi1ZTCxvWJGVdGKg=;
        b=JgSJ4sWT303YUZeM4lCJYMipAh12ssnyudKI1wC5l/YbJo8pcgNaPzBY1de1Lxn9qt
         0vWy9FmRI4a7Gf+YJWnycNg8k/IapxqWvBWq3T1g3+Ak7YYLPvs7umSSNZfjqs2AbhtE
         OujtB9ohvDYAwfZ5+upOwkq/sqDjxsQRzUjX4=
X-Forwarded-Encrypted: i=1; AFNElJ9rJTkVTcwtUCEB/MdLMLafIfjoMtg5SqOyLLC/FwB5TFwznqfZP3jBl7NmWtkqzw/hdL7AQKNfLDyIGWk=@vger.kernel.org
X-Received: by 2002:a17:90b:3b90:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-370ef0f5bcamr21076946a91.10.1781005761884;
        Tue, 09 Jun 2026 04:49:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3b90:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-370ef0f5bcamr21076843a91.10.1781005760883;
        Tue, 09 Jun 2026 04:49:20 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf903fasm18898075a91.2.2026.06.09.04.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:49:20 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Khalid Aziz <khalid@gonehiking.org>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	"Juergen E . Fischer" <fischer@norbit.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	Oliver Neukum <oliver@neukum.org>,
	Ali Akcaagac <aliakc@web.de>,
	Jamie Lenehan <lenehan@twibble.org>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	target-devel@vger.kernel.org,
	Bradley Grove <linuxdrivers@attotech.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Yihang Li <liyihang9@h-partners.com>,
	Don Brace <don.brace@microchip.com>,
	storagedev@microchip.com,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Brian King <brking@us.ibm.com>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	open-iscsi@googlegroups.com,
	Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	megaraidlinux.pdl@broadcom.com,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	Daniel Palmer <daniel@thingy.jp>,
	GOTO Masanori <gotom@debian.or.jp>,
	YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Geoff Levand <geoff@infradead.org>,
	Michael Reed <mdr@sgi.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Narsimhulu Musini <nmusini@cisco.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Vishal Bhakta <vishal.bhakta@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 2/4] scsi: host: allocate struct Scsi_Host on the NUMA node of the host adapter
Date: Tue,  9 Jun 2026 17:48:01 +0530
Message-ID: <20260609121806.2121755-3-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,vger.kernel.org,gmail.com,gonehiking.org,microsemi.com,infradead.org,suse.com,norbit.de,armlinux.org.uk,lists.infradead.org,linux-m68k.org,qlogic.com,neukum.org,web.de,twibble.org,broadcom.com,attotech.com,cisco.com,h-partners.com,microchip.com,highpoint-tech.com,linux.ibm.com,ellerman.id.au,kernel.org,lists.ozlabs.org,us.ibm.com,redhat.com,oracle.com,googlegroups.com,thingy.jp,debian.or.jp,netlab.is.tsukuba.ac.jp,cloud.ionos.com,sgi.com,marvell.com,microsoft.com,lists.linux.dev,epam.com,lists.xenproject.org];
	TAGGED_FROM(0.00)[bounces-11551-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,vger.kernel.org:from_smtp,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sumit.saxena@broadcom.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:axboe@kernel.dk,m:James.Bottomley@HansenPartnership.com,m:linux-scsi@vger.kernel.org,m:linux-block@vger.kernel.org,m:aradford@gmail.com,m:khalid@gonehiking.org,m:aacraid@microsemi.com,m:willy@infradead.org,m:hare@suse.com,m:fischer@norbit.de,m:linux@armlinux.org.uk,m:linux-arm-kernel@lists.infradead.org,m:fthain@linux-m68k.org,m:schmitzmic@gmail.com,m:anil.gurumurthy@qlogic.com,m:sudarsana.kalluru@qlogic.com,m:oliver@neukum.org,m:aliakc@web.de,m:lenehan@twibble.org,m:ram.vegesna@broadcom.com,m:target-devel@vger.kernel.org,m:linuxdrivers@attotech.com,m:satishkh@cisco.com,m:sebaddel@cisco.com,m:kartilak@cisco.com,m:liyihang9@h-partners.com,m:don.brace@microchip.com,m:storagedev@microchip.com,m:linux@highpoint-tech.com,m:tyreld@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:brking@us.ibm.com,m:lduncan@suse.com,m:cleech@redhat.com,m:michael.christie
 @oracle.com,m:open-iscsi@googlegroups.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:kashyap.desai@broadcom.com,m:shivasharan.srikanteshwara@broadcom.com,m:chandrakanth.patil@broadcom.com,m:megaraidlinux.pdl@broadcom.com,m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:mpi3mr-linuxdrv.pdl@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:MPT-FusionLinux.pdl@broadcom.com,m:daniel@thingy.jp,m:gotom@debian.or.jp,m:yokota@netlab.is.tsukuba.ac.jp,m:jinpu.wang@cloud.ionos.com,m:geoff@infradead.org,m:mdr@sgi.com,m:njavali@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:nmusini@cisco.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:pbonzini@redhat.com,m:stefanha@redhat.com,m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:vishal.bhakta@broadcom.com,m:bcm-kernel-feedback-list@broadcom.co
 m,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:xen-devel@lists.xenproject.org,m:sumit.saxena@broadcom.com,m:john.g.garry@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.saxena@broadcom.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[82];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2B8165FA9F

scsi_host_alloc() used kzalloc(), which always picks an arbitrary node.
Extend the function to accept a 'struct device *dev' parameter and use
kzalloc_node() with dev_to_node(dev) so the Scsi_Host struct lands on
the same NUMA node as the HBA, mirroring the treatment already applied
to struct scsi_device, struct scsi_target, and shost_data.

When dev is NULL (legacy ISA/platform drivers without a dma_dev) the
allocation falls back to NUMA_NO_NODE, preserving existing behaviour.

Update all in-tree callers:
  - PCI-based HBA drivers pass &pdev->dev (or the equivalent struct
    member such as &phba->pcidev->dev, &h->pdev->dev, &ha->pdev->dev)
    so their host struct is placed on the adapter's node.
  - Non-PCI drivers (ISA, Amiga, ARM PCMCIA, virtio, Hyper-V, PS3, …)
    pass NULL.
  - libfc's libfc_host_alloc() inline helper passes NULL; FC drivers
    that want NUMA awareness can open-code the call with their pdev.

Suggested-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/3w-9xxx.c                    | 2 +-
 drivers/scsi/3w-sas.c                     | 2 +-
 drivers/scsi/3w-xxxx.c                    | 2 +-
 drivers/scsi/53c700.c                     | 2 +-
 drivers/scsi/BusLogic.c                   | 2 +-
 drivers/scsi/a100u2w.c                    | 2 +-
 drivers/scsi/a2091.c                      | 2 +-
 drivers/scsi/a3000.c                      | 2 +-
 drivers/scsi/aacraid/linit.c              | 2 +-
 drivers/scsi/advansys.c                   | 6 +++---
 drivers/scsi/aha152x.c                    | 2 +-
 drivers/scsi/aha1542.c                    | 2 +-
 drivers/scsi/aha1740.c                    | 2 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c        | 2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.c        | 2 +-
 drivers/scsi/aic94xx/aic94xx_init.c       | 2 +-
 drivers/scsi/am53c974.c                   | 2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c          | 3 ++-
 drivers/scsi/arm/acornscsi.c              | 2 +-
 drivers/scsi/arm/arxescsi.c               | 2 +-
 drivers/scsi/arm/cumana_1.c               | 2 +-
 drivers/scsi/arm/cumana_2.c               | 2 +-
 drivers/scsi/arm/eesox.c                  | 2 +-
 drivers/scsi/arm/oak.c                    | 2 +-
 drivers/scsi/arm/powertec.c               | 2 +-
 drivers/scsi/atari_scsi.c                 | 2 +-
 drivers/scsi/atp870u.c                    | 2 +-
 drivers/scsi/bfa/bfad_im.c                | 2 +-
 drivers/scsi/csiostor/csio_init.c         | 4 ++--
 drivers/scsi/dc395x.c                     | 2 +-
 drivers/scsi/dmx3191d.c                   | 2 +-
 drivers/scsi/elx/efct/efct_xport.c        | 4 ++--
 drivers/scsi/esas2r/esas2r_main.c         | 2 +-
 drivers/scsi/fdomain.c                    | 2 +-
 drivers/scsi/fnic/fnic_main.c             | 2 +-
 drivers/scsi/g_NCR5380.c                  | 2 +-
 drivers/scsi/gvp11.c                      | 2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c     | 2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 2 +-
 drivers/scsi/hosts.c                      | 6 ++++--
 drivers/scsi/hpsa.c                       | 2 +-
 drivers/scsi/hptiop.c                     | 2 +-
 drivers/scsi/ibmvscsi/ibmvfc.c            | 2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c          | 2 +-
 drivers/scsi/imm.c                        | 2 +-
 drivers/scsi/initio.c                     | 2 +-
 drivers/scsi/ipr.c                        | 2 +-
 drivers/scsi/ips.c                        | 2 +-
 drivers/scsi/isci/init.c                  | 2 +-
 drivers/scsi/jazz_esp.c                   | 2 +-
 drivers/scsi/libiscsi.c                   | 2 +-
 drivers/scsi/lpfc/lpfc_init.c             | 2 +-
 drivers/scsi/mac53c94.c                   | 2 +-
 drivers/scsi/mac_esp.c                    | 2 +-
 drivers/scsi/mac_scsi.c                   | 2 +-
 drivers/scsi/megaraid.c                   | 2 +-
 drivers/scsi/megaraid/megaraid_mbox.c     | 2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
 drivers/scsi/mesh.c                       | 2 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c           | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 4 ++--
 drivers/scsi/mvme147.c                    | 2 +-
 drivers/scsi/mvsas/mv_init.c              | 2 +-
 drivers/scsi/mvumi.c                      | 2 +-
 drivers/scsi/myrb.c                       | 2 +-
 drivers/scsi/myrs.c                       | 2 +-
 drivers/scsi/ncr53c8xx.c                  | 2 +-
 drivers/scsi/nsp32.c                      | 2 +-
 drivers/scsi/pcmcia/nsp_cs.c              | 2 +-
 drivers/scsi/pcmcia/qlogic_stub.c         | 2 +-
 drivers/scsi/pcmcia/sym53c500_cs.c        | 2 +-
 drivers/scsi/pm8001/pm8001_init.c         | 2 +-
 drivers/scsi/pmcraid.c                    | 2 +-
 drivers/scsi/ppa.c                        | 2 +-
 drivers/scsi/ps3rom.c                     | 2 +-
 drivers/scsi/qla1280.c                    | 2 +-
 drivers/scsi/qla2xxx/qla_mid.c            | 2 +-
 drivers/scsi/qla2xxx/qla_os.c             | 2 +-
 drivers/scsi/qlogicfas.c                  | 2 +-
 drivers/scsi/qlogicpti.c                  | 2 +-
 drivers/scsi/scsi_debug.c                 | 2 +-
 drivers/scsi/sgiwd93.c                    | 2 +-
 drivers/scsi/smartpqi/smartpqi_init.c     | 2 +-
 drivers/scsi/snic/snic_main.c             | 2 +-
 drivers/scsi/stex.c                       | 2 +-
 drivers/scsi/storvsc_drv.c                | 2 +-
 drivers/scsi/sun3_scsi.c                  | 2 +-
 drivers/scsi/sun3x_esp.c                  | 2 +-
 drivers/scsi/sun_esp.c                    | 2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c       | 2 +-
 drivers/scsi/virtio_scsi.c                | 2 +-
 drivers/scsi/vmw_pvscsi.c                 | 2 +-
 drivers/scsi/wd719x.c                     | 2 +-
 drivers/scsi/xen-scsifront.c              | 2 +-
 drivers/scsi/zorro_esp.c                  | 2 +-
 include/scsi/libfc.h                      | 2 +-
 include/scsi/scsi_host.h                  | 3 ++-
 97 files changed, 107 insertions(+), 103 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 9b93a2440af8..444578ee8070 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2021,7 +2021,7 @@ static int twa_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 		goto out_disable_device;
 	}
 
-	host = scsi_host_alloc(&driver_template, sizeof(TW_Device_Extension));
+	host = scsi_host_alloc(&driver_template, sizeof(TW_Device_Extension), &pdev->dev);
 	if (!host) {
 		TW_PRINTK(host, TW_DRIVER, 0x24, "Failed to allocate memory for device extension");
 		retval = -ENOMEM;
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 52dc1aa639f7..d063d39faf4f 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1576,7 +1576,7 @@ static int twl_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 		goto out_disable_device;
 	}
 
-	host = scsi_host_alloc(&driver_template, sizeof(TW_Device_Extension));
+	host = scsi_host_alloc(&driver_template, sizeof(TW_Device_Extension), &pdev->dev);
 	if (!host) {
 		TW_PRINTK(host, TW_DRIVER, 0x19, "Failed to allocate memory for device extension");
 		retval = -ENOMEM;
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index c68678fa72c1..0ccb5f1f8805 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2268,7 +2268,7 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 		goto out_disable_device;
 	}
 
-	host = scsi_host_alloc(&driver_template, sizeof(TW_Device_Extension));
+	host = scsi_host_alloc(&driver_template, sizeof(TW_Device_Extension), &pdev->dev);
 	if (!host) {
 		printk(KERN_WARNING "3w-xxxx: Failed to allocate memory for device extension.");
 		retval = -ENOMEM;
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index c78f74b8f45c..e30d55ab5dea 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -341,7 +341,7 @@ NCR_700_detect(struct scsi_host_template *tpnt,
 	if(tpnt->proc_name == NULL)
 		tpnt->proc_name = "53c700";
 
-	host = scsi_host_alloc(tpnt, 4);
+	host = scsi_host_alloc(tpnt, 4, NULL);
 	if (!host)
 		return NULL;
 	memset(hostdata->slots, 0, sizeof(struct NCR_700_command_slot)
diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 5304d2febd63..f865fdec4136 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2302,7 +2302,7 @@ static int __init blogic_init(void)
 		 */
 
 		host = scsi_host_alloc(&blogic_template,
-				sizeof(struct blogic_adapter));
+				sizeof(struct blogic_adapter), NULL);
 		if (host == NULL) {
 			release_region(myadapter->io_addr,
 					myadapter->addr_count);
diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index 4365b896f5c4..9124c6103902 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1106,7 +1106,7 @@ static int inia100_probe_one(struct pci_dev *pdev,
 	bios = inw(port + 0x50);
 
 
-	shost = scsi_host_alloc(&inia100_template, sizeof(struct orc_host));
+	shost = scsi_host_alloc(&inia100_template, sizeof(struct orc_host), &pdev->dev);
 	if (!shost)
 		goto out_release_region;
 
diff --git a/drivers/scsi/a2091.c b/drivers/scsi/a2091.c
index 204448bfd04b..51effb2edefb 100644
--- a/drivers/scsi/a2091.c
+++ b/drivers/scsi/a2091.c
@@ -214,7 +214,7 @@ static int a2091_probe(struct zorro_dev *z, const struct zorro_device_id *ent)
 		return -EBUSY;
 
 	instance = scsi_host_alloc(&a2091_scsi_template,
-				   sizeof(struct a2091_hostdata));
+				   sizeof(struct a2091_hostdata), NULL);
 	if (!instance) {
 		error = -ENOMEM;
 		goto fail_alloc;
diff --git a/drivers/scsi/a3000.c b/drivers/scsi/a3000.c
index bf054dd7682b..5b3d25b8ad37 100644
--- a/drivers/scsi/a3000.c
+++ b/drivers/scsi/a3000.c
@@ -235,7 +235,7 @@ static int __init amiga_a3000_scsi_probe(struct platform_device *pdev)
 		return -EBUSY;
 
 	instance = scsi_host_alloc(&amiga_a3000_scsi_template,
-				   sizeof(struct a3000_hostdata));
+				   sizeof(struct a3000_hostdata), NULL);
 	if (!instance) {
 		error = -ENOMEM;
 		goto fail_alloc;
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 2fa8f7ddb703..d003667007f7 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1636,7 +1636,7 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 
-	shost = scsi_host_alloc(&aac_driver_template, sizeof(struct aac_dev));
+	shost = scsi_host_alloc(&aac_driver_template, sizeof(struct aac_dev), &pdev->dev);
 	if (!shost) {
 		error = -ENOMEM;
 		goto out_disable_pdev;
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 5cdbf2bdb13d..e7ef433778a1 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -11237,7 +11237,7 @@ static int advansys_vlb_probe(struct device *dev, unsigned int id)
 		goto release_region;
 
 	err = -ENOMEM;
-	shost = scsi_host_alloc(&advansys_template, sizeof(*board));
+	shost = scsi_host_alloc(&advansys_template, sizeof(*board), NULL);
 	if (!shost)
 		goto release_region;
 
@@ -11345,7 +11345,7 @@ static int advansys_eisa_probe(struct device *dev)
 			irq = advansys_eisa_irq_no(edev);
 
 		err = -ENOMEM;
-		shost = scsi_host_alloc(&advansys_template, sizeof(*board));
+		shost = scsi_host_alloc(&advansys_template, sizeof(*board), NULL);
 		if (!shost)
 			goto release_region;
 
@@ -11462,7 +11462,7 @@ static int advansys_pci_probe(struct pci_dev *pdev,
 	ioport = pci_resource_start(pdev, 0);
 
 	err = -ENOMEM;
-	shost = scsi_host_alloc(&advansys_template, sizeof(*board));
+	shost = scsi_host_alloc(&advansys_template, sizeof(*board), &pdev->dev);
 	if (!shost)
 		goto release_region;
 
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index e3ccb6bb62c0..d82ce80de098 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -734,7 +734,7 @@ struct Scsi_Host *aha152x_probe_one(struct aha152x_setup *setup)
 {
 	struct Scsi_Host *shpnt;
 
-	shpnt = scsi_host_alloc(&aha152x_driver_template, sizeof(struct aha152x_hostdata));
+	shpnt = scsi_host_alloc(&aha152x_driver_template, sizeof(struct aha152x_hostdata), NULL);
 	if (!shpnt) {
 		printk(KERN_ERR "aha152x: scsi_host_alloc failed\n");
 		return NULL;
diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
index fd766282d4a4..1a109c850785 100644
--- a/drivers/scsi/aha1542.c
+++ b/drivers/scsi/aha1542.c
@@ -752,7 +752,7 @@ static struct Scsi_Host *aha1542_hw_init(const struct scsi_host_template *tpnt,
 	if (!request_region(base_io, AHA1542_REGION_SIZE, "aha1542"))
 		return NULL;
 
-	sh = scsi_host_alloc(tpnt, sizeof(struct aha1542_hostdata));
+	sh = scsi_host_alloc(tpnt, sizeof(struct aha1542_hostdata), NULL);
 	if (!sh)
 		goto release;
 	aha1542 = shost_priv(sh);
diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index c435769359f2..31a52edf0748 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -583,7 +583,7 @@ static int aha1740_probe (struct device *dev)
 	printk(KERN_INFO "aha174x: Extended translation %sabled.\n",
 	       translation ? "en" : "dis");
 	shpnt = scsi_host_alloc(&aha1740_template,
-			      sizeof(struct aha1740_hostdata));
+			      sizeof(struct aha1740_hostdata), NULL);
 	if(shpnt == NULL)
 		goto err_release_region;
 
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index feb1707feb7e..76e30b0784b9 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -1214,7 +1214,7 @@ ahd_linux_register_host(struct ahd_softc *ahd, struct scsi_host_template *templa
 	int	retval;
 
 	template->name = ahd->description;
-	host = scsi_host_alloc(template, sizeof(struct ahd_softc *));
+	host = scsi_host_alloc(template, sizeof(struct ahd_softc *), NULL);
 	if (host == NULL)
 		return (ENOMEM);
 
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index d93b522695eb..0169509abd76 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -1083,7 +1083,7 @@ ahc_linux_register_host(struct ahc_softc *ahc, struct scsi_host_template *templa
 	int	retval;
 
 	template->name = ahc->description;
-	host = scsi_host_alloc(template, sizeof(struct ahc_softc *));
+	host = scsi_host_alloc(template, sizeof(struct ahc_softc *), NULL);
 	if (host == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 4400a3661d90..1336e5e38f8d 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -704,7 +704,7 @@ static int asd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	err = -ENOMEM;
 
-	shost = scsi_host_alloc(&aic94xx_sht, sizeof(void *));
+	shost = scsi_host_alloc(&aic94xx_sht, sizeof(void *), &dev->dev);
 	if (!shost)
 		goto Err;
 
diff --git a/drivers/scsi/am53c974.c b/drivers/scsi/am53c974.c
index f972a3c90a2f..4ca73e801232 100644
--- a/drivers/scsi/am53c974.c
+++ b/drivers/scsi/am53c974.c
@@ -388,7 +388,7 @@ static int pci_esp_probe_one(struct pci_dev *pdev,
 		goto fail_disable_device;
 	}
 
-	shost = scsi_host_alloc(hostt, sizeof(struct esp));
+	shost = scsi_host_alloc(hostt, sizeof(struct esp), &pdev->dev);
 	if (!shost) {
 		dev_printk(KERN_INFO, &pdev->dev,
 			   "failed to allocate scsi host\n");
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 8aa948f06cac..f0cc59e756dc 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1087,7 +1087,8 @@ static int arcmsr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if(error){
 		return -ENODEV;
 	}
-	host = scsi_host_alloc(&arcmsr_scsi_host_template, sizeof(struct AdapterControlBlock));
+	host = scsi_host_alloc(&arcmsr_scsi_host_template,
+			       sizeof(struct AdapterControlBlock), &pdev->dev);
 	if(!host){
     		goto pci_disable_dev;
 	}
diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index 79d7d7336b6a..97e3db7e6a7c 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -2806,7 +2806,7 @@ static int acornscsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 	if (ret)
 		goto out;
 
-	host = scsi_host_alloc(&acornscsi_template, sizeof(AS_Host));
+	host = scsi_host_alloc(&acornscsi_template, sizeof(AS_Host), NULL);
 	if (!host) {
 		ret = -ENOMEM;
 		goto out_release;
diff --git a/drivers/scsi/arm/arxescsi.c b/drivers/scsi/arm/arxescsi.c
index 925d0bd68aa5..32f0a3aefb44 100644
--- a/drivers/scsi/arm/arxescsi.c
+++ b/drivers/scsi/arm/arxescsi.c
@@ -272,7 +272,7 @@ static int arxescsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 		goto out_region;
 	}
 
-	host = scsi_host_alloc(&arxescsi_template, sizeof(struct arxescsi_info));
+	host = scsi_host_alloc(&arxescsi_template, sizeof(struct arxescsi_info), NULL);
 	if (!host) {
 		ret = -ENOMEM;
 		goto out_region;
diff --git a/drivers/scsi/arm/cumana_1.c b/drivers/scsi/arm/cumana_1.c
index d1a2a22ffe8c..d47ff9353c1b 100644
--- a/drivers/scsi/arm/cumana_1.c
+++ b/drivers/scsi/arm/cumana_1.c
@@ -238,7 +238,7 @@ static int cumanascsi1_probe(struct expansion_card *ec,
 	if (ret)
 		goto out;
 
-	host = scsi_host_alloc(&cumanascsi_template, sizeof(struct NCR5380_hostdata));
+	host = scsi_host_alloc(&cumanascsi_template, sizeof(struct NCR5380_hostdata), NULL);
 	if (!host) {
 		ret = -ENOMEM;
 		goto out_release;
diff --git a/drivers/scsi/arm/cumana_2.c b/drivers/scsi/arm/cumana_2.c
index e460068f6834..e35afe3a1fe4 100644
--- a/drivers/scsi/arm/cumana_2.c
+++ b/drivers/scsi/arm/cumana_2.c
@@ -394,7 +394,7 @@ static int cumanascsi2_probe(struct expansion_card *ec,
 	}
 
 	host = scsi_host_alloc(&cumanascsi2_template,
-			       sizeof(struct cumanascsi2_info));
+			       sizeof(struct cumanascsi2_info), NULL);
 	if (!host) {
 		ret = -ENOMEM;
 		goto out_region;
diff --git a/drivers/scsi/arm/eesox.c b/drivers/scsi/arm/eesox.c
index 99be9da8757f..de4d457f8ce7 100644
--- a/drivers/scsi/arm/eesox.c
+++ b/drivers/scsi/arm/eesox.c
@@ -510,7 +510,7 @@ static int eesoxscsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 	}
 
 	host = scsi_host_alloc(&eesox_template,
-			       sizeof(struct eesoxscsi_info));
+			       sizeof(struct eesoxscsi_info), NULL);
 	if (!host) {
 		ret = -ENOMEM;
 		goto out_region;
diff --git a/drivers/scsi/arm/oak.c b/drivers/scsi/arm/oak.c
index d69245007096..b2ff8616f963 100644
--- a/drivers/scsi/arm/oak.c
+++ b/drivers/scsi/arm/oak.c
@@ -126,7 +126,7 @@ static int oakscsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 	if (ret)
 		goto out;
 
-	host = scsi_host_alloc(&oakscsi_template, sizeof(struct NCR5380_hostdata));
+	host = scsi_host_alloc(&oakscsi_template, sizeof(struct NCR5380_hostdata), NULL);
 	if (!host) {
 		ret = -ENOMEM;
 		goto release;
diff --git a/drivers/scsi/arm/powertec.c b/drivers/scsi/arm/powertec.c
index 823c65ff6c12..045f35e50eff 100644
--- a/drivers/scsi/arm/powertec.c
+++ b/drivers/scsi/arm/powertec.c
@@ -318,7 +318,7 @@ static int powertecscsi_probe(struct expansion_card *ec,
 	}
 
 	host = scsi_host_alloc(&powertecscsi_template,
-			       sizeof (struct powertec_info));
+			       sizeof(struct powertec_info), NULL);
 	if (!host) {
 		ret = -ENOMEM;
 		goto out_region;
diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
index 85055677666c..9a469cf3991f 100644
--- a/drivers/scsi/atari_scsi.c
+++ b/drivers/scsi/atari_scsi.c
@@ -785,7 +785,7 @@ static int __init atari_scsi_probe(struct platform_device *pdev)
 	}
 
 	instance = scsi_host_alloc(&atari_scsi_template,
-	                           sizeof(struct NCR5380_hostdata));
+				   sizeof(struct NCR5380_hostdata), NULL);
 	if (!instance) {
 		error = -ENOMEM;
 		goto fail_alloc;
diff --git a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
index 67459d81f479..57f0b4a11ba7 100644
--- a/drivers/scsi/atp870u.c
+++ b/drivers/scsi/atp870u.c
@@ -1579,7 +1579,7 @@ static int atp870u_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 
 	err = -ENOMEM;
-	shpnt = scsi_host_alloc(&atp870u_template, sizeof(struct atp_unit));
+	shpnt = scsi_host_alloc(&atp870u_template, sizeof(struct atp_unit), &pdev->dev);
 	if (!shpnt)
 		goto release_region;
 
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index 97990b285e17..bd14aee64886 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -740,7 +740,7 @@ bfad_scsi_host_alloc(struct bfad_im_port_s *im_port, struct bfad_s *bfad)
 
 	sht->sg_tablesize = bfad->cfg_data.io_max_sge;
 
-	return scsi_host_alloc(sht, sizeof(struct bfad_im_port_pointer));
+	return scsi_host_alloc(sht, sizeof(struct bfad_im_port_pointer), NULL);
 }
 
 void
diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index 238431524801..a4bf1ba03248 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -606,11 +606,11 @@ csio_shost_init(struct csio_hw *hw, struct device *dev,
 	if (dev == &hw->pdev->dev)
 		shost = scsi_host_alloc(
 				&csio_fcoe_shost_template,
-				sizeof(struct csio_lnode));
+				sizeof(struct csio_lnode), &hw->pdev->dev);
 	else
 		shost = scsi_host_alloc(
 				&csio_fcoe_shost_vport_template,
-				sizeof(struct csio_lnode));
+				sizeof(struct csio_lnode), &hw->pdev->dev);
 
 	if (!shost)
 		goto err;
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 6183ce05d8cf..16adeac93aac 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -3984,7 +3984,7 @@ static int dc395x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 	/* allocate scsi host information (includes out adapter) */
 	scsi_host = scsi_host_alloc(&dc395x_driver_template,
-				    sizeof(struct AdapterCtlBlk));
+				    sizeof(struct AdapterCtlBlk), &dev->dev);
 	if (!scsi_host)
 		goto fail;
 
diff --git a/drivers/scsi/dmx3191d.c b/drivers/scsi/dmx3191d.c
index d6d091b2f3c7..8ba17e3eefe3 100644
--- a/drivers/scsi/dmx3191d.c
+++ b/drivers/scsi/dmx3191d.c
@@ -74,7 +74,7 @@ static int dmx3191d_probe_one(struct pci_dev *pdev,
 	}
 
 	shost = scsi_host_alloc(&dmx3191d_driver_template,
-			sizeof(struct NCR5380_hostdata));
+			sizeof(struct NCR5380_hostdata), &pdev->dev);
 	if (!shost)
 		goto out_release_region;       
 
diff --git a/drivers/scsi/elx/efct/efct_xport.c b/drivers/scsi/elx/efct/efct_xport.c
index 9dcaef6fc188..74ef76e00eb5 100644
--- a/drivers/scsi/elx/efct/efct_xport.c
+++ b/drivers/scsi/elx/efct/efct_xport.c
@@ -378,7 +378,7 @@ efct_scsi_new_device(struct efct *efct)
 	int error = 0;
 	struct efct_vport *vport = NULL;
 
-	shost = scsi_host_alloc(&efct_template, sizeof(*vport));
+	shost = scsi_host_alloc(&efct_template, sizeof(*vport), NULL);
 	if (!shost) {
 		efc_log_err(efct, "failed to allocate Scsi_Host struct\n");
 		return -ENOMEM;
@@ -902,7 +902,7 @@ efct_scsi_new_vport(struct efct *efct, struct device *dev)
 	int error = 0;
 	struct efct_vport *vport = NULL;
 
-	shost = scsi_host_alloc(&efct_template, sizeof(*vport));
+	shost = scsi_host_alloc(&efct_template, sizeof(*vport), NULL);
 	if (!shost) {
 		efc_log_err(efct, "failed to allocate Scsi_Host struct\n");
 		return NULL;
diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index ada278c24c51..4aac1f6db5e9 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -382,7 +382,7 @@ static int esas2r_probe(struct pci_dev *pcid,
 		       "after pci_enable_device() enable_cnt: %d",
 		       pcid->enable_cnt.counter);
 
-	host = scsi_host_alloc(&driver_template, host_alloc_size);
+	host = scsi_host_alloc(&driver_template, host_alloc_size, &pcid->dev);
 	if (host == NULL) {
 		esas2r_log(ESAS2R_LOG_CRIT, "scsi_host_alloc() FAIL");
 		return -ENODEV;
diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
index 22fbb0222f07..66ba4551def8 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -537,7 +537,7 @@ struct Scsi_Host *fdomain_create(int base, int irq, int this_id,
 		return NULL;
 	}
 
-	sh = scsi_host_alloc(&fdomain_template, sizeof(struct fdomain));
+	sh = scsi_host_alloc(&fdomain_template, sizeof(struct fdomain), NULL);
 	if (!sh)
 		return NULL;
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 24d62c0874ac..688d85bc3f01 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -847,7 +847,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		{
 			host =
 				scsi_host_alloc(&fnic_host_template,
-								sizeof(struct fnic *));
+								sizeof(struct fnic *), &pdev->dev);
 			if (!host) {
 				dev_err(&fnic->pdev->dev, "Unable to allocate scsi host\n");
 				err = -ENOMEM;
diff --git a/drivers/scsi/g_NCR5380.c b/drivers/scsi/g_NCR5380.c
index 270eae7ac427..8b9076d6a964 100644
--- a/drivers/scsi/g_NCR5380.c
+++ b/drivers/scsi/g_NCR5380.c
@@ -312,7 +312,7 @@ static int generic_NCR5380_init_one(const struct scsi_host_template *tpnt,
 		goto out_release;
 	}
 
-	instance = scsi_host_alloc(tpnt, sizeof(struct NCR5380_hostdata));
+	instance = scsi_host_alloc(tpnt, sizeof(struct NCR5380_hostdata), NULL);
 	if (instance == NULL) {
 		ret = -ENOMEM;
 		goto out_unmap;
diff --git a/drivers/scsi/gvp11.c b/drivers/scsi/gvp11.c
index 0420bfe9bd42..ad5052db5a2e 100644
--- a/drivers/scsi/gvp11.c
+++ b/drivers/scsi/gvp11.c
@@ -353,7 +353,7 @@ static int gvp11_probe(struct zorro_dev *z, const struct zorro_device_id *ent)
 		goto fail_check_or_alloc;
 
 	instance = scsi_host_alloc(&gvp11_scsi_template,
-				   sizeof(struct gvp11_hostdata));
+				   sizeof(struct gvp11_hostdata), NULL);
 	if (!instance) {
 		error = -ENOMEM;
 		goto fail_check_or_alloc;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 944ce19ae2fc..5696da8da6c7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2483,7 +2483,7 @@ static struct Scsi_Host *hisi_sas_shost_alloc(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	int error;
 
-	shost = scsi_host_alloc(hw->sht, sizeof(*hisi_hba));
+	shost = scsi_host_alloc(hw->sht, sizeof(*hisi_hba), NULL);
 	if (!shost) {
 		dev_err(dev, "scsi host alloc failed\n");
 		return NULL;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index c7430f7c4048..44e584496ed5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3469,7 +3469,7 @@ hisi_sas_shost_alloc_pci(struct pci_dev *pdev)
 	struct hisi_hba *hisi_hba;
 	struct device *dev = &pdev->dev;
 
-	shost = scsi_host_alloc(&sht_v3_hw, sizeof(*hisi_hba));
+	shost = scsi_host_alloc(&sht_v3_hw, sizeof(*hisi_hba), &pdev->dev);
 	if (!shost) {
 		dev_err(dev, "shost alloc failed\n");
 		return NULL;
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index e047747d4ecf..e1f42be79729 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -403,12 +403,14 @@ static const struct device_type scsi_host_type = {
  * Return value:
  * 	Pointer to a new Scsi_Host
  **/
-struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int privsize)
+struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int privsize,
+				  struct device *dev)
 {
 	struct Scsi_Host *shost;
 	int index;
 
-	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);
+	shost = kzalloc_node(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL,
+			     dev ? dev_to_node(dev) : NUMA_NO_NODE);
 	if (!shost)
 		return NULL;
 
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a1b116cd4723..b9f9f18bd985 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5837,7 +5837,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 {
 	struct Scsi_Host *sh;
 
-	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info *));
+	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info *), &h->pdev->dev);
 	if (sh == NULL) {
 		dev_err(&h->pdev->dev, "scsi_host_alloc failed\n");
 		return -ENOMEM;
diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index 7083c14c5302..7d79357be265 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -1311,7 +1311,7 @@ static int hptiop_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
 		goto disable_pci_device;
 	}
 
-	host = scsi_host_alloc(&driver_template, sizeof(struct hptiop_hba));
+	host = scsi_host_alloc(&driver_template, sizeof(struct hptiop_hba), &pcidev->dev);
 	if (!host) {
 		printk(KERN_ERR "hptiop: fail to alloc scsi host\n");
 		goto free_pci_regions;
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 3dd2adda195e..b11d564a21d9 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -6325,7 +6325,7 @@ static int ibmvfc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	unsigned int max_scsi_queues = min((unsigned int)IBMVFC_MAX_SCSI_QUEUES, online_cpus);
 
 	ENTER;
-	shost = scsi_host_alloc(&driver_template, sizeof(*vhost));
+	shost = scsi_host_alloc(&driver_template, sizeof(*vhost), NULL);
 	if (!shost) {
 		dev_err(dev, "Couldn't allocate host data\n");
 		goto out;
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 609bda730b3a..e8342e581246 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2235,7 +2235,7 @@ static int ibmvscsi_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 
 	dev_set_drvdata(&vdev->dev, NULL);
 
-	host = scsi_host_alloc(&driver_template, sizeof(*hostdata));
+	host = scsi_host_alloc(&driver_template, sizeof(*hostdata), NULL);
 	if (!host) {
 		dev_err(&vdev->dev, "couldn't allocate host data\n");
 		goto scsi_host_alloc_failed;
diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 0535252e77e3..a6131f87fcaf 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -1221,7 +1221,7 @@ static int __imm_attach(struct parport *pb)
 	INIT_DELAYED_WORK(&dev->imm_tq, imm_interrupt);
 
 	err = -ENOMEM;
-	host = scsi_host_alloc(&imm_template, sizeof(imm_struct *));
+	host = scsi_host_alloc(&imm_template, sizeof(imm_struct *), NULL);
 	if (!host)
 		goto out1;
 	host->io_port = pb->base;
diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 06fbe85dccfa..294f7f8d5dbb 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -2824,7 +2824,7 @@ static int initio_probe_one(struct pci_dev *pdev,
 		error = -ENODEV;
 		goto out_disable_device;
 	}
-	shost = scsi_host_alloc(&initio_template, sizeof(struct initio_host));
+	shost = scsi_host_alloc(&initio_template, sizeof(struct initio_host), &pdev->dev);
 	if (!shost) {
 		printk(KERN_WARNING "initio: Could not allocate host structure.\n");
 		error = -ENOMEM;
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index d207e5e81afe..85608804ff39 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9379,7 +9379,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 	ENTER;
 
 	dev_info(&pdev->dev, "Found IOA with IRQ: %d\n", pdev->irq);
-	host = scsi_host_alloc(&driver_template, sizeof(*ioa_cfg));
+	host = scsi_host_alloc(&driver_template, sizeof(*ioa_cfg), &pdev->dev);
 
 	if (!host) {
 		dev_err(&pdev->dev, "call to scsi_host_alloc failed!\n");
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 41ed73966a48..709a2a799f3e 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -6638,7 +6638,7 @@ ips_register_scsi(int index)
 {
 	struct Scsi_Host *sh;
 	ips_ha_t *ha, *oldha = ips_ha[index];
-	sh = scsi_host_alloc(&ips_driver_template, sizeof (ips_ha_t));
+	sh = scsi_host_alloc(&ips_driver_template, sizeof(ips_ha_t), &oldha->pcidev->dev);
 	if (!sh) {
 		IPS_PRINTK(KERN_WARNING, oldha->pcidev,
 			   "Unable to register controller with SCSI subsystem\n");
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index acf0c2038d20..7da06ace20ad 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -538,7 +538,7 @@ static struct isci_host *isci_host_alloc(struct pci_dev *pdev, int id)
 		INIT_LIST_HEAD(&idev->node);
 	}
 
-	shost = scsi_host_alloc(&isci_sht, sizeof(void *));
+	shost = scsi_host_alloc(&isci_sht, sizeof(void *), &pdev->dev);
 	if (!shost)
 		return NULL;
 
diff --git a/drivers/scsi/jazz_esp.c b/drivers/scsi/jazz_esp.c
index 35137f5cfb3a..1817246e4cc6 100644
--- a/drivers/scsi/jazz_esp.c
+++ b/drivers/scsi/jazz_esp.c
@@ -110,7 +110,7 @@ static int esp_jazz_probe(struct platform_device *dev)
 	struct resource *res;
 	int err;
 
-	host = scsi_host_alloc(tpnt, sizeof(struct esp));
+	host = scsi_host_alloc(tpnt, sizeof(struct esp), NULL);
 
 	err = -ENOMEM;
 	if (!host)
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 160f02f2f51d..458955dfc0aa 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -2903,7 +2903,7 @@ struct Scsi_Host *iscsi_host_alloc(const struct scsi_host_template *sht,
 	struct Scsi_Host *shost;
 	struct iscsi_host *ihost;
 
-	shost = scsi_host_alloc(sht, sizeof(struct iscsi_host) + dd_data_size);
+	shost = scsi_host_alloc(sht, sizeof(struct iscsi_host) + dd_data_size, NULL);
 	if (!shost)
 		return NULL;
 	ihost = shost_priv(shost);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 82af59c913e9..25264866075f 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4745,7 +4745,7 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 		template->sg_tablesize = lpfc_get_sg_tablesize(phba);
 	}
 
-	shost = scsi_host_alloc(template, sizeof(struct lpfc_vport));
+	shost = scsi_host_alloc(template, sizeof(struct lpfc_vport), &phba->pcidev->dev);
 	if (!shost)
 		goto out;
 
diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index de2bd860b9d7..737e5f2fef6f 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -426,7 +426,7 @@ static int mac53c94_probe(struct macio_dev *mdev, const struct of_device_id *mat
 		return -EBUSY;
 	}
 
-       	host = scsi_host_alloc(&mac53c94_template, sizeof(struct fsc_state));
+	host = scsi_host_alloc(&mac53c94_template, sizeof(struct fsc_state), NULL);
 	if (host == NULL) {
 		printk(KERN_ERR "mac53c94: couldn't register host");
 		rc = -ENOMEM;
diff --git a/drivers/scsi/mac_esp.c b/drivers/scsi/mac_esp.c
index a0ceaa2428c2..c8652bfdb3b8 100644
--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -301,7 +301,7 @@ static int esp_mac_probe(struct platform_device *dev)
 	if (dev->id > 1)
 		return -ENODEV;
 
-	host = scsi_host_alloc(tpnt, sizeof(struct esp));
+	host = scsi_host_alloc(tpnt, sizeof(struct esp), NULL);
 
 	err = -ENOMEM;
 	if (!host)
diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index a86bd839d08e..eeb00ee30aaa 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -474,7 +474,7 @@ static int __init mac_scsi_probe(struct platform_device *pdev)
 		mac_scsi_template.sg_tablesize = 1;
 
 	instance = scsi_host_alloc(&mac_scsi_template,
-	                           sizeof(struct NCR5380_hostdata));
+				   sizeof(struct NCR5380_hostdata), NULL);
 	if (!instance)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 9476a0d2c72d..701e54843193 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -4203,7 +4203,7 @@ megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	/* Initialize SCSI Host structure */
-	host = scsi_host_alloc(&megaraid_template, sizeof(adapter_t));
+	host = scsi_host_alloc(&megaraid_template, sizeof(adapter_t), &pdev->dev);
 	if (!host)
 		goto out_iounmap;
 
diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index ce89032a5a74..17b015b3d35f 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -620,7 +620,7 @@ megaraid_io_attach(adapter_t *adapter)
 	struct Scsi_Host	*host;
 
 	// Initialize SCSI Host structure
-	host = scsi_host_alloc(&megaraid_template_g, 8);
+	host = scsi_host_alloc(&megaraid_template_g, 8, &pdev->dev);
 	if (!host) {
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid mbox: scsi_host_alloc failed\n"));
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index ecd365d78ae3..bae1070371d5 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -7512,7 +7512,7 @@ static int megasas_probe_one(struct pci_dev *pdev,
 	pci_set_master(pdev);
 
 	host = scsi_host_alloc(&megasas_template,
-			       sizeof(struct megasas_instance));
+			       sizeof(struct megasas_instance), &pdev->dev);
 
 	if (!host) {
 		dev_printk(KERN_DEBUG, &pdev->dev, "scsi_host_alloc failed\n");
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index dc1402b321da..a4ba6bc49d23 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1877,7 +1877,7 @@ static int mesh_probe(struct macio_dev *mdev, const struct of_device_id *match)
        		printk(KERN_ERR "mesh: unable to request memory resources");
 		return -EBUSY;
 	}
-       	mesh_host = scsi_host_alloc(&mesh_template, sizeof(struct mesh_state));
+	mesh_host = scsi_host_alloc(&mesh_template, sizeof(struct mesh_state), NULL);
 	if (mesh_host == NULL) {
 		printk(KERN_ERR "mesh: couldn't register host");
 		goto out_release;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 402d1f35d214..c74e2addc77d 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -5468,7 +5468,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	shost = scsi_host_alloc(&mpi3mr_driver_template,
-	    sizeof(struct mpi3mr_ioc));
+	    sizeof(struct mpi3mr_ioc), &pdev->dev);
 	if (!shost) {
 		retval = -ENODEV;
 		goto shost_failed;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 6ff788557294..06c8df6261d4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -13367,7 +13367,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_CLKPM);
 		/* Use mpt2sas driver host template for SAS 2.0 HBA's */
 		shost = scsi_host_alloc(&mpt2sas_driver_template,
-		  sizeof(struct MPT3SAS_ADAPTER));
+		  sizeof(struct MPT3SAS_ADAPTER), &pdev->dev);
 		if (!shost)
 			return -ENODEV;
 		ioc = shost_priv(shost);
@@ -13399,7 +13399,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	case MPI26_VERSION:
 		/* Use mpt3sas driver host template for SAS 3.0 HBA's */
 		shost = scsi_host_alloc(&mpt3sas_driver_template,
-		  sizeof(struct MPT3SAS_ADAPTER));
+		  sizeof(struct MPT3SAS_ADAPTER), &pdev->dev);
 		if (!shost)
 			return -ENODEV;
 		ioc = shost_priv(shost);
diff --git a/drivers/scsi/mvme147.c b/drivers/scsi/mvme147.c
index 98b99c0f5bc7..4d61e25de2cf 100644
--- a/drivers/scsi/mvme147.c
+++ b/drivers/scsi/mvme147.c
@@ -97,7 +97,7 @@ static int __init mvme147_init(void)
 		return 0;
 
 	mvme147_shost = scsi_host_alloc(&mvme147_host_template,
-			sizeof(struct WD33C93_hostdata));
+			sizeof(struct WD33C93_hostdata), NULL);
 	if (!mvme147_shost)
 		goto err_out;
 	mvme147_shost->base = 0xfffe4000;
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 5abc17a2e261..fd90b5eec0b4 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -494,7 +494,7 @@ static int mvs_pci_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto err_out_regions;
 
-	shost = scsi_host_alloc(&mvs_sht, sizeof(void *));
+	shost = scsi_host_alloc(&mvs_sht, sizeof(void *), &pdev->dev);
 	if (!shost) {
 		rc = -ENOMEM;
 		goto err_out_regions;
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index e70d336b4ab3..d12b33a32a09 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2468,7 +2468,7 @@ static int mvumi_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto fail_set_dma_mask;
 
-	host = scsi_host_alloc(&mvumi_template, sizeof(*mhba));
+	host = scsi_host_alloc(&mvumi_template, sizeof(*mhba), &pdev->dev);
 	if (!host) {
 		dev_err(&pdev->dev, "scsi_host_alloc failed\n");
 		ret = -ENOMEM;
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index 3678b66310ed..f28c29b41cf6 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -3401,7 +3401,7 @@ static struct myrb_hba *myrb_detect(struct pci_dev *pdev,
 	struct Scsi_Host *shost;
 	struct myrb_hba *cb = NULL;
 
-	shost = scsi_host_alloc(&myrb_template, sizeof(struct myrb_hba));
+	shost = scsi_host_alloc(&myrb_template, sizeof(struct myrb_hba), &pdev->dev);
 	if (!shost) {
 		dev_err(&pdev->dev, "Unable to allocate Controller\n");
 		return NULL;
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index afd68225221a..a8ce488e6520 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1937,7 +1937,7 @@ static struct myrs_hba *myrs_alloc_host(struct pci_dev *pdev,
 	struct Scsi_Host *shost;
 	struct myrs_hba *cs;
 
-	shost = scsi_host_alloc(&myrs_template, sizeof(struct myrs_hba));
+	shost = scsi_host_alloc(&myrs_template, sizeof(struct myrs_hba), &pdev->dev);
 	if (!shost)
 		return NULL;
 
diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 5369ca3fe4fd..009d4c55054e 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -8108,7 +8108,7 @@ struct Scsi_Host * __init ncr_attach(struct scsi_host_template *tpnt,
 	printk(KERN_INFO "ncr53c720-%d: rev 0x%x irq %d\n",
 		unit, device->chip.revision_id, device->slot.irq);
 
-	instance = scsi_host_alloc(tpnt, sizeof(*host_data));
+	instance = scsi_host_alloc(tpnt, sizeof(*host_data), NULL);
 	if (!instance)
 	        goto attach_error;
 	host_data = (struct host_data *) instance->hostdata;
diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index e893d5677241..681e1d554657 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -2556,7 +2556,7 @@ static int nsp32_detect(struct pci_dev *pdev)
 	/*
 	 * register this HBA as SCSI device
 	 */
-	host = scsi_host_alloc(&nsp32_template, sizeof(nsp32_hw_data));
+	host = scsi_host_alloc(&nsp32_template, sizeof(nsp32_hw_data), &pdev->dev);
 	if (host == NULL) {
 		nsp32_msg (KERN_ERR, "failed to scsi register");
 		goto err;
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index ae70fda96ae9..32ca7872b7f8 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1326,7 +1326,7 @@ static struct Scsi_Host *nsp_detect(struct scsi_host_template *sht)
 	nsp_hw_data *data_b = &nsp_data_base, *data;
 
 	nsp_dbg(NSP_DEBUG_INIT, "this_id=%d", sht->this_id);
-	host = scsi_host_alloc(&nsp_driver_template, sizeof(nsp_hw_data));
+	host = scsi_host_alloc(&nsp_driver_template, sizeof(nsp_hw_data), NULL);
 	if (host == NULL) {
 		nsp_dbg(NSP_DEBUG_INIT, "host failed");
 		return NULL;
diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
index 5d8a434d3f66..b417b39ab723 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -106,7 +106,7 @@ static struct Scsi_Host *qlogic_detect(struct scsi_host_template *host,
 	qlogicfas408_setup(qbase, qinitid, INT_TYPE);
 
 	host->name = qlogic_name;
-	shost = scsi_host_alloc(host, sizeof(struct qlogicfas408_priv));
+	shost = scsi_host_alloc(host, sizeof(struct qlogicfas408_priv), NULL);
 	if (!shost)
 		goto err;
 	shost->io_port = qbase;
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index 1530c1ad5d36..83aab6c69a62 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -752,7 +752,7 @@ SYM53C500_config(struct pcmcia_device *link)
 
 	chip_init(port_base);
 
-	host = scsi_host_alloc(tpnt, sizeof(struct sym53c500_data));
+	host = scsi_host_alloc(tpnt, sizeof(struct sym53c500_data), NULL);
 	if (!host) {
 		printk("SYM53C500: Unable to register host, giving up.\n");
 		goto err_release;
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index e93ea76b565e..873810c6853c 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1142,7 +1142,7 @@ static int pm8001_pci_probe(struct pci_dev *pdev,
 	if (rc)
 		goto err_out_regions;
 
-	shost = scsi_host_alloc(&pm8001_sht, sizeof(void *));
+	shost = scsi_host_alloc(&pm8001_sht, sizeof(void *), &pdev->dev);
 	if (!shost) {
 		rc = -ENOMEM;
 		goto err_out_regions;
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 942a99393204..a26c747806ef 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -5236,7 +5236,7 @@ static int pmcraid_probe(struct pci_dev *pdev,
 	}
 
 	host = scsi_host_alloc(&pmcraid_host_template,
-				sizeof(struct pmcraid_instance));
+				sizeof(struct pmcraid_instance), &pdev->dev);
 
 	if (!host) {
 		dev_err(&pdev->dev, "scsi_host_alloc failed!\n");
diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index 8a4e910d5758..40fe9c6acc3b 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -1101,7 +1101,7 @@ static int __ppa_attach(struct parport *pb)
 	INIT_DELAYED_WORK(&dev->ppa_tq, ppa_interrupt);
 
 	err = -ENOMEM;
-	host = scsi_host_alloc(&ppa_template, sizeof(ppa_struct *));
+	host = scsi_host_alloc(&ppa_template, sizeof(ppa_struct *), NULL);
 	if (!host)
 		goto out1;
 	host->io_port = pb->base;
diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index a9c727d22931..3542a35b137e 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -361,7 +361,7 @@ static int ps3rom_probe(struct ps3_system_bus_device *_dev)
 		goto fail_free_bounce;
 
 	host = scsi_host_alloc(&ps3rom_host_template,
-			       sizeof(struct ps3rom_private));
+			       sizeof(struct ps3rom_private), NULL);
 	if (!host) {
 		dev_err(&dev->sbd.core, "%s:%u: scsi_host_alloc failed\n",
 			__func__, __LINE__);
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index cdd6fe002c32..f88f2e659baa 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -4142,7 +4142,7 @@ qla1280_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_master(pdev);
 
 	error = -ENOMEM;
-	host = scsi_host_alloc(&qla1280_driver_template, sizeof(*ha));
+	host = scsi_host_alloc(&qla1280_driver_template, sizeof(*ha), &pdev->dev);
 	if (!host) {
 		printk(KERN_WARNING
 		       "qla1280: Failed to register host, aborting.\n");
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index c563133f751e..4bafc367e21d 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -502,7 +502,7 @@ qla24xx_create_vhost(struct fc_vport *fc_vport)
 	vha = qla2x00_create_host(sht, ha);
 	if (!vha) {
 		ql_log(ql_log_warn, vha, 0xa005,
-		    "scsi_host_alloc() failed for vport.\n");
+		    "scsi_host_alloc() failed for vport.\n", NULL);
 		return(NULL);
 	}
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 72b1c28e4dae..ce0d097f3317 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5046,7 +5046,7 @@ struct scsi_qla_host *qla2x00_create_host(const struct scsi_host_template *sht,
 	struct Scsi_Host *host;
 	struct scsi_qla_host *vha = NULL;
 
-	host = scsi_host_alloc(sht, sizeof(scsi_qla_host_t));
+	host = scsi_host_alloc(sht, sizeof(scsi_qla_host_t), &ha->pdev->dev);
 	if (!host) {
 		ql_log_pci(ql_log_fatal, ha->pdev, 0x0107,
 		    "Failed to allocate host from the scsi layer, aborting.\n");
diff --git a/drivers/scsi/qlogicfas.c b/drivers/scsi/qlogicfas.c
index 8f05e3707d69..b9ead7dc371c 100644
--- a/drivers/scsi/qlogicfas.c
+++ b/drivers/scsi/qlogicfas.c
@@ -95,7 +95,7 @@ static struct Scsi_Host *__qlogicfas_detect(struct scsi_host_template *host,
 
 	qlogicfas408_setup(qbase, qinitid, INT_TYPE);
 
-	hreg = scsi_host_alloc(host, sizeof(struct qlogicfas408_priv));
+	hreg = scsi_host_alloc(host, sizeof(struct qlogicfas408_priv), NULL);
 	if (!hreg)
 		goto err_release_mem;
 	priv = get_priv_by_host(hreg);
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index ea0a2b5a0a42..f67a9b400100 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1316,7 +1316,7 @@ static int qpti_sbus_probe(struct platform_device *op)
 	if (op->archdata.irqs[0] == 0)
 		return -ENODEV;
 
-	host = scsi_host_alloc(&qpti_template, sizeof(struct qlogicpti));
+	host = scsi_host_alloc(&qpti_template, sizeof(struct qlogicpti), NULL);
 	if (!host)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index bb6b0e7fb910..59488bf74ce0 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -9548,7 +9548,7 @@ static int sdebug_driver_probe(struct device *dev)
 
 	sdbg_host = dev_to_sdebug_host(dev);
 
-	hpnt = scsi_host_alloc(&sdebug_driver_template, 0);
+	hpnt = scsi_host_alloc(&sdebug_driver_template, 0, NULL);
 	if (NULL == hpnt) {
 		pr_err("scsi_host_alloc failed\n");
 		error = -ENODEV;
diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
index 6594661db5f4..07fbe6fda7c2 100644
--- a/drivers/scsi/sgiwd93.c
+++ b/drivers/scsi/sgiwd93.c
@@ -231,7 +231,7 @@ static int sgiwd93_probe(struct platform_device *pdev)
 	unsigned int irq = pd->irq;
 	int err;
 
-	host = scsi_host_alloc(&sgiwd93_template, sizeof(struct ip22_hostdata));
+	host = scsi_host_alloc(&sgiwd93_template, sizeof(struct ip22_hostdata), NULL);
 	if (!host) {
 		err = -ENOMEM;
 		goto out;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 65ff50982978..a3163c06b3f8 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -7619,7 +7619,7 @@ static int pqi_register_scsi(struct pqi_ctrl_info *ctrl_info)
 	int rc;
 	struct Scsi_Host *shost;
 
-	shost = scsi_host_alloc(&pqi_driver_template, sizeof(ctrl_info));
+	shost = scsi_host_alloc(&pqi_driver_template, sizeof(ctrl_info), &ctrl_info->pci_dev->dev);
 	if (!shost) {
 		dev_err(&ctrl_info->pci_dev->dev, "scsi_host_alloc failed\n");
 		return -ENOMEM;
diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.c
index 82953e6a0915..9edf6661e6f1 100644
--- a/drivers/scsi/snic/snic_main.c
+++ b/drivers/scsi/snic/snic_main.c
@@ -363,7 +363,7 @@ snic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/*
 	 * Allocate SCSI Host and setup association between host, and snic
 	 */
-	shost = scsi_host_alloc(&snic_host_template, sizeof(struct snic));
+	shost = scsi_host_alloc(&snic_host_template, sizeof(struct snic), &pdev->dev);
 	if (!shost) {
 		SNIC_ERR("Unable to alloc scsi_host\n");
 		ret = -ENOMEM;
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 6aeeb338633d..7d6b851fef24 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1667,7 +1667,7 @@ static int stex_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	S6flag = 0;
 	register_reboot_notifier(&stex_notifier);
 
-	host = scsi_host_alloc(&driver_template, sizeof(struct st_hba));
+	host = scsi_host_alloc(&driver_template, sizeof(struct st_hba), &pdev->dev);
 
 	if (!host) {
 		printk(KERN_ERR DRV_NAME "(%s): scsi_host_alloc failed\n",
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 571ea549152b..fc4c05127dc4 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1969,7 +1969,7 @@ static int storvsc_probe(struct hv_device *device,
 				(100 - ring_avail_percent_lowater) / 100;
 
 	host = scsi_host_alloc(&scsi_driver,
-			       sizeof(struct hv_host_device));
+			       sizeof(struct hv_host_device), NULL);
 	if (!host)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/sun3_scsi.c b/drivers/scsi/sun3_scsi.c
index ca9cd691cc32..ed41b605328e 100644
--- a/drivers/scsi/sun3_scsi.c
+++ b/drivers/scsi/sun3_scsi.c
@@ -578,7 +578,7 @@ static int __init sun3_scsi_probe(struct platform_device *pdev)
 #endif
 
 	instance = scsi_host_alloc(&sun3_scsi_template,
-	                           sizeof(struct NCR5380_hostdata));
+				   sizeof(struct NCR5380_hostdata), NULL);
 	if (!instance) {
 		error = -ENOMEM;
 		goto fail_alloc;
diff --git a/drivers/scsi/sun3x_esp.c b/drivers/scsi/sun3x_esp.c
index 365406885b8e..f7e48f4c5444 100644
--- a/drivers/scsi/sun3x_esp.c
+++ b/drivers/scsi/sun3x_esp.c
@@ -175,7 +175,7 @@ static int esp_sun3x_probe(struct platform_device *dev)
 	struct resource *res;
 	int err = -ENOMEM;
 
-	host = scsi_host_alloc(tpnt, sizeof(struct esp));
+	host = scsi_host_alloc(tpnt, sizeof(struct esp), NULL);
 	if (!host)
 		goto fail;
 
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index aa430501f0c7..bc4e4030acb6 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -457,7 +457,7 @@ static int esp_sbus_probe_one(struct platform_device *op,
 	struct esp *esp;
 	int err;
 
-	host = scsi_host_alloc(tpnt, sizeof(struct esp));
+	host = scsi_host_alloc(tpnt, sizeof(struct esp), NULL);
 
 	err = -ENOMEM;
 	if (!host)
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index 27e22acaf1a7..16e821c3b59e 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -1300,7 +1300,7 @@ static struct Scsi_Host *sym_attach(const struct scsi_host_template *tpnt, int u
 	if (!fw)
 		goto attach_failed;
 
-	shost = scsi_host_alloc(tpnt, sizeof(*sym_data));
+	shost = scsi_host_alloc(tpnt, sizeof(*sym_data), &pdev->dev);
 	if (!shost)
 		goto attach_failed;
 	sym_data = shost_priv(shost);
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 5fdaa71f0652..88375574cb18 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -929,7 +929,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
 	num_targets = virtscsi_config_get(vdev, max_target) + 1;
 
 	shost = scsi_host_alloc(&virtscsi_host_template,
-				struct_size(vscsi, req_vqs, num_queues));
+				struct_size(vscsi, req_vqs, num_queues), NULL);
 	if (!shost)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 151cac9f9c2a..32c39c66c49b 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1435,7 +1435,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		PVSCSI_MAX_NUM_REQ_ENTRIES_PER_PAGE;
 	pvscsi_template.cmd_per_lun =
 		min(pvscsi_template.can_queue, pvscsi_cmd_per_lun);
-	host = scsi_host_alloc(&pvscsi_template, sizeof(struct pvscsi_adapter));
+	host = scsi_host_alloc(&pvscsi_template, sizeof(struct pvscsi_adapter), &pdev->dev);
 	if (!host) {
 		printk(KERN_ERR "vmw_pvscsi: failed to allocate host\n");
 		goto out_release_resources_and_disable;
diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index 830d40f57f6a..0aa6bb093431 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -921,7 +921,7 @@ static int wd719x_pci_probe(struct pci_dev *pdev, const struct pci_device_id *d)
 		goto release_region;
 
 	err = -ENOMEM;
-	sh = scsi_host_alloc(&wd719x_template, sizeof(struct wd719x));
+	sh = scsi_host_alloc(&wd719x_template, sizeof(struct wd719x), &pdev->dev);
 	if (!sh)
 		goto release_region;
 
diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 989bcaee42ca..d4d57f33cc15 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -899,7 +899,7 @@ static int scsifront_probe(struct xenbus_device *dev,
 	int err = -ENOMEM;
 	char name[TASK_COMM_LEN];
 
-	host = scsi_host_alloc(&scsifront_sht, sizeof(*info));
+	host = scsi_host_alloc(&scsifront_sht, sizeof(*info), NULL);
 	if (!host) {
 		xenbus_dev_fatal(dev, err, "fail to allocate scsi host");
 		return err;
diff --git a/drivers/scsi/zorro_esp.c b/drivers/scsi/zorro_esp.c
index 1622285c9aec..5983015877a7 100644
--- a/drivers/scsi/zorro_esp.c
+++ b/drivers/scsi/zorro_esp.c
@@ -774,7 +774,7 @@ static int zorro_esp_probe(struct zorro_dev *z,
 		goto fail_free_zep;
 	}
 
-	host = scsi_host_alloc(tpnt, sizeof(struct esp));
+	host = scsi_host_alloc(tpnt, sizeof(struct esp), NULL);
 
 	if (!host) {
 		pr_err("No host detected; board configuration problem?\n");
diff --git a/include/scsi/libfc.h b/include/scsi/libfc.h
index be0ffe1e3395..17e545fa5c7e 100644
--- a/include/scsi/libfc.h
+++ b/include/scsi/libfc.h
@@ -883,7 +883,7 @@ libfc_host_alloc(const struct scsi_host_template *sht, int priv_size)
 	struct fc_lport *lport;
 	struct Scsi_Host *shost;
 
-	shost = scsi_host_alloc(sht, sizeof(*lport) + priv_size);
+	shost = scsi_host_alloc(sht, sizeof(*lport) + priv_size, NULL);
 	if (!shost)
 		return NULL;
 	lport = shost_priv(shost);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 7e2011830ba4..09c82a41b7a1 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -796,7 +796,8 @@ static inline int scsi_host_in_recovery(struct Scsi_Host *shost)
 extern int scsi_queue_work(struct Scsi_Host *, struct work_struct *);
 extern void scsi_flush_work(struct Scsi_Host *);
 
-extern struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *, int);
+extern struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht,
+					 int privsize, struct device *dev);
 extern int __must_check scsi_add_host_with_dma(struct Scsi_Host *,
 					       struct device *,
 					       struct device *);
-- 
2.43.7


