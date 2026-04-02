Return-Path: <linux-hyperv+bounces-9918-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPpBADmlzmlZpAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9918-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 19:19:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1338C792
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 19:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8513730088B9
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BFD313283;
	Thu,  2 Apr 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EjZXixO/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021103.outbound.protection.outlook.com [52.101.52.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E8386567;
	Thu,  2 Apr 2026 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149787; cv=fail; b=BXnFdlfuo1yxLeOoExgX25AQwr/YiuWTCcvW/vn1Uarn+B9a6UrcdesYAHw5FEAEdIkf3YLcw97J1yhnfDbr7ROCfVDLCiTXqq7bdIfM2AuzSDujvuQbwACKKeupxon1yHS2R6MFrDlJuutH/w1OhppQJwawNAwTq16/XzGWTbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149787; c=relaxed/simple;
	bh=42LgXffvupzRe2cvQloLD7/TLu5xbaAGQniSI4+50Xo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ou0MoV2GK6Wpb7ri2tiHlgrChndp1g7hz2sQj9ryAE9oiACzgIKcfJSKycUZjP1M63RzRCl/19aoQLWQ4IQS4L2XdQ6lxgCVxp9+JN4ybyr+gqfEDFYxEJ+bP4vVY2hP5OyEcpELUh2WMw4+XMoXUf1R76VVp+33o/n7sbyd4T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EjZXixO/; arc=fail smtp.client-ip=52.101.52.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frlst5Uy3nXGkR24+D2MDEvbgmRT1gTd9xqvZ8D5RGe1RgJea0fgesRl/mUMeL1EO2kIlFUatvdri0/05I8jqn10MyYz9vQcth5aoC40JgyS1nr4TInZwHu78qyh96LX4hBE11tLmYwNRwRwDl5QXG4qLO7qZxKMoZ8wDdz1O+qBRcFoteCfMA4/ErGDIl1aKo/bXgTw0rd2ENjc5yYKcm9nTVbZY7V0M/QzQj9bUhFDMj4h3b+3PMViiaksFWl8ErYhy4m6USh4AmpwGIDMwl0zbAhTwRDk21o5VE1qaA8r81Gx4CN54uO503HaOs70H9G9O5/1njllYWCOi8DmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuRLQbRCNVYpDntQpyH4129JBTCRGi64h9qDuuZvhMQ=;
 b=MgANKR+yE6i40JgyO8A1QklukeuqKUCqeapGUgDRqSzIFxBYg6sBmcBTd7+sPHjB5x0BVuALUAp6ozBEm0nFTs2PwyppPygO9VHh0ovWLqGJynHhEMpJjsdt41BjggmlFutGFiXt/p41LsgLGo3datSMRh4bbpz7+f17Z4/xVxrcYteusN5VBBdAe9POIzY7qdPqeoSSRSGYl1Dwhw2z98lacOIAHHOQMWJpR957MM+UNdtjlIcstht8iXSFNF6pNEO6rhEmqWNl+klnLkcUopH4lnxzPxmhGbRzaZFYibNx93mSreT+xqE4Os0f/38usc3EYx7beFBMHFhF6e62ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuRLQbRCNVYpDntQpyH4129JBTCRGi64h9qDuuZvhMQ=;
 b=EjZXixO/Qgd0CMZJdFjJIw7zc8DCq9eFPUYhDSTThE12D2YdpZVZhvYeFvLkszPeQK25aVKw34rEIHM/ydA2zEJcFMqq4FDzIaBLSdyK1+LS8DA57+JsySiQ5wZqWrEVzs2qROLrAzknwd0EJ0wTFKkXUf7z+DHrFEpnZHrYrTk=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA0PR21MB3039.namprd21.prod.outlook.com (2603:10b6:806:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 17:09:37 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 17:09:37 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Jake Oshins
	<jakeo@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Matthew Ruffell
	<matthew.ruffell@canonical.com>, Krister Johansen <kjlx@templeofstupid.com>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgG35paA=
Date: Thu, 2 Apr 2026 17:09:37 +0000
Message-ID:
 <SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260122020337.94967-1-decui@microsoft.com>
 <BN7PR02MB41486A6DBF839D5BC5D5BC2ED497A@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB41486A6DBF839D5BC5D5BC2ED497A@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cfb6675b-3944-4a29-970d-456de1ad7f69;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-02T06:19:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA0PR21MB3039:EE_
x-ms-office365-filtering-correlation-id: e1142bc1-845a-498c-bc05-08de90da9ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Y4NWKRkRZjskVsZmsso/vFnxN/X0Zg84BICU0VLh/M1PCEpf73O6QL7dB4jjeKgcKsg/x3nuiG9/GWL4BrazegTNmfjJqlXk4Ca0RazaHdBgwKZTzl2YNgkoX7HMWV7LGZX3SueeVIweE1xptI9il8CQjuaBAp0xMndo6jzxddGyVtcl1ktpX0XLBZfftTXDYHAIIpmRL4urXobDZo5+9Hf3AURJW2cha/k2iD/1ptopgX8UW9i4cwkayXRtaotRLbaXM4Vs6mGo3zaYVMG0Shi0GT56ZfdD2/vynghp2NoPpDZsbNo+mw68emrEN0mkTlCUzMv6Ob9xT74lMk3ZK4CegMMWcLlssFovrAuebn/V6U5TacbHMxIU3KdgJ2GHLefAHhE4ZyrYvDmaUAQR404r53n4mqt8KiMLLyyndOuIffQPBbiHn7V4/w/8D8e5mQEAyoj3lU3Xx+nAiN6BXd1ocal4wCCf3hKEioKrJFx0/fVk1TiLNpOk9apgKx32aixXqJQQ4wkqo8mbt/v9ae3g1j+F/69tZSxOLIhiDlWG3fZla4fh6SvfjJIkBIu1StPQcmeXybBk/IQXo+iizJzCAzOCXE3EM/J2H2atrNmTn9WEHsC2CnACHog4yOWqF6Wpo9Om4K9M1ma4lU8PvoUhF/8wulC9+bKxnFtUzyFumKDG2I7VTvSZjbp/XqjotYlhlqz2LWog8Uk+N6K6oKlyHu6zZlQsCNvOgH4Xa4UIdh7grDU0EN2evFidYkcG/sIS+W0C67/s6pQkcFIRogT+akcfr95L9RBONMZpE/pNjXmeKrkkybK4JjWoUOVr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cTRUNEZBcURmMXBWeFNsc1RqcmpvRDgrZWtEZ3Z3K0FKalpwNHhaV3Iv?=
 =?iso-2022-jp?B?RHVpclpXV24yQnJLd29HWjBZdCtZV3QzUWNHVXk4dXVUK3lhbzZOeitx?=
 =?iso-2022-jp?B?SnJBTnROZTFtQUczVDdFWjQ1Q1VDaXh3QlJSOXZoSWZJS1FRSHpDeWpI?=
 =?iso-2022-jp?B?STlsRXRpQzBTd25DdnhzMjVJckNMM2Uwa0ZBMENhbjBlZTBtZDhhVmNX?=
 =?iso-2022-jp?B?UTNmMnY3bUdoeVNIcExSdFhDYWpqU2lxVHFyMzV6REZ2eW1abUxxRm9S?=
 =?iso-2022-jp?B?SmV2YnAvN1pCOGxUNnIySVNza2NDaDVqU1luQmtkaGdxMFZ5NlI2M2ZT?=
 =?iso-2022-jp?B?UEVvazU2VGQ0WHgva2xVR1hJQXFQU0VBQ3lQeG8vYllWVW56eFlzVlZY?=
 =?iso-2022-jp?B?SnFEdlJ2MFYybjFrdXl0amZMeU5HWFAxa1p2V1ZISFZ5ZmczdEprbXNs?=
 =?iso-2022-jp?B?Skh6NzArKzdYdk03Y2hLN3hFNXRpM1pPMFU3VWVsc1YxZVpJRXh2WnBt?=
 =?iso-2022-jp?B?WkE3SS90VE9uWVh5SHlFSUgvU1d4bS9YMlhZMnNIUXVCS2x3WjBUcFl5?=
 =?iso-2022-jp?B?MXpTVUYrS2xCa3o2Zi9PYWlNRUZrTXdtUVBCTVBOMG8xZjRvTUQ3d29Y?=
 =?iso-2022-jp?B?TTdjU0kxUjN3SFV3eU5tSkJQdm1HNkU2UFB4VzBqdG12elkycjdIMGI3?=
 =?iso-2022-jp?B?N09HckJyeVN6dTkrWENscmxlSWpKajNKc21DdElXWWE0MkxhMzMyOHhU?=
 =?iso-2022-jp?B?T05BK3RVSEQ5K3ByeU9xK3duNE5xeDVqdTl0ZnB2Mi9uN0lPczJQNUZ0?=
 =?iso-2022-jp?B?VSs2L1NwRVYxamtWSFp3cjl6RkFzTmh4bVVMOXJSc3h2UFlzdkpHOWdP?=
 =?iso-2022-jp?B?SllHV28vUjJtbDhPZ1JTemZEZ1M2ZUd4M2xHdFkyL1FVZWhVRi9QaFFs?=
 =?iso-2022-jp?B?Ky9vSkRWZjVoakwzRGFuVnpTb2x1VzNRNzBWNVo0UUdob3BEY0ZEdWI4?=
 =?iso-2022-jp?B?RlF5a3hVbGNsWVl1bWNZNW1RR0g1WXVSQ3EvdlEzbHVQUkVHbHNzSUhJ?=
 =?iso-2022-jp?B?N0dsTlQ4dEpFb01RZkhtaHVlV2F3dmFKc1ExRUpIUlBvWU94WHl3eG5P?=
 =?iso-2022-jp?B?c3JsSnlTM0NjOGZrek11UzhHNFZLN2hqWVBRTWcweUlYODdPdG1VcThx?=
 =?iso-2022-jp?B?THl5WDlkdHFnMGp3elY5cFcrUDJhcmNneHdDRnB5REo3SjJPS1lTZ1dE?=
 =?iso-2022-jp?B?YVZVV0NjN0lTZGNWSlZkNDFabklWS0ROZmdyeDZ0TE5IejdxTk9MZVdR?=
 =?iso-2022-jp?B?dGRjMzlHdHFtWXluY2ovUzVXNW9MYnhSY1NOYjFQdmw4M3dkMHZiR0RR?=
 =?iso-2022-jp?B?ZmtTOUJrUHVpYzNZeWhhZDE1a3hPRTIvR0V5ei9Qbk9hb1cvQlIxcmJj?=
 =?iso-2022-jp?B?QTBXRkovYm4wb3M4QzMzNURFNEZoYXdEUUZOK2ZIbHJpbG0yVGM2eVdh?=
 =?iso-2022-jp?B?Rk5WVXFPOFhFR2U3WkNnL2UxbmIyenZxTS9sUFNIMC9HWEhyNk9CKzFE?=
 =?iso-2022-jp?B?NGZDYWkrVUxSTzBMNGFUYWZQRUFUdVVodVBWVUtoUzF5a2dBK3cwemhN?=
 =?iso-2022-jp?B?RkYyRmliWXphb2oxdjlnZnZ6QmFIYXRZbHdielBlZktsdFlrSEh1c3hL?=
 =?iso-2022-jp?B?WVpjYUNjVnV6MXFhYmNvYzA5cHEvZWgzOE1uWUdWRUQ3VWJiNU1URHhM?=
 =?iso-2022-jp?B?VjJ4MG1aUmRlRmpEYmlLQWg1U2x5ak1HQys5RW1Gcm1UZVhjZTMwSzBT?=
 =?iso-2022-jp?B?eVZEcmlnekNQMEp5bXcxdU5qUW45enZZMnhFbzBQbHRZdzkvaWoxMm1O?=
 =?iso-2022-jp?B?TXNTOGhtNFVrQkdtUWNKb002ejBJZys1TzZSZGdGQ1Y2Tm9zTlZjd3pi?=
 =?iso-2022-jp?B?ZllCZVgwWm5uZWtFak8zL2ZJVHVyT0ZLNmhhMXM3SWZHdUFqK2ZSUGNo?=
 =?iso-2022-jp?B?TzIzS1R0dVNJRlJLMDZnYUxsT002OWxaakhPd0d0c2tFQVBKcWRDdTdz?=
 =?iso-2022-jp?B?UVNEV1BGbFZydFRyRTlMQzNXY3ZSVXd4RW5nZjZ1by9mbHVPalFkeUdO?=
 =?iso-2022-jp?B?L1BJamF4OWtXOEdmNlFVWk04S0lmSFh6K09EenVkZ2tVR1NEYlRzVm1h?=
 =?iso-2022-jp?B?ZkZvNW51NElQRkZDL211a2xVbG5VU1pJVXNHRmo2RUsyQXppd1VjY28y?=
 =?iso-2022-jp?B?M0FIUWs4VDFFZkVUZkdyb0hnaUhBT1BzTVloZ05jNVFBYTYvbnNybnlO?=
 =?iso-2022-jp?B?NzRjWlVOSE12QUo2SnhZaHJFdGUzU0hRc1g1bVJ4RlZVcGw2WG5EaVhJ?=
 =?iso-2022-jp?B?d3gzOERNRlREYkpGWDNsVEMyZGxVOFZTNVFpVzlxay9KelFhT0ZBeTFv?=
 =?iso-2022-jp?B?bXZEM0hSbWlxcFRUMis5ckNkZWF6MXAvWjJhQmtaSEhqWjdPd1IxR2VQ?=
 =?iso-2022-jp?B?M3BoRHVj?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1142bc1-845a-498c-bc05-08de90da9ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 17:09:37.1839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMVfOX7qJZLvdAIRkYdVgF0e+w9rYN5VG9yfwjevMx2Eix8YQEuZ/QHu4Javwu2L4+DqLL4Sxed8FQAEyAS9pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB3039
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9918-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,google.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,SA1PR21MB6921.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 66B1338C792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Wednesday, January 21, 2026 11:11 PM
> ...
> From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, January 21,
> 2026 6:04 PM
> >
> > There has been a longstanding MMIO conflict between the pci_hyperv
> > driver's config_window (see hv_allocate_config_window()) and the
> > hyperv_drm (or hyperv_fb) driver (see hyperv_setup_vram()): typically
> > both get MMIO from the low MMIO range below 4GB; this is not an issue
> > in the normal kernel since the VMBus driver reserves the framebuffer
> > MMIO in vmbus_reserve_fb(), so the drm driver's hyperv_setup_vram()
> > can always get the reserved framebuffer MMIO; however, a Gen2 VM's=20
> > kdump kernel fails to reserve the framebuffer MMIO in vmbus_reserve_fb(=
)
> >  because the screen_info.lfb_base is zero in the kdump kernel:=20
> > the screen_info is not initialized at all in the kdump kernel, because =
the
> > EFI stub code, which initializes screen_info, doesn't run in the case o=
f kdump.
>=20
> I don't think this is correct. Yes, the EFI stub doesn't run, but screen_=
info

Hi Michael, sorry for delaying the reply for so long! Now I think I should
understand all the details.

My earlier statement "the screen_info is not initialized at all in the kdum=
p
kernel" is not correct on x86, but I believe it's correct on ARM64. Please =
see
my explanation below.

> should be initialized in the kdump kernel by the code that loads the
> kdump kernel into the reserved crash memory. See discussion in the commit
> message for commit 304386373007.
>=20
> I wonder if commit a41e0ab394e4 broke the initialization of screen_info
> in the kdump kernel. Or perhaps there is now a rev-lock between the kerne=
l
> with this commit and a new version of the user space kexec command.

The commit
a41e0ab394e4 ("sysfb: Replace screen_info with sysfb_primary_display")
should be unrelated here.

> There's a parameter to the kexec() command that governs whether it
> uses the kexec_file_load() system call or the kexec_load() system call.
> I wonder if that parameter makes a difference in the problem described
> for this patch.
>=20
> I can't immediately remember if, when I was working on commit
> 304386373007, I tested kdump in a Gen 2 VM with an NVMe OS disk to
> ensure that MMIO space was properly allocated to the frame buffer
> driver (either hyperv_fb or hyperv_drm). I'm thinking I did, but tomorrow
> I'll check for any definitive notes on that.
>=20
> Michael

If vmbus_reserve_fb() in the kdump kernel fails to reserve the framebuffer
MMIO range due to a Gen2 VM's screen_info.lfb_base being 0,  the MMIO
conflict between hyperv_fb/hyperv_drm and hv_pci happens -- this is
especially an issue if hv_pci is built-in and hyperv_fb/hyperv_drm is built
as modules. vmbus_reserve_fb() should always succeed for a Gen1 VM, since
it can always get the framebuffer MMIO base from the legacy PCI graphics
device, so we only need to discuss Gen2 VMs here.

When kdump-tools loads the kdump kernel into memory, the tool can
accept any of the 3 parameters (e.g. I got the below via "man kexec" in
Ubuntu 24.04):

       -s (--kexec-file-syscall)
              Specify that the new KEXEC_FILE_LOAD syscall should be used e=
xclusively.

       -c (--kexec-syscall)
              Specify that the old KEXEC_LOAD syscall should be used exclus=
ively.

       -a (--kexec-syscall-auto)
              Try the new KEXEC_FILE_LOAD syscall first and when it is not =
supported or the kernel does not understand the supplied  im=1B$B!>=1B(B
              age fall back to the old KEXEC_LOAD interface.

              There is no one single interface that always works, so this i=
s the default.

              KEXEC_FILE_LOAD is required on systems that use locked-down s=
ecure boot to verify the kernel signature.  KEXEC_LOAD may be
              also disabled in the kernel configuration.

              KEXEC_LOAD is required for some kernel image formats and on a=
rchitectures that do not implement KEXEC_FILE_LOAD.

If none of the parameters are specified, the default may be -c, or -s
or -a, depending on the distro and the version in use.  We can run
    strace -f kdump-config reload  2>&1 | egrep 'kexec_file_load|kexec_load=
'
to tell which syscall is being used.

Old distro versions seem to use KEXEC_LOAD by default, and new distro
versions tend to use KEXEC_FILE_LOAD by default, especially when
Secure Boot is enabled (e.g. see /usr/sbin/kdump-config: kdump_load()
in Ubuntu).

In Ubuntu, we can explicitly specify one of the parameters in
"/etc/default/kdump-tools", e.g. KDUMP_KEXEC_ARGS=3D"-c -d".

The -d is for debugging. I found it very useful: when we run
"kdump-config show" or "kdump-config reload", we get very useful
debug info with -d.

On x86-64, with -c:
The kdump-tools gets the framebuffer's MMIO base using
ioctl(fd, FBIOGET_FSCREENINFO, ....): see the end of the email for
an example program; kdump-tools then uses the KEXEC_LOAD syscall
to set up the screen_info.lfb_base for the kdump kernel.

The function in kdump-tools that gets the framebuffer MMIO base=20
is kexec/arch/i386/x86-linux-setup.c: setup_linux_vesafb():
https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/kexe=
c/arch/i386/x86-linux-setup.c?h=3Dv2.0.32#n133

Unluckily, setup_linux_vesafb() only recognizes the vesafb
driver in Linux kernel ("VESA VGA") and the efifb driver ("EFI VGA").
It looks like normally arch_options.reuse_video_type is always 0.

This means the kdump kernel's screen_info.lfb_base is 0, if
hyperv_fb or hyperv_drm loads. In the past,  for a Ubuntu kernel
with CONFIG_FB_EFI=3Dy, our workaround is blacklisting=20
hyperv_fb or hyperv_drm, so /dev/fb0 is backed by efifb, and
the screen_info.lfb_base is correctly set for kdump.

However, now CONFIG_FB_EFI is not set in recent Ubuntu kernels:
$ egrep 'CONFIG_FB_EFI|CONFIG_SYSFB|CONFIG_SYSFB_SIMPLEFB|CONFIG_DRM_SIMPLE=
DRM|CONFIG_DRM_HYPERV' /boot/config-6.8.0-1051-azure
CONFIG_SYSFB=3Dy
CONFIG_SYSFB_SIMPLEFB=3Dy
CONFIG_DRM_SIMPLEDRM=3Dy
CONFIG_DRM_HYPERV=3Dm
# CONFIG_FB_EFI is not set

So, with Ubuntu 22.04/24.04,  -c can't avoid the MMIO conflict
for Gen2 x86-64 VMs now, even if we blacklist hyperv_fb/hyperv_drm.
Note: Ubuntu 20.04 uses an old version of the kdump-tools, so
the statement is different there (see the later discussion below).

hyperv_fb has been removed in the mainline kernel: see
commit 40227f2efcfb ("fbdev: hyperv_fb: Remove hyperv_fb driver")
so we no longer need to worry about it.

Even if we modify setup_linux_vesafb() to support  hyperv_drm,
it still won't work, because the MMIO base is hidden by commit
da6c7707caf3 ("fbdev: Add FBINFO_HIDE_SMEM_START flag")

On x86-64, with -s:
The KEXEC_FILE_LOAD syscall sets the kdump kernel's
screen_info.lfb_base in the kernel: see=20

"arch/x86/kernel/kexec-bzimage64.c"
    bzImage64_load
        setup_boot_parameters
            memcpy(&params->screen_info, &screen_info, sizeof(struct screen=
_info));

so, as long as the first kernel's hyperv_drm doesn't relocate the
MMIO base, kdump should work fine; if the MMIO base is relocated,
currently hyperv_drm doesn't update the screen_info.lfb_base,
so the kdump's efifb driver and hv_pci driver won't work. Normally
hyperv_drm doesn't relocate the MMIO base, unless the user
specifies a very high resolution and the required MMIO size
exceeds the default 8MB reserved by vmbus_reserve_fb() -- let's
ignore that scenario for now.


On AMR64, with -c:
The kdump-tools doesn't even open /dev/fb0 (we can confirm this by using=20
strace or bpftrace), so the kdump kernel's screen_info.lfb_base ia always 0=
.

On AMR64, with -s:
"arch/arm64/kernel/kexec_image.c": image_load() doesn't set the
params->screen_info, so the kdump kernel's screen_info.lfb_base ia always 0=
.

To recap, with a recent mainline kernel (or the linux-azure kernels) that
has 304386373007, my observation on Ubuntu 22.04 and 24.04 is:=20
    on x86-64, -c fails, but -s works.
    on ARM64, -c fails, and -s also fails.=20

Note: the kdump-tools v2.0.18 in Ubuntu 20.04 doesn't have this commit:
https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?i=
d=3Dfb5a8792e6e4ee7de7ae3e06d193ea5beaaececc
(Note the "return 0;" in setup_linux_vesafb())
so, on x86-64, -c also works in Ubuntu 20.04, if hyperv_fb is used
(-c still doesn't work if hyperv_drm is used due to da6c7707caf3).

With this patch
"PCI: hv: Allocate MMIO from above 4GB for the config window",
both -c  and -s work on x86-64 and ARM64 due to no MMIO conflict,
as long as there are no 32-bit PCI BARs (which should be true on
Azure and on modern hosts.)

With the patch, even if hyperv_drm relocates the framebuffer MMO
base, there would still be no MMIO conflict because typically hyperv_drm
gets its MMIO from below 4GB: it seems like vmbus_walk_resources()=20
always finds the low MMIO range first and adds it to the beginning of the=20
MMIO resources "hyperv_mmio", so presumably hyperv_drm would
get MMIO from the low MMIO range.

I'll update the commit message, add Matthew's and Krister's=20
Tested-by's and post v2.

Thanks,
Dexuan


//Print the info of the frame buffer for /dev/fb0:
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/fb.h>

static void print_bitfield(const char *name, const struct fb_bitfield *bf) =
{
    printf("%s:\n", name);
    printf("  offset       : %u\n", bf->offset);
    printf("  length       : %u\n", bf->length);
    printf("  msb_right    : %u\n", bf->msb_right);
}

static void print_fix_screeninfo(const struct fb_fix_screeninfo *fix) {
    printf("struct fb_fix_screeninfo:\n");
    printf("  id           : %.16s\n", fix->id);
    printf("  smem_start   : 0x%lx\n", fix->smem_start);
    printf("  smem_len     : %u\n", fix->smem_len);
    printf("  type         : %u\n", fix->type);
    printf("  type_aux     : %u\n", fix->type_aux);
    printf("  visual       : %u\n", fix->visual);
    printf("  xpanstep     : %u\n", fix->xpanstep);
    printf("  ypanstep     : %u\n", fix->ypanstep);
    printf("  ywrapstep    : %u\n", fix->ywrapstep);
    printf("  line_length  : %u\n", fix->line_length);
    printf("  mmio_start   : %lu\n", fix->mmio_start);
    printf("  mmio_len     : %u\n", fix->mmio_len);
    printf("  accel        : %u\n", fix->accel);
    printf("  capabilities : %u\n", fix->capabilities);
    printf("  reserved[0]  : %u\n", fix->reserved[0]);
    printf("  reserved[1]  : %u\n", fix->reserved[1]);
}

static void print_var_screeninfo(const struct fb_var_screeninfo *var) {
    printf("struct fb_var_screeninfo:\n");
    printf("  xres         : %u\n", var->xres);
    printf("  yres         : %u\n", var->yres);
    printf("  xres_virtual : %u\n", var->xres_virtual);
    printf("  yres_virtual : %u\n", var->yres_virtual);
    printf("  xoffset      : %u\n", var->xoffset);
    printf("  yoffset      : %u\n", var->yoffset);
    printf("  bits_per_pixel: %u\n", var->bits_per_pixel);
    printf("  grayscale    : %u\n", var->grayscale);

    print_bitfield("  red", &var->red);
    print_bitfield("  green", &var->green);
    print_bitfield("  blue", &var->blue);
    print_bitfield("  transp", &var->transp);

    printf("  nonstd       : %u\n", var->nonstd);
    printf("  activate     : %u\n", var->activate);
    printf("  height       : %u\n", var->height);
    printf("  width        : %u\n", var->width);
    printf("  accel_flags  : %u\n", var->accel_flags);
    printf("  pixclock     : %u\n", var->pixclock);
    printf("  left_margin  : %u\n", var->left_margin);
    printf("  right_margin : %u\n", var->right_margin);
    printf("  upper_margin : %u\n", var->upper_margin);
    printf("  lower_margin : %u\n", var->lower_margin);
    printf("  hsync_len    : %u\n", var->hsync_len);
    printf("  vsync_len    : %u\n", var->vsync_len);
    printf("  sync         : %u\n", var->sync);
    printf("  vmode        : %u\n", var->vmode);
    printf("  rotate       : %u\n", var->rotate);
    printf("  colorspace   : %u\n", var->colorspace);
    printf("  reserved[0]  : %u\n", var->reserved[0]);
    printf("  reserved[1]  : %u\n", var->reserved[1]);
    printf("  reserved[2]  : %u\n", var->reserved[2]);
    printf("  reserved[3]  : %u\n", var->reserved[3]);
}

int main(void) {
    int fd;
    struct fb_fix_screeninfo fix;
    struct fb_var_screeninfo var;

    fd =3D open("/dev/fb0", O_RDONLY);
    if (fd =3D=3D -1) {
        perror("open");
        return EXIT_FAILURE;
    }

    if (ioctl(fd, FBIOGET_FSCREENINFO, &fix) =3D=3D -1) {
        perror("ioctl(FBIOGET_FSCREENINFO)");
        close(fd);
        return EXIT_FAILURE;
    }

    if (ioctl(fd, FBIOGET_VSCREENINFO, &var) =3D=3D -1) {
        perror("ioctl(FBIOGET_VSCREENINFO)");
        close(fd);
        return EXIT_FAILURE;
    }

    print_fix_screeninfo(&fix);
    printf("\n");
    print_var_screeninfo(&var);

    close(fd);
    return EXIT_SUCCESS;
}

