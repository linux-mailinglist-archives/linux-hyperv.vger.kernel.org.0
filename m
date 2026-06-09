Return-Path: <linux-hyperv+bounces-11549-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CD8XEJL+J2pc6wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11549-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 13:52:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C734465FAC4
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 13:52:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=e2uIwMV8;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11549-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11549-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478F3304D278
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FC93FFFB5;
	Tue,  9 Jun 2026 11:48:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782E3FD13A
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 11:48:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005722; cv=none; b=coWEXcHc39GoJt9LKaJ3WdpxUo1YKvYOO97Ax+uVeUxfWn0VNuRC3uiJjVGuVGY+wVjn2DaRyQauOIbucFt1zQhRaRkdJNxnNO8hdNkh8W9ZjhC1+poXcLq5X9/iaRhEmnmIzwdxE6LZDYHTWqObO/r9gw5aJ+6727xBTs6+9HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005722; c=relaxed/simple;
	bh=uwnsk7uP8WIJoO8ttbzpXJmdi0aUvgvTHnMPSDHcaKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JUCu73G/+f6sdz/YUhFYWkUAnLHlEvuLCXEQjRr0dXJwE7lewXSZAg4yze/ap9hBahrjTCeGAGOwuQcg2t29faAyjsMOa7ZlG4BSMq2vV6xYI9TCKecHFuuM3DPwSzQntqURhtmkUwIIYFqPuYlpm2A3kQRby7eFXLA9TlKdIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e2uIwMV8; arc=none smtp.client-ip=209.85.214.228
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2c168baac83so25004295ad.2
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 04:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005720; x=1781610520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GtwyftxDgDxHf00TNmN+7bsJSzsnvSjUZVIyovfOvI=;
        b=DsEsfjHjzeB/Zceo0jGE1noz201nOEgilNxbDGx7qKPLGwk4Ij66PiTYJWnBDRl6qd
         h8C+OEu5zKzZxChZaLD9nvH3TA3QVcFqbmXN22jGBr9s4WaT8HTDRt+hurvxSx7vrJ/V
         zfXWCX9e2RD/GqvN45zWMl9h4F29sqxjAAcNljvN8Gpdm/iB5x/rkpALaRaMmOHpn3ZQ
         2OeQtdNF0p9oZ1uZJ3Vv1BfTt8ZGhvZAJn1kCHa+RRNyC+9g/P6saZYsWBIkdAxyf18P
         2jR9v4KUZJS2neWs2ZmO3ftQ3x5hfAYMd7e697uWQAdx+uE3/4uNRKHV2/sTDvy1s/lT
         QlDg==
X-Forwarded-Encrypted: i=1; AFNElJ8qYtB2rAknRLQSNs8TczWyZnrOfm2L0GwFEUdRdqia0vbBzmWJFBemTi+knwHfDIsaGAHnC45Ww/10DjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvdwmzCXrWAlUNHWax0uRqv7JP55gvsSw2zWHJcc2gkqTYP3dI
	ig897iVnw2Yx2MPQerCMAPurK4d2pow5L/0eW5VrXXIB1gou01L3FpMAAbVzHu5cl/M2EoyQqou
	jNZAoOzejZuYOdb9gRPAYsU0YHJGMf2VJSmB/f1or4joTHuyUU5dW2e36oZh94zfmd/5l1q4VXF
	Q96q4nsmoXyBe99iInotTrIrESz3vKGujbU+LAukD1NJnLsney18Tx3xpPCZ7RlNjiahf9Fmk5g
	M6vUerp41yO1aOuuHA=
