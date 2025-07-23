Return-Path: <linux-hyperv+bounces-6348-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0622EB0E782
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 02:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3731C27A08
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 00:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADF3BA4A;
	Wed, 23 Jul 2025 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="auT9LsYb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021110.outbound.protection.outlook.com [52.101.57.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909E3D81;
	Wed, 23 Jul 2025 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753229843; cv=fail; b=eCDQzrrMZyEVIxTvu2BJu5ggLEwC+0x8QtBrmcUhFVLksVVRDj5MVma9hvli5DrzDuDx3ZNaffKGtngkVEGMkesyGpyYQHPvGRvtKnUR6yJY901MvkB1qEGaUEcXx/Gi4wycATvLkoxsg0KkP3o6jyvncb4ig78JuG79iKj9mnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753229843; c=relaxed/simple;
	bh=ISGQSDctHJ9r09XgW4vVTfdh02P1CiRuoQzbYrZQoQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJWrjvf4abL2f/0Q3J+QnVdhjAlLHMCs7sBYpxmcGiURd9RHXo+G/FZ9uq05FFma7vFfGb5pvN/vzLbnPMkS32XyRzVkaE/chmFlfi+jGkmXwaw4eQX73/6x50mvGjbAMuE532KxWtPLGoqp9jU1IWcDJ/oXiZck4DXkH0xeSvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=auT9LsYb; arc=fail smtp.client-ip=52.101.57.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiHeTZ7ztzo4Hx8v7kTMZxLkqzOd1z/qyzVrIq2F+0MdSU3qYzPPzjJGhRY/Etkalq9Fsfdfd6EzpD7F8HRYfobVshOthciUchOlZCnR610eSh0xfcDPbv6gNgPa/A0nh8wbqyucPAxBh6qtuMeCZcYH/7hUFkr7jvkdFg40YPlA3BIGFxnLxptjPrPKQbUV0cdmrrLaFfwWlYPveolSt3lkhbI/k2ILXDP8OxPeABBB7pbMjEatu4SIsCOF84oE8XoUh3MZdYY/awaDifbUWH++l18JXNT+W6rSL3UgRHNHBObIm4vKsX7oxV0cB7FfJ6wbARx6r6fOn31uzG7wEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISGQSDctHJ9r09XgW4vVTfdh02P1CiRuoQzbYrZQoQ4=;
 b=TKJSrDpMRg3zvD/VFFnCkD/R7VXf0pATTS9b0o43WXrD2E+6zSCMADzWDiPgCe7edbYGdhyIV4VHXE9urF5fjlwvbSONzs5FiylfVdhawq/bhPTjGV0IXiqlErtBwaAeHNBKflHgg751L6Hh2883AjppldCz56eyolWteDWdwB0QiCVb6IPCdTl6c0QmKk8xiqaqN3n4aO2W2w+xTnBvMh9SUQ1iriiPJGUD9slAt2ayjE/xtbMDtGsi6a2iAYSS2+REvjiB0hRdedXbAyJcULtJ4qa7ybYDJX3nV6u3sBIJRLp3Lwym8ZJvDFDCDAqLKClW4tpZ2iYEa6kBAMAhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISGQSDctHJ9r09XgW4vVTfdh02P1CiRuoQzbYrZQoQ4=;
 b=auT9LsYb6OCPNfUyS0kooEeMlog+mhsT5kwunWPWXmM9VxfrAuTplWltoy5QGUQhJhZpunbGDvdJ0sD0TQABaANvUf01n13Ggj7ePIo/g4l9TtccQrxtXCFH8WDX3LZM+iz1YuU7GTRIhZFUy3GdBLfJdLXuoAdgzQn3dzmP4ZE=
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com (2603:10b6:a03:546::14)
 by DS7PR21MB3340.namprd21.prod.outlook.com (2603:10b6:8:7f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.4; Wed, 23 Jul
 2025 00:17:17 +0000
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18]) by SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18%4]) with mapi id 15.20.8964.004; Wed, 23 Jul 2025
 00:17:17 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"sd@queasysnail.net" <sd@queasysnail.net>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"neil@brown.name" <neil@brown.name>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net, 1/2] net: core: Fix missing init of
 llist_node in setup_net()
