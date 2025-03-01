Return-Path: <linux-hyperv+bounces-4192-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EDBA4AE52
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Mar 2025 00:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65A21894E0D
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Mar 2025 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0A1DB148;
	Sat,  1 Mar 2025 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D3bKXou4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023099.outbound.protection.outlook.com [40.107.201.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857461D6DDA;
	Sat,  1 Mar 2025 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740870972; cv=fail; b=Olh0svonuz+weL/+DDqiMjGhrf9w+grNcwVp5WEhTs4NGr1FBhZbbh9J0ES0POO2qw7OpHyGm8x6FUVvrK2dWe6ODao398a3513F3rZQq2mm05bWEGeB+vVvqpBH3ElJokx8JQoae7+cLq6WDuPVrVS8uV4LKu3P/OTSfb0EO7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740870972; c=relaxed/simple;
	bh=8UX3gyFMi8EJFG5Uf31QhxAiX0uPmgnhm6nRN3ogqn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/xTcN6W5JkWWQGs5fHUXGPcQpwQTzgBdpZTYZH7JxFj5Fsvt0K9jqs8HUIQlekz39OG9sNobKpDqwTVMiKPiWy3LMpFMspHVAxWZHQz1g/DmL0CFQrTQkobrVuMOf7IJ2Id2xn/68sSZqx/tjf2n3NZibHxWsMZpgbFSFB6uJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=D3bKXou4; arc=fail smtp.client-ip=40.107.201.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3IgCnq09/lVLFsIcZrdL7HoSk70O6krYQRvqbWrQF3Gg9Oent5Fu+aXOVG1SjG7bc93x/ZxmMSHuVvwOK2hgh31+vnbpcJn+mrrYP+DFzqNiSjmGl1VRbHKTrJAVIypwuA1KPI1DCg6QucKegwMQxQntVYeCeqMP74X/t1O636veyfnXGGhcxMe7MM1UUND2yMcpZq7H+8zD3BUZczzAF9hKtgdgYNqWi3z0QBYMUYFSy211TZSUBbZZSUh3KXFVhsxyyi37eAzF/SCROZPBcOvPIOBbtFjLIzTnOB02dOpNDmuzcC8Xw6EdxkkpdT5TvlaCOCSAW0hCUMhVn1Ybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UX3gyFMi8EJFG5Uf31QhxAiX0uPmgnhm6nRN3ogqn4=;
 b=Bu7ARGL4776gxGDzJqZg6jeWlptZ/PVcbDlZYiIFuMpijO3UukVEM7+N+WfMTGOpX/s+WjxdZxqQ1QG74d31EekeJ4dLzdrR0eiQwANZqb/iFqZb2XWxkmHXm+aqzMuRAqK6SVJa9OBHUTSXB3mQDnIBXgRzV895kulAIRSlEkSUG0wP2CACWhDBlUbIMscOJ5iBXhjsHy+LP+Pi/SkDMAT+L9xUmWtpOph1GMiMUsseVdG8wo5iEXs+C96SxowPE7bIHU2mgZrex/FAJF5lKE2I+bdp6hcey45s9eL5/NV6EfVAH2o9P3iPAYYWbIQ7kHJBJ7DDVR80qFolzMGnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UX3gyFMi8EJFG5Uf31QhxAiX0uPmgnhm6nRN3ogqn4=;
 b=D3bKXou43eB0bis3OEN3Ov1zVVnD3oofOq0pNsKYcSGwMhI0sv1ym9MKQ5pGuYH40I7E8fwPhcgnQ2SFgbG0NDDr4kR1n7AlKtROhAO464vzpbGPCUVOjV4AAR9eHghi+GekLbc5P1f40R0OTadAa+mM1hs532XfOnrevvdSkWk=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by IA1PR21MB3546.namprd21.prod.outlook.com (2603:10b6:208:3e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.4; Sat, 1 Mar
 2025 23:16:04 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::19f:96c4:be9a:c684%5]) with mapi id 15.20.8511.012; Sat, 1 Mar 2025
 23:16:04 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Yunsheng Lin
	<yunshenglin0825@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH] mm: page_frag: Fix refill handling in
 __page_frag_alloc_align()
