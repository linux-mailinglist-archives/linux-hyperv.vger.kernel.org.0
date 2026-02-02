Return-Path: <linux-hyperv+bounces-8666-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJUGNaY3gWm7EwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8666-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 00:47:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 432DDD2BBD
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 00:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E11203014645
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 23:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839335A936;
	Mon,  2 Feb 2026 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SVwpCEBM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020108.outbound.protection.outlook.com [52.101.85.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B02F7ACA;
	Mon,  2 Feb 2026 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076057; cv=fail; b=E88MNfLbgwuHTsjHCWJvTl/PIhvJo28umittFyCzZ/hAh+fwxIeeHZz/AgY2PZeEeW+h96A1jArSA/9ziFvyaPsldpzFLnY2nnTPAvclEjxv8q5zOXJk/Jy6ig3sskYSgylCqunB+hRkDyugHjOiS2FIsWU8TACgLkuHBtgrIrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076057; c=relaxed/simple;
	bh=AssnuB5NDWLCIVZCNhhMWbKgNpi4TI7CABd4cgUT9f0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tjoHr5sokISHP4/AkwsVwdjFssvuhw8CN/A0DeVQKEoTcuTqq2x3e6iHf1392mdKgNbw5UJhWw5hZNCoEvQhLa8ouFgpcsqIBxutrbqgRTsFd6A5Ww/j8/ZEjlmVxWNDbuS0ZKvRiSfyOn0te4RgV6hb4Cfh4Ky/NjSBJvtOYFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SVwpCEBM; arc=fail smtp.client-ip=52.101.85.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqpyvsEZJ4vuQN+XKsUUsxgOMJMjShrxikLaALN/A0XxhkoNlr3wuzHRlAIl6vRnMqUv17rtt3Zfqg8GS86vlQIZHoXmFxixDXSD2DCve10GIEyzUbfC9MXOvj+6szZDtrteQGKNbJSSgtw/WTlI6TThpceeg9lSHtM5acvmrDiTFYdzbuk/s1YfI20YaXEOX+eXNR2J6C8pSMJNGhw94pESmE+2adgZYcDRzrlsNuBQJlNWLgk/voGp+7hedZhNZ5iwjHKNVBhzc1z93soIF4MDiwFuyC5e00ilDUYFGKzwfNpP4x5GpxykN/L1Xhq/MAkITUH2WzfOCAC6NMgOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYanTrt+bN67T4M4XfE1XA6EsYOAKIm2jR5Wb0SHcgY=;
 b=X4YDNQJ2/6IzDpLP81cB6F5AHBt+EP7pi5u7LEi1y9iOQlTa8vPTd3RtX9yTc9tvxHEtTnoSpX/aJkI6mQW+bkS56Fi7jS29nzRdGabCA9QyQvSh7gvnXNOWvXA9IyBcl4iuy7DC1I2msuPVCaMwZd3aG8Np4q9/oKEbKzVh5kCAtNgBAeOPs5rChGVUOo61DXljQyKb1+KcLRLkaVF6dtXTAz1ghs2UIYJeFKKxIZit+fFCXpDaT4AMhUzqKOv/1lSXEdZaWWenPj8HYqXAl/9lMdV4Ip7iRt18dt1pBkoLRBHhT+DMJVUxpfISnIN6N755ud45J3f6nbUDoJIS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYanTrt+bN67T4M4XfE1XA6EsYOAKIm2jR5Wb0SHcgY=;
 b=SVwpCEBMO0L74+pPb1q58UtRAPVM1WR+oy91rPmOHV0JgaPK2MUegxuIRyXH1LI6Hnrj7yG6h2+yfyBfJvDuIX5jgJLjKsQDmJpjiH4jI0H5bxAyVR2evvggk9fAzt825B3sheYMZ1vVT21DTti1aCOOwew2w50xv63Q2WDuGiE=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB6580.namprd21.prod.outlook.com (2603:10b6:8:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.10; Mon, 2 Feb
 2026 23:47:31 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9587.010; Mon, 2 Feb 2026
 23:47:31 +0000
From: Long Li <longli@microsoft.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <DECUI@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, RT <linux-rt-users@vger.kernel.org>, Mitchell
 Levy <levymitchell0@gmail.com>
Subject: RE: [EXTERNAL] [PATCH] scsi: storvsc: Fix scheduling while atomic on
 PREEMPT_RT
Thread-Topic: [EXTERNAL] [PATCH] scsi: storvsc: Fix scheduling while atomic on
 PREEMPT_RT
Thread-Index: AQHckSveRAp71CHme0yq5RCDVXPlzLVwGTjg
Date: Mon, 2 Feb 2026 23:47:31 +0000
Message-ID:
 <DS3PR21MB5735CBC7D843174F9CA9039CCE9AA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
In-Reply-To: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0295dd74-01f0-4c44-a9fb-d44bb89980df;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-02T23:43:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB6580:EE_
x-ms-office365-filtering-correlation-id: bd2469b8-95b6-40c2-7383-08de62b56e3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8WbQU1+LWbOe+WVyG59NXLejulcAYgETCtwYjo89undhbCu5BfA737dL7+Eu?=
 =?us-ascii?Q?gNLorlqWUwPEldQAEiHIQVwnLzLtBng/IQ5SV73V5250mxf9PsvjKbJq/FZN?=
 =?us-ascii?Q?EH4567dSo2jjaXKR0KMLys0+2N03PGtgK6minT9yoTC87huEQej2Q4GpUyTT?=
 =?us-ascii?Q?xduVdaPTpXAiv0sFUcDW5Ynuuq1y1HNu1OUUJiIh/hwGQcY8+bk0sKdtWHBM?=
 =?us-ascii?Q?UrorHQjpJ9eLDX+ubwxHxtOlHwyAmWFf4jwOHKlqncmBAj14EAPx7bXAnPKr?=
 =?us-ascii?Q?GX63c/3cGrYDtR1s8EgDPo5wxyJSDKDzKpRrOzjiKTiq/UscP1eQgIhnFVR+?=
 =?us-ascii?Q?WNrT4qnfS5De0GAOn9sIF5W+oQyqlSM4V0LTdH/lKV+kYSWaKPjtWb/UlUor?=
 =?us-ascii?Q?h+vJvEBjOG1onIlhQXcDOH4OmV4X2veeJjWzVZajTtAeQ0FH9VSL1IGud3Kn?=
 =?us-ascii?Q?SUE8PnwOVNcBxRVupLooCx0XLLZyF4TKcQFjQ3P91r5wdBSHffNHLw7qk8fa?=
 =?us-ascii?Q?clFuS0xg3aHGc1AUFzGi3CHGcudY8EBmaivTEx5Oi97xBzJOBONU8yo5SaIB?=
 =?us-ascii?Q?MdWi1HDH/f/G4AH2fX3hDO+u+Uyt1GNkTgc3G34/oYcyVstdWlUMCJXDEX77?=
 =?us-ascii?Q?PoSG4MMLg+X6JkPlLofqWPDa7ppkbdlxqmJneUiE5oJ3Mcos2ZizrOSwjipS?=
 =?us-ascii?Q?taz3hWY0cOexhp2cIHlYxowLD6Lio4WYMxhTrMg+MXncV5xQdDgCTP/MRkNY?=
 =?us-ascii?Q?3lPCauNYz4h+oFLUnFYcaLaAQZj3zvlGWv+5x+k66vjK+nUHVkGVLvdwWdPE?=
 =?us-ascii?Q?5xp2p9EmhVWcTWnfh0F94klxCClmuMcuGqHghqUtZCv+/7WpW21NRQ3Ro8p3?=
 =?us-ascii?Q?Y7PIleMyUNu+eh0ALxeq02NpFYlh5nZS1MIuD+osYqz3dTs3zkRGiWn+7Shd?=
 =?us-ascii?Q?h9wl2KuuYCg0g46srSrSSQqvKLUJbYKUSuLAuUSs45zNWp3tJf3J7tx6/8XN?=
 =?us-ascii?Q?NpZAbPqEXLwLcFRE1lMIGb2CwmZtX0sSVapHRXCBXP2Rq8yyGXeR9nDHgEaQ?=
 =?us-ascii?Q?FTVkA7nw7mDYN2qxKCp3prTEZpbikbvh1v2u6pJMip8amlWN29TCG1OSLgSZ?=
 =?us-ascii?Q?mx7//ynxphY+sG6JVEPNyWEYt32la6G5ti6/l4HwVABJvS/id+dEghwwfjPc?=
 =?us-ascii?Q?QjNr32663zbXZ9Rj2DdLjLE/91oQfDNmregUALWG6+RTOJ/GABqd3d6Qlqka?=
 =?us-ascii?Q?XKX8G+j8OHcqu+ksu8pF7mwUeqx3t60jVRsDqrgVMuXs36MU04ns72k6On8l?=
 =?us-ascii?Q?AZlzalD6MsVvVFKr6bSYgn2ai/nYDu/TWgwEHG+lnc/dOE1451q8kzpDfFU3?=
 =?us-ascii?Q?eFnehGM0l1jdaFR3tpyFQdvBj5LftuCbSaZXZfgsYAVQ3TDaFiZw9AkqYh3k?=
 =?us-ascii?Q?7dCJt8Gd2EdtsugOPX6UCWhjBPjNvbJgMW3WFzoMqCyr0jTRFEn7BuHebFFF?=
 =?us-ascii?Q?LIqk1RZB6R+qyAHcdEPrLpixx7ApmK5e/0GOPaY3puRNQKup6uWO7oFaT9vk?=
 =?us-ascii?Q?qNpjNiSkOF9v5ciPTQ+roSBLWvj9WBMQzQqv/TP6IXJtCE+hPTtd6ulQRVte?=
 =?us-ascii?Q?GyiRaaZI65JTAnzSEgaKD0o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fNI7hdrGSB3QONEEnlY4+PdNxDNEF+9oLSWCU7ADF8B6LZ0hBuewFni4s6uu?=
 =?us-ascii?Q?P3w0fxe7dlLlk3G7H+qiI4QfAOvvkQletCb1k+B5rM6Ru8N8GRHeB6WgClyb?=
 =?us-ascii?Q?iiaVcub6s6Y5DLhBamg0L1ei1S8OJLqqB+ZWXyrQEZq1YpEvNBuw+Aks1jms?=
 =?us-ascii?Q?Ec9vKHKszXfmib3FJyHvKuFR1L6aEAdKgOgEIME1u+WS5cp30IcPS4MtXI4B?=
 =?us-ascii?Q?DI2U4EekOb0n0aBr/j/SCLaFvyJy9qszck/UaDjfgAQ8XLrixMX9xOaf6HCU?=
 =?us-ascii?Q?c0tbTeGPar5aIpfObQ16rYF/UL07rFniFboTRwxnNKuY/+cTQyUsNfu8C3J7?=
 =?us-ascii?Q?IWOpsjnFgYNclglQMvPqhV4EddPl6O9EcenEORNE/M3MiJSR6jLmuJOXZLdB?=
 =?us-ascii?Q?KZJtKNfVci2qExhOIZtmDFFzf1kLV/7IoFwl6BszqutH3+UtES7TPt4TVxbT?=
 =?us-ascii?Q?eMEbXX6tIMqudYTP1sQcBIdJ7i5Oik65+Tx/GTHBycAXRaXZKFLzJsHYSFwp?=
 =?us-ascii?Q?ERidO4H2xzPb0CrCFIvtYiP4MFzw2uBmlDxWClxkASM1BJAsE1XM9/Sn2aYn?=
 =?us-ascii?Q?5XZILsy6ZPgjiyTo/hnKzq3flBxU9bY16RKvE8ICYnkvoDPgspbSrr0qP1Uq?=
 =?us-ascii?Q?27RxTklullF+cqG+5+ryr+B53lUg4aG6Q6RZ3pDHxUBLURecwsj8DrzuTiPx?=
 =?us-ascii?Q?ImTV3XcnZ3bkIRe2HzpE3Mtt65UWk4DNa/jNX+7oA+wu233YMyA+oIrcmaxV?=
 =?us-ascii?Q?IpEJ3MsIt/KxUVvuxaO5H6xMKeo2hWik4eaN9ggQzBqJSxS8yZ+xM0zuhkcM?=
 =?us-ascii?Q?XE50j47p/gFd0CNd5rwhZ/hqSKtoez3LpaUq4q/d5BhOwPlECDLZKKOgZ7iY?=
 =?us-ascii?Q?xAisvTHGVNvBK5oFzmJYN1W9NVJM8JcnlhJUS/w3DOA04SwG39mcwI1/qR++?=
 =?us-ascii?Q?OjdvHI1wecF6RHiIRxI0k7phmrJ8/7JFZiFSnnN6s9KAxHdi0/MuxYHAAmMr?=
 =?us-ascii?Q?cti32C/lt1WgOfJwy7g0cRQjtvprTDwyHIiu8N/EmYQC8YW+exeiqFuFbMPf?=
 =?us-ascii?Q?s3+3DitSHW/37AhZNRRojCRhcW3x2rulplW3flX0YTbX9P74tFBm/VBNnuor?=
 =?us-ascii?Q?4bjhdYXgv/iMmFnB10AfXEBjVaw+G+QOodJlqRyFQavGVREoRF7VinAkoXP0?=
 =?us-ascii?Q?pawWoTr4Wp9/a4ZEvB+ddw2mSURA8ikJ04PAZlEDD4QVk6b4VO1EAu+0m8Zf?=
 =?us-ascii?Q?acR22Cq8ETyZJzbobXz+7WGVoPoRd5cjzSXoGkBqEhd+YHGOjzInCiinYn7o?=
 =?us-ascii?Q?nnoDGz722iNLHgh1yzbh/SrAc1ZiR25oAZXLx2qjGUWiOlISnfdheRm+CZpD?=
 =?us-ascii?Q?5oh4dZNO1QoQm0mr6yAxzjWyXgYldopE7pQhMAXh7SoobAxtc4UfNEqo1W2q?=
 =?us-ascii?Q?K1itehbrijxZBoJ7nMnd9AC8wraB16ClUPy/6Gsv08wFfbAQ0RVh2qP/TE2Y?=
 =?us-ascii?Q?V+5AEM9jdzJZFKs8Dk6oATV8Tu+iYdUU8fhX/OKaaXuEaIctfCdwpUEor20+?=
 =?us-ascii?Q?1Mcdc2Pqcat6EZCmgDl0PWPnViF/rB8q6ZQ9gJSjp3Y767YVFM6EjWD+fRQM?=
 =?us-ascii?Q?BGuf8kxJmJ6Lg6fH+PeEhCBwJ2e2vOQ1cyRexbpoRZ7joS5JnZ8R6EPvkZ/W?=
 =?us-ascii?Q?ZVrPZRtvWjiPPFHgaRxxETKdgZJyYc7J6m3KfKgtMvEwg4Tc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2469b8-95b6-40c2-7383-08de62b56e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 23:47:31.1346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LPSNbKNLo+HTtNdQE0BOXhjEPO5XBt7jaKxh4e7z7vW3PBwGLmzrlkMBG3Y9iMXBf6FSgloX//lTtbIPC6Szg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6580
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-8666-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lore:url,outlook.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,DS3PR21MB5735.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 432DDD2BBD
X-Rspamd-Action: no action

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This resolves the follow splat and lock-up when running with PREEMPT_RT
> enabled on Hyper-V:

Hi Jan,

It's interesting to know the use-case of running a RT kernel over Hyper-V.

Can you give an example?

As far as I know, Hyper-V makes no RT guarantees of scheduling VPs for a VM=
.

Thanks,
Long

>=20
> [  415.140818] BUG: scheduling while atomic: stress-ng-
> iomix/1048/0x00000002 [  415.140822] INFO: lockdep is turned off.
> [  415.140823] Modules linked in: intel_rapl_msr intel_rapl_common
> intel_uncore_frequency_common intel_pmc_core pmt_telemetry
> pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec
> ghash_clmulni_intel aesni_intel rapl binfmt_misc nls_ascii nls_cp437 vfat=
 fat
> snd_pcm hyperv_drm snd_timer drm_client_lib drm_shmem_helper snd sg
> soundcore drm_kms_helper pcspkr hv_balloon hv_utils evdev joydev drm
> configfs efi_pstore nfnetlink vsock_loopback
> vmw_vsock_virtio_transport_common hv_sock vmw_vsock_vmci_transport
> vsock vmw_vmci efivarfs autofs4 ext4 crc16 mbcache jbd2 sr_mod sd_mod
> cdrom hv_storvsc serio_raw hid_generic scsi_transport_fc hid_hyperv
> scsi_mod hid hv_netvsc hyperv_keyboard scsi_common [  415.140846]
> Preemption disabled at:
> [  415.140847] [<ffffffffc0656171>] storvsc_queuecommand+0x2e1/0xbe0
> [hv_storvsc] [  415.140854] CPU: 8 UID: 0 PID: 1048 Comm: stress-ng-iomix
> Not tainted 6.19.0-rc7 #30 PREEMPT_{RT,(full)} [  415.140856] Hardware
> name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V
> UEFI Release v4.1 09/04/2024 [  415.140857] Call Trace:
> [  415.140861]  <TASK>
> [  415.140861]  ? storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
> [  415.140863]  dump_stack_lvl+0x91/0xb0 [  415.140870]
> __schedule_bug+0x9c/0xc0 [  415.140875]  __schedule+0xdf6/0x1300
> [  415.140877]  ? rtlock_slowlock_locked+0x56c/0x1980
> [  415.140879]  ? rcu_is_watching+0x12/0x60 [  415.140883]
> schedule_rtlock+0x21/0x40 [  415.140885]
> rtlock_slowlock_locked+0x502/0x1980
> [  415.140891]  rt_spin_lock+0x89/0x1e0
> [  415.140893]  hv_ringbuffer_write+0x87/0x2a0 [  415.140899]
> vmbus_sendpacket_mpb_desc+0xb6/0xe0
> [  415.140900]  ? rcu_is_watching+0x12/0x60 [  415.140902]
> storvsc_queuecommand+0x669/0xbe0 [hv_storvsc] [  415.140904]  ?
> HARDIRQ_verbose+0x10/0x10 [  415.140908]  ? __rq_qos_issue+0x28/0x40
> [  415.140911]  scsi_queue_rq+0x760/0xd80 [scsi_mod] [  415.140926]
> __blk_mq_issue_directly+0x4a/0xc0 [  415.140928]
> blk_mq_issue_direct+0x87/0x2b0 [  415.140931]
> blk_mq_dispatch_queue_requests+0x120/0x440
> [  415.140933]  blk_mq_flush_plug_list+0x7a/0x1a0 [  415.140935]
> __blk_flush_plug+0xf4/0x150 [  415.140940]  __submit_bio+0x2b2/0x5c0
> [  415.140944]  ? submit_bio_noacct_nocheck+0x272/0x360
> [  415.140946]  submit_bio_noacct_nocheck+0x272/0x360
> [  415.140951]  ext4_read_bh_lock+0x3e/0x60 [ext4] [  415.140995]
> ext4_block_write_begin+0x396/0x650 [ext4] [  415.141018]  ?
> __pfx_ext4_da_get_block_prep+0x10/0x10 [ext4] [  415.141038]
> ext4_da_write_begin+0x1c4/0x350 [ext4] [  415.141060]
> generic_perform_write+0x14e/0x2c0 [  415.141065]
> ext4_buffered_write_iter+0x6b/0x120 [ext4] [  415.141083]
> vfs_write+0x2ca/0x570 [  415.141087]  ksys_write+0x76/0xf0
> [  415.141089]  do_syscall_64+0x99/0x1490 [  415.141093]  ?
> rcu_is_watching+0x12/0x60 [  415.141095]  ?
> finish_task_switch.isra.0+0xdf/0x3d0
> [  415.141097]  ? rcu_is_watching+0x12/0x60 [  415.141098]  ?
> lock_release+0x1f0/0x2a0 [  415.141100]  ? rcu_is_watching+0x12/0x60
> [  415.141101]  ? finish_task_switch.isra.0+0xe4/0x3d0
> [  415.141103]  ? rcu_is_watching+0x12/0x60 [  415.141104]  ?
> __schedule+0xb34/0x1300 [  415.141106]  ?
> hrtimer_try_to_cancel+0x1d/0x170 [  415.141109]  ?
> do_nanosleep+0x8b/0x160 [  415.141111]  ?
> hrtimer_nanosleep+0x89/0x100 [  415.141114]  ?
> __pfx_hrtimer_wakeup+0x10/0x10 [  415.141116]  ?
> xfd_validate_state+0x26/0x90 [  415.141118]  ? rcu_is_watching+0x12/0x60
> [  415.141120]  ? do_syscall_64+0x1e0/0x1490 [  415.141121]  ?
> do_syscall_64+0x1e0/0x1490 [  415.141123]  ? rcu_is_watching+0x12/0x60
> [  415.141124]  ? do_syscall_64+0x1e0/0x1490 [  415.141125]  ?
> do_syscall_64+0x1e0/0x1490 [  415.141127]  ? irqentry_exit+0x140/0x7e0
> [  415.141129]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> get_cpu() disables preemption while the spinlock hv_ringbuffer_write is u=
sing
> is converted to an rt-mutex under PREEMPT_RT.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> This is likely just the tip of an iceberg, see specifically [1], but if y=
ou never start
> addressing it, it will continue to crash ships, even if those are only on=
 test
> cruises (we are fully aware that Hyper-V provides no RT guarantees for
> guests). A pragmatic alternative to that would be a simple
>=20
> config HYPERV
>     depends on !PREEMPT_RT
>=20
> Please share your thoughts if this fix is worth it, or if we should bette=
r stop
> looking at the next splats that show up after it. We are currently consid=
ering to
> thread some of the hv platform IRQs under PREEMPT_RT as potential next
> step.
>=20
> TIA!
>=20
> [1]
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20230809-b4-rt_preempt-fix-v1-0-
> 7283bbdc8b14%40gmail.com%2F&data=3D05%7C02%7Clongli%40microsoft.c
> om%7C9bcc663272304e06251908de5f42fe3b%7C72f988bf86f141af91ab2
> d7cd011db47%7C1%7C0%7C639052938514762134%7CUnknown%7CTWF
> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
> 4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DWyFA
> %2FIUPpZDcayM%2Fj7Ky8%2Bm93bey239zVWguDspSbdo%3D&reserved=3D0
>=20
>  drivers/scsi/storvsc_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c inde=
x
> b43d876747b7..68c837146b9e 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1855,8 +1855,9 @@ static int storvsc_queuecommand(struct Scsi_Host
> *host, struct scsi_cmnd *scmnd)
>  	cmd_request->payload_sz =3D payload_sz;
>=20
>  	/* Invokes the vsc to start an IO */
> -	ret =3D storvsc_do_io(dev, cmd_request, get_cpu());
> -	put_cpu();
> +	migrate_disable();
> +	ret =3D storvsc_do_io(dev, cmd_request, smp_processor_id());
> +	migrate_enable();
>=20
>  	if (ret)
>  		scsi_dma_unmap(scmnd);
> --
> 2.51.0