Thread-Topic: [EXTERNAL] Re: [PATCH net, 1/2] net: core: Fix missing init of
 llist_node in setup_net()
Thread-Index: AQHb+2UC8O4xLMOfv0O2YNnpmzBln7Q+1VTA
Date: Wed, 23 Jul 2025 00:17:17 +0000
Message-ID:
 <SJ2PR21MB4013CDE051C7AEFC67B0FB9BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
References: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com>
 <1753228248-20865-2-git-send-email-haiyangz@linux.microsoft.com>
 <CAAVpQUBuyfnv4BBxnOvheEb7JVnokTEiea5Yp4UZdX=5CuWVHg@mail.gmail.com>
In-Reply-To:
 <CAAVpQUBuyfnv4BBxnOvheEb7JVnokTEiea5Yp4UZdX=5CuWVHg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e3e8f27b-cb1c-40d6-8045-2ed1452beef3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-23T00:09:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR21MB4013:EE_|DS7PR21MB3340:EE_
x-ms-office365-filtering-correlation-id: f8e13a08-108c-4d79-8901-08ddc97e485b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1RVRXRPS1Q3dWpEbzZPMFFvSXV1ZEhlMElMbld0M3plQjJhMjF4bXpvak5T?=
 =?utf-8?B?OEc3dTZkTmlEc1FZWVl3WGJacHN4TGVSZitjazF6UUVqQldYQlZHcGRlb1p1?=
 =?utf-8?B?YXkwaFFiZHBzMWtaVnRmaVgxd2hYRUlhdVpGdzVGT2IzQzdjZnhxdFNPTmtn?=
 =?utf-8?B?SHhsdUFqbWRlMFJvQzdiMFlkWVRTZ0VTTTFSaXVRbHdkM2doSER5cDRmaHhp?=
 =?utf-8?B?T1FyQ0VrOVFnRGtVdUVndHRpbERzbVluR2lnQ0EzRWE3VUtST3orU2ZuVTJj?=
 =?utf-8?B?Z2U3Q0VZdndiZ0cvWk1sVnQySCt4b2Z0dGh0OUcvY0NRb080OTh0MmRHdnEv?=
 =?utf-8?B?WGJlOFh6ZnRjUXpkUXg2T0VtQ0lsVkZGYzgzeVdJN0orZXYvaUFzMmdjVy9P?=
 =?utf-8?B?ekJjYWNDYUFUZEdCd3B2aE84WFBPSDRYNXJoeG5lRW81ZkVMaWpjamYwdEZH?=
 =?utf-8?B?Y3RIQXRObWJsQlJNcFBweFJyakFjemxUYVYyQUxjQ1QrSUh0U05LUFdxelBr?=
 =?utf-8?B?by9hamoya3VSSkQzQnQzRi8xMi9wSXZwV0FBd21lT2IzTzBTeDc3RWhOT1pM?=
 =?utf-8?B?K0pLc3JWSnMwM1NjR1lNTGRZNVNnSFNNMHVkK0hzdHIvc2xqU0FJZzJyN29s?=
 =?utf-8?B?NzZGTjBFeEpHZ3lseHdQYWdlc25EcnN3T2pLbUVsK2VjTWo1N2hCOHpHSDRB?=
 =?utf-8?B?WndKeVVjTGk3TXBaVDNHaWRXUmlldVVJaE5ZTU0wTkVHTEIveUE0OUxsUGFx?=
 =?utf-8?B?NyszaTM2bVIrU3RmbXNDdXFiTlRCN2x3UUEvbjdQQllRZzIyWGZtSXdrUTR5?=
 =?utf-8?B?T0tBaEJhMTQ3OW5hd1dOcVA1R0xZT3dNSGVBQkVlcDJWTHZhQnJ6YUpaTjVn?=
 =?utf-8?B?NXhLY3duY2t1eXJBQWRydTFEaHNZVUljeW43aE11RXdsQjZjaStuMEZQcWdG?=
 =?utf-8?B?ZGt1a2FsdVRjWDk3S1J0d29DTTZ6d0xSMnhUc2dmZ2tMSXYwdy91NWJGNGdx?=
 =?utf-8?B?WktkZ1F5K29leTMzSTJaSEJoREpIdTNpamc2NFNqczcvQ1NKdVZmK3RzSEJx?=
 =?utf-8?B?RzIvaVdBWGNLb2tWNDNwSUUzQkR3UVZKODFDRi95NmVlSFhRQnhyTTExUS8r?=
 =?utf-8?B?Vkxpbjk5ZmlrZWo3Vlk5N1ViSUt6LzNScWtwZjlMdjhuTmU3czhReEpjU0N1?=
 =?utf-8?B?Y1dubXR4WURtakwyYSt3MUtZV24rUDJEei8zLy9wZnlEYmp1SzVESkFJcHlR?=
 =?utf-8?B?NmNnOUJOaXozRW0xWjhyZUd4VGp3LzI1aTVLcTFPdmpHVTM2aDFLc0kxa2V0?=
 =?utf-8?B?RVVldGt5TjVQenFQUWpCVWNyMEsvRTB6cUwxbkxLNWg5L3l3dTBNeXl3YURh?=
 =?utf-8?B?YWhkTDA0MVNUZ1BWSWMzaTU2d1Q4a0o5NGtjd2ZVTS94aGxLc0NDWXA2aWU0?=
 =?utf-8?B?Q1FpR1E2ampmTU5XZmhBa3lYNmZrR0d6UHp3YWdmYW9qeFloTkpPUWhvSFhX?=
 =?utf-8?B?enhMdk9sS2hmbTM4SjQ5UjhDUFpXNnpHRDNKMDdmY1drRUNvdUlYVVB5ZS9w?=
 =?utf-8?B?YjZPVG5xckhPODB1bzJFOVNGOFZoelJuNmtiYmpaM0hFL24wVHQwN1hhaGRt?=
 =?utf-8?B?ZnpDMjFDcnlESkRicklmejhGWDJtQTkyZzltNW1BbS82Ri8rcFBoclJmTmFE?=
 =?utf-8?B?UGhTY21JMVN1S3A5Z0Q4TjRLTlNBbDJselFOM2hoYXRJb1FwaFR2NittdmhM?=
 =?utf-8?B?S2JlNVZYNTl4MUtIOTJXZ1BQMVp6S0dQYUpxUjFsQ1BaSzdVVTNpWE03RjY4?=
 =?utf-8?B?a3hhMWpEWWtaK05GeTEra29kZHNneXFqTlVmSUErYS83RDlxd3NKY0xieUx5?=
 =?utf-8?B?RkM3SFQ4ZW5MY2RuL05nbWRWd1dwU05MNU1xeHptS0VBazI0cnRSU0ZzaTB3?=
 =?utf-8?B?VU5tcEpPOGw3YmxTMUxaYVZjYy9rTURNK09BRWVRQkRoQjRZSUJDSlhoRDlM?=
 =?utf-8?Q?E5g8U9/fBwTntwDBam0KGh3a8hWNow=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR21MB4013.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0FYRXFyMTNEcExWVDNaOTNTVU9wRU8rc2NjSFloeWdqazhoRDhWc1RaVzdT?=
 =?utf-8?B?aDJDTmZqdGtsQklKSDc0S3QrL2lGNko4alNIbFhHbFRMUWNDQjF2eUFKWk1z?=
 =?utf-8?B?cDJ5QXliYWpjbUlXWlVoSmJESzdMMndXKzRoYk5BUGg5bVloNGNDeDNERk12?=
 =?utf-8?B?dkJPSlJMRy9lTENvNFN5aXVnTWFVakZqbVVKT3FCdXZlME4yTWlaR1NHS205?=
 =?utf-8?B?TnVOSDExczBCdUt0MUNIRitINGsrWWtpWndpVGMrbnpKVExmOFhEbmx1clg3?=
 =?utf-8?B?VWxrNExMSDUxSzd6M0R3Z3RpWlJWTm5zRUcvcHVqYmRuQUI4YWlUaXNNRkNT?=
 =?utf-8?B?L2FMQ1pSb3pmVGp2UktCMzRmTUhQTjlac0dhYURWOENqTGhNTGJBRTgzNVRT?=
 =?utf-8?B?blhFTEFQVmtMVktpRTcweU1taGwzUUtEVHhZQk5sT0VjZHhoY1pTbE9HblVR?=
 =?utf-8?B?Z0ZYM3Vvd3REQ2NTRmJneE1LbVBabGlHa25LaThPMllvejhoU1BZaENGT2cx?=
 =?utf-8?B?cVA0NzQ1alh5UVBscmtsZ0lLaUVLMVdMS3E4VVJIVzd4Rk94MGJtZ2JVVk5y?=
 =?utf-8?B?dVBtNWhYNytyNVpnR2JpMm1YYmtUSmFFQXRIYk9yVnRINndNdlY4bnZYM0Vl?=
 =?utf-8?B?amhITkY4Mm82N3VIN2FTcEx1dTZ1cklBcGowK3BaZERLN0ZqRFVzWk1OK2p5?=
 =?utf-8?B?bFRRV3FRWG1sRzJVMmZxOURKK2JNZVVjS1FyLytiVjA5Z21TTU95bDJjc2lm?=
 =?utf-8?B?b1ZGMTkvSllnbUprc1JxcmswNUtDbWV1bTEyYWtvVkdNTXg5OEZ1ajc1ZXBh?=
 =?utf-8?B?S3lVWHo2N3ZyUndnTXgxSTFwckxnNmFheVRYWnEyYVRtbk9ML2R0RHNVaGVN?=
 =?utf-8?B?bVJ5TkZFSjZtUkJ6WURxTEl0dHNQMlh0TnNNSmFxWVplalFzSWlGK3JDZ2Nq?=
 =?utf-8?B?SkFhNWtzSVpaNlVVb0hmUGJWbjBwTHVWZ1hIMVZxYnBreXBCaVpzakhiOGJV?=
 =?utf-8?B?ZjcyeEVwUExkam5mR0ZmWW5rQVg2cVdHT2pIaWRmeHBOcXlEV1E5N1NiVXZM?=
 =?utf-8?B?K3hzeFFrWnpMMzdJR09UNW9oTU1kMG50RzY5NGhxdnFoRWh1YnRHZ0VUZlkw?=
 =?utf-8?B?R1lodDUrSk1lSTZNeEFnY0FsejJNQnJYS0lQZFZ2RGF6dmFMN2hNU1RZeFk5?=
 =?utf-8?B?WjFaS01yMVd6VDZCRkZISmtnbjltWitsYlMxUDZNQ1pzZWp0dWZpS0lRNzkv?=
 =?utf-8?B?MmF1Q25Rb1pYczBDTEpleW1XekFvbUVrMzIyM3dTQm94TThDYTQwVmxPcGVO?=
 =?utf-8?B?ZWdueC9TcndGaGY5RHhTZmg1WjF4ei9UOEtlbTI5b21ablVLZmcrMFY3M2Rz?=
 =?utf-8?B?ak56QXlNK2RHYXl6SU0vV3BsOTBwQ2ZjOWN6WFlSWGxPQWVBQUZQbkVpaW44?=
 =?utf-8?B?WUU5MUVKYWVBTnRKaDlmcmE1dm8xYTlkS2cvM0ZwZmhLUzdUY3ZQbVkzV2cx?=
 =?utf-8?B?MW4zWGVjeVlGVTlZOTl2dndQWW5hR1lqdnBDT0pwbkIxOG9PNUlPK3I1aC9i?=
 =?utf-8?B?L0ZibElCYlVaeEc0cHdPcUo3RUg3eUZjNWk2cjRiYnJEKytyVXQrK0VzSTBa?=
 =?utf-8?B?RE0yTlYrQk1weCtqa3R3TU5obFBKVEdqL0NZZkhLQllNQjljYlJlNDcxZ1Z1?=
 =?utf-8?B?QUJVcVBRRWZMQnc4cFZncjJNQ254MjBnaStIUEtteU9pemdGOStzai9TMTNQ?=
 =?utf-8?B?Z0xlSUdJeWlJb3ptK3ZNNnNCOEpLY1dSaHd0QVpWam41RHlYMmt4Wm9TV0dD?=
 =?utf-8?B?V1dOMkN1R0pDQ2dQZmszWmF5TklsSnhXdTczVWE5cHZnMk8yYndCYXlGdEQ5?=
 =?utf-8?B?dXZUWjNVM3hHTDZQR09PMk1wY1M2ZjhtUitTYUhYRWFCM2JqZWh3N1ppelFk?=
 =?utf-8?B?aVB6TXVuS2pUYWcxWTErZGhjb21JT0xlUldMN3lBM0x2Mk9HbVgyRXZ5bzBK?=
 =?utf-8?B?a2NmbDJERXB0cGxlSGtWUzFaT1lkSFhZc2ozbkptTjd3TVc4cHVmTkpCblNI?=
 =?utf-8?B?eDZxUHZ0MGlwL284VFFKOUtjNklwT3dpUlRQS2NlUnJURjdvbldhdkJXdTRF?=
 =?utf-8?Q?c0GZQ/PAjw3MzgpwJ1iEyyR9G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR21MB4013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e13a08-108c-4d79-8901-08ddc97e485b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 00:17:17.3344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZrJXb0TMK5QA0RG84P4m12vO4Nwa4/nlYmjsGdajZqp75yecAKJ9N9CZEot+Eh/JB4Uaw7r6MASWD1BTHFknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3340

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VuaXl1a2kgSXdhc2hp
bWEgPGt1bml5dUBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDIyLCAyMDI1IDg6
MDIgUE0NCj4gVG86IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QGxpbnV4Lm1pY3Jvc29mdC5jb20+
DQo+IENjOiBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgS1kgU3Jpbml2
YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+Ow0KPiB3ZWkubGl1QGtlcm5lbC5vcmc7IERleHVhbiBD
dWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+Ow0KPiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IHNkQHF1
ZWFzeXNuYWlsLm5ldDsgdmlyb0B6ZW5pdi5saW51eC5vcmcudWs7DQo+IGNodWNrLmxldmVyQG9y
YWNsZS5jb207IG5laWxAYnJvd24ubmFtZTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBr
ZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgaG9ybXNAa2VybmVsLm9yZzsgZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldDsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggbmV0LCAxLzJdIG5l
dDogY29yZTogRml4IG1pc3NpbmcgaW5pdCBvZg0KPiBsbGlzdF9ub2RlIGluIHNldHVwX25ldCgp
DQo+IA0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGt1bml5dUBnb29nbGUuY29t
LiBMZWFybiB3aHkgdGhpcyBpcw0KPiBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5B
Ym91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IE9uIFR1ZSwgSnVsIDIyLCAyMDI1IGF0
IDQ6NTHigK9QTSBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBsaW51eC5taWNyb3NvZnQuY29t
PiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29m
dC5jb20+DQo+ID4NCj4gPiBBZGQgaW5pdF9sbGlzdF9ub2RlIGZvciBsb2NrLWxlc3MgbGlzdCBu
b2RlcyBpbiBzdHJ1Y3QgbmV0IGluDQo+ID4gc2V0dXBfbmV0KCksIHNvIHdlIGNhbiB0ZXN0IGlm
IGEgbm9kZSBpcyBvbiBhIGxpc3Qgb3Igbm90Lg0KPiA+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiBGaXhlczogZDZiMzM1OGEyODEzICgibGxpc3Q6IGFkZCBpbnRlcmZhY2Ug
dG8gY2hlY2sgaWYgYSBub2RlIGlzIG9uIGENCj4gbGlzdC4iKQ0KPiANCj4gTm8gRml4ZXMgdGFn
IGlzIG5lZWRlZCBiZWNhdXNlIHdlIGRpZG4ndCBoYXZlIGEgbmVlZCB0bw0KPiB0ZXN0IGlmIG5l
dCBpcyBxdWV1ZWQgZm9yIGRlc3RydWN0aW9uLg0KDQpJIGtub3cgdGhlIG9yaWdpbmFsIHBhdGNo
IHdhc24ndCBidWdneS4NClRoaXMgdGFnIGlzIGp1c3QgZm9yIHRoZSBzdGFibGUgYmFja3BvcnQg
dmVyc2lvbiBoaW50Lg0KDQpJbiBhbm90aGVyIHRocmVhZCwgRXJpYyBEdW1hemV0IHJlY29tbWVu
ZGVkIEZpeGVzIHRhZyBmb3IgcGF0Y2hlcyBmb3IgInN0YWJsZSI6DQpodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNoLzE3NTI4NzAwMTQtMjg5MDktMS1n
aXQtc2VuZC1lbWFpbC1oYWl5YW5nekBsaW51eC5taWNyb3NvZnQuY29tLw0KDQpUaGFua3MsDQot
IEhhaXlhbmcNCg0K

