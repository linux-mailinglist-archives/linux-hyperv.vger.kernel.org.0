Return-Path: <linux-hyperv+bounces-11577-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ieRVNWb9KGoYOgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11577-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 08:00:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C00566608A
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 08:00:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=EjMwLqYu;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11577-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11577-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C560130C9540
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jun 2026 06:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE434DCC7;
	Wed, 10 Jun 2026 06:00:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7FA3438B7
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Jun 2026 06:00:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071204; cv=none; b=HKGNRqJ4RJgUsZEmnak+LYJlxVWPo1Y+NVYo0a1jnRgXMr5bSJMZ0tfvxjPNM8Isrw42yEKBamvOkxye0y3TgaKR2AMevkdoCL2ov6DDVE/dveXCAhFejn5uwqniCQau1lsdjhs4N8yZSwmAz4EJPsrn/OMzU3isy5TFgkf2GiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071204; c=relaxed/simple;
	bh=AvZ62CJBNYf9slGn5Sv7jZnOy8sCQBSyuSuQs3KW624=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qcxo1vAQgh8LguD4+xI0lmVorylI/LvSOjQ2qtdWVAaJ9Vi1h0uLI5czavHdz8fjb1TajZ1UFHNOoItIpdnQhS6fLNBC1s+7s75vR1xfeRcRvwbZJpt70WPTx0ZrvQZ21slz7NPX0zDiXCgmK897uP9ZH8zgn9M32WEZPORV26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EjMwLqYu; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso25546055e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 23:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781071201; x=1781676001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eeq4qUemue69ATVH9Hc0G+s1EX6SM4VcPKiJpjYoUk=;
        b=EjMwLqYujTxy+YSxoLHsRyOYOX4r/EAZp2/ifXHXTJoJpf9tpEOLpOI6D7kbGzidhm
         qLO79IlI7HlqlCK2gjE/c/4YJ1nTaFIu84/098dMgwpBwJeE6ErYxbhVjJIN+z8Sdkq6
         tG02njeUzYHi+UzF2x88M8Cj2tCrV/CvpscLRDBurC7eykEDaT6soboaQvvNGgsbgH1w
         cbhQPAhnngBmAjWFoXiD/UAP3F2fTRPvDToqhbNLmRvaotOirJ2RIJwGNcKaGni4Vzom
         AdDC11mPMOHY5fCA3RWHyUtXOlaKEZdxwYYX0zhLUJRpYxe9G5r2KsqOMbSpkoEVSioS
         8M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071201; x=1781676001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eeq4qUemue69ATVH9Hc0G+s1EX6SM4VcPKiJpjYoUk=;
        b=V/CcuqaOPSSvu5iokEHLf0vb7ZQoUfs3P8MHn/b/Byy/2Y3FmeF7GWO1FYSMbh6YkP
         ESngxbtSIiifJnxZwKlhzocJ+e047Ezr7aA0iJE4lb44TTwSn/ABwljOVBtsDRXNVP3K
         M37c05BzB1L0CyL186B1NLc+nWXl5SK79ZE/11WLRB1o/1Bowk+mOcf/B18u8MmCJyk5
         OIdl6G3OFKA2SrHKgGWqHx9rs6EfBASpWuRxB/z/hebLUQe1v4IATIEdzRjnNbhkzCQA
         IxOgUMmo/61k25GMRPhL31/zHfO/co0eLQJk6TzoVi29cI4IwPboLPPAbsSyHzXQP+eZ
         Iucg==
X-Forwarded-Encrypted: i=1; AFNElJ/oAVz5P/TBilqH81WCqgtuVvUe7h/3me4sFT+hJf/wtEq4OQiQ+RxkNkEAqDCBGe8vTUGqTUzxAm1Td6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5aByvluG4NITpDORv5KT3OAerPIUHEoNFHYSu+cRU4oaCmZZq
	hxqm8JRYb/oTCou2+hD24dBUolaQ8siM1RQF9gURmV0Cn1pIl9v+yTPmkneWLQhhXa8=
X-Gm-Gg: Acq92OExv8AtWFHxy2XLLpLbDvthjKJHs5ajqVQmml1yMH4SGxmh0Tss8DVIKD3iepK
	PzJXgmNQz3qQDCxuR7S0Mt7J2PTiP1CtDZkVh+1qmdVIilOwTwmGkvZ+sKV4r49xL8Ghuo/JHbZ
	gfrp9nUqefQnw+HdNHHV4IiajNTnyk/74bKYr28WvOefc2O1e+NXa14+VWkVREONckRovjXCr9T
	nnrAz2VnuOwreN17PQomi7zqui6dtOUY/lGL0Ir5UQ4vyFQEXej3cv7uZ75YdWAaJxAOhS4ZYnz
	iBweJZiatBM0APY8HM9kS981K4iGBpXzAJaqHEpvY/eiSQpI9ofDlisXndLjdlbhmV4B9bpXFbC
	iyaXFhLD3i9PijfosgmkCDWoXhNhWe/aQdiEn3AL9BjfM+7wh8/IEMYk2hL7ZKNzc9o4Xtr9Hy2
	v0/Vb+ttMdW2Igw44iomjkD2pxINwC3OToSCiFYF3Q0vtktlG6vXAohaAZWsGIR77fNO4GyzA=
