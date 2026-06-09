Return-Path: <linux-hyperv+bounces-11555-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hb4ACIYRKGq29QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11555-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 15:13:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D3E6606E6
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 15:13:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b="cJ/9cs8k";
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b="Mt/ICtpN";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11555-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11555-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7A373045ED6
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0241C302;
	Tue,  9 Jun 2026 13:06:18 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8041C2FC
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 13:06:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010378; cv=fail; b=Vib9eUSgO66CLqlTLs9gXR0le4B/RrkIPk32Xngrf5o1EZpRAyJWCRruxRa+Frz8u3MZogO86MF5i+kdAphQTDZLHNwIUShlLtvQhglvtj+mgV/HLAkMX7j2UH51wnXgbGGHeHtYY+Z3+C06lf2IhvU6v2awlh58JNelq8oq8Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010378; c=relaxed/simple;
	bh=SrpPtCdDd7YOf8ijGfUtV+SKDhOxPf4ge0RGdHMF6bU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHUcaJ72fp4T5xgWGqFRNP45OjU0BINEQG7uu/eriqSAYnRrcMreucc8yMC9dZuxJmVusepvxosuTQ/na+XbX9ExeMySL8BlZIpOO+WgG2BL2JmyFpNDjGhmxpq8ngwCoOTlKMntjtbY2WYH4YUi3k9Msx3bILQTGHC+1kfAMOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cJ/9cs8k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mt/ICtpN; arc=fail smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6598H5Lo3246913;
	Tue, 9 Jun 2026 13:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hkafPhPn2ZUoqC38Axyejl3/HjFZYDX29rq+w+VMToE=; b=
	cJ/9cs8kVSwoRcyqUajxt5xbP4UaQIjB3EyujxpaYMWxiKOB+McpBXxlxKtaZoRr
	Ws8/GO0PiDNjuoxVrINjURLwAhPh+X+KAkiNuRW9k0zh6zV2dLe54vJSWRH7h9+M
	pA/9wDlJc88jjHSvIdgOx65WE7gBbAI0lHkavDwKQkS70FYoVlIJDL8DFsAW2LNk
	eV50Niff6J+gXUkdbigXIlq1xm/UItWXwuoZgY9OMFsfTGcNVfbgNw7laU3HrHWi
	INKV6YLa3bH96RGxxKbto9+ye4o9uko9qsvW7pYsvH5+FHWrqJ3a70EHABd3HG/P
	pqlWv8uVE6Zh3ssz2fvZCQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emc3rm8cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 13:05:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 659D3ibN014478;
	Tue, 9 Jun 2026 13:05:07 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0q4104-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 13:05:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye1oqYUnfYSXu7x/41/sMUQTslcdH8Hnnfo0a+wfIZGL8mLzmxjooqc9TI1iByofwMYXCaOoNbxqhhMjQYzuNBP4r2YrDWR4SQuv/oplPIiVysBPwbeZxn7kNtl7vWIVCFkhrvNl3vX/W2zY/AUzAAC67JPypCys20qf+MCXecwUA4KJX/U88ZWwXW6QJR9w/aq1lMjKsGNfH1tv+GwuoXBXxv4OzKXt7uW//sR+ItHCX4JzrNXLdK72a+Da8PCDyCGDNGr8FyS1K2jfJyd5NkCbIyXM9+UYerD2sdFWmAEjufMgGHmU5HEYo9CG9nYyg5Yie6cvQnFlFX0XV2ZUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkafPhPn2ZUoqC38Axyejl3/HjFZYDX29rq+w+VMToE=;
 b=oc8braw6m9ksUcltuahYe+Bavyed/Tyw/yRI4VRUJyNighO938VQ6PAyNdLo5tqtvqWJmP+mkhuUuX8azdyxUMY3ukdpPjit6Lb89WPHyb/pnrNkZNTNW7QFlCPmUvIc0EltTHqwm5TQz7lnyvBWVS8nIxedHeyo56NEKo6Vnj1387AmbyMbHOKb/d/lBhsPt053+8LhKseBhPwLbKO7/eXympBc9JTTAAEQj4k1qN+A2MuPCC4+/7k136vG4x+MudfRuKcP0dBV3UeRSAnDCXKwi2L5l5Y8aLjdiHakx8c75qB4JVRQFb3UlLjnw8GrmWxc2D6ufcaxpdqcZe4Z/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkafPhPn2ZUoqC38Axyejl3/HjFZYDX29rq+w+VMToE=;
 b=Mt/ICtpNZ43a9iX2ctCQzsz+mkpVM3JmJBXWYcoZXL6cN3sSMtqqbChp3jolkZiPtmFju/3ZaCvfuWi+cMdTlNRYSMaYR1m3KxYtk2S+ruxeiqB2RroKt1dZ49TG7ub85yK5UduLYvve4EsMEijGS93Ux2BBIZnIxqlmsW3ZRDc=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS7PR10MB4848.namprd10.prod.outlook.com
 (2603:10b6:5:3a2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 13:04:01 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 13:04:01 +0000
Message-ID: <12716adc-a026-4a5d-b981-78431a5be39a@oracle.com>
Date: Tue, 9 Jun 2026 14:03:45 +0100
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
        Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Ram Vegesna <ram.vegesna@broadcom.com>, target-devel@vger.kernel.org,
        Bradley Grove <linuxdrivers@attotech.com>,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Yihang Li
 <liyihang9@h-partners.com>,
        Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
        HighPoint Linux Team <linux@highpoint-tech.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Brian King <brking@us.ibm.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        Mike Christie
 <michael.christie@oracle.com>,
        open-iscsi@googlegroups.com, Justin Tee <justin.tee@broadcom.com>,
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
        MPT-FusionLinux.pdl@broadcom.com, Daniel Palmer <daniel@thingy.jp>,
        GOTO Masanori <gotom@debian.or.jp>,
        YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Geoff Levand <geoff@infradead.org>, Michael Reed <mdr@sgi.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Narsimhulu Musini
 <nmusini@cisco.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        linux-hyperv@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
        Vishal Bhakta <vishal.bhakta@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-3-sumit.saxena@broadcom.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260609121806.2121755-3-sumit.saxena@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::7) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: f868ae62-f295-40ab-a3c4-08dec6279327
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
 lr9aWUQQvYqYsqHnQ6d89eYodmgt7Gqztr38OR54hPWHHOZGdxJZoRGV3AJpVGbS/qmpxqtkzNrHtTXzqZQKRKEf0KE5Q6KF+4zC4SAAEYo/ZpLwqxbPbmYSXOQvxuSe4JMEkk2y9yWRctmfU/3QGIfOCUOFB2/sfKsHufV0fHYCCuHwTXbwp01JxLbV6Nk29z7SO4oX8TMF2+S7MyxATBxi/B2m+pN103kBg9t9sT5vglOPpD6KymOcYcZHELlLbPCTB9mjs7qyymkv0YLD7ytdfZXObou2ud3ZOzspWFGIHAjlMWGOZNj5ceYXQ3kBe69ynVRHqxmZy9IE8RtPMPgPIpO2bMiU6LtxFyc7hE9wUSXptmR1J5C14OfuUR3suXhdTq6nGW81VtPBG8LFiDTjfCd9V06W2a/9B02lsQWHqBjOyiGklOqou/3iXt88hPtTk0lhKATmTq3nqpyQYAhoEKeEBf9QENTUGFb5WD0P8YUSETayQIJropp5Ajkxx1DchxQlEgiGxzXXe1Zw1p4+ug25uF9D0Es9NSwRlrXydyz4XDWcgba5RfXxdE3N5uaqoPY8OMtToPxqdBYpGv7O21Gycfig81DWcbHwuXiuVAug6FsKI65Xv1mUE1tcb0y900IXKpzVYvTsM9HCJ7OQF2AXEgdcKJIszxTdGyh4g6pB97ExJRBRFOEm5QEP
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VmN1MEkyMEM4YlpHYlcwWFkrV0tMZGJwZzZsRXVZaXBTWGFsMTlJcU10Zys2?=
 =?utf-8?B?TGZsSEdlWUp3OHN2UFNyM0FwVFIvTm9uM041eitJVXpINExPa01pc0wzNHRX?=
 =?utf-8?B?SmZzODdoSG5USDM3em1ZMERYMWE5V2tnOHU4R1hwOEtMN1l5cHlMZzBBS1A5?=
 =?utf-8?B?ZlBGa0JTRlByY0pVNE1jNkV5ckpFM0crL1pNMnZsNjdJMjYwMEF1eU5uVmI3?=
 =?utf-8?B?eThBWG9KMnBvZEQwTXU5Q2ZlZFdlQnRHelBtUDN5YkU2Q2NUc2Y1MTBDOGVp?=
 =?utf-8?B?bUNibldydG9uSkdSMExtQnYwb0x2MU9SZ2lyejhGMGdhbFI1bVpRREQ5Rlln?=
 =?utf-8?B?K0ZLRVFWQzgyeHo3bXV3R0hqQlAybmlmZ1Z3ZHdBakhTa2hzZmJpQm9TajVx?=
 =?utf-8?B?N2wrck5qZjBpNFBIWWFDSzlZN2x2ZFhkWFRxTGkzVWdTVWVmNU1uOGhadEoz?=
 =?utf-8?B?RUxaQTJGQ3BZOS9GWWVQTVozTEJlYXArbHpWOCswK1JtTUVDVjAweFJiVGpF?=
 =?utf-8?B?Z2V2TngwbWZ1cTVNU29UQktSZ2xBckhPZ0FuZTF1SHNRTkRIY3Y1V003WEdh?=
 =?utf-8?B?OURxNDN2L1RmSUU5WFBHck84V09PYitWTUgyTTIvOUJXUk1pWG9FNzVmc3lq?=
 =?utf-8?B?RVQ1ZHRhMk9jdkt5UWpBaGxDU2VXK2pydlRkL296dU1NcTlrSGE2WWdUOUMx?=
 =?utf-8?B?ZWZnbkZ0dVJGdkFEekZyRXhVc2hFYTVYclgwYlpWZFdFbDJySGllZG5tTzJp?=
 =?utf-8?B?N0VGMnc5eVYrUUJKUTdDWjVja2R1U3pqRGNxOXpiSWp3L2RESHZJREpuWmVj?=
 =?utf-8?B?eExNblZsT0RMdTRvaCs2d1I0Sm1STE1iMzdKSHdWM1diVVlEUFZtUHdRYnRD?=
 =?utf-8?B?ZC9IeHhoMW5wWmJZcWs2THAyZEcxandxdGkwS284cTVxZ21OVHRSblhySTNO?=
 =?utf-8?B?aTI5M1dEUHY2OW9hTmdrZ2E0L1ZqUEpjanRITmYvWllEVS9TWDdDYXY2RW1F?=
 =?utf-8?B?KzVGcE9oYjd1akxQd3VWWmplK01jZFdPeHN0WFlCcXdZeFdMT2svYzdDSzFp?=
 =?utf-8?B?Uk1wczZkWWR0V2lXL3dlTUcxY29vOXpNbTdrQ2cxYXpFMXJuclpzMG1aWDZn?=
 =?utf-8?B?Z2E0NUoxY2tTd0RFRUNWQXppeEVPbmNZUEtFdlREcTZGUW5XbHBlc1FiaG1G?=
 =?utf-8?B?UTk2YkhOSjEvMWFQdUNtR3NnQlU5K0NUNUN1cS9PUVcvaUF3KytCOTd1Rllw?=
 =?utf-8?B?cXVtdXFKMDJDa0dCM2gyN1FOSFR2bzVYc2Q3bk9nL1dhL1Y2Ty9tNUkvdFhw?=
 =?utf-8?B?b0krTXZPZDRicE1GN1E5bWt0YVdNQ25sdHZ6Y0MvYkxhUElNdmgybW45RWRS?=
 =?utf-8?B?T1Z6a3poTEhtSXlSUllUSk12TGsrQ0N0RmlYMXdjVlBHaURMdUQ2bW50cE8w?=
 =?utf-8?B?THI2WHVwaUt3UlFkOGxrWWFPak56SnROSGxQNlgyeW1nRzVTSUhrM0N6TldW?=
 =?utf-8?B?eGpBTU1lYjRSZi85L3dlZUkwYjhrdllqVjRMbGVLTXZxbThiY2x6ZnlPeG02?=
 =?utf-8?B?T2t5enV2QmhDS09sMlc1YlJjMGtDWU40RkxxRWVzVjRDVnpXQVJINU9zTkxs?=
 =?utf-8?B?djBVVkluUEZtaGpia1dUdmRIZHRndU9jVFhlTk1HakVJK3dDMXdETjR3Zit1?=
 =?utf-8?B?UkovNmxneFQwMlM2RENSMWtPcHYyWWZMbzAyczNuMzJObkFITzIzQnFhUE1q?=
 =?utf-8?B?MFdyK0tWNUwvbHppVlBNZGxSbTBWVTJnTjBPNzFFZS90UVFSYlloN2ZlcU4z?=
 =?utf-8?B?M2h0TVY4bUZRbnpKR0ZRNDdweS9RZ1g4bkZuWGhkcHYrTmgxQVV0cHhVS2Zo?=
 =?utf-8?B?a2gwY1ZUa1J4dXM2T3RrOElZbytLZDJ1dkVURkIwWHV5bloyeWhUbTRZeHNB?=
 =?utf-8?B?NEV0OS92VWVHRnlHQmRXWit2SytlbDNGd0NGVUpnNmU0ZlQ5MUo1Ykp1U2Zx?=
 =?utf-8?B?ZXVOQ28rU0RZbG9UL2kyeTV3T3FYNGU3REJ1cjNxYytMWncwYjJhY2FYM0Vj?=
 =?utf-8?B?aVJscndmR09jNEh5eG00OGY3WEYzQTg4MTJaaXhibm1PRDhCSE9HQmJKbGdF?=
 =?utf-8?B?eXdyOUk0ZW5UYzYvSHl2VXBXRE9meitVM3RiKzN0bTNLOC9wTXpUVGVWU0V3?=
 =?utf-8?B?TVFJYk13TWFtdWRwY0ZFKy8zcVFXK09HU2VwQ3o2Q1dTYlgwQnpZWXh2Mk16?=
 =?utf-8?B?M2lxQTk5UW1ZeURKTWRCWmxyS0pkczc2c29oakpiYndhaWM0ZHpiN1hQclBl?=
 =?utf-8?B?V3YyMW9SSWg1UDEzMXBWcVppbThmQkMyU0lPMGNZeStkdU51QVQzUT09?=
