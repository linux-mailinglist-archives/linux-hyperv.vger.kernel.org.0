Return-Path: <linux-hyperv+bounces-7342-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5534C0FCBB
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 18:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B197E48081F
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A33164B6;
	Mon, 27 Oct 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V2S2BfcH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020118.outbound.protection.outlook.com [52.101.193.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B3306B3B;
	Mon, 27 Oct 2025 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587533; cv=fail; b=NffCeDQ8GwfcD44wrCQ6BGCuV8Oz0oInhWdEQnAnkaNfE7SbGPl1bj6HziQ5HnFEkhVl8grN9uCI30Agx0v0T1fF8UmAj5SVL1Ekb+iuPqmS1Uol9xmyDqlVlhzIFoYWRhEJUqSV81CTQVJP5tE78iAnSK6eaL4rHh4JU5k9rWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587533; c=relaxed/simple;
	bh=HPBFKEccBIElAjV0c2BW+nsRVgTNn8fQ07TI82dKlOY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FO6GSq3lZ+F9vEQx88xwyHm+gyK4tR9Sp0apj93ksWlsFx+EXAvMKAiavETRTcN7pfazWwH2c33rQC+qu2vwgiM96zB2Cj2f7hqUjmHXSCERuA9uJuR4Q6GcXYX/x0U7D0zv0gWVU365NUQlsCTCaJTydemYnSOPvxX2wXw5+pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=V2S2BfcH; arc=fail smtp.client-ip=52.101.193.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPf1v5ymhhO+NpdPHQGMfARJRmeEg1wu6AiPnVIQkdqF1r1UKAXGobH5LUjDeg+HVocp6a15XlYvdu8TrZHqqfR64ia7/r5EnB/NQO1uUh2tI6d+YSt92qjXS1s9K0RIO0fcAaEHjD3gFR0fYoQw7mULrOvRptCRrUeRM7dqttQqIzDy05b4PPgh61h9+zIMCzKzunxLbpxSg0/+ZS736UHWyESIBRv8yQqj/ZwsAn/nXQ8r0MluRXtnSUHch5nGt4NylKMxAPZrI6zPXOOXKlYyB2vlvRaWUGp3Jfq1+j4TSDmqjlVpK7/2YLuKME5vw8WqE8nxv6fYRfz1th3i2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXLA4bjRnSvsGjW4hGnvhLjaoKnjySdp3qAGnGIg4E4=;
 b=ZQwlq27hkmKCHqVlvS5DuQCCRaSs5XSlaGnAeE0IX0o+zaGIcET3a4SS9z+/aE9jjPVWVedlJTw2pHrV6UVJpi2OTy3aUV0zvKWOe8lsLCX2xBnaN7vAUSNsqZmdQM8J1oXCTGxDC6/fx2Wai+3mJUt6nhe89ngJfv5kLTMI9OpnU6jKrRs5eb+OOqhYBoU7x/sg0lpVRRz9bHLDi58OUY9JQrKUp4lfcYeUdiiTOn84TS4UOa22LWiJW7vAe64FPjvQ6585av9mQvrbA533Czlt9BE3rp1SvLL1gJARPJh4ZoR5Pd/OJ6izJiYTKGkuMODI0KJ6wyvyQJUhmN7rIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXLA4bjRnSvsGjW4hGnvhLjaoKnjySdp3qAGnGIg4E4=;
 b=V2S2BfcHJxN3V2sVJymJ8JqOV5HqR1TPiEuMqrUFFtcFaIgf2oQfsmXp0WS+IqHNVn7b5POMvlhz0+cOjIY7ucCHCP+o4QAQpe7yGIEPlcDeOpQ4soxCSoE/iQAMnxq/+MeMR0cKKnoN4EBWKMn5jpZKh4jPNC6m1IQI608KcH0=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB2019.namprd21.prod.outlook.com (2603:10b6:806:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.1; Mon, 27 Oct
 2025 17:52:07 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%4]) with mapi id 15.20.9298.001; Mon, 27 Oct 2025
 17:52:07 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Dipayaan Roy
	<dipayanroy@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Thread-Topic: [PATCH net-next] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Thread-Index: AQHcRzdAFI1Tk26EHEia77G9UEyz0rTWRb6g