X-Gm-Gg: Acq92OGsBLxIeGvP8F329ftvXHVcouf7INl/Ui1wc2aQPE9L6XA5fOUZvzq1wgFuMRo
	2ZPvPrwvbsOekoYAFMVDX68f9ff6VhukkzfW7Xpzt7kUZdRWe97aLGBGtob1lL145W2P+SAGOkF
	bbfwbgMxf/zCbGhejKRYoccBPfW89oYyyyvRMBuk5ZELTINGstOgc5HlPvIs7RgFMcSzz1+KXzW
	RSWlLJOzSwxUaNuUjbT1jYhISTla6qt+JUMAkK60bm+YcUle04yL9HittoYB2bhL4U3tvUWmuen
	5VgKNHkmNXo1b72MxgMA2BIqArP/sSbTcIAC+0Q4idDFpDjsm21IafH5GdeldVAG+geJqXATSUR
	noqqLRg/G5VUjV/7594/MpWkG8T5XXA0ipU+zjuu8OXA/xs98fPup5M7AUORimTqNboBN63zy1Y
	bcnRnJF0Xf8fg2519xE6aXIq3CcuoXi/m8+2cnn/dLqx9rarSM7JwV9+LJICJiZw5AOhU=
X-Received: by 2002:a17:903:380f:b0:2c2:75c4:4b0f with SMTP id d9443c01a7336-2c275c44d43mr100033675ad.2.1781005719612;
        Tue, 09 Jun 2026 04:48:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c1664a7d18sm18583985ad.54.2026.06.09.04.48.39
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:48:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b74447so4270692a91.2
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781005718; x=1781610518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GtwyftxDgDxHf00TNmN+7bsJSzsnvSjUZVIyovfOvI=;
        b=e2uIwMV898uSiIGBFwRmwkHCS2tymQ6pmRRxIcDZzGObmm9Z76jjduPKTt86NTUa6X
         Q3sgiAT4XML/RSl9EVEL5STDpek+Vs9kvLFQ8qqmeO8taDtrBQehtJvXD3ZxMFL0T5dF
         Vquzng4pDKrXKas1cg4uNKfLimmruPZCgKEZ0=
X-Forwarded-Encrypted: i=1; AFNElJ8RDHGlXg9SQ4J18ljjxwwTjofchnVvguwUMeHs9vF1bmU9+Lpp/Tg5s9waIBK1wJ1pYJlo1cSTJe0vK6U=@vger.kernel.org
X-Received: by 2002:a17:90b:5783:b0:36a:4074:9aa6 with SMTP id 98e67ed59e1d1-370ee82fcb9mr19842181a91.6.1781005717465;
        Tue, 09 Jun 2026 04:48:37 -0700 (PDT)
X-Received: by 2002:a17:90b:5783:b0:36a:4074:9aa6 with SMTP id 98e67ed59e1d1-370ee82fcb9mr19842127a91.6.1781005716916;
        Tue, 09 Jun 2026 04:48:36 -0700 (PDT)
Received: from sumit_ws.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf903fasm18898075a91.2.2026.06.09.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:48:36 -0700 (PDT)
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
	Sumit Saxena <sumit.saxena@broadcom.com>