X-Exchange-RoutingPolicyChecked:
	rTSJW0lnJNpxXN7Exd6oPBKQhnrdUWbxdwgvh8EjamEknVwUWuenSEQcfRY+JOGnSuOL1N4qnWXe4eINYU/2jBWu2bx+7P1Rb3pYgnpW+ssebSFghi1g04C3StUixisEn4VB7DcTbegDQu0tIvpFN7wKZYYHnbdaJlbN8CP4XPSfizzDjxLHjVLGVahY6tU6ysu5O9Am/mtCL1f3LTsD2MdV/rLQgyuJiksYeFs4v8yyQVUrc6k4M7jZztVxnwOmrDxhrX67z0MoHAJHYYxZdXaKn/tntBfBej+3GWnzvgBWBEkfb2EsoSS6+oPL1P2tjAGkoWczkYx2KT2NstbQTQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OisDCkqTW1Ijmm00C5ZR5NJpaRMFQOR1hxzOaJa5Zry+cigtuaEl/0kAkWAMNw/dI3Zj3/RsdZnzTrVq9+jiFl4J+YIalBKAILktyc8SCXw9YONSOIvwGQS0v9WOu9gAciV542fo6hGL9vSqXK0+pyLNnuJUlk6QM+QaOpTTF1K9s+s7o8VIa0rTYAzYKw5K1g0WepnedIYdMXMbRgeMFijP5JjWxSCq7YROyS/mW/UXpg/s6dSqHLUW2FLbHyOrfzvje+XMwLkN2zogrtFy4Bi4+QP8yuLAXwANL4S5MDXj2iBMbN6BWLNPhHj3yt/4YQYvcz5on8+3a/dOrXmD2UI6IdCorq5MYA7wobfxkOIMwS/K8/96+o6l3Xrjq65tzLG58H0yBXXY6uYUBSWhVnP5GM/OMczOKbULnUXaNvZxUmxiOjqv6VZ2AXDuGFApre056Mt8pNdvrBSoBW2tXeg/i9VZdc+tQfWeCyjWN5YOf9VsdpLjsG5hvWuSWrlNZ9MtBQvX6ikzteMqOZ4okvyshKmwNgC/nm12YSOFA1ZPAfpyKgImkcXo7plD4zUGJctdKeNYL+WSpT9OscW3SVGa0cKFZLJrNpZ/js4tncI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f868ae62-f295-40ab-a3c4-08dec6279327
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 13:04:01.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhxh6ARi7uS+6jN6dZBF5IpOMAU1NgN/AliUPOWchv+PlblYvk66dgJI0/8Tftr2IS5JXFRwiboVPrscI2snpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606090124
X-Proofpoint-ORIG-GUID: _SOt8WyKKKpoCedRkVtLqCgdNCyTxuXe
X-Authority-Analysis: v=2.4 cv=crirVV4i c=1 sm=1 tr=0 ts=6a280f85 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=Q-fNiiVtAAAA:8 a=Dtt8aju-Z9gyQQo-GkUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-GUID: _SOt8WyKKKpoCedRkVtLqCgdNCyTxuXe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNCBTYWx0ZWRfXyC0dKITnBUYf
 8I9wim9IoQPZPzn+lKLQHcs2ZXb1XE74rJjccrxgh7ThywPuLd11QRVjFBbwQv0pYwfJavdn5TF
 X3pqWChBSv1fsm2yVb9Q4/NF08sBp4AGYz72+nxmzjnxb5ibvks54ZILeEjbD/Q100W7LvgTgpg
 j6zGHFNPhjy6Ro2rKedJYugdbb2aiRWT95ZSslN35nj7hA583LqC6DRY81vX0N2mjGKsgFyv6h6
 tRDt/kVWC1MG2dx5zrXVpCzxgwwCe1slUKpRxOc7QJzhk1Pw4bC8DCnptBxKVCZSjImYnCkGQdY
 ruhdctbnya7pg+YDZEY3nKmeAcx4reO3RzRzoOZYk68pqJTxFCOYjDJOqzAxqBHzlRmU2pPeBq5
 aQFOoTnJywCjnBAKX9clnPusG6qk7M+bUf2nlqMwK25iEBonykeDRP6A0W298I9iEyym8oe5xwx
 6/CM8WbM2HzxrUp92reJzTUTHkN2fyKeAjjlxp94=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11555-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.saxena@broadcom.com,m:martin.petersen@oracle.com,m:axboe@kernel.dk,m:James.Bottomley@HansenPartnership.com,m:linux-scsi@vger.kernel.org,m:linux-block@vger.kernel.org,m:aradford@gmail.com,m:khalid@gonehiking.org,m:aacraid@microsemi.com,m:willy@infradead.org,m:hare@suse.com,m:fischer@norbit.de,m:linux@armlinux.org.uk,m:linux-arm-kernel@lists.infradead.org,m:fthain@linux-m68k.org,m:schmitzmic@gmail.com,m:anil.gurumurthy@qlogic.com,m:sudarsana.kalluru@qlogic.com,m:oliver@neukum.org,m:aliakc@web.de,m:lenehan@twibble.org,m:ram.vegesna@broadcom.com,m:target-devel@vger.kernel.org,m:linuxdrivers@attotech.com,m:satishkh@cisco.com,m:sebaddel@cisco.com,m:kartilak@cisco.com,m:liyihang9@h-partners.com,m:don.brace@microchip.com,m:storagedev@microchip.com,m:linux@highpoint-tech.com,m:tyreld@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:brking@us.ibm.com,m:lduncan@suse.com,m:cleech@r
 edhat.com,m:michael.christie@oracle.com,m:open-iscsi@googlegroups.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:kashyap.desai@broadcom.com,m:shivasharan.srikanteshwara@broadcom.com,m:chandrakanth.patil@broadcom.com,m:megaraidlinux.pdl@broadcom.com,m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:mpi3mr-linuxdrv.pdl@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:ranjan.kumar@broadcom.com,m:MPT-FusionLinux.pdl@broadcom.com,m:daniel@thingy.jp,m:gotom@debian.or.jp,m:yokota@netlab.is.tsukuba.ac.jp,m:jinpu.wang@cloud.ionos.com,m:geoff@infradead.org,m:mdr@sgi.com,m:njavali@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:nmusini@cisco.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:pbonzini@redhat.com,m:stefanha@redhat.com,m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:vishal.bhakta@broadcom.com,m:bcm-kern
 el-feedback-list@broadcom.com,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[john.g.garry@oracle.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,vger.kernel.org,gmail.com,gonehiking.org,microsemi.com,infradead.org,suse.com,norbit.de,armlinux.org.uk,lists.infradead.org,linux-m68k.org,qlogic.com,neukum.org,web.de,twibble.org,broadcom.com,attotech.com,cisco.com,h-partners.com,microchip.com,highpoint-tech.com,linux.ibm.com,ellerman.id.au,kernel.org,lists.ozlabs.org,us.ibm.com,redhat.com,oracle.com,googlegroups.com,thingy.jp,debian.or.jp,netlab.is.tsukuba.ac.jp,cloud.ionos.com,sgi.com,marvell.com,microsoft.com,lists.linux.dev,epam.com,lists.xenproject.org];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.g.garry@oracle.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_GT_50(0.00)[81];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73D3E6606E6