Date: Mon, 27 Oct 2025 17:52:07 +0000
Message-ID:
 <SA3PR21MB3867E1DE0A3783D14621B220CAFCA@SA3PR21MB3867.namprd21.prod.outlook.com>
References:
 <20251027114549.GA12252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20251027114549.GA12252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=583527dd-1db6-49d4-8192-634b899d19a7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-27T17:49:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB2019:EE_
x-ms-office365-filtering-correlation-id: 601d2162-7b28-41fa-81af-08de15818bf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F+bwTPjTLhEq4ztt3ib+/xNXsP1Lh6Wc3HW1O4xtpFkvBXmwdMCFyPvFKFvm?=
 =?us-ascii?Q?hWjDFN8XtQPg0hlcPTxwrLvUh3bVBMu18LFbBADfHVvslS/dGryN8He7KM3P?=
 =?us-ascii?Q?ymAce1QttzAWXoJ3l/Spr4NKsPTOP8Y9pYeI7R0lvgB/gwBhiAPCwybWaoQ5?=
 =?us-ascii?Q?EZjBtqTSzbiiXSwLEgEV8Uqi5xzzf1vBYzR9vqhfLO6JIVZuNmirPRrBMO+F?=
 =?us-ascii?Q?8PDWRk7wIj4PHQAV7t6K6NgvivKMiNRjK9tg+a8NQUC36K1MJPauHFd/c17d?=
 =?us-ascii?Q?AXlJXC6adwoal9w5KWI9oVtRl9yvEkIgFcnHghdlT23Z+GXClrmQ5+QfLX4G?=
 =?us-ascii?Q?oL0qJezmHOPL2uCauOmsrya9lWQHwC59a2MiWs2iWS3LcpYThrVTSRUcf+2y?=
 =?us-ascii?Q?Y7oWwhdcnNCgpaKSs+b/73pAw91GSnCT7GH2GYxkOunaH5h/AEYfqzxGPTHH?=
 =?us-ascii?Q?fmEZNc62JAzu4qSV4gkDdUVwj4xv+xGAZGrZlw2jvfwkbfrutmCm8iV4Qvir?=
 =?us-ascii?Q?PLJdgDXXgLOWxGQsypMiNkahuQ0OhnAJxjdOCANrOwwIdafW6lvQXWSRS2T9?=
 =?us-ascii?Q?axAYEErzhDyBHKxjpHDqw2iYJ4MBVQtGKIJ+onb8/IT337VRQ4iE6EMrJNMG?=
 =?us-ascii?Q?lRndNRQmdEFTQ9iQlN08K0Rrp+FfcRfTEGBDz751B0hsSz2ZY2Ksl7ocPUjh?=
 =?us-ascii?Q?pb3vbGIZB4j3pPGb+2cgLRbA4ZfY0Ri0ZJ28SDOG9ioUoqjFddlp7fIkVsl+?=
 =?us-ascii?Q?UzsOD5okzQiK2wRAY02U2suEQ6JG6/9hy+HdI21QnlrizEAtyBPwjbFIicPZ?=
 =?us-ascii?Q?UKeWsGZ5bq3/2DmD8/qA3FIMgeP9LNFki+ECnXPiDtlWlMHiP3b7xw/NuOyM?=
 =?us-ascii?Q?0IPyaQH7VrYy8U1JiAS8E1CwZm5lYjIY6z/B+ISRsVvmOLoF3wPqOAmMUIbx?=
 =?us-ascii?Q?XczIcFZg+nHo5Q7CyL+rEVOUzjNJ92ahOciALYrUFZetPc3twP3ASY19WHq8?=
 =?us-ascii?Q?2a4k22HQwQ1CzbPKG0WKykf8V9/8NgMWMvj27IvHUmG/3vPJOasAXCEAKLsp?=
 =?us-ascii?Q?mp3rx2CNAg+Vw1HCX2fk3fOEu7b9KHCBiK3gu9jynhIlPp1FhQMoPJSW3C4B?=
 =?us-ascii?Q?qfrU2TQbEY1J/d0LrY3OMjzruxhRrlZS7FLykDVJ6iILHIY9vi1KdO2oQwJF?=
 =?us-ascii?Q?1cCxE+40E6E9IveE0CW++HOpf578T4fYoKLjMHjer+zonQdFgf0QggqESP2u?=
 =?us-ascii?Q?N2d2c5WaBm8l1z6A61dxKGA/0Z6HPkFaLG2e4NKzs7cuWeg4RtEmHi44ybkI?=
 =?us-ascii?Q?d5fXNIa36Xw3cBRTLBv4Dz0C9sP+WNPUNDKuK/QePEQlQYbBcn/V2ynZKal0?=
 =?us-ascii?Q?T4E/fGjsXyrl8utn/eKsYVezyBQvAYt2F7oWyEDTd9TLyXpKzPh8b1GS0fxr?=
 =?us-ascii?Q?pA5o9xPNtqVtvHP5v2L1c4NOzw09nyjauEDGKjRTXG2evsqZl6pp9KQQVAYm?=
 =?us-ascii?Q?ZmxP5phDSijm7LT1cNB20gIi+GPjdgNzARK1XR0xQmWieBiTv3V/LuktYg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NxiP6O2EdeQh0Ye6ErY1az5bBNbiJW54CrvU7WULw+8HiWA3fY57E9lxh0Tq?=
 =?us-ascii?Q?Y7d3t3KxEthk5MGRnnmv/vECrERiAOVgzbXcL4YVa0dwxd/ztqCSgV7gR00m?=
 =?us-ascii?Q?7gFGHxqFkWGOrkc5rhXhXVdHQo1/m9nDv6kwUkMX0zsuC1T0bIiHj2AofA+f?=
 =?us-ascii?Q?WNDgdPFxQupQaS+LocyVpA0YnrwDOHB8P+3GPvSW+iZ5UOnhl+zae5AeRTi+?=
 =?us-ascii?Q?ym+KDdq70U6OHIVjmG79PoMGeZ/qH6yyCeOQL/I247mhktUvmPeNegR8sBnX?=
 =?us-ascii?Q?TRYceHE7z2ngjdmC5kexBDFhr2vEPukIpqqMxLnpAboUpxT+1TgqcTEGHTPj?=
 =?us-ascii?Q?KiqocqsGjK4CE++vICEAghiQJKPq7mwgFbQcZTFAEO3syrgK7XGhqzSj0a/7?=
 =?us-ascii?Q?BaQ0O+EkhHD8ND6B+vPUCkKtu4XKPs699ge5LYDsmJV7tbJTAKjRxzPCsxA5?=
 =?us-ascii?Q?/ehDgKRGFp3UkgkB3LLDr8AETTxErPO/J8CETBPEiPhx4KZCBY1WVYOPeA7Y?=
 =?us-ascii?Q?o1x3O7zkOUDxOwHBSfJIu2ht6jniOL8ql9ytnqyc6LkiCQ+/fi33jC9UtmoK?=
 =?us-ascii?Q?wWhpM4yu/kRF47u+cotuwTz6m7nFjI/HjxVh3QN034nwaLIMzN+ohEcMI+gQ?=
 =?us-ascii?Q?MwLpmTfh5NOFgxy7tTrH/vxSGtLJWdTBeeID0ShpLqADw1b0+e7gLhRfIVpz?=
 =?us-ascii?Q?ZHPaXrupsfLZ/wxRc5xS1kl3go3k5lTG2B/kfzjqqYvfxZRep3tX2H3GetV0?=
 =?us-ascii?Q?y6yjs5NqO2SAUSNJ7nMpKOi3h1HKlWX4HNhuBytgHaI7/l3QRB9M54WBucpe?=
 =?us-ascii?Q?svW/Qge2srD/B2WiC/TbPPuLiEFQS72AMhMWmpmFfyCPaP7ao2XOdo6UzrIf?=
 =?us-ascii?Q?YVjeV2Bj+31aok7b9zHKgtCJMUIcEFwOYmCp9HSYlMOqZ9fjeOKntCqS/6nV?=
 =?us-ascii?Q?mQZBJ52lATSJKSB7Ig5eKx4MSAIsD5g9AEteb7uqVk3SPCT8Oiu/6E70TTJX?=
 =?us-ascii?Q?tgEwejDXzuPhA49w2F01UxlurRBBvpJ98W8C8KxNndLTfEuCqlkwOQtUKAaL?=
 =?us-ascii?Q?gyO1fNZAZhWcOuelXDb5XRpHyS+UUpECgBS9fGR1C5Sm4jrilYNp6yiSu7KW?=
 =?us-ascii?Q?Hdm8jYfGwaqUxBa3PdlC5wpKXyC+0JMHeBJfYdbzuv+g0lQL8URuy4Nw42Dt?=
 =?us-ascii?Q?EMGcz+U7jZe7OPtMe22iyA0kU9T8sE/Wo085nGQh5BeIj3K290iIBEJWBlZ2?=
 =?us-ascii?Q?WoIyPd3ihDOoxMehoK5hc/gwhHHGWv+lrzyjdQplCOzkk+EIFYDrkQVR4Axu?=
 =?us-ascii?Q?pozc4+QMFkItfIGIujBpb/xBwoW5NE/fMoR4xeNVzSI/F7KMy2hjR9rQkki7?=
 =?us-ascii?Q?d25U20Tfv3oQ9M/Snf3W1qWbnYD1JKApgHd5ulpG3yeAfVksoWRTF1F96Tl8?=
 =?us-ascii?Q?BtipXMK72pf9hKuMxslwqBTYX32DD8uiHki8G1MGH2GyWnNRH5Jt8AiU/0m1?=
 =?us-ascii?Q?SqFU2c3tqstXNUuiGWEzbhry20y1T+8HHczy8YkxLjcjxMjPbHlMfBZ8hSH+?=
 =?us-ascii?Q?QeGfE0cJg9WsllO7e98DRhQy5NiE/+R4QuESJ2pn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 601d2162-7b28-41fa-81af-08de15818bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 17:52:07.6167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTvPm9XaXLoqcKcjJHSfxrg5nyN1jW4eVioSiJlySpXMbUTlkGcdXf1BA+GGS+nzzMq1LZJPrz6Z5LA9OU0Xdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2019