Thread-Topic: [EXTERNAL] Re: [PATCH] mm: page_frag: Fix refill handling in
 __page_frag_alloc_align()
Thread-Index: AQHbik5MH771hPkvl0CS2gCCzDywnrNeTQOAgAAuB/CAAGtm4A==
Date: Sat, 1 Mar 2025 23:16:04 +0000
Message-ID:
 <MN0PR21MB3437DB9A18F1C354963C5EF3CACF2@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1740794613-30500-1-git-send-email-haiyangz@microsoft.com>
 <cc3034c6-2589-4e9a-97af-a7879998d7d8@gmail.com>
 <MN0PR21MB3437E18AA793762F242BE795CACF2@MN0PR21MB3437.namprd21.prod.outlook.com>
In-Reply-To:
 <MN0PR21MB3437E18AA793762F242BE795CACF2@MN0PR21MB3437.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8d884ffe-634e-4c8f-8e2e-6e554caf15fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-01T16:34:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|IA1PR21MB3546:EE_
x-ms-office365-filtering-correlation-id: 3ca38465-0026-45ca-2586-08dd59170a1a
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mM4+sCiRIbbPC/RXuiGcEWAUF8LBZu8a0t3x6FPoGfiAf6qedhG5a6HDn2I6?=
 =?us-ascii?Q?0S5msfn73eOEBTcWa9uTMpdDmQIQs7My+M35hlljo58p18mB1U3g2LyJhG5E?=
 =?us-ascii?Q?+5v/U/NjFg1Jp1kdZQJPGcc/eACw9ay8AOExGcrOA046wRxgCpxcqo2U0Xaz?=
 =?us-ascii?Q?DdZlqER5kct3G940+3WKmUo6spxLZX/jcNA7H8hN4FWf1vrDfuvZU+EryDb+?=
 =?us-ascii?Q?vW9BlwfrcPdSyz4h7+TZNLxNnMsdGxviRaT8lb5NnPIS/K9TenyEnbOYQ2Z4?=
 =?us-ascii?Q?S2sFS5+/SQy1RR8y1T38hc1W2ACeaM9bdf8lh3ni+z9k5dIWXhWsKkmCMW9T?=
 =?us-ascii?Q?HzYD9w8QssOh0Uql2rbqKLsqBQLQpQu//f35SiVjCq9WNygNeVNSA3973s+e?=
 =?us-ascii?Q?OphpVeY89DWKemhuUyubTG9BWrDMp7YCtuPMOclcOy7VAdt947kSau8xTyDN?=
 =?us-ascii?Q?lkzngI15SBO/n+ouJuRY1PaUR1+VQMtRIecx5DlxBMG4+6NkYZbHEBlVH0/v?=
 =?us-ascii?Q?wu6l0MmSN9y8wjExKrmf2C7tKqOdqA/paHIqXPebjKIF+6gpLq2UMMA0n6pp?=
 =?us-ascii?Q?C3y/VbM52bJJtIivCdp7poYXy5Wv/z3TfgSM/4dwjqfXKNmRizNp9YnvOwXw?=
 =?us-ascii?Q?AsdTEKGC2c8P+wZlWbmaZ3t2vXqIDDOcXWYeKdMkCx+XTmDFe0x9ZCPQl+6u?=
 =?us-ascii?Q?8K6H2gtxdimdw3FcGsKOvSUJwSTRPU+UuxJMU5ToLEi8BMDq+8oWARE2pFsP?=
 =?us-ascii?Q?qloIzGXwXoyQYnDxMPdqWffD4d6Dp0wpek1ng48KMPh36HLjEoWuRR3i/JXa?=
 =?us-ascii?Q?z1FuHx9XbRpPiwJ9D5vLgHELugEemblqy0tqVcvolvd6IhBBEB3kf8U3bHNG?=
 =?us-ascii?Q?kP4BR5oSUWUwWCYEaLhIPkXZDtSXkXhesvT3Vy+GzbgMNFCHkRj/DDxTy2YY?=
 =?us-ascii?Q?pCLLndC95E4Y4jm316BFObD4e7zveAxuitH1BxlWB9REppwRjEo57NrWFfap?=
 =?us-ascii?Q?NlE9Rj77mvi+4ZWU+7bsCptMrTHW/jEpZ5MB+F/XBt2PLZngdnpvfo7n+w7n?=
 =?us-ascii?Q?KNU78OvROGx8+0t9xmbkv5iXgBCjslikw71AwqWdh+amKgqiYkh5w4AYh0Yz?=
 =?us-ascii?Q?d03qenhuhN+lzepPIbI8HUQSP0jKmGYoAdici5Hq9q3Uil22Ux4OBpjR/8f0?=
 =?us-ascii?Q?IVXleR9GnMdwR+alCLV2QkBnhzC3Wu9dPbRUAyf7e3kNv5MkDstOoqS0Qd84?=
 =?us-ascii?Q?BulvlTxcIHxuMtk0qfiOEl365GTRpoWGRWoMuPT8w5BPGdTuxwhhuDVS7119?=
 =?us-ascii?Q?DUpO6nveB2snh2Voa+17LMyIQlaZZVVnEGBfeDkLrQxekGkx8WQum/7Pa4Wz?=
 =?us-ascii?Q?/34Kvw3cMAfqtdUe10Br9XbJIst7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k1pc5QM7nRqTMVDqjaEwz/7dJQyDfRBQ0+OtLWDeBvfpk82M34IrmStS9Env?=
 =?us-ascii?Q?H1HteB1anUyxNulRQSw8cF9THlMIOVgVfNj3JUwwDE3qG+KmTqKyn70u441P?=
 =?us-ascii?Q?0PL5GWFqwnW8XSCqu0XFc+CnNZ0lCBs2kSuw28GFTBNunhqxes0BPPQk7pTl?=
 =?us-ascii?Q?1odbtZeBtYuZxrYJw+fDX4GsPf8JxDwJnGLh8wtXXxXzk/Q5qasKgBg1Nfew?=
 =?us-ascii?Q?5no0p2Bp4akfLt8JHbWACEaYHoClKWOrvuGUGEjpe3nFMEeh/AjRM6VIr7zy?=
 =?us-ascii?Q?x80EPB4M16GYsw7XrtVsJr21j9BZNQKP+d951s6DNigM46Uf/unZC4am/9pr?=
 =?us-ascii?Q?rxLy/y5VRM0pVOBCuVTGN2xeRE/x3YlVPF7Ag3dWrlEP/E8Y3sP6P5n7mDJu?=
 =?us-ascii?Q?ghbpXsaHHCT+nM5/++xrATyKYK6MQISazrs/kVmLAw3Mcg1+4TK+g/WAJzDe?=
 =?us-ascii?Q?WAsDEyj7NaUNtXROZk67BpeAAYv3BqMREdF6lK8T6Awaagw67hOupE/knuDA?=
 =?us-ascii?Q?WaXKkOcwIjbxJ8tXs6svRdvUdGGP+scrKNnrr37C2cLyLIurNitTqeGECkVJ?=
 =?us-ascii?Q?s3PPLOifBZI1RK26toXFwCINOScuSYfLLz+LeLX89L159LdlF5DTz62Hp/JO?=
 =?us-ascii?Q?ADbh0xPcYiH83uKxiypcpYQm2UG16IPo5xrWVhsWkoEJoXqMAH3cOr/Fx232?=
 =?us-ascii?Q?ExJqPHqUCFHb+jxFmr73tp2bRCGToSKvS4XzMzmqzg2KVKqIJ9ACdfRGJ4dH?=
 =?us-ascii?Q?mm/Yp9sNGQckqfzlAVgk0yU6s0d5lXAb7bCI6EBif+KypJHnU4CIrVXv8y2F?=
 =?us-ascii?Q?16EzyIK6bUUHsOXODbSBkWSr9Qu++ahBxNbqTsQUWILltEWvKCprBDeV4hlL?=
 =?us-ascii?Q?YguUqzydWCkgbhWm+C/sFuRz53n9hJ8HB4fTWv/DNcXpWTmhHUQOXt3ob7jc?=
 =?us-ascii?Q?JOdax3VgvoVbTtj7Acs0IBDbTgZHKGTzI6Tto9gV1oazJlojglseKGIPIxpv?=
 =?us-ascii?Q?ltAC6PJUzJFumgYb8Ep9WjEaJJuvpE/WJjCMLLGFh/Ss/isoJajZ+kI8idlu?=
 =?us-ascii?Q?obadCPaliZ+9A9mxWiGfet7XZgtpH8f0yWRrHqKHpLgrf4F/tv9aT6SMv+2P?=
 =?us-ascii?Q?2TJn6TjluT+KbD/AhakKpwltIbkv+7dofsF7RBSviX0O0RaUDitoMaROrKou?=
 =?us-ascii?Q?1mFL7OsYo36srqz5ynvmZuTKvJt8qSlWuqERc//74feupFUDMdqe8s03RwOQ?=
 =?us-ascii?Q?RVEAGOIeXDgHSEQJ6teCVvE0VCO8n26dekfkKVnUo3Q23EzGoYM6T9WwLb+a?=
 =?us-ascii?Q?Ugd0WcNJG/NuZsDxorRAqu8F+9b9tIftsVdK797kHoyt6O6V2FYfKqmPs+lG?=
 =?us-ascii?Q?rsaULdc3Qr/z3xwu3PfaZPX+Xpc7jVsBfvzuWAR4cXEJQZqIwLhpBkAsz0St?=
 =?us-ascii?Q?E6XleMMMYYCCEU5HlDM32oN5nj536v+niGrNgbDjPLjJ818m/y9HVNBvyjXE?=
 =?us-ascii?Q?z5HVhjlb2txyW98nHG4NUxY0tVzy8q3m1LqwQs3Bg6XitThf3L1YjkG4uhKk?=
 =?us-ascii?Q?Z9zb7RDIwjqVLOxGkDsk7/aYMGHXywvSocwlmA/R?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca38465-0026-45ca-2586-08dd59170a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2025 23:16:04.4674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20KpHkXiPvoVAdnxqILP9E53UfKHF0WFExsfF5nU7EBb8WdrLaWqSPT1X8tukyEbbEo+pWcEnZvvLzJN/pjWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3546