On 09/06/2026 13:18, Sumit Saxena wrote:
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

Wow ... I was not expecting such a large change, but admittedly I did 
not consider the implementation.

I did mention that pci-based adapters should already be effectively 
doing kzalloc_node() since the adapter driver is probed on the local 
NUMA node (and kmalloc first tries local NUMA allocations).

> ---

> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index e047747d4ecf..e1f42be79729 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -403,12 +403,14 @@ static const struct device_type scsi_host_type = {
>    * Return value:
>    * 	Pointer to a new Scsi_Host
>    **/
> -struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int privsize)
> +struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht, int privsize,
> +				  struct device *dev)
>   {
>   	struct Scsi_Host *shost;
>   	int index;
>   
> -	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);
> +	shost = kzalloc_node(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL,
> +			     dev ? dev_to_node(dev) : NUMA_NO_NODE);
>   	if (!shost)
>   		return NULL;
>   

> -extern struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *, int);
> +extern struct Scsi_Host *scsi_host_alloc(const struct scsi_host_template *sht,
> +					 int privsize, struct device *dev);
>   extern int __must_check scsi_add_host_with_dma(struct Scsi_Host *,
>   					       struct device *,
>   					       struct device *);


scsi_add_host_with_dma() and scsi_add_host() do assignment of 
shost->dma_dev, so I think that could be moved to scsi_host_alloc().

I can imagine that we always know dev and dma_dev at Scsi_Host alloc 
time (and not just scsi_add_host()) time. However those would be very 
intrusive changes.

Let me consider this more. Maybe we can have a platform device version 
of shost alloc, as I can't imagine that we care about much more. Thanks!