X-Received: by 2002:a05:600c:8285:b0:490:abef:dae6 with SMTP id 5b1f17b1804b1-490c25b09bcmr392960895e9.19.1781071200857;
        Tue, 09 Jun 2026 23:00:00 -0700 (PDT)
Received: from ?IPV6:2001:a62:1439:d001:a0af:1164:c6fd:8c51? ([2001:a62:1439:d001:a0af:1164:c6fd:8c51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm69552212f8f.33.2026.06.09.22.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 23:00:00 -0700 (PDT)
Message-ID: <e2a61373-0c27-41c3-b0ca-836a4727a3b5@suse.com>
Date: Wed, 10 Jun 2026 07:59:57 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] scsi: host: allocate struct Scsi_Host on the NUMA
 node of the host adapter
To: Sumit Saxena <sumit.saxena@broadcom.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 Adam Radford <aradford@gmail.com>, Khalid Aziz <khalid@gonehiking.org>,
 Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
 Matthew Wilcox <willy@infradead.org>, "Juergen E . Fischer"
 <fischer@norbit.de>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Finn Thain <fthain@linux-m68k.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
 Jamie Lenehan <lenehan@twibble.org>, Ram Vegesna <ram.vegesna@broadcom.com>,
 target-devel@vger.kernel.org, Bradley Grove <linuxdrivers@attotech.com>,
 Satish Kharat <satishkh@cisco.com>, Sesidhar Baddela <sebaddel@cisco.com>,
 Karan Tilak Kumar <kartilak@cisco.com>, Yihang Li
 <liyihang9@h-partners.com>, Don Brace <don.brace@microchip.com>,
 storagedev@microchip.com, HighPoint Linux Team <linux@highpoint-tech.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Brian King <brking@us.ibm.com>, Lee Duncan <lduncan@suse.com>,
 Chris Leech <cleech@redhat.com>, Mike Christie
 <michael.christie@oracle.com>, open-iscsi@googlegroups.com,
 Justin Tee <justin.tee@broadcom.com>, Paul Ely <paul.ely@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
 megaraidlinux.pdl@broadcom.com,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 mpi3mr-linuxdrv.pdl@broadcom.com,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Ranjan Kumar <ranjan.kumar@broadcom.com>, MPT-FusionLinux.pdl@broadcom.com,
 Daniel Palmer <daniel@thingy.jp>, GOTO Masanori <gotom@debian.or.jp>,
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Geoff Levand <geoff@infradead.org>,
 Michael Reed <mdr@sgi.com>, Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com, Narsimhulu Musini
 <nmusini@cisco.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 linux-hyperv@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
 virtualization@lists.linux.dev, Vishal Bhakta <vishal.bhakta@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, John Garry <john.g.garry@oracle.com>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-3-sumit.saxena@broadcom.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260609121806.2121755-3-sumit.saxena@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hare@suse.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[HansenPartnership.com,vger.kernel.org,gmail.com,gonehiking.org,microsemi.com,infradead.org,norbit.de,armlinux.org.uk,lists.infradead.org,linux-m68k.org,qlogic.com,neukum.org,web.de,twibble.org,broadcom.com,attotech.com,cisco.com,h-partners.com,microchip.com,highpoint-tech.com,linux.ibm.com,ellerman.id.au,kernel.org,lists.ozlabs.org,us.ibm.com,suse.com,redhat.com,oracle.com,googlegroups.com,thingy.jp,debian.or.jp,netlab.is.tsukuba.ac.jp,cloud.ionos.com,sgi.com,marvell.com,microsoft.com,lists.linux.dev,epam.com,lists.xenproject.org];
	TAGGED_FROM(0.00)[bounces-11577-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.saxena@broadcom.com,m:martin.petersen@oracle.com,m:axboe@kernel.dk,m:James.Bottomley@HansenPartnership.com,m:linux-scsi@vger.kernel.org,m:linux-block@vger.kernel.org,m:aradford@gmail.com,m:khalid@gonehiking.org,m:aacraid@microsemi.com,m:willy@infradead.org,m:fischer@norbit.de,m:linux@armlinux.org.uk,m:linux-arm-kernel@lists.infradead.org,m:fthain@linux-m68k.org,m:schmitzmic@gmail.com,m:anil.gurumurthy@qlogic.com,m:sudarsana.kalluru@qlogic.com,m:oliver@neukum.org,m:aliakc@web.de,m:lenehan@twibble.org,m:ram.vegesna@broadcom.com,m:target-devel@vger.kernel.org,m:linuxdrivers@attotech.com,m:satishkh@cisco.com,m:sebaddel@cisco.com,m:kartilak@cisco.com,m:liyihang9@h-partners.com,m:don.brace@microchip.com,m:storagedev@microchip.com,m:linux@highpoint-tech.com,m:tyreld@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:brking@us.ibm.com,m:lduncan@suse.com,m:cleech@redhat.com,m:mich
 ael.christie@oracle.com,m:open-iscsi@googlegroups.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:kashyap.desai@broadcom.com,m:shivasharan.srikanteshwara@broadcom.com,m:chandrakanth.patil@broadcom.com,m:megaraidlinux.pdl@broadcom.com,m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:mpi3mr-linuxdrv.pdl@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:MPT-FusionLinux.pdl@broadcom.com,m:daniel@thingy.jp,m:gotom@debian.or.jp,m:yokota@netlab.is.tsukuba.ac.jp,m:jinpu.wang@cloud.ionos.com,m:geoff@infradead.org,m:mdr@sgi.com,m:njavali@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:nmusini@cisco.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:pbonzini@redhat.com,m:stefanha@redhat.com,m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:vishal.bhakta@broadcom.com,m:bcm-kernel-feedback-list
 @broadcom.com,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:xen-devel@lists.xenproject.org,m:john.g.garry@oracle.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[81];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,vger.kernel.org:from_smtp,broadcom.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C00566608A

On 6/9/26 14:18, Sumit Saxena wrote:
> scsi_host_alloc() used kzalloc(), which always picks an arbitrary node.
> Extend the function to accept a 'struct device *dev' parameter and use
> kzalloc_node() with dev_to_node(dev) so the Scsi_Host struct lands on
> the same NUMA node as the HBA, mirroring the treatment already applied
> to struct scsi_device, struct scsi_target, and shost_data.
> 
> When dev is NULL (legacy ISA/platform drivers without a dma_dev) the
> allocation falls back to NUMA_NO_NODE, preserving existing behaviour.
> 
> Update all in-tree callers:
>    - PCI-based HBA drivers pass &pdev->dev (or the equivalent struct
>      member such as &phba->pcidev->dev, &h->pdev->dev, &ha->pdev->dev)
>      so their host struct is placed on the adapter's node.
>    - Non-PCI drivers (ISA, Amiga, ARM PCMCIA, virtio, Hyper-V, PS3, …)
>      pass NULL.
>    - libfc's libfc_host_alloc() inline helper passes NULL; FC drivers
>      that want NUMA awareness can open-code the call with their pdev.
> 
> Suggested-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>   drivers/scsi/3w-9xxx.c                    | 2 +-
>   drivers/scsi/3w-sas.c                     | 2 +-
>   drivers/scsi/3w-xxxx.c                    | 2 +-
>   drivers/scsi/53c700.c                     | 2 +-
>   drivers/scsi/BusLogic.c                   | 2 +-
>   drivers/scsi/a100u2w.c                    | 2 +-
>   drivers/scsi/a2091.c                      | 2 +-
>   drivers/scsi/a3000.c                      | 2 +-
>   drivers/scsi/aacraid/linit.c              | 2 +-
>   drivers/scsi/advansys.c                   | 6 +++---
>   drivers/scsi/aha152x.c                    | 2 +-
>   drivers/scsi/aha1542.c                    | 2 +-
>   drivers/scsi/aha1740.c                    | 2 +-
>   drivers/scsi/aic7xxx/aic79xx_osm.c        | 2 +-
>   drivers/scsi/aic7xxx/aic7xxx_osm.c        | 2 +-
>   drivers/scsi/aic94xx/aic94xx_init.c       | 2 +-
>   drivers/scsi/am53c974.c                   | 2 +-
>   drivers/scsi/arcmsr/arcmsr_hba.c          | 3 ++-
>   drivers/scsi/arm/acornscsi.c              | 2 +-
>   drivers/scsi/arm/arxescsi.c               | 2 +-
>   drivers/scsi/arm/cumana_1.c               | 2 +-
>   drivers/scsi/arm/cumana_2.c               | 2 +-
>   drivers/scsi/arm/eesox.c                  | 2 +-
>   drivers/scsi/arm/oak.c                    | 2 +-
>   drivers/scsi/arm/powertec.c               | 2 +-
>   drivers/scsi/atari_scsi.c                 | 2 +-
>   drivers/scsi/atp870u.c                    | 2 +-
>   drivers/scsi/bfa/bfad_im.c                | 2 +-
>   drivers/scsi/csiostor/csio_init.c         | 4 ++--
>   drivers/scsi/dc395x.c                     | 2 +-
>   drivers/scsi/dmx3191d.c                   | 2 +-
>   drivers/scsi/elx/efct/efct_xport.c        | 4 ++--
>   drivers/scsi/esas2r/esas2r_main.c         | 2 +-
>   drivers/scsi/fdomain.c                    | 2 +-
>   drivers/scsi/fnic/fnic_main.c             | 2 +-
>   drivers/scsi/g_NCR5380.c                  | 2 +-
>   drivers/scsi/gvp11.c                      | 2 +-
>   drivers/scsi/hisi_sas/hisi_sas_main.c     | 2 +-
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 2 +-
>   drivers/scsi/hosts.c                      | 6 ++++--
>   drivers/scsi/hpsa.c                       | 2 +-
>   drivers/scsi/hptiop.c                     | 2 +-
>   drivers/scsi/ibmvscsi/ibmvfc.c            | 2 +-
>   drivers/scsi/ibmvscsi/ibmvscsi.c          | 2 +-
>   drivers/scsi/imm.c                        | 2 +-
>   drivers/scsi/initio.c                     | 2 +-
>   drivers/scsi/ipr.c                        | 2 +-
>   drivers/scsi/ips.c                        | 2 +-
>   drivers/scsi/isci/init.c                  | 2 +-
>   drivers/scsi/jazz_esp.c                   | 2 +-
>   drivers/scsi/libiscsi.c                   | 2 +-
>   drivers/scsi/lpfc/lpfc_init.c             | 2 +-
>   drivers/scsi/mac53c94.c                   | 2 +-
>   drivers/scsi/mac_esp.c                    | 2 +-
>   drivers/scsi/mac_scsi.c                   | 2 +-
>   drivers/scsi/megaraid.c                   | 2 +-
>   drivers/scsi/megaraid/megaraid_mbox.c     | 2 +-
>   drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
>   drivers/scsi/mesh.c                       | 2 +-
>   drivers/scsi/mpi3mr/mpi3mr_os.c           | 2 +-
>   drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 4 ++--
>   drivers/scsi/mvme147.c                    | 2 +-
>   drivers/scsi/mvsas/mv_init.c              | 2 +-
>   drivers/scsi/mvumi.c                      | 2 +-
>   drivers/scsi/myrb.c                       | 2 +-
>   drivers/scsi/myrs.c                       | 2 +-
>   drivers/scsi/ncr53c8xx.c                  | 2 +-
>   drivers/scsi/nsp32.c                      | 2 +-
>   drivers/scsi/pcmcia/nsp_cs.c              | 2 +-
>   drivers/scsi/pcmcia/qlogic_stub.c         | 2 +-
>   drivers/scsi/pcmcia/sym53c500_cs.c        | 2 +-
>   drivers/scsi/pm8001/pm8001_init.c         | 2 +-
>   drivers/scsi/pmcraid.c                    | 2 +-
>   drivers/scsi/ppa.c                        | 2 +-
>   drivers/scsi/ps3rom.c                     | 2 +-
>   drivers/scsi/qla1280.c                    | 2 +-
>   drivers/scsi/qla2xxx/qla_mid.c            | 2 +-
>   drivers/scsi/qla2xxx/qla_os.c             | 2 +-
>   drivers/scsi/qlogicfas.c                  | 2 +-
>   drivers/scsi/qlogicpti.c                  | 2 +-
>   drivers/scsi/scsi_debug.c                 | 2 +-
>   drivers/scsi/sgiwd93.c                    | 2 +-
>   drivers/scsi/smartpqi/smartpqi_init.c     | 2 +-
>   drivers/scsi/snic/snic_main.c             | 2 +-
>   drivers/scsi/stex.c                       | 2 +-
>   drivers/scsi/storvsc_drv.c                | 2 +-
>   drivers/scsi/sun3_scsi.c                  | 2 +-
>   drivers/scsi/sun3x_esp.c                  | 2 +-
>   drivers/scsi/sun_esp.c                    | 2 +-
>   drivers/scsi/sym53c8xx_2/sym_glue.c       | 2 +-
>   drivers/scsi/virtio_scsi.c                | 2 +-
>   drivers/scsi/vmw_pvscsi.c                 | 2 +-
>   drivers/scsi/wd719x.c                     | 2 +-
>   drivers/scsi/xen-scsifront.c              | 2 +-
>   drivers/scsi/zorro_esp.c                  | 2 +-
>   include/scsi/libfc.h                      | 2 +-
>   include/scsi/scsi_host.h                  | 3 ++-
>   97 files changed, 107 insertions(+), 103 deletions(-)
> 
Quite a lot of churn for such a (relatively) simple change.

I think it might be better to introduce a new function
(scsi_host_alloc_node() ?) with the additional parameter,
and make scsi_host_alloc() a wrapper around that.

That will reduce the size of this patch immensely.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