> -----Original Message-----
> From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Sent: Monday, October 27, 2025 7:46 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Long Li
> <longli@microsoft.com>; Konstantin Taranov <kotaranov@microsoft.com>;
> horms@kernel.org; shradhagupta@linux.microsoft.com;
> ssengar@linux.microsoft.com; ernis@linux.microsoft.com; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Dipayaan Roy <dipayanroy@microsoft.com>
> Subject: [PATCH net-next] net: mana: Implement ndo_tx_timeout and
> serialize queue resets per port.
>=20
> Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detecte=
d
> and a device-controlled port reset for all queues can be scheduled to an
> ordered workqueue. The reset for all queues on stall detection is
> recomended by hardware team.
>=20
> The change introduces a single ordered workqueue
> ("mana_per_port_queue_reset_wq") with WQ_UNBOUND | WQ_MEM_RECLAIM and
> queues exactly one work_struct per port onto it. This achieves:
>=20
>   * Global FIFO across all port reset requests (alloc_ordered_workqueue).
>   * Natural per-port de-duplication: the same work_struct cannot be
>     queued twice while pending/running.
>   * Avoids hogging a per-CPU kworker for long, may-sleep reset paths
>     (WQ_UNBOUND).
>   * Guarantees forward progress during memory pressure
>     (WQ_MEM_RECLAIM rescuer).
>=20
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Looks good, except for the comments from Pavan.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