Subject: [PATCH v3 0/4] scsi/block: NUMA-local scan allocations, shared-tag path cleanup, and SCSI I/O counters
Date: Tue,  9 Jun 2026 17:47:59 +0530
Message-ID: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.43.7
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,vger.kernel.org,gmail.com,gonehiking.org,microsemi.com,infradead.org,suse.com,norbit.de,armlinux.org.uk,lists.infradead.org,linux-m68k.org,qlogic.com,neukum.org,web.de,twibble.org,broadcom.com,attotech.com,cisco.com,h-partners.com,microchip.com,highpoint-tech.com,linux.ibm.com,ellerman.id.au,kernel.org,lists.ozlabs.org,us.ibm.com,redhat.com,oracle.com,googlegroups.com,thingy.jp,debian.or.jp,netlab.is.tsukuba.ac.jp,cloud.ionos.com,sgi.com,marvell.com,microsoft.com,lists.linux.dev,epam.com,lists.xenproject.org];
	TAGGED_FROM(0.00)[bounces-11549-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:dkim,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sumit.saxena@broadcom.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:axboe@kernel.dk,m:James.Bottomley@HansenPartnership.com,m:linux-scsi@vger.kernel.org,m:linux-block@vger.kernel.org,m:aradford@gmail.com,m:khalid@gonehiking.org,m:aacraid@microsemi.com,m:willy@infradead.org,m:hare@suse.com,m:fischer@norbit.de,m:linux@armlinux.org.uk,m:linux-arm-kernel@lists.infradead.org,m:fthain@linux-m68k.org,m:schmitzmic@gmail.com,m:anil.gurumurthy@qlogic.com,m:sudarsana.kalluru@qlogic.com,m:oliver@neukum.org,m:aliakc@web.de,m:lenehan@twibble.org,m:ram.vegesna@broadcom.com,m:target-devel@vger.kernel.org,m:linuxdrivers@attotech.com,m:satishkh@cisco.com,m:sebaddel@cisco.com,m:kartilak@cisco.com,m:liyihang9@h-partners.com,m:don.brace@microchip.com,m:storagedev@microchip.com,m:linux@highpoint-tech.com,m:tyreld@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:brking@us.ibm.com,m:lduncan@suse.com,m:cleech@redhat.com,m:michael.christie
 @oracle.com,m:open-iscsi@googlegroups.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:kashyap.desai@broadcom.com,m:shivasharan.srikanteshwara@broadcom.com,m:chandrakanth.patil@broadcom.com,m:megaraidlinux.pdl@broadcom.com,m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:mpi3mr-linuxdrv.pdl@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:MPT-FusionLinux.pdl@broadcom.com,m:daniel@thingy.jp,m:gotom@debian.or.jp,m:yokota@netlab.is.tsukuba.ac.jp,m:jinpu.wang@cloud.ionos.com,m:geoff@infradead.org,m:mdr@sgi.com,m:njavali@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:nmusini@cisco.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:pbonzini@redhat.com,m:stefanha@redhat.com,m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:vishal.bhakta@broadcom.com,m:bcm-kernel-feedback-list@broadcom.co
 m,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:xen-devel@lists.xenproject.org,m:sumit.saxena@broadcom.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.saxena@broadcom.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[81];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C734465FAC4

This series contains three performance improvements targeting the SCSI
and block layers on multi-socket NUMA and heavily loaded SMP systems.

On multi-socket NUMA systems we observed extreme I/O throughput variance
of 50-60% between runs.  This series identifies and fixes two root causes:
cross-node memory accesses due to NUMA-unaware allocations in the scan
path, and false sharing between hot atomic counters in struct request_queue
and struct scsi_device.

Performance notes:

Tested on a dual-socket NUMA system (2x 32-core, 256 GB/socket) with
an mpi3mr HBA, running fio (random read, 4K, QD 64, 16 jobs, 60 s,
direct I/O).  IOPS figures are in KIOPS (thousands of IOPS):

  Configuration                    Avg KIOPS   Range (KIOPS)   Spread
  Baseline                         6,255       4,200 - 6,700   ~37%
  Baseline + all patches           7,350       7,000 - 7,700    ~10%

Key findings:

These patches combinedly reduces the observed 50-60% run-to-run variance
to under 10%, significantly improving workload predictability and
improves IOPs by 16-18%.

No functional regressions observed.

Changes in v3
-------------
-Handled feedback from Bart Van Assche and John Garry.
-Added a patch for shost local NUMA allocation.
-Converted ioerr_cnt and iotmo_cnt atomic counters into per-cpu counters. 

Changes in v2
--------------

  Patch 1 — Same functional goal as v1 patch 1: NUMA-local scsi_device /
  scsi_target allocations in the scan path so steady-state I/O does not
  habitually touch remote memory when the host has a fixed DMA/NUMA
  affinity.

  Patch 2 — Replaces v1’s ____cacheline_aligned_in_smp on
  nr_active_requests_shared_tags with removal of the shared-tag fairness
  throttling machinery (including hctx_may_queue(), blk_mq_hw_ctx.nr_active,
  and request_queue.nr_active_requests_shared_tags and their updates).
  This follows the earlier standalone proposal by Bart Van Assche [1],
  rebased for the current tree; it removes the high-frequency atomic
  accounting that motivated the v1 false-sharing workaround and, in our
  testing, improves IOPS on the order of roughly 16–18% for the shared-tag
  workload exercised.

  Patch 3 — Replaces v1’s cache-line padding of iodone_cnt with
  percpu_counter for both iorequest_cnt and iodone_cnt, so submission and
  completion paths mostly update CPU-local state instead of bouncing a
  single cache line, without inflating struct scsi_device for SMP
  alignment.

Merge / review hints
--------------------

Patch 3 touches the block layer and should have block maintainer review;
rest of patches are SCSI-oriented.  Please route or Ack as your subsystem
workflow requires.

Bart Van Assche (1):
  block: drop shared-tag fairness throttling

James Rizzo (1):
  scsi: scan: allocate sdev and starget on the NUMA node of the host
    adapter

Sumit Saxena (2):
  scsi: host: allocate struct Scsi_Host on the NUMA node of the host
    adapter
  scsi: use percpu counters for iostat counters in struct scsi_device

 block/blk-core.c                          |   2 -
 block/blk-mq-debugfs.c                    |  22 ++++-
 block/blk-mq-tag.c                        |   4 -
 block/blk-mq.c                            |  17 +---
 block/blk-mq.h                            | 100 ----------------------
 drivers/scsi/3w-9xxx.c                    |   2 +-
 drivers/scsi/3w-sas.c                     |   2 +-
 drivers/scsi/3w-xxxx.c                    |   2 +-
 drivers/scsi/53c700.c                     |   2 +-
 drivers/scsi/BusLogic.c                   |   2 +-
 drivers/scsi/a100u2w.c                    |   2 +-
 drivers/scsi/a2091.c                      |   2 +-
 drivers/scsi/a3000.c                      |   2 +-
 drivers/scsi/aacraid/linit.c              |   2 +-
 drivers/scsi/advansys.c                   |   6 +-
 drivers/scsi/aha152x.c                    |   2 +-
 drivers/scsi/aha1542.c                    |   2 +-
 drivers/scsi/aha1740.c                    |   2 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c        |   2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.c        |   2 +-
 drivers/scsi/aic94xx/aic94xx_init.c       |   2 +-
 drivers/scsi/am53c974.c                   |   2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c          |   3 +-
 drivers/scsi/arm/acornscsi.c              |   2 +-
 drivers/scsi/arm/arxescsi.c               |   2 +-
 drivers/scsi/arm/cumana_1.c               |   2 +-
 drivers/scsi/arm/cumana_2.c               |   2 +-
 drivers/scsi/arm/eesox.c                  |   2 +-
 drivers/scsi/arm/oak.c                    |   2 +-
 drivers/scsi/arm/powertec.c               |   2 +-
 drivers/scsi/atari_scsi.c                 |   2 +-
 drivers/scsi/atp870u.c                    |   2 +-
 drivers/scsi/bfa/bfad_im.c                |   2 +-
 drivers/scsi/csiostor/csio_init.c         |   4 +-
 drivers/scsi/dc395x.c                     |   2 +-
 drivers/scsi/dmx3191d.c                   |   2 +-
 drivers/scsi/elx/efct/efct_xport.c        |   4 +-
 drivers/scsi/esas2r/esas2r_main.c         |   2 +-
 drivers/scsi/fdomain.c                    |   2 +-
 drivers/scsi/fnic/fnic_main.c             |   2 +-
 drivers/scsi/g_NCR5380.c                  |   2 +-
 drivers/scsi/gvp11.c                      |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c     |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |   2 +-
 drivers/scsi/hosts.c                      |   6 +-
 drivers/scsi/hpsa.c                       |   2 +-
 drivers/scsi/hptiop.c                     |   2 +-
 drivers/scsi/ibmvscsi/ibmvfc.c            |   2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c          |   2 +-
 drivers/scsi/imm.c                        |   2 +-
 drivers/scsi/initio.c                     |   2 +-
 drivers/scsi/ipr.c                        |   2 +-
 drivers/scsi/ips.c                        |   2 +-
 drivers/scsi/isci/init.c                  |   2 +-
 drivers/scsi/jazz_esp.c                   |   2 +-
 drivers/scsi/libiscsi.c                   |   2 +-
 drivers/scsi/lpfc/lpfc_init.c             |   2 +-
 drivers/scsi/mac53c94.c                   |   2 +-
 drivers/scsi/mac_esp.c                    |   2 +-
 drivers/scsi/mac_scsi.c                   |   2 +-
 drivers/scsi/megaraid.c                   |   2 +-
 drivers/scsi/megaraid/megaraid_mbox.c     |   2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c |   2 +-
 drivers/scsi/mesh.c                       |   2 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c           |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |   4 +-
 drivers/scsi/mvme147.c                    |   2 +-
 drivers/scsi/mvsas/mv_init.c              |   2 +-
 drivers/scsi/mvumi.c                      |   2 +-
 drivers/scsi/myrb.c                       |   2 +-
 drivers/scsi/myrs.c                       |   2 +-
 drivers/scsi/ncr53c8xx.c                  |   2 +-
 drivers/scsi/nsp32.c                      |   2 +-
 drivers/scsi/pcmcia/nsp_cs.c              |   2 +-
 drivers/scsi/pcmcia/qlogic_stub.c         |   2 +-
 drivers/scsi/pcmcia/sym53c500_cs.c        |   2 +-
 drivers/scsi/pm8001/pm8001_init.c         |   2 +-
 drivers/scsi/pmcraid.c                    |   2 +-
 drivers/scsi/ppa.c                        |   2 +-
 drivers/scsi/ps3rom.c                     |   2 +-
 drivers/scsi/qla1280.c                    |   2 +-
 drivers/scsi/qla2xxx/qla_mid.c            |   2 +-
 drivers/scsi/qla2xxx/qla_os.c             |   2 +-
 drivers/scsi/qlogicfas.c                  |   2 +-
 drivers/scsi/qlogicpti.c                  |   2 +-
 drivers/scsi/scsi_debug.c                 |   2 +-
 drivers/scsi/scsi_error.c                 |   4 +-
 drivers/scsi/scsi_lib.c                   |  10 +--
 drivers/scsi/scsi_scan.c                  |  15 +++-
 drivers/scsi/scsi_sysfs.c                 |  23 +++--
 drivers/scsi/sd.c                         |   2 +-
 drivers/scsi/sgiwd93.c                    |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c     |   2 +-
 drivers/scsi/snic/snic_main.c             |   2 +-
 drivers/scsi/stex.c                       |   2 +-
 drivers/scsi/storvsc_drv.c                |   2 +-
 drivers/scsi/sun3_scsi.c                  |   2 +-
 drivers/scsi/sun3x_esp.c                  |   2 +-
 drivers/scsi/sun_esp.c                    |   2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c       |   2 +-
 drivers/scsi/virtio_scsi.c                |   2 +-
 drivers/scsi/vmw_pvscsi.c                 |   2 +-
 drivers/scsi/wd719x.c                     |   2 +-
 drivers/scsi/xen-scsifront.c              |   2 +-
 drivers/scsi/zorro_esp.c                  |   2 +-
 include/linux/blk-mq.h                    |   6 --
 include/linux/blkdev.h                    |   2 -
 include/scsi/libfc.h                      |   2 +-
 include/scsi/scsi_device.h                |   9 +-
 include/scsi/scsi_host.h                  |   3 +-
 110 files changed, 168 insertions(+), 258 deletions(-)

-- 
2.43.7