> -----Original Message-----
> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Saturday, March 1, 2025 12:00 PM
> To: Yunsheng Lin <yunshenglin0825@gmail.com>; linux-
> hyperv@vger.kernel.org; akpm@linux-foundation.org; linux-mm@kvack.org
> Cc: Dexuan Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> Paul Rosswurm <paulros@microsoft.com>; olaf@aepfle.de; vkuznets
> <vkuznets@redhat.com>; davem@davemloft.net; wei.liu@kernel.org; Long Li
> <longli@microsoft.com>; linux-kernel@vger.kernel.org;
> linyunsheng@huawei.com; stable@vger.kernel.org; netdev@vger.kernel.org;
> Alexander Duyck <alexander.duyck@gmail.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] mm: page_frag: Fix refill handling in
> __page_frag_alloc_align()
>
>
>
> > -----Original Message-----
> > From: Yunsheng Lin <yunshenglin0825@gmail.com>
> > Sent: Saturday, March 1, 2025 8:50 AM
> > To: Haiyang Zhang <haiyangz@microsoft.com>; linux-
> hyperv@vger.kernel.org;
> > akpm@linux-foundation.org; linux-mm@kvack.org
> > Cc: Dexuan Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>=
;
> > Paul Rosswurm <paulros@microsoft.com>; olaf@aepfle.de; vkuznets
> > <vkuznets@redhat.com>; davem@davemloft.net; wei.liu@kernel.org; Long Li
> > <longli@microsoft.com>; linux-kernel@vger.kernel.org;
> > linyunsheng@huawei.com; stable@vger.kernel.org; netdev@vger.kernel.org;
> > Alexander Duyck <alexander.duyck@gmail.com>
> > Subject: [EXTERNAL] Re: [PATCH] mm: page_frag: Fix refill handling in
> > __page_frag_alloc_align()
> >
> > +cc netdev ML & Alexander
> >
> > On 3/1/2025 10:03 AM, Haiyang Zhang wrote:
> > > In commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
> > > page_frag_alloc_align()"), the check for fragsz is moved earlier.
> > > So when the cache is used up, and if the fragsz > PAGE_SIZE, it won't
> > > try to refill, and just return NULL.
> > > I tested it with fragsz:8192, cache-size:32768. After the initial fou=
r
> > > successful allocations, it failed, even there is plenty of free memor=
y
> > > in the system.
> >
> > Hi, Haiyang
> > It seems the PAGE_SIZE is 4K for the tested system?
> Yes.
>
> > Which drivers or subsystems are passing the fragsz being bigger than
> > PAGE_SIZE to page_frag_alloc_align() related API?
> For example, our MANA driver when using jumbo frame.
> https://web.git/.
> kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnetdev%2Fnet-
> next.git%2Ftree%2Fdrivers%2Fnet%2Fethernet%2Fmicrosoft%2Fmana&data=3D05%7=
C02
> %7Chaiyangz%40microsoft.com%7Cea9cc3de8c904a5c720408dd58e2913a%7C72f988bf=
8
> 6f141af91ab2d7cd011db47%7C1%7C0%7C638764452327076527%7CUnknown%7CTWFpbGZs=
b
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTW=
F
> pbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D7%2BZ9hBYGudGZUeeF0i4UEa3zjx4Z=
LFd
> q5E3qcZxnIWE%3D&reserved=3D0
>
> > > To fix, revert the refill logic like before: the refill is attempted
> > > before the check & return NULL.
> >
> > page_frag API is not really for allocating memory being bigger than
> > PAGE_SIZE as __page_frag_cache_refill() will not try hard enough to
> > allocate order 3 compound page when calling __alloc_pages() and will
> > fail back to allocate base page as the discussed in below:
> >
> https://lore.ker/
> %2F&data=3D05%7C02%7Chaiyangz%40microsoft.com%7Cea9cc3de8c904a5c720408dd5=
8e2
> 913a%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638764452327105287%7CUn=
k
> nown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW=
4
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dg4VAI8DbzUD95q=
gth
> vzFV0PYgOIA3%2F%2FI3gmQHzuLwbo%3D&reserved=3D0
> > nel.org%2Fall%2Fead00fb7-8538-45b3-8322-
> >
> 8a41386e7381%40huawei.com%2F&data=3D05%7C02%7Chaiyangz%40microsoft.com%7C=
d73
> >
> d6a0ae65b4a42681c08dd58c8087b%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%=
7
> >
> C638764338396356411%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiO=
i
> >
> IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%=
7
> > C&sdata=3DFJ7Ggrxxxv6QzKepUiHmtns1GZC2G2oJMcWSzOuFbsE%3D&reserved=3D0
> We are already aware of this, and have error checking in place for the
> failover
> case to "base page".
>
> From the discussion thread above, there are other drivers using
> page_frag_alloc_align() for over PAGE_SIZE too. If making the page_frag
> API
> support only fragsz <=3D PAGE_SIZE is desired, can we create another API?
> One
> keeps the existing API semantics (allowing > PAGE_SIZE), the other uses
> your new code. By the way, it should add an explicit check and fail ALL
> requests
> for fragsz > PAGE_SIZE. Currently your code successfully allocates big
> frags
> for a few times, then fail. This is not a desired behavior. It's also a
> breaking change for our MANA driver, which can no longer run Jumbo frames=
.
>
> @Andrew Morton <akpm@linux-foundation.org>
> And other maintainers, could you please also evaluate the idea above?
>

And, quote from current doc 6.14.0-rc4:
"A page fragment is an arbitrary-length arbitrary-offset area of memory
which resides within a 0 or higher order compound page."
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/Documentation/mm/page_frags.rst

So, it is designed to be *arbitrary-length* within a 0 or higher order
compound page.

If the commit 8218f62c9c9b ("mm: page_frag: use initial zero offset for
page_frag_alloc_align()") intended to change the existing API semantics
to be Page Frag Length <=3D PAGE_SIZE, the document and all breaking driver=
s
need to be updated.

Thanks,
- Haiyang


