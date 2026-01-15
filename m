Return-Path: <linux-hyperv+bounces-8328-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1096D2842C
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 20:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6347E304BE55
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 19:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380431A805;
	Thu, 15 Jan 2026 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MXouC6vC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020099.outbound.protection.outlook.com [40.93.198.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5682E0925;
	Thu, 15 Jan 2026 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507068; cv=fail; b=G8snenDFTb8g2f2YRMqXLYnQnNefQjACdMTP9itzT1uwZHHo58hzL6gVGQx0EdwkW5J//kmSsOPjeNConEtfaZRcclFrlBtsNz5s17iBpGYI7/updEuxMe1rBZ1hnN2mBPi8gDjlFaNIM9n8dzh6Vlv8v/lSL3fbrLfNWmLKybg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507068; c=relaxed/simple;
	bh=srP5EKPttu3if2Vn7+g3ax/bT8SzA3fXIgVkOAz/7V8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iPSC3t5viGM1KgHqeWrwsDtchvLA8pyqn/iWvYgM/X2JZW7O26EcynWdft3hM3TU1ikqB+VEQIvLDGvuT7zT6X30Vom5KW7sjGJ5WqZLDPawj56vBYIEGM/qhlgq0+Z1wdXrWvb51pQmKiXN4QpTio4d2T91XHUOXRTyxq2nRvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MXouC6vC; arc=fail smtp.client-ip=40.93.198.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJbhIFNkBcPhFcLgPYdrWMbY3ffvzFqnvvaAxoXMpt6nmeeRIeAsxqjeQ9nwCG+g4+YHU/fCaRp6x4R6EFmhYqk1tuIZR1S0chkrsvlpNOGOprgl7OkiZc0I3bsgsFgukH2sv5jvoylvV6zgP+AjUY6qFQIvVIJGH1gcID0fUgXxKhFavB6ZL5a/taS+XTmWhZV4VAtK4yUhszS3v25msOpY2VyUHVKYe8ymKQF1Wwt1C6voc8c1TZ9nm+U0UfCjTQGZagIFnfEvAA5qVMJzIdCX560l9XL7fUtg3sCCH1TPJodNIp0n6P0mjBW3WS9wr8T874oM7oc8e0G8GCZEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srP5EKPttu3if2Vn7+g3ax/bT8SzA3fXIgVkOAz/7V8=;
 b=WkFbMxNJwvVZgxDMKiBvxszguLdWKCHVmb6Cxh0aW68gUDZ7qwtQaEjJhNeFKBs07UNmtbb5EpF/NEDuRpsScnO/Ms70H6hBcu/3AxMWpn0rN4DVGx87tSU+vAFkjP5YAnixk5tXYWBhuBXlIoXY2I2cWVCJYNg8FC66qyfgSccWgAYJEgvV5vZX8qqjUi8geB/gCdNh+tmDY1Nyf4bw10ylzYqHtGvFxDNFIIz7RtW0v1I9nh2ozCM7R17Mz+WlSnSDx0rrJ5pYfsXZa+VApbMRSmlR/gVcVNgr0d2jc+dS+piHexDfFoVDLgjjOrfCkLZ4HC9RXx6efTjDQfr2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srP5EKPttu3if2Vn7+g3ax/bT8SzA3fXIgVkOAz/7V8=;
 b=MXouC6vCKBIz6mfM7O6VJYvVN+9D0gudajcwgVl9dbrKWpi3oHdLyZKRVyEPlWknATl/TngCOkuCwm/aG6F927J2i8dQa2onXh2GATmOnJT10bEFbZYjTvtvqks/LOtjPAGzCcsY9npIyMcyZoyJOE2ebrGvP5tdivrmwVlnpHg=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6177.namprd21.prod.outlook.com (2603:10b6:806:4a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.4; Thu, 15 Jan
 2026 19:57:44 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9542.001; Thu, 15 Jan 2026
 19:57:44 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Topic: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Index:
 AQHcf02oLJOgwMZgokiNaAnIBRMMibVKqfoAgARiUFCAAEsSAIAA4mDAgAAFB6CAAKeVAIABIOnwgACOxQCAARoLgA==
Date: Thu, 15 Jan 2026 19:57:44 +0000
Message-ID:
 <SA3PR21MB38673CA4DDE618A5D9C4FA99CA8CA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260113170948.1d6fbdaf@kernel.org>
	<SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
 <20260114185450.58db5a6d@kernel.org>
In-Reply-To: <20260114185450.58db5a6d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=379d525b-92f1-427c-8160-e3388ac09052;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-15T19:44:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6177:EE_
x-ms-office365-filtering-correlation-id: 9c0d57f1-0912-47d7-852c-08de5470595f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xEKagOW/PFiFChvbjdNH+0/aSf2lU46l3je3JYsG7gBf9F88wND29FQCoJxF?=
 =?us-ascii?Q?87WaLheraQNKBEXomT2WbLRhr2483gMo3R6ueYTPAvIZsPHm3wIb8aQjDZSH?=
 =?us-ascii?Q?vMPDjfBT/OxB3y/gRu4Lzj3i6qgYzAv1TsgX+7oL2+adYkRK+9oTgUKwINPM?=
 =?us-ascii?Q?vYzpEBT1FA4uG5FzEGkG7/ZgrmU4PLNzijwqKq6PDspn+VKGsDHi2FzAe27N?=
 =?us-ascii?Q?ShNob6l9mSQu+wdyDkNMygMsv+M4swkRt6fNbkINoFewreUk3a6Tjkiyhrhl?=
 =?us-ascii?Q?XMyenbb6EEjHu/TFwP1WMxv1pDsDFYZ0PZGjgGr5yhW42MclP6VDHEExRmyH?=
 =?us-ascii?Q?2SDVjq95xhVpib1fVfpAYJCysjddnIJBsyz96D5LZ3uc0V0tP0TWitmii/UJ?=
 =?us-ascii?Q?4re/2tmlKN2APEaGfnEdIuR4MOxGc++Wpyyl1p6sLlrtzf4Mcg1mikX1vxJf?=
 =?us-ascii?Q?qAXnpuIaItHE9AoI3FADebk6L+xjtKkuAynWBZYL0DH84z48KP1tAnIwtp4i?=
 =?us-ascii?Q?4VnalcWGd5eIjSwF+0ZP7Ah0/ajPzX7rZJvniwFiRkH59UMcoP9H0vkiUfHv?=
 =?us-ascii?Q?a2xVtqPRAEUf35Z9f3lUfVaDDiacjY3nJFpQoVIu/D446hIgcTxz9Tq7KfuI?=
 =?us-ascii?Q?BuRUQFQvfK1BvS1zlH4Wg25hT/RvvEsak/ds1aH7P+9bNdH+GHEk3T3y/oGF?=
 =?us-ascii?Q?69bCxrYyu0KDHmkVX55UUHp2/Q1OkuFkSwKaWY9tCmWQJhW7A74muzL7Lgze?=
 =?us-ascii?Q?N7pwI9c8jle9Aavc/4hSVpXXYFL3n8NMmdq4ueTOMNmMtAIj8Eu2B6sUz+tD?=
 =?us-ascii?Q?YlObIZFLv5vIuWq68UKcG76iyxhxXqxPb7avtQPbmHKll+JGSe0rbkLkU6QB?=
 =?us-ascii?Q?ah2+bc8ghKDsfeYv/yUOkVJwMj11Dnk4d/tIeAxAa74gRKdmVtAWWTVUYOUG?=
 =?us-ascii?Q?0cdb7vBJahnj0TxBS2LBFnOTXvFpmU/Gn8QhlPgTukb7XpdWXdkf41+5HLXr?=
 =?us-ascii?Q?GPBMBNfrSMKWgXhK8ni3wMjciZkMZ7PWe9vsYT70/7O/r2Ix1/NsDWpny8uI?=
 =?us-ascii?Q?W69Jw2v62oP6wTr6puvNEQqeCh0QAdR5l0Z+MF8kP3TRKpP8u7x/eb9RuUYA?=
 =?us-ascii?Q?kNlNEKbclKSI7oicLhB0b1MV+7OEDAyBbZXG5qx/y9kOlNbRvKI8jof4XStq?=
 =?us-ascii?Q?vCZatl4IOYj4ZR1LdXBembFSiUtgGd/bMQ67n+1blo/O192m+gAVdD+6fUfF?=
 =?us-ascii?Q?TL2qganFsu5AYwpB95pv9HhcmeR0wp0uoIsPbsgHx+kdoKR+CKfO6fToCnPW?=
 =?us-ascii?Q?ASboEzk2kItpqTkVdD8MpD+9WVKjKsY+5DUIGP5X1l+F4MdsIBmmFwoYsIZF?=
 =?us-ascii?Q?l5/0ghAZNyUVHryqat2aA61HUnAQd3bZMvZIk3ZcZIABwBVW3L+ODHaGbV6t?=
 =?us-ascii?Q?g6oMq2dtLF/KX0PKx2R6GVpLSpEsvJMEuZ/7aMVkaM/p8gvG4ujDyOd3e2pc?=
 =?us-ascii?Q?PsHAmvb6IUjB2NAWCmOXHIR3Of5FOiUbhF4nUiZBABb6DH+h1ePgasgkosq/?=
 =?us-ascii?Q?5xoH2SlYLzeOUf9QTaSo5trA+SvRpYse1IZru3Lh3dRYB8geLbrR+4XLZKRJ?=
 =?us-ascii?Q?e8B2bukiIUmzFmk/mQzuLV4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tMUnO/H/AwSulAi8rpncRIDauCtmFFr7b/QdKWRW/IMcwypzEeG3t9ej+6+K?=
 =?us-ascii?Q?KTtGmRuVfNj/4Y3UJaLUxpPDlyIGN9oirjoUxISKKBAROxpapMtCVuMU9Mut?=
 =?us-ascii?Q?zj+4QcmCbWKSNYl6yEgIIIvbXz1Va9+ajOT/0cxvYwSXRjd37r9m8652hrpO?=
 =?us-ascii?Q?8ParS2SfFHSluaAc3YHkz4V4wksnTebR8+hJsmcKNpSVFeyFqEjddK4d1pAC?=
 =?us-ascii?Q?3DB7SIrs4doVkBEhO4xB35oUIaEz9O0Xnc446oyxRp2ik+w1jpMZee9xFqoE?=
 =?us-ascii?Q?M7gpyWsguKyfKPjOHqz7bM5EJc70jj8tGgF7DIMynz8sHqCV1ze5AQq/SEB7?=
 =?us-ascii?Q?nv+i88amEGL52iZvlfOSNjkUWZutB9lDQIbGKht6M6RR3vh5/+oLzKeDJ5D8?=
 =?us-ascii?Q?FT6Z7GCAavxh+QoWxSv/0oBRdyWr3WVfNUljn09Vk6s3/mOigLvgseqGZmrb?=
 =?us-ascii?Q?CEIekcOAK79xwX30m0ncWkcx9BqZX7fm7qBNjjAqV8+6ZdpyyK5fwukKHhhX?=
 =?us-ascii?Q?E+XrMDbo32pEeGeaeXpI7myBjRqmA0LuN7MsxkC+KtIKZJGlbhxlLeRzeRMs?=
 =?us-ascii?Q?FJQTc4rvb+uNV7bI+wkBzIKTQwzrBSViyUJ74vBxKhY3OeudoMUJX3ja/TMK?=
 =?us-ascii?Q?5/dHy0eDxcYLpmz3GkjnantKIhYkaYgz3M9C8BorCr9E0KAdBJrmi6/imSRY?=
 =?us-ascii?Q?KZ0jSdewndCBzi/dfytm/HBA9zI7PM0ZP+vLbtzqGI+mQYtarcXZvixF2ub6?=
 =?us-ascii?Q?V7iIMws0ogwmswXOycGckTRxJrMrUzeFQp27DUuXa1qXmYPU7+l793vPCm8r?=
 =?us-ascii?Q?yAAm+cHI5jFaUMN14pSz5OxDCz/EMp1q0MHzvK8+/gYWEerg84o3t3/Rud7O?=
 =?us-ascii?Q?rngJzsX6VKh0agsi7IYaGRefyFTV2YjJ+BsJOjKKHgeuwbrN2SfJvOXtrnST?=
 =?us-ascii?Q?8G3+pKRxgQ2prPANCiwycHw5yeyfpr/XHAmyWorGCF5cBAfLwhdLPa7bpBZf?=
 =?us-ascii?Q?RLVgJPuNdA26+Nx9Lr/1IQATeu8AubvtWqWVwodUziWYScHJUziLuye9xbml?=
 =?us-ascii?Q?YuegJdk5PKYJn+0tjZ8DaCOGBr8Biw5f22B7cUFuATOshEAQtLXgvFQYA0zt?=
 =?us-ascii?Q?wwZ+jUZgKjBY+ALcv+iYPCnH9bcazLNFLNP0HjM/7J7oSiJ7RKHbn/yAqN43?=
 =?us-ascii?Q?sqWEuXrkNv6afniOgpR233LFGj2yap1aTthRn5GzCbuWVaCPAFPsflBpZ7v2?=
 =?us-ascii?Q?ViNk1JJyM9gvsXmwxkiSWiEm0ZgQZljJsSGKHpmh3XqogEXjj1wsUkeOs2G1?=
 =?us-ascii?Q?YmnuwOPRBbVRKdJBEj/4lbe+R0qTktjUBk2y2drHtM7jz9XdWXwhjzrQDXM3?=
 =?us-ascii?Q?xBikSY8gULxcZOCKjx9Jz04q2SzO/Yp8uh+HfE7fpk4URE7wUpGWYvRlojFk?=
 =?us-ascii?Q?BBP0cYuzQ9ra0d3D/WU6QucJvhIuWSuLl/GEsJV8TbXHU7dd3g37Xh7IiBpa?=
 =?us-ascii?Q?amFwg3wkBnocfNclxss8eabf3xg8bg7HvP83A9lBO9nB2TJU7PUqDyXHz1UY?=
 =?us-ascii?Q?VKlMcgBUwDFe+WgthI7Hh/DgUSw/Bp7XHikfiCTxI4VuVI22wmuybKPrb0jO?=
 =?us-ascii?Q?QlggaqphKqM4LE0D+DMkwbG8w+3WXtl+VU54bq2BYPMbXZWvIqQoPOaPI8K+?=
 =?us-ascii?Q?+f0tovDXz0J1CTDLqEJ2CxfJ3OiLmV0rIA8mVwTmRzqPJQ+nl8ZmSKLpaDQd?=
 =?us-ascii?Q?MHQxYExczA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0d57f1-0912-47d7-852c-08de5470595f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 19:57:44.5371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZlxhI4wrF4nf/4a8OoOpT2bQyFuyAevw4+5BaHv9Fd46EPhDORXFiOXfXxNmUCQQSDWppUQOqVG/QYZ9zCCGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6177



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, January 14, 2026 9:55 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Konstanti=
n
> Taranov <kotaranov@microsoft.com>; Simon Horman <horms@kernel.org>; Erni
> Sri Satya Vennela <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add
> support for coalesced RX packets on CQE
>=20
> On Wed, 14 Jan 2026 18:27:50 +0000 Haiyang Zhang wrote:
> > > > And, the coalescing can add up to 2 microseconds into one-way
> latency.
> > >
> > > I am asking you how the _device_ (hypervisor?) decides when to
> coalesce
> > > and when to send a partial CQE (<4 packets in 4 pkt CQE). You are
> using
> > > the coalescing uAPI, so I'm trying to make sure this is the correct
> API.
> > > CQE configuration can also be done via ringparam.
> >
> > When coalescing is enabled, the device waits for packets which can
> > have the CQE coalesced with previous packet(s). That coalescing process
> > is finished (and a CQE written to the appropriate CQ) when the CQE is
> > filled with 4 pkts, or time expired, or other device specific logic is
> > satisfied.
>=20
> See, what I'm afraid is happening here is that you are enabling
> completion coalescing (how long the device keeps the CQE pending).
> Which is _not_ what rx_max_coalesced_frames controls for most NICs.
> For most NICs rx_max_coalesced_frames controls IRQ generation logic.
>=20
> The NIC first buffers up CQEs for typically single digit usecs, and
> then once CQE timer exipred and writeback happened it starts an IRQ
> coalescing timer. Once the IRQ coalescing timer expires IRQ is
> triggered, which schedules NAPI. (broad strokes, obviously many
> differences and optimizations exist)
>=20
> Is my guess correct? Are you controlling CQE coalescing>
>=20
> Can you control the timeout instead of the frame count?

Our NIC's timeout value cannot be controlled by driver. Also, the
timeout may be changed in future NIC HW.

So, I use the ethtool/rx-frames, which is either 1 or 4 on our
NIC, to switch the CQE coalescing feature on/off.

Thanks,
- Haiyang


